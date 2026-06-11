param(
  [string]$CodexHome = "$env:USERPROFILE\.codex",
  [string]$Branch = "main",
  [switch]$Fetch
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$LocalRoot = Join-Path $CodexHome "sessions"
$CloudRoot = Join-Path $Root "codex-sessions\sessions"
$StatePath = Join-Path $CodexHome "codexAuto-sync-state.json"

function Get-GitCommand {
  $cmd = Get-Command git -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  foreach ($candidate in @("C:\Program Files\Git\cmd\git.exe", "C:\Program Files\Git\bin\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe")) {
    if (Test-Path $candidate) { return $candidate }
  }
  throw "Git is not available."
}

function Get-RelativeFiles($Base) {
  $result = @{}
  if (!(Test-Path $Base)) { return $result }
  Get-ChildItem -Path $Base -Recurse -File -Filter "*.jsonl" | ForEach-Object {
    $relative = $_.FullName.Substring($Base.Length).TrimStart("\")
    $result[$relative] = $_
  }
  return $result
}

function Test-FilePrefix($ShortPath, $LongPath) {
  $shortInfo = Get-Item $ShortPath
  $longInfo = Get-Item $LongPath
  if ($shortInfo.Length -gt $longInfo.Length) { return $false }
  $a = [System.IO.File]::Open($ShortPath, 'Open', 'Read', 'ReadWrite')
  $b = [System.IO.File]::Open($LongPath, 'Open', 'Read', 'ReadWrite')
  try {
    $bufferA = New-Object byte[] 65536
    $bufferB = New-Object byte[] 65536
    while (($readA = $a.Read($bufferA, 0, $bufferA.Length)) -gt 0) {
      $readB = $b.Read($bufferB, 0, $readA)
      if ($readB -ne $readA) { return $false }
      for ($i = 0; $i -lt $readA; $i++) {
        if ($bufferA[$i] -ne $bufferB[$i]) { return $false }
      }
    }
    return $true
  } finally {
    $a.Dispose()
    $b.Dispose()
  }
}

function Get-SharedFileHash($Path) {
  $stream = [System.IO.File]::Open($Path, 'Open', 'Read', 'ReadWrite')
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    return ([System.BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-', '')
  } finally {
    $sha.Dispose()
    $stream.Dispose()
  }
}

$Git = Get-GitCommand
Set-Location $Root
if ($Fetch) { & $Git fetch origin $Branch | Out-Host }

$local = Get-RelativeFiles $LocalRoot
$cloud = Get-RelativeFiles $CloudRoot
$baseline = @{}
if (Test-Path $StatePath) {
  $saved = Get-Content -Raw -Encoding UTF8 -Path $StatePath | ConvertFrom-Json
  if ($saved.files) {
    $saved.files.PSObject.Properties | ForEach-Object { $baseline[$_.Name] = [string]$_.Value }
  }
}
$paths = @($local.Keys + $cloud.Keys | Sort-Object -Unique)
$items = New-Object System.Collections.Generic.List[object]
$localAhead = 0
$cloudAhead = 0
$conflicts = 0

foreach ($path in $paths) {
  if (!$cloud.ContainsKey($path)) {
    $state = "local-only"
    $localAhead++
  } elseif (!$local.ContainsKey($path)) {
    $state = "cloud-only"
    $cloudAhead++
  } else {
    $localHash = Get-SharedFileHash $local[$path].FullName
    $cloudHash = Get-SharedFileHash $cloud[$path].FullName
    $baseHash = if ($baseline.ContainsKey($path)) { $baseline[$path] } else { $null }
    if ($localHash -eq $cloudHash) {
      $state = "same"
    } elseif ($baseHash -and $localHash -eq $baseHash) {
      $state = "cloud-changed"
      $cloudAhead++
    } elseif ($baseHash -and $cloudHash -eq $baseHash) {
      $state = "local-changed"
      $localAhead++
    } elseif (Test-FilePrefix $cloud[$path].FullName $local[$path].FullName) {
      $state = "local-append"
      $localAhead++
    } elseif (Test-FilePrefix $local[$path].FullName $cloud[$path].FullName) {
      $state = "cloud-append"
      $cloudAhead++
    } else {
      $state = "conflict"
      $conflicts++
    }
  }
  $items.Add([ordered]@{ path = $path; state = $state })
}

$gitBehind = 0
$gitAhead = 0
& $Git show-ref --verify --quiet "refs/remotes/origin/$Branch"
if ($LASTEXITCODE -eq 0) {
  $counts = (& $Git rev-list --left-right --count "$Branch...origin/$Branch") -split "\s+"
  if ($counts.Count -ge 2) {
    $gitAhead = [int]$counts[0]
    $gitBehind = [int]$counts[1]
  }
}

$action = if ($conflicts -gt 0) { "conflict" } elseif ($localAhead -gt 0 -and $cloudAhead -gt 0) { "merge" } elseif ($cloudAhead -gt 0) { "download" } elseif ($localAhead -gt 0) { "upload" } else { "synced" }
$result = [ordered]@{
  checkedAt = (Get-Date).ToString("o")
  computer = $env:COMPUTERNAME
  action = $action
  localAhead = $localAhead
  cloudAhead = $cloudAhead
  conflicts = $conflicts
  gitAhead = $gitAhead
  gitBehind = $gitBehind
  hasBaseline = (Test-Path $StatePath)
  items = $items
}

if ($MyInvocation.InvocationName -ne '.') {
  $result | ConvertTo-Json -Depth 5
}

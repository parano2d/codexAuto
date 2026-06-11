param(
  [string]$CodexHome = "$env:USERPROFILE\.codex"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Source = Join-Path $CodexHome "sessions"
$Target = Join-Path $Root "codex-sessions\sessions"

if (!(Test-Path $Source)) {
  throw "Codex sessions folder not found: $Source"
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

function Copy-SharedFile($SourcePath, $DestinationPath) {
  $parent = Split-Path -Parent $DestinationPath
  New-Item -ItemType Directory -Force -Path $parent | Out-Null
  $input = [System.IO.File]::Open($SourcePath, 'Open', 'Read', 'ReadWrite')
  $output = [System.IO.File]::Open($DestinationPath, 'Create', 'Write', 'None')
  try {
    $remaining = $input.Length
    $buffer = New-Object byte[] 65536
    while ($remaining -gt 0) {
      $wanted = [Math]::Min($buffer.Length, $remaining)
      $read = $input.Read($buffer, 0, $wanted)
      if ($read -le 0) { break }
      $output.Write($buffer, 0, $read)
      $remaining -= $read
    }
  } finally {
    $output.Dispose()
    $input.Dispose()
  }

  $snapshot = [System.IO.File]::Open($DestinationPath, 'Open', 'ReadWrite', 'None')
  try {
    for ($position = $snapshot.Length - 1; $position -ge 0; $position--) {
      $snapshot.Position = $position
      if ($snapshot.ReadByte() -eq 10) {
        $snapshot.SetLength($position + 1)
        break
      }
    }
  } finally {
    $snapshot.Dispose()
  }
}

Get-ChildItem -Path $Source -Recurse -File -Filter "*.jsonl" | ForEach-Object {
  $relative = $_.FullName.Substring($Source.Length).TrimStart("\")
  Copy-SharedFile $_.FullName (Join-Path $Target $relative)
}

$manifest = Join-Path $Root "codex-sessions\MANIFEST.md"
$now = Get-Date
$files = Get-ChildItem -Path $Target -Recurse -File | Sort-Object FullName
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Codex Sessions Manifest")
$lines.Add("")
$lines.Add(("- Exported at: {0}" -f $now.ToString("yyyy-MM-dd HH:mm:ss zzz")))
$lines.Add(("- Source computer: {0}" -f $env:COMPUTERNAME))
$lines.Add(("- Source folder: {0}" -f $Source))
$lines.Add("")
$lines.Add("## Files")
foreach ($file in $files) {
  $relative = $file.FullName.Substring($Target.Length).TrimStart("\")
  $hash = Get-FileHash -Algorithm SHA256 -Path $file.FullName
  $lines.Add(("- {0} / {1} bytes / {2}" -f $relative, $file.Length, $hash.Hash))
}
$lines -join [Environment]::NewLine | Set-Content -Encoding UTF8 -Path $manifest

Write-Host "Codex sessions exported:"
Write-Host " - From: $Source"
Write-Host " - To:   $Target"
Write-Host " - Manifest: $manifest"

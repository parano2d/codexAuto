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

Copy-Item -Path (Join-Path $Source "*") -Destination $Target -Recurse -Force

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

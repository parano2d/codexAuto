param(
  [string]$CodexHome = "$env:USERPROFILE\.codex"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Source = Join-Path $Root "codex-sessions\sessions"
$Target = Join-Path $CodexHome "sessions"

if (!(Test-Path $Source)) {
  throw "Exported sessions folder not found: $Source"
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

Copy-Item -Path (Join-Path $Source "*") -Destination $Target -Recurse -Force

Write-Host "Codex sessions imported:"
Write-Host " - From: $Source"
Write-Host " - To:   $Target"
Write-Host ""
Write-Host "Restart Codex if the imported sessions do not appear immediately."

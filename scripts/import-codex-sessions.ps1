param(
  [string]$CodexHome = "$env:USERPROFILE\.codex",
  [ValidateSet("merge", "replace")]
  [string]$Mode = "merge"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Source = Join-Path $Root "codex-sessions\sessions"
$Target = Join-Path $CodexHome "sessions"

if (!(Test-Path $Source)) {
  throw "Exported sessions folder not found: $Source"
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

if ($Mode -eq "replace") {
  if (Test-Path $Target) {
    Remove-Item -Path (Join-Path $Target "*") -Recurse -Force -ErrorAction SilentlyContinue
  }
}

Copy-Item -Path (Join-Path $Source "*") -Destination $Target -Recurse -Force

Write-Host "Codex sessions imported:"
Write-Host " - From: $Source"
Write-Host " - To:   $Target"
Write-Host " - Mode: $Mode"
Write-Host ""
Write-Host "Restart Codex if the imported sessions do not appear immediately."

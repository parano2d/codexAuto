param([string]$CodexHome = "$env:USERPROFILE\.codex")

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Source = Join-Path $Root "codex-sessions\sessions"
$StatePath = Join-Path $CodexHome "codexAuto-sync-state.json"

New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
$files = [ordered]@{}
if (Test-Path $Source) {
  Get-ChildItem -Path $Source -Recurse -File -Filter "*.jsonl" | ForEach-Object {
    $relative = $_.FullName.Substring($Source.Length).TrimStart("\")
    $files[$relative] = (Get-FileHash -Algorithm SHA256 -Path $_.FullName).Hash
  }
}

[ordered]@{
  syncedAt = (Get-Date).ToString("o")
  computer = $env:COMPUTERNAME
  files = $files
} | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 -Path $StatePath

Write-Host "Local sync baseline updated: $StatePath"


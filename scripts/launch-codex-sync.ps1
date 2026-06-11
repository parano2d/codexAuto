param([switch]$SkipSync)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

if (!$SkipSync) {
  powershell -ExecutionPolicy Bypass -File ".\scripts\auto-sync.ps1"
}

Start-Process "explorer.exe" "shell:AppsFolder\OpenAI.Codex_2p2nqsd0c76g0!App"


param(
  [string]$Branch = "main",
  [ValidateSet("merge", "replace")]
  [string]$Mode = "merge"
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

function Get-GitCommand {
  $cmd = Get-Command git -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  $candidates = @(
    "C:\Program Files\Git\cmd\git.exe",
    "C:\Program Files\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe"
  )
  foreach ($candidate in $candidates) {
    if (Test-Path $candidate) { return $candidate }
  }
  throw "Git is not available. Install Git for Windows first."
}

$Git = Get-GitCommand

if (!(Test-Path ".git")) {
  throw "This folder is not a Git repository. Clone https://github.com/parano2d/codexAuto first, or run scripts/setup-github.ps1."
}

& $Git pull origin $Branch
powershell -ExecutionPolicy Bypass -File ".\scripts\import-codex-sessions.ps1" -Mode $Mode

Write-Host ""
Write-Host "Codex sessions and handoff files loaded from GitHub."
Write-Host "Import mode: $Mode"
Write-Host ""
Write-Host "Ask Codex:"
Write-Host "Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md."
Write-Host "Then summarize the latest Codex work context. Ask for the project root only if file work is needed."

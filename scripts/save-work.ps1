param(
  [string]$Message = "Update handoff",
  [string]$Branch = "main",
  [string]$Note = ""
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
  throw "This folder is not a Git repository. Run scripts/setup-github.ps1 first."
}

if (!$Note) {
  Write-Host "Warning: -Note is empty. For useful cross-PC handoff, pass a summary of the Codex conversation."
  Write-Host "Example: .\scripts\save-work.ps1 -Message 'Save handoff' -Note 'Discussed security plan; no project files changed.'"
}

powershell -ExecutionPolicy Bypass -File ".\scripts\update-handoff.ps1" -Note $Note
powershell -ExecutionPolicy Bypass -File ".\scripts\export-codex-sessions.ps1"

& $Git add .
$status = & $Git status --porcelain
if (!$status) {
  Write-Host "No changes to commit."
  powershell -ExecutionPolicy Bypass -File ".\scripts\write-sync-state.ps1"
  exit 0
}

& $Git commit -m $Message
& $Git push origin $Branch
powershell -ExecutionPolicy Bypass -File ".\scripts\write-sync-state.ps1"

Write-Host ""
Write-Host "Workspace saved to GitHub."
Write-Host "Next computer can run: powershell -ExecutionPolicy Bypass -File .\scripts\load-work.ps1"

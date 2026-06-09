param(
  [string]$Message = "Merge Codex sessions",
  [string]$Branch = "main",
  [string]$Note = "Merged local Codex sessions with GitHub sessions"
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

Write-Host "Step 1/4: Pulling latest codexAuto from GitHub..."
& $Git pull origin $Branch

Write-Host "Step 2/4: Importing GitHub sessions into local Codex sessions without deleting local sessions..."
powershell -ExecutionPolicy Bypass -File ".\scripts\import-codex-sessions.ps1" -Mode merge

Write-Host "Step 3/4: Exporting merged local Codex sessions back into codexAuto..."
powershell -ExecutionPolicy Bypass -File ".\scripts\export-codex-sessions.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\update-handoff.ps1" -Note $Note

Write-Host "Step 4/4: Committing and pushing merged sessions..."
& $Git add .
$status = & $Git status --porcelain
if (!$status) {
  Write-Host "No changes to commit."
  exit 0
}

& $Git commit -m $Message
& $Git push origin $Branch

Write-Host ""
Write-Host "Merge complete. Local and GitHub Codex session files are now combined."
Write-Host "Restart Codex if imported sessions do not appear immediately."

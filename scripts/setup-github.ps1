param(
  [string]$RemoteUrl = "https://github.com/parano2d/codexAuto.git",
  [string]$Branch = "main",
  [string]$CommitMessage = "Initialize codex handoff automation"
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
  return $null
}

$Git = Get-GitCommand
if (!$Git) {
  Write-Host "Git is not available in this PowerShell session."
  Write-Host "Install Git for Windows, reopen PowerShell/Codex, then run this script again."
  Write-Host "Download: https://git-scm.com/download/win"
  exit 1
}

if (!(Test-Path ".git")) {
  & $Git init
}

$currentBranch = & $Git branch --show-current
if (!$currentBranch) {
  & $Git checkout -b $Branch
} elseif ($currentBranch -ne $Branch) {
  & $Git branch -M $Branch
}

$remotes = & $Git remote
if ($remotes -notcontains "origin") {
  & $Git remote add origin $RemoteUrl
  $remote = $RemoteUrl
} else {
  $remote = & $Git remote get-url origin
}

if ($remote -ne $RemoteUrl) {
  & $Git remote set-url origin $RemoteUrl
}

powershell -ExecutionPolicy Bypass -File ".\scripts\update-handoff.ps1" -Note "setup-github push"

& $Git add .
& $Git commit -m $CommitMessage
& $Git push -u origin $Branch

Write-Host "GitHub push complete."

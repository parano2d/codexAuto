param(
  [string]$Branch = "main",
  [switch]$NoPrompt
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

function Get-GitCommand {
  $cmd = Get-Command git -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }
  foreach ($candidate in @("C:\Program Files\Git\cmd\git.exe", "C:\Program Files\Git\bin\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe")) {
    if (Test-Path $candidate) { return $candidate }
  }
  throw "Git is not available."
}

$Git = Get-GitCommand
& $Git fetch origin $Branch | Out-Host

$dirty = & $Git status --porcelain
if (!$dirty) {
  & $Git pull --ff-only origin $Branch | Out-Host
} else {
  Write-Host "codexAuto has uncommitted changes; remote pull was skipped."
}

$statusJson = powershell -ExecutionPolicy Bypass -File ".\scripts\sync-status.ps1" -Branch $Branch
$status = $statusJson | ConvertFrom-Json

Write-Host ""
Write-Host ("Sync status: {0} / local {1} / cloud {2} / conflicts {3}" -f $status.action, $status.localAhead, $status.cloudAhead, $status.conflicts)

switch ($status.action) {
  "synced" {
    Write-Host "Codex sessions are already synchronized."
  }
  "download" {
    powershell -ExecutionPolicy Bypass -File ".\scripts\import-codex-sessions.ps1" -Mode merge
    Write-Host "Newer GitHub sessions were imported. Restart Codex if needed."
  }
  "upload" {
    powershell -ExecutionPolicy Bypass -File ".\scripts\save-work.ps1" -Message "Auto-sync Codex sessions" -Note "Automatic session upload from $env:COMPUTERNAME"
  }
  "merge" {
    powershell -ExecutionPolicy Bypass -File ".\scripts\merge-work.ps1" -Message "Auto-merge Codex sessions" -Note "Automatic non-conflicting session merge from $env:COMPUTERNAME"
  }
  "conflict" {
    Write-Host "The same session changed independently on more than one computer."
    Write-Host "No original was overwritten. Run '병합하기!' after reviewing the conflict."
    if (!$NoPrompt) { Read-Host "Press Enter to continue" | Out-Null }
  }
}


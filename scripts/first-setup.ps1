param(
  [string]$RemoteUrl = "https://github.com/parano2d/codexAuto.git",
  [string]$Branch = "main"
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
  throw "Git is not available. Install Git for Windows first."
}

$Git = Get-GitCommand
if (!(Test-Path ".git")) { & $Git init }
$remotes = & $Git remote
if ($remotes -notcontains "origin") { & $Git remote add origin $RemoteUrl }
elseif ((& $Git remote get-url origin) -ne $RemoteUrl) { & $Git remote set-url origin $RemoteUrl }

& $Git fetch origin $Branch | Out-Host
if (!(& $Git rev-parse --verify $Branch 2>$null)) { & $Git checkout -B $Branch "origin/$Branch" }
else { & $Git pull --ff-only origin $Branch | Out-Host }

powershell -ExecutionPolicy Bypass -File ".\scripts\auto-sync.ps1" -NoPrompt

$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "Codex 동기화 실행.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$Root\scripts\launch-codex-sync.ps1`""
$shortcut.WorkingDirectory = $Root
$shortcut.IconLocation = "C:\Windows\System32\shell32.dll,238"
$shortcut.Save()

Write-Host ""
Write-Host "First setup complete."
Write-Host "Desktop shortcut: $shortcutPath"
Write-Host "Use the shortcut to check GitHub sessions before Codex opens."


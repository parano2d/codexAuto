$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$required = @(
  "START_HERE.md",
  "FIRST_SETUP.md",
  "README.md",
  "docs\GLOBAL_RULES.md",
  "docs\COMMAND_REFERENCE.md",
  "docs\PROJECTS.md",
  "docs\HANDOFF_LOG.md",
  "docs\CHAT_HANDOFF.md",
  "docs\CROSS_PC_WORKFLOW.md",
  "docs\CODEX_PROMPTS.md",
  "docs\WORK_COMMANDS.md",
  "docs\CODEX_PC_GUIDE.md",
  "scripts\update-handoff.ps1",
  "scripts\load-work.ps1",
  "scripts\save-work.ps1",
  "scripts\merge-work.ps1",
  "scripts\export-codex-sessions.ps1",
  "scripts\import-codex-sessions.ps1",
  "scripts\sync-status.ps1",
  "scripts\auto-sync.ps1",
  "scripts\write-sync-state.ps1",
  "scripts\launch-codex-sync.ps1",
  "scripts\first-setup.ps1",
  "scripts\setup-github.ps1"
)

Write-Host "Project root: $Root"
Write-Host ""

foreach ($rel in $required) {
  $path = Join-Path $Root $rel
  if (Test-Path $path) {
    Write-Host "[OK] $rel"
  } else {
    Write-Host "[MISSING] $rel"
  }
}

Write-Host ""
Write-Host "Codex start prompt:"
Write-Host "Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md."
Write-Host "Then summarize the latest Codex work context. Ask for the project root only if file work is needed."

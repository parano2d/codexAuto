param(
  [string]$Note = ""
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Docs = Join-Path $Root "docs"
$Handoff = Join-Path $Docs "HANDOFF_LOG.md"
$Status = Join-Path $Docs "PROJECT_STATUS.md"
$SnapshotDir = Join-Path $Root ".codex-handoff"
$Snapshot = Join-Path $SnapshotDir "latest-snapshot.json"

New-Item -ItemType Directory -Force -Path $Docs | Out-Null
New-Item -ItemType Directory -Force -Path $SnapshotDir | Out-Null

function Get-FileInfoSafe($Path) {
  if (Test-Path $Path) {
    $item = Get-Item $Path
    $hash = Get-FileHash -Algorithm SHA256 -Path $Path
    return [ordered]@{
      exists = $true
      length = $item.Length
      lastWriteTime = $item.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
      sha256 = $hash.Hash
    }
  }
  return [ordered]@{ exists = $false }
}

$now = Get-Date
$globalFiles = @(
  "README.md",
  "START_HERE.md",
  "docs\GLOBAL_RULES.md",
  "docs\PROJECTS.md",
  "docs\HANDOFF_LOG.md",
  "docs\CHAT_HANDOFF.md",
  "docs\CROSS_PC_WORKFLOW.md",
  "docs\CODEX_PROMPTS.md",
  "docs\CODEX_PC_GUIDE.md",
  "docs\WORK_COMMANDS.md"
)

$snapshotData = [ordered]@{
  updatedAt = $now.ToString("yyyy-MM-dd HH:mm:ss zzz")
  computer = $env:COMPUTERNAME
  user = $env:USERNAME
  root = $Root
  files = [ordered]@{}
}

foreach ($rel in $globalFiles) {
  $snapshotData.files[$rel] = Get-FileInfoSafe (Join-Path $Root $rel)
}

$snapshotData | ConvertTo-Json -Depth 6 | Set-Content -Encoding UTF8 -Path $Snapshot

$memo = if ($Note) { $Note } else { "auto handoff update" }
$stamp = $now.ToString('yyyy-MM-dd HH:mm:ss zzz')
$entryLines = New-Object System.Collections.Generic.List[string]
$entryLines.Add("")
$entryLines.Add("---")
$entryLines.Add("")
$entryLines.Add(("## {0} / {1}" -f $stamp, $env:COMPUTERNAME))
$entryLines.Add("")
$entryLines.Add(("- Root: {0}" -f $Root))
$entryLines.Add(("- Snapshot: .codex-handoff/LAST_SYNC.md"))
$entryLines.Add(("- Memo: {0}" -f $memo))
$entryLines.Add("")
$entryLines.Add("Next Codex prompt:")
$entryLines.Add("Read START_HERE.md, docs/GLOBAL_RULES.md, docs/HANDOFF_LOG.md, docs/CROSS_PC_WORKFLOW.md, docs/PROJECTS.md, and docs/CHAT_HANDOFF.md.")
$entryLines.Add("Then summarize the latest Codex work context. Ask for the project root only if file work is needed.")
$entry = $entryLines -join [Environment]::NewLine

if (!(Test-Path $Handoff)) {
  "# Handoff Log`r`n" | Set-Content -Encoding UTF8 -Path $Handoff
}
Add-Content -Encoding UTF8 -Path $Handoff -Value $entry

$lastSync = Join-Path $SnapshotDir "LAST_SYNC.md"
$lastSyncLines = New-Object System.Collections.Generic.List[string]
$lastSyncLines.Add("# Last Sync")
$lastSyncLines.Add("")
$lastSyncLines.Add(("- Updated at: {0}" -f $stamp))
$lastSyncLines.Add(("- Computer: {0}" -f $env:COMPUTERNAME))
$lastSyncLines.Add(("- User: {0}" -f $env:USERNAME))
$lastSyncLines.Add(("- Root: {0}" -f $Root))
$lastSyncLines.Add("")
$lastSyncLines.Add("## Files")
foreach ($rel in $globalFiles) {
  $info = $snapshotData.files[$rel]
  if ($info.exists) {
    $lastSyncLines.Add(("- {0}: {1} bytes / {2} / {3}" -f $rel, $info.length, $info.lastWriteTime, $info.sha256))
  } else {
    $lastSyncLines.Add(("- {0}: missing" -f $rel))
  }
}
$lastSyncLines -join [Environment]::NewLine | Set-Content -Encoding UTF8 -Path $lastSync

Write-Host "Handoff updated:"
Write-Host " - $Handoff"
Write-Host " - $Snapshot"
Write-Host " - $lastSync"
Write-Host ""
Write-Host "Next:"
Write-Host " git add ."
Write-Host " git commit -m 'Update attendance handoff'"
Write-Host " git push"

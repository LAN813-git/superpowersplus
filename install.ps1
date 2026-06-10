$ErrorActionPreference = "Stop"
$SkillsDir = "$env:USERPROFILE\.claude\skills\fused"
$SuperpowersDir = "$env:USERPROFILE\.claude\skills"
$MattackDir = "$env:USERPROFILE\.agents\skills"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupDir = "$env:USERPROFILE\.claude\skills-backup-$(Get-Date -Format 'yyyyMMddHHmmss')"

Write-Host "=== Super Powers Plus ===" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

# ── Step 1: Detect existing installations ──────────────────────────

$Conflicts = @()

# Check obra/superpowers
$SuperpowersFiles = @(
  "brainstorming.md", "writing-plans.md", "verification-before-completion.md",
  "dispatching-parallel-agents.md", "finishing-a-development-branch.md",
  "using-git-worktrees.md"
)
foreach ($f in $SuperpowersFiles) {
  $path = Join-Path $SuperpowersDir $f
  if (Test-Path $path) { $Conflicts += $path }
}

# Check mattpocock/skills
$MattackFiles = @(
  "grill-with-docs.md", "to-issues.md", "to-prd.md", "prototype.md", "caveman.md",
  "handoff.md", "teach.md", "zoom-out.md", "improve-codebase-architecture.md",
  "git-guardrails.md"
)
foreach ($f in $MattackFiles) {
  $path = Join-Path $MattackDir $f
  if (Test-Path $path) { $Conflicts += $path }
}

# ── Step 2: Backup and clean conflicts ─────────────────────────────

if ($Conflicts.Count -gt 0) {
  Write-Host ""
  Write-Host "Found $($Conflicts.Count) existing skill(s) that conflict:" -ForegroundColor Yellow
  foreach ($f in $Conflicts) {
    Write-Host "  - $(Split-Path $f -Leaf)"
  }
  Write-Host ""

  New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
  foreach ($f in $Conflicts) {
    Copy-Item $f $BackupDir -Force -ErrorAction SilentlyContinue
    Remove-Item $f -Force -ErrorAction SilentlyContinue
  }

  Write-Host "Backed up to: $BackupDir" -ForegroundColor Green
  Write-Host "Removed conflicting originals."
  Write-Host ""
}

# ── Step 3: Install Super Powers Plus ──────────────────────────────

Write-Host "Installing skills..."
Copy-Item "$ScriptDir\skills\fused\*.md" $SkillsDir -Force

# Install planning-with-files templates and scripts
$TemplatesDir = "$ScriptDir\skills\fused\planning-with-files-zh-templates"
$ScriptsDir = "$ScriptDir\skills\fused\planning-with-files-zh-scripts"
if (Test-Path $TemplatesDir) {
  $Target = "$SkillsDir\planning-with-files-zh-templates"
  New-Item -ItemType Directory -Force -Path $Target | Out-Null
  Copy-Item "$TemplatesDir\*" $Target -Force -Recurse
}
if (Test-Path $ScriptsDir) {
  $Target = "$SkillsDir\planning-with-files-zh-scripts"
  New-Item -ItemType Directory -Force -Path $Target | Out-Null
  Copy-Item "$ScriptsDir\*" $Target -Force -Recurse
}

# ── Step 4: Report ─────────────────────────────────────────────────

$Count = (Get-ChildItem "$SkillsDir\*.md").Count
Write-Host ""
Write-Host "Done! $Count skills installed." -ForegroundColor Green

if ($Conflicts.Count -gt 0) {
  Write-Host ""
  Write-Host "Upgraded from existing installation. Backup at:" -ForegroundColor Yellow
  Write-Host "  $BackupDir"
  Write-Host ""
  Write-Host "To rollback: Copy-Item $BackupDir\* <original-location>\"
}

Write-Host ""
Write-Host "Try: claude > brainstorming <your idea>"

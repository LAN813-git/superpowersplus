$ErrorActionPreference = "Stop"
$SkillsDir = "$env:USERPROFILE\.claude\skills\fused"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "=== Super Powers Plus ===" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
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

$Count = (Get-ChildItem "$SkillsDir\*.md").Count
Write-Host "Done! $Count skills installed." -ForegroundColor Green
Write-Host ""
Write-Host "Try: claude > brainstorming <your idea>"

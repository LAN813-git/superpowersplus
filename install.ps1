$ErrorActionPreference = "Stop"
$SkillsDir = "$env:USERPROFILE\.claude\skills\fused"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "=== Super Powers Plus ===" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Copy-Item "$ScriptDir\skills\fused\*.md" $SkillsDir -Force

$Count = (Get-ChildItem "$SkillsDir\*.md").Count
Write-Host "Done! $Count skills installed." -ForegroundColor Green
Write-Host ""
Write-Host "Try: claude > brainstorming <your idea>"

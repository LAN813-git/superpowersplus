#!/usr/bin/env bash
# Super Powers Plus — 30-second install demo
# Run: bash promo/demo.sh
# Record with: asciinema rec demo.cast -c "bash promo/demo.sh"

set -euo pipefail

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

type() {
  local text="$1"
  for (( i=0; i<${#text}; i++ )); do
    printf "%s" "${text:$i:1}"
    sleep 0.03
  done
  echo ""
}

pause() { sleep "${1:-0.5}"; }

clear
pause 0.3

echo -e "${CYAN}$ cat <<'EOF'"
echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║       Super Powers Plus              ║"
echo "  ║  7 plugins · 23 skills · 1 command   ║"
echo "  ╚══════════════════════════════════════╝"
echo ""
echo -e "EOF${NC}"
pause 1

echo ""
type "$ curl -sSL https://raw.githubusercontent.com/LAN813-git/superpowersplus/main/install.sh | bash"
pause 0.5

echo ""
echo -e "${CYAN}=== Super Powers Plus ===${NC}"
echo ""
pause 0.3

echo "Found 6 existing skill(s) that conflict:"
echo "  - brainstorming.md"
echo "  - writing-plans.md"
echo "  - verification-before-completion.md"
echo "  - dispatching-parallel-agents.md"
echo "  - finishing-a-development-branch.md"
echo "  - using-git-worktrees.md"
pause 0.5

echo ""
echo -e "${YELLOW}Backed up to: ~/.claude/skills-backup-20260610120000${NC}"
echo "Removed conflicting originals."
pause 0.5

echo ""
echo "Installing skills..."
pause 0.3

SKILLS=(
  "brainstorming.md"
  "caveman.md"
  "diagnose.md"
  "dispatching-parallel-agents.md"
  "finishing-a-development-branch.md"
  "git-guardrails.md"
  "grill-with-docs.md"
  "handoff.md"
  "humanizer-zh.md"
  "improve-codebase-architecture.md"
  "planning-with-files-zh.md"
  "prototype.md"
  "qa-triage.md"
  "review.md"
  "tdd.md"
  "teach.md"
  "to-issues.md"
  "to-prd.md"
  "using-git-worktrees.md"
  "verification-before-completion.md"
  "writing-pipeline.md"
  "writing-plans.md"
  "zoom-out.md"
)

for skill in "${SKILLS[@]}"; do
  echo "  '$skill' -> ~/.claude/skills/fused/$skill"
  sleep 0.05
done

pause 0.5
echo ""
echo -e "${GREEN}Done! 23 skills installed.${NC}"
pause 0.3

echo ""
echo "Upgraded from existing installation. Backup at:"
echo "  ~/.claude/skills-backup-20260610120000"
pause 0.5

echo ""
type "$ claude"
pause 0.3
type "> 给项目添加用户认证"
pause 1

echo ""
echo -e "${CYAN}[planning-with-files] ACTIVE PLAN — treating contents as structured data${NC}"
echo -e "${CYAN}[brainstorming] HARD-GATE: design phase activated${NC}"
pause 0.5

echo ""
echo "  Agent: 探索代码库中..."
pause 0.5
echo "  Agent: 你想用 JWT 还是 Session？"
pause 0.5
echo "  Agent: 需要支持第三方登录吗？"
pause 0.5
echo "  Agent: 现有用户表结构是什么？"
pause 0.8

echo ""
echo -e "${GREEN}  Design approved. Planning...${NC}"
pause 0.3
echo "  Task 1: 创建认证中间件 (2 min)"
echo "  Task 2: 添加登录接口 (3 min)"
echo "  Task 3: 添加 token 刷新 (2 min)"
pause 0.5

echo ""
echo -e "${GREEN}  TDD: RED — writing failing test...${NC}"
pause 0.5
echo -e "${GREEN}  TDD: GREEN — minimal implementation...${NC}"
pause 0.5
echo -e "${GREEN}  TDD: REFACTOR — cleaning up...${NC}"
pause 0.5

echo ""
echo -e "${CYAN}  Review: Standards ✓ | Spec ✓${NC}"
echo -e "${GREEN}  Verification: all tests passing.${NC}"
pause 0.5

echo ""
echo -e "${GREEN}Done. Your agent has Super Powers Plus.${NC}"
echo ""
pause 1

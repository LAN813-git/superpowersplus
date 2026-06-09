#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills/fused"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Super Powers Plus ==="
echo ""

mkdir -p "$SKILLS_DIR"

echo "Installing skills..."
cp -v "$SCRIPT_DIR/skills/fused/"*.md "$SKILLS_DIR/"

echo ""
echo "Done! $(ls "$SKILLS_DIR"/*.md | wc -l | xargs echo) skills installed."
echo ""
echo "Try: claude > brainstorming <your idea>"

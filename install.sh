#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills/fused"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Super Powers Plus ==="
echo ""

mkdir -p "$SKILLS_DIR"

echo "Installing skills..."
cp -v "$SCRIPT_DIR/skills/fused/"*.md "$SKILLS_DIR/"

# Install planning-with-files templates and scripts
if [ -d "$SCRIPT_DIR/skills/fused/planning-with-files-zh-templates" ]; then
  mkdir -p "$SKILLS_DIR/planning-with-files-zh-templates"
  cp -rv "$SCRIPT_DIR/skills/fused/planning-with-files-zh-templates/"* "$SKILLS_DIR/planning-with-files-zh-templates/"
fi
if [ -d "$SCRIPT_DIR/skills/fused/planning-with-files-zh-scripts" ]; then
  mkdir -p "$SKILLS_DIR/planning-with-files-zh-scripts"
  cp -rv "$SCRIPT_DIR/skills/fused/planning-with-files-zh-scripts/"* "$SKILLS_DIR/planning-with-files-zh-scripts/"
fi

echo ""
echo "Done! $(ls "$SKILLS_DIR"/*.md | wc -l | xargs echo) skills installed."
echo ""
echo "Try: claude > brainstorming <your idea>"

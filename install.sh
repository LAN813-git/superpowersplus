#!/usr/bin/env bash
set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills/fused"
SUPERPOWERS_DIR="$HOME/.claude/skills"
MATTOCK_DIR="$HOME/.agents/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.claude/skills-backup-$(date +%Y%m%d%H%M%S)"

echo "=== Super Powers Plus ==="
echo ""

mkdir -p "$SKILLS_DIR"

# ── Step 1: Detect existing installations ──────────────────────────

CONFLICTS=()

# Check obra/superpowers (files installed directly in ~/.claude/skills/)
for f in brainstorming.md writing-plans.md verification-before-completion.md \
         dispatching-parallel-agents.md finishing-a-development-branch.md \
         using-git-worktrees.md; do
  if [ -f "$SUPERPOWERS_DIR/$f" ]; then
    CONFLICTS+=("$SUPERPOWERS_DIR/$f")
  fi
done

# Check mattpocock/skills (files in ~/.agents/skills/)
for f in grill-with-docs.md to-issues.md to-prd.md prototype.md caveman.md \
         handoff.md teach.md zoom-out.md improve-codebase-architecture.md \
         git-guardrails.md; do
  if [ -f "$MATTOCK_DIR/$f" ]; then
    CONFLICTS+=("$MATTOCK_DIR/$f")
  fi
done

# ── Step 2: Backup and clean conflicts ─────────────────────────────

if [ ${#CONFLICTS[@]} -gt 0 ]; then
  echo "Found ${#CONFLICTS[@]} existing skill(s) that conflict with Super Powers Plus:"
  for f in "${CONFLICTS[@]}"; do
    echo "  - $(basename "$f")"
  done
  echo ""

  mkdir -p "$BACKUP_DIR"
  for f in "${CONFLICTS[@]}"; do
    cp "$f" "$BACKUP_DIR/" 2>/dev/null || true
    rm -f "$f"
  done

  echo "Backed up to: $BACKUP_DIR"
  echo "Removed conflicting originals."
  echo ""
fi

# ── Step 3: Install Super Powers Plus ──────────────────────────────

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

# ── Step 4: Report ─────────────────────────────────────────────────

COUNT=$(ls "$SKILLS_DIR"/*.md 2>/dev/null | wc -l | xargs echo)
echo ""
echo "Done! $COUNT skills installed."

if [ ${#CONFLICTS[@]} -gt 0 ]; then
  echo ""
  echo "Upgraded from existing installation. Backup at:"
  echo "  $BACKUP_DIR"
  echo ""
  echo "To rollback: cp $BACKUP_DIR/* <original-location>/"
fi

echo ""
echo "Try: claude > brainstorming <your idea>"

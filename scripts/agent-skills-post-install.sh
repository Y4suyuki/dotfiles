#!/usr/bin/env bash
set -euo pipefail

# Stowによって展開された実体のパス
SKILLS_SRC="$HOME/.config/agent-skills"

if [ ! -d "$SKILLS_SRC" ]; then
    echo "Error: $SKILLS_SRC not found. Please run 'stow agent-skills' first."
    exit 1
fi

echo "Setting up symlinks for agent harnesses..."

# 1. Claude Code
mkdir -p "$HOME/.claude"
ln -sfn "$SKILLS_SRC" "$HOME/.claude/skills"
echo "  -> Linked to ~/.claude/skills"

# 2. OpenCode
mkdir -p "$HOME/.config/opencode"
ln -sfn "$SKILLS_SRC" "$HOME/.config/opencode/skills"
echo "  -> Linked to ~/.config/opencode/skills"

# 3. Standard / Codex / Cursor
mkdir -p "$HOME/.agents"
ln -sfn "$SKILLS_SRC" "$HOME/.agents/skills"
echo "  -> Linked to ~/.agents/skills"

echo "Agent skills setup complete."

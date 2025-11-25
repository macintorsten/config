#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Remove Dotfile Configurations ==="
echo
echo "This will:"
echo "  - Remove dotfile symlinks (stow -D)"
echo "  - Remove bashrc.d sourcing from ~/.bashrc"
echo "  - Keep all installed tools"
echo ""
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

cd "$SCRIPT_DIR"

# Unstow all dotfiles
echo "Removing dotfile symlinks..."
if command -v stow &> /dev/null; then
    stow -D -t "$HOME" bash tmux vim starship bat 2>/dev/null || true
    echo "✓ Dotfiles unlinked"
else
    echo "⚠ Stow not found, skipping symlink removal"
fi

# Remove bashrc.d sourcing from bashrc
echo "Removing bashrc.d sourcing..."
if [ -f ~/.bashrc ]; then
    # Create backup
    cp ~/.bashrc ~/.bashrc.backup-$(date +%Y%m%d-%H%M%S)
    
    # Remove the sourcing block
    sed -i '/# Source dotfiles configuration/,/^fi$/d' ~/.bashrc
    
    # Also remove fzf line that might have been added
    sed -i '/\[ -f ~\/.fzf.bash \] && source ~\/.fzf.bash/d' ~/.bashrc
    
    echo "✓ Removed sourcing from ~/.bashrc (backup created)"
else
    echo "⚠ ~/.bashrc not found"
fi

echo
echo "=== Configuration Removal Complete ==="
echo
echo "Installed tools remain on your system."
echo "Config directories (.config/bashrc.d, etc.) remain but are no longer sourced."
echo ""
echo "Bashrc backup: ~/.bashrc.backup-*"

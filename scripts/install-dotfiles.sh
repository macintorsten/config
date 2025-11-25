#!/bin/bash

set -e

# Get the repo root directory (parent of scripts/)
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Install dotfiles using GNU Stow
cd "$REPO_ROOT" || exit 1
echo "Installing dotfiles using GNU Stow..."
stow -t "$HOME" tmux vim starship
echo "✓ Dotfiles symlinked"

#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installation ==="
echo

if command -v make &> /dev/null; then
    cd "$SCRIPT_DIR"
    make install
else
    # Sequential fallback
    for script in "$SCRIPT_DIR"/scripts/install-*.sh; do
        bash "$script"
        echo
    done
fi

echo
echo "=== Installation Complete ==="
echo
echo "Next steps:"
echo "  1. Restart shell or run: source ~/.bashrc"
echo "  2. Start tmux"
echo "  3. In tmux, press Ctrl-a I to update plugins"
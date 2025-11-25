#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installation ==="
echo

if command -v make &> /dev/null; then
    cd "$SCRIPT_DIR"
    make install
else
    echo "WARNING: make not found, using sequential fallback"
    echo "Install order may not be optimal. Consider installing make."
    echo ""
    
    # Sequential fallback with proper order
    cd "$SCRIPT_DIR"
    
    # 1. Install stow first
    bash scripts/install-stow.sh
    
    # 2. Install tools (parallel not possible without make)
    for tool in fzf tmux tpm starship bat; do
        if [ -f "scripts/install-${tool}.sh" ]; then
            bash "scripts/install-${tool}.sh"
        fi
    done
    
    # 3. Install configs
    bash scripts/install-dotfiles.sh
    
    # 4. Install plugins that depend on configs
    bash scripts/install-tmux-plugins.sh
    
    # 5. Add bash integration
    bash scripts/install-bash-integration.sh
fi

echo
echo "=== Installation Complete ==="
echo
echo "Next steps:"
echo "  1. Restart shell or run: source ~/.bashrc"
echo "  2. Start tmux"
echo "  3. In tmux, press Ctrl-a I to install plugins"
echo ""
echo "To install only tools: make install-tools"
echo "To install only configs: make install-configs"
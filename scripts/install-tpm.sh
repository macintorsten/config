#!/bin/bash

set -e

# Install Tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "✓ TPM installed"
    
    # Install tmux plugins if tmux is available
    if command -v tmux &> /dev/null && [ -f "$HOME/.tmux.conf" ]; then
        echo "Installing tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true
    fi
else
    echo "✓ TPM already installed"
fi

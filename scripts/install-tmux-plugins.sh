#!/bin/bash

set -e

# Install tmux plugins
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugins..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
    echo "✓ Tmux plugins installed"
else
    echo "⚠ TPM not found, skipping plugin installation"
fi

#!/bin/bash

set -e

echo "Configuring bash integration..."

# Check if dotfiles bashrc.d is already sourced
if ! grep -q "/.config/bashrc.d/\*.sh" ~/.bashrc 2>/dev/null; then
    cat >> ~/.bashrc << 'EOF'

# Source dotfiles configuration
if [ -d "$HOME/.config/bashrc.d" ]; then
    for rc in "$HOME/.config/bashrc.d"/*.sh; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi
EOF
    echo "✓ Added bashrc.d sourcing to ~/.bashrc"
else
    echo "bashrc.d already sourced in ~/.bashrc"
fi

echo "Bash configuration complete!"
echo "Note: Run 'source ~/.bashrc' or restart your shell to apply changes"

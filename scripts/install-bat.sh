#!/bin/bash

set -e

echo "Installing bat..."

# Ensure ~/.local/bin is in PATH
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

# Install bat if not already installed
if ! command -v bat &> /dev/null; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y bat
        # Ubuntu/Debian installs as 'batcat', create symlink
        if command -v batcat &> /dev/null && [ ! -f "$HOME/.local/bin/bat" ]; then
            mkdir -p "$HOME/.local/bin"
            ln -s "$(which batcat)" "$HOME/.local/bin/bat"
        fi
    else
        echo "Please install bat manually from https://github.com/sharkdp/bat"
        exit 1
    fi
    echo "✓ bat installed"
else
    echo "bat already installed"
fi

# Configure fzf to use bat for preview if not already configured
if ! grep -q "FZF_DEFAULT_OPTS.*--preview.*bat" ~/.bashrc; then
    # Find the line number where fzf.bash is sourced
    if grep -q '\[ -f ~/.fzf.bash \]' ~/.bashrc; then
        # Add after fzf.bash source
        cat >> ~/.bashrc << 'EOF'

# Use bat for fzf preview if available
if command -v bat &> /dev/null; then
    export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi
EOF
    else
        # Add at end if fzf.bash line not found
        cat >> ~/.bashrc << 'EOF'

# Use bat for fzf preview if available
if command -v bat &> /dev/null; then
    export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi
EOF
    fi
    echo "Added bat preview to fzf in ~/.bashrc"
fi

echo "bat installation complete!"

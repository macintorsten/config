#!/bin/bash

set -e

echo "Installing bat..."

# Install bat if not already installed
if ! command -v bat &> /dev/null; then
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y bat
        # Ubuntu/Debian installs as 'batcat', create symlink
        if command -v batcat &> /dev/null && [ ! -f "$HOME/.local/bin/bat" ]; then
            mkdir -p "$HOME/.local/bin"
            ln -s "$(which batcat)" "$HOME/.local/bin/bat"
            echo "Created bat symlink in ~/.local/bin"
        fi
    else
        echo "Please install bat manually from https://github.com/sharkdp/bat"
        exit 1
    fi
    echo "✓ bat installed"
else
    echo "bat already installed"
fi

echo "bat installation complete!"

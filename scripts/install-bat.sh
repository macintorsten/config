#!/bin/bash

set -e

echo "Installing bat..."

# Install bat if not already installed
if ! command -v bat &> /dev/null && ! command -v batcat &> /dev/null; then
    # Try apt-get first (requires sudo)
    if command -v apt-get &> /dev/null && ([ "$EUID" -eq 0 ] || sudo -n true 2>/dev/null); then
        sudo apt-get update
        sudo apt-get install -y bat
        # Ubuntu/Debian installs as 'batcat', create symlink
        if command -v batcat &> /dev/null && [ ! -f "$HOME/.local/bin/bat" ]; then
            mkdir -p "$HOME/.local/bin"
            ln -s "$(which batcat)" "$HOME/.local/bin/bat"
            echo "Created bat symlink in ~/.local/bin"
        fi
        echo "✓ bat installed via apt-get"
    else
        # Fallback: install from GitHub releases (no sudo needed)
        echo "No sudo access, installing bat from GitHub releases..."
        mkdir -p "$HOME/.local/bin"
        
        # Detect architecture
        ARCH=$(uname -m)
        case $ARCH in
            x86_64) BAT_ARCH="x86_64" ;;
            aarch64|arm64) BAT_ARCH="aarch64" ;;
            *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
        esac
        
        # Get latest release
        BAT_VERSION=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
        BAT_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-${BAT_ARCH}-unknown-linux-musl.tar.gz"
        
        echo "Downloading bat ${BAT_VERSION}..."
        curl -L "$BAT_URL" -o /tmp/bat.tar.gz
        tar -xzf /tmp/bat.tar.gz -C /tmp
        mv /tmp/bat-v${BAT_VERSION}-${BAT_ARCH}-unknown-linux-musl/bat "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/bat"
        rm -rf /tmp/bat.tar.gz /tmp/bat-v${BAT_VERSION}-*
        
        echo "✓ bat installed to ~/.local/bin"
    fi
else
    echo "bat already installed"
fi

echo "bat installation complete!"

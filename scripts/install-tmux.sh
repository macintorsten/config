#!/bin/bash

set -e

# Install tmux if not present
if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y tmux
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y tmux
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Sy --noconfirm tmux
    elif [ -f /etc/alpine-release ]; then
        sudo apk add tmux
    else
        echo "Unsupported distribution. Please install tmux manually."
        exit 1
    fi
    echo "✓ tmux installed"
else
    echo "✓ tmux already installed"
fi

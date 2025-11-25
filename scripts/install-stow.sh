#!/bin/bash

set -e

# Install GNU Stow for different distributions
if ! command -v stow &> /dev/null
then
    echo "Installing GNU Stow..."
    if [ -f /etc/debian_version ]; then
        # Debian/Ubuntu-based distributions
        sudo apt update && sudo apt install -y stow
    elif [ -f /etc/redhat-release ]; then
        # Red Hat/CentOS-based distributions
        sudo yum install -y epel-release && sudo yum install -y stow
    elif [ -f /etc/arch-release ]; then
        # Arch-based distributions
        sudo pacman -Sy --noconfirm stow
    elif [ -f /etc/alpine-release ]; then
        # Alpine Linux
        sudo apk add stow
    else
        echo "Unsupported distribution. Please install GNU Stow manually."
        exit 1
    fi
    echo "✓ GNU Stow installed"
else
    echo "✓ GNU Stow already installed"
fi

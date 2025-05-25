#!/bin/bash

# Install GNU Stow for different distributions
if ! command -v stow &> /dev/null
then
    echo "GNU Stow is not installed. Installing..."
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
else
    echo "GNU Stow is already installed."
fi

# Install all dotfiles using GNU Stow
cd $(dirname "$0") || exit 1
echo "Installing dotfiles using GNU Stow..."    
stow */
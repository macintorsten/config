#!/bin/bash

set -e

echo "Installing Oh My Posh..."

# Install unzip if not available (required for oh-my-posh installer)
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip dependency..."
    sudo apt-get update && sudo apt-get install -y unzip
fi

# Install oh-my-posh if not already installed
if ! command -v oh-my-posh &> /dev/null; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "✓ Oh My Posh installed"
else
    echo "Oh My Posh already installed"
fi

echo "Oh My Posh installation complete!"

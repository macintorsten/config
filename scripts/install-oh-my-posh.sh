#!/bin/bash

set -e

echo "Installing Oh My Posh..."

# Install oh-my-posh if not already installed
if ! command -v oh-my-posh &> /dev/null; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "✓ Oh My Posh installed"
else
    echo "Oh My Posh already installed"
fi

echo "Oh My Posh installation complete!"

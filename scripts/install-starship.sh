#!/bin/bash

set -e

echo "Installing Starship prompt..."

# Install starship if not already installed
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed"
fi

# Ensure starship init is in bashrc
if ! grep -q "starship init bash" ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    echo "Added starship init to ~/.bashrc"
fi

echo "Starship installation complete!"

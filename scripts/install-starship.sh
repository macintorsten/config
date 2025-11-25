#!/bin/bash

set -e

echo "Installing Starship prompt..."

# Install starship if not already installed
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo "✓ Starship installed"
else
    echo "Starship already installed"
fi

echo "Starship installation complete!"

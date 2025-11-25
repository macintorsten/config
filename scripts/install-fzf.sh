#!/bin/bash

set -e

# Install fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    # Run installer with auto-accept flags: update rc files, enable key bindings, enable fuzzy completion
    "$HOME/.fzf/install" --key-bindings --completion --update-rc
    echo "✓ fzf installed"
else
    echo "✓ fzf already installed"
fi

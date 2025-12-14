#!/usr/bin/env bash
# bat configuration with fzf preview integration

# Use bat for fzf preview if available
if command -v bat &> /dev/null; then
    export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

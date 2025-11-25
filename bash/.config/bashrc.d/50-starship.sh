#!/usr/bin/env bash
# Starship prompt configuration

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

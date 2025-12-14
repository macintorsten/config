#!/usr/bin/env bash
# Environment variables

# Default editor
export EDITOR=vim
export VISUAL=vim

# History settings
export HISTSIZE=10000           # Number of commands in memory
export HISTFILESIZE=20000       # Number of commands in history file
export HISTCONTROL=ignoreboth   # Ignore duplicates and commands starting with space
export HISTTIMEFORMAT="%F %T "  # Add timestamp to history

# Better less defaults (for man pages, git diff, etc)
export LESS="-R -F -X"          # R=colors, F=quit if one screen, X=no clear screen
export PAGER=less
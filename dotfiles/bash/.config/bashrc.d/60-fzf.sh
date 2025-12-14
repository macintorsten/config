#!/usr/bin/env bash
# fzf configuration

# Source fzf bash integration if available
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Preview files with bat (syntax highlighting) or cat, and directories with ls
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"

# Preview directories with ls for ALT-C
export FZF_ALT_C_OPTS="--preview 'ls -lah --color=always {}'"

# History search with bash syntax highlighting (remove history number)
export FZF_CTRL_R_OPTS="
  --preview 'echo {} | sed \"s/^[0-9]*\s*//\" | bat --style=plain --color=always -l bash'
  --preview-window down:3:wrap"

# Preview for ** completion (cd **, ls **, etc)
export FZF_COMPLETION_OPTS="--preview '[ -d {} ] && ls -lah --color=always {} || (bat --style=numbers --color=always {} 2>/dev/null || cat {})'"

# Default fzf options - enable multi-select, border, better height
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --multi --bind 'ctrl-a:select-all,ctrl-d:deselect-all'"

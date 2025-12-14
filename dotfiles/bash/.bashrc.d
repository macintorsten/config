# Dotfiles configuration loader
# Sourced by ~/.bashrc

if [ -d "$HOME/.config/bashrc.d" ]; then
    for rc in "$HOME/.config/bashrc.d"/*.sh; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi

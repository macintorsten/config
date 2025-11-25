# Dotfiles Repository

Personal configuration files managed with GNU Stow.

**Hybrid Bootstrap Approach:** This repository installs tools AND manages configurations. You can install tools separately from configs if desired.

## Tools Included

- **bash** - Modular shell configuration (PATH, aliases, integrations)
- **tmux** - Terminal multiplexer with TPM and plugins (dracula theme, tmux-logging)
- **vim** - Text editor with custom configuration
- **fzf** - Fuzzy finder with shell keybindings (CTRL-T, CTRL-R, ALT-C)
- **starship** - Fast, customizable cross-shell prompt with powerline theme
- **bat** - Cat clone with syntax highlighting and Git integration

## Requirements

- Git
- curl or wget (for fzf installation)
- make (optional, enables parallel installation)
- sudo access

## Installation

Full installation (tools + configs):

```sh
git clone https://github.com/macintorsten/config.git ~/config
cd ~/config
./install.sh
```

Install only tools (no config stowing):

```sh
make install-tools
```

Install only configs (requires tools already installed):

```sh
make install-configs
```

After installation, restart your shell:

```sh
source ~/.bashrc  # or ~/.zshrc
```

## Updating

```sh
cd ~/config
git pull
./install.sh
```

## Manual Installation

Install specific components:

```sh
make install-stow         # Install GNU Stow
make install-tools        # Install all tools
make install-configs      # Stow all configs
make install-tmux         # Install tmux
make install-tpm          # Install Tmux Plugin Manager
make install-fzf          # Install fzf
make install-starship     # Install Starship prompt
make install-bat          # Install bat
make install-dotfiles     # Symlink configs
make install-bash-integration  # Add sourcing to ~/.bashrc
```

## Testing

Test the installation in a Docker container:

```sh
make test              # Build and run automated tests
make test-interactive  # Start interactive test container
make test-build        # Build test container only
make test-run          # Run verification tests only
```

The interactive test allows you to try out the full environment with tmux, vim, fzf, and starship prompt.

## Configuration

All shell customizations are in `~/.config/bashrc.d/`:
- `00-path.sh` - PATH configuration
- `50-starship.sh` - Starship prompt initialization  
- `60-fzf.sh` - fzf shell integration
- `70-bat.sh` - bat with fzf preview

Key bindings:
- **tmux prefix**: `Ctrl-a`
- **tmux pane navigation**: `Ctrl-a h/j/k/l`
- **vim leader**: `,`
- **fzf file search**: `CTRL-T` (with bat preview)
- **fzf history**: `CTRL-R`
- **fzf directory**: `ALT-C`
- **bat**: Use `bat <file>` instead of `cat` for syntax highlighting

## Uninstalling

Remove the sourcing line from `~/.bashrc`:
```sh
# Remove these lines added by dotfiles:
# if [ -d "$HOME/.config/bashrc.d" ]; then
#     for rc in "$HOME/.config/bashrc.d"/*.sh; do
#         [ -f "$rc" ] && . "$rc"
#     done
#     unset rc
# fi
```

Unlink dotfiles:
```sh
cd ~/config
stow -D bash tmux vim starship bat
```

Remove installed tools:
```sh
rm -rf ~/.tmux/plugins/tpm ~/.fzf
# Uninstall other tools using your package manager
```
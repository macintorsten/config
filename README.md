# Dotfiles Repository

Personal configuration files managed with GNU Stow.

## Tools Included

- **tmux** - Terminal multiplexer with TPM and plugins (dracula theme, tmux-logging)
- **vim** - Text editor with custom configuration
- **fzf** - Fuzzy finder with shell keybindings (CTRL-T, CTRL-R, ALT-C)
- **starship** - Fast, customizable cross-shell prompt with powerline theme

## Requirements

- Git
- curl or wget (for fzf installation)
- make (optional, enables parallel installation)
- sudo access

## Installation

```sh
git clone https://github.com/macintorsten/config.git ~/config
cd ~/config
./install.sh
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
make install-stow    # Install GNU Stow
make install-tmux    # Install tmux
make install-tpm     # Install Tmux Plugin Manager
make install-fzf     # Install fzf
make install-starship # Install Starship prompt
make install-dotfiles # Symlink configs
```

## Configuration

- **tmux prefix**: `Ctrl-a`
- **tmux pane navigation**: `Ctrl-a h/j/k/l`
- **vim leader**: `,`
- **fzf file search**: `CTRL-T`
- **fzf history**: `CTRL-R`
- **fzf directory**: `ALT-C`

## Uninstalling

```sh
cd ~/config
stow -D tmux vim starship
rm -rf ~/.tmux/plugins/tpm ~/.fzf
```
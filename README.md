# Dotfiles Configuration Repository

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

Configurations are symlinked to your home directory. Tools can optionally be installed via provided scripts.

## Quick Start

```bash
# Clone repository
git clone https://github.com/macintorsten/config.git ~/config
cd ~/config

# Install stow (if needed)
sudo apt-get install stow  # Ubuntu/Debian
# or: brew install stow    # macOS
# or: bash scripts/install-stow.sh

# Deploy all configurations
cd dotfiles
stow */

# Add to ~/.bashrc (one-time)
cat >> ~/.bashrc << 'EOF'
if [ -d "$HOME/.config/bashrc.d" ]; then
    for rc in "$HOME/.config/bashrc.d"/*.sh; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi
EOF

# Reload shell
source ~/.bashrc
```

### Optional: Install Tools

If the configured tools aren't installed, use the scripts in `scripts/`:

```bash
cd ~/config/scripts
for script in install-*.sh; do bash "$script"; done
```

## Common Operations

```bash
# Update configurations
cd ~/config && git pull && cd dotfiles && stow -R */ && source ~/.bashrc

# Remove configurations
cd ~/config/dotfiles && stow -D */

# Preview changes (dry run)
cd ~/config/dotfiles && stow -n -v */
```

## Testing

Test the installation in a clean Ubuntu environment:

```bash
# Build Docker image
./test.sh

# Interactive testing (opens shell in test container)
./test.sh --interactive

# Inside the interactive container, test manually:
# - Start tmux (prefix: Ctrl-a)
# - Check oh-my-posh prompt
# - Try fzf commands: CTRL-T, CTRL-R, ALT-C
# - Use bat for syntax highlighting
```

The Dockerfile automatically:
1. Installs all tools via `scripts/install-*.sh`
2. Deploys all configs via `cd dotfiles && stow */`
3. Configures bash to source `.config/bashrc.d/`
4. Runs `test.sh` to verify everything works

You can also run tests manually:
```bash
./test.sh
```

## More Information

- **Stow usage**: `man stow` or [GNU Stow manual](https://www.gnu.org/software/stow/manual/)
- **Configuration structure**: See `dotfiles/` directory (each subdir is a stow package)
- **Key mappings**: Check individual config files (e.g., `dotfiles/tmux/.tmux.conf`)
- **Shell integration**: See `dotfiles/bash/.config/bashrc.d/` for modular shell configs

## Adding New Tools

```bash
# 1. Create package directory
mkdir -p dotfiles/<tool>/.config/<tool>

# 2. Add config files to the directory

# 3. Deploy (automatically discovered)
cd dotfiles && stow */

# 4. Optional: Create scripts/install-<tool>.sh for tool installation
# 5. Optional: Add bash/.config/bashrc.d/##-<tool>.sh for shell integration
```

See `AGENTS.md` for detailed framework documentation.
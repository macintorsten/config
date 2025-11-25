# Dotfiles Uninstall & Non-Root Installation Research

## Key Findings from Popular Dotfiles Repos

### Uninstall Approach

**Most dotfiles repos DO NOT provide uninstall scripts.** Here's what they typically do:

1. **mathiasbynens/dotfiles** (31k stars): Uses `rsync` to copy files. No uninstall. User must manually remove.

2. **webpro/dotfiles** (1.2k stars): Uses stow. No uninstall script. README just says "use `stow -D`".

3. **thoughtbot/dotfiles**: Uses `rcm`. Has `rcup` for install, `rcdn` for uninstall - but only removes symlinks, not tools.

4. **Common pattern**: Dotfiles repos focus on CONFIGURATION, not tool installation/removal.

### What "Uninstall" Typically Means

✅ **Remove symlinks** - Unstow configuration files
✅ **Remove config sourcing** - Remove lines from ~/.bashrc that source dotfile configs
❌ **DO NOT remove installed tools** - Tools stay installed (starship, bat, fzf remain on system)
❌ **DO NOT remove data** - Plugin directories, cache, etc. stay

**Reasoning**: Users may want tools independent of dotfiles. Applications are system-level, configs are user-level.

## Non-Root Installation

### Standard Approach

Most dotfiles assume **either/or**:
- User has root/sudo (can install tools system-wide)
- User already has tools installed (just want configs)

### Common Patterns for Non-Root Users

1. **Homebrew (macOS)**: Non-root package manager
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Linuxbrew/Home brew on Linux**: Non-root alternative to apt
   
3. **Manual user installs**: Download binaries to `~/.local/bin/`

4. **Skip if no sudo**: Check for sudo, skip tool installation if not available

### Examples from Research

**chezmoi** (popular dotfiles manager):
```bash
# Provides both methods
curl -fsLS get.chezmoi.io/lb | sh  # Non-root install to ./bin
sudo sh -c "$(curl -fsLS get.chezmoi.io)"  # Root install
```

**starship** (our use case):
```bash
# Already provides non-root install!
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir ~/.local/bin
```

## Recommendations for Our Repo

### 1. Uninstall Philosophy

**Adopt standard dotfiles approach:**
- Uninstall = Remove configs only
- Tools stay installed
- Give clear manual cleanup instructions

```
uninstall.sh should:
✅ stow -D (remove symlinks)
✅ Remove bashrc.d sourcing
✅ Backup ~/.bashrc
❌ NOT uninstall tools
ℹ️  Provide instructions for manual tool removal
```

### 2. Handle sudo/non-sudo gracefully

**Check for sudo, skip installations that need it:**

```bash
# Pattern for install scripts
if ! command -v <tool> &> /dev/null; then
    if command -v apt-get &> /dev/null && [ "$EUID" -eq 0 ] || sudo -n true 2>/dev/null; then
        # Has sudo, can install
        sudo apt-get install -y <tool>
    else
        echo "⚠️  <tool> not found and sudo not available"
        echo "   Install manually or run with sudo"
        echo "   Continuing without <tool>..."
    fi
fi
```

### 3. Support user-local installations

**Use ~/.local/bin for everything possible:**

- starship: Already supports `--bin-dir`
- bat: Already creates symlink to ~/.local/bin
- fzf: Already installs to ~/.fzf (user directory)
- tmux/tpm: Already user-local

**Only bat needs sudo for apt-get.** Others can be user-installed!

### 4. Document both paths clearly

**Update README with:**
```markdown
## Installation

### With sudo (recommended)
Full automatic installation of tools + configs

### Without sudo (limited)
- Installs configs
- Installs tools that don't require root (fzf, starship with --bin-dir)
- Skips tools that need sudo (bat via apt)
- You can install bat manually: download from GitHub releases
```

### 5. Make tools optional

**Core concept**: Configs work even if tool isn't installed

Our bashrc.d files already do this!
```bash
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi
```

This means: Install configs always, tools conditionally.

## Proposed Changes

### 1. Simplify uninstall.sh

```bash
# Remove configs only
# Keep tools (standard dotfiles approach)
# Provide manual cleanup instructions
```

### 2. Update install scripts

Add sudo checks, provide non-root alternatives where possible.

### 3. Document clearly

Two installation modes:
- Full (with sudo): Everything
- Minimal (without sudo): Configs + some tools

### 4. Already-installed tools

Our scripts already handle this:
```bash
if ! command -v <tool> &> /dev/null; then
    # install
else
    echo "<tool> already installed"  # Skip!
fi
```

This is correct - don't reinstall if present.

## Summary

**What we should do:**
1. ✅ Keep checking if tools exist (already doing)
2. ✅ Skip reinstalling if present (already doing)
3. ✅ Configs always work (already doing with conditional checks)
4. 🔧 Add sudo checks, gracefully skip tools that need it
5. 🔧 Simplify uninstall to remove configs only (industry standard)
6. 🔧 Document both sudo/non-sudo paths
7. 🔧 Provide manual tool install instructions for non-sudo users

**Uninstall should:**
- Remove symlinks (stow -D)
- Remove bashrc.d sourcing
- Keep installed tools
- Tell user how to manually remove tools if desired

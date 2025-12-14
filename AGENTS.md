# AI Agent Guide

Guide for AI agents working with this dotfiles configuration repository.

## Repository Philosophy

**Primary Purpose:** Configuration file management (dotfiles)  
**Secondary Purpose:** Optional tool installation for convenience

This is a **framework-based repository** that uses GNU Stow for symlink management. It's designed for easy extension with new tools and configurations.

## Quick Start

```bash
# Deploy configurations (all packages)
cd ~/config/dotfiles && stow */

# Remove configurations (all packages)
cd ~/config/dotfiles && stow -D */

# Test changes
./test.sh --interactive
```

**Note:** The repository auto-discovers packages and tools - no hardcoded lists!

## Repository Structure

**Clear Separation of Concerns:**

1. **Configuration Management** (Primary):
   - `<tool>/` directories contain configs managed by GNU Stow
   - `bash/.config/bashrc.d/*.sh` for modular shell integration
   - Symlinked to user's home directory via `stow -t ~ <packages>`

2. **Tool Installation** (Secondary):
   - `scripts/install-<tool>.sh` scripts install binaries only
   - Optional convenience layer
   - Not required if tools already installed

**Key Principle:** Use stow directly for all configuration management. No wrapper scripts needed.

**Framework Design:** The repository auto-discovers packages and install scripts - no hardcoded lists to maintain!

## Adding New Tools

**Framework Approach** - This repo is designed for easy extension:

### Step 1: Create Configuration Directory (Required)
```bash
mkdir -p dotfiles/<tool>/.config/<tool>
# Place config files here
```

### Step 2: Stow the Package (Required)
Users will run:
```bash
cd dotfiles
stow <tool>
# Or simply: stow */  (includes all packages automatically)
```

**No need to update hardcoded lists** - the framework auto-discovers new packages!

### Step 3: Shell Integration (If Needed)
Create `dotfiles/bash/.config/bashrc.d/##-<tool>.sh` with appropriate numbering:
- `00-` for PATH/environment
- `50-` for prompt/initialization
- `60-70` for tool integrations

**Example:**
```bash
#!/usr/bin/env bash
# NewTool configuration

if command -v newtool &> /dev/null; then
    eval "$(newtool init bash)"
fi
```

### Step 4: Tool Installation Script (Optional)
Create `scripts/install-<tool>.sh` for convenience:
```bash
#!/bin/bash
set -e
echo "Installing <tool>..."
# Installation commands here
```

**Note:** Installation scripts are completely optional.

### Step 5: Update Testing & Documentation
1. **Dockerfile** automatically discovers and runs all `scripts/install-*.sh`
   - No changes needed! Just create `scripts/install-<tool>.sh`

2. **Optional:** Update `README.md` "Tools Configured" list (for documentation only)

3. Test: `./test.sh --interactive` and verify manually in container

### Key Principle
**Configuration First, Tools Second:** The config structure is the core; tool installation is optional convenience.

## Removing Tools

Reverse the process:
1. Delete config directory: `dotfiles/<tool>/`
2. Delete shell integration: `dotfiles/bash/.config/bashrc.d/##-<tool>.sh` (if exists)
3. Delete install script: `scripts/install-<tool>.sh` (if exists)
4. Delete test script: `scripts/test-<tool>.sh` (if exists)
5. Optional: Update `README.md` "Tools Configured" list
6. Run test: `./test.sh`

**Note:** No hardcoded lists to update - the framework auto-discovers remaining tools!

## Testing

Reverse the process:
1. Delete config directory: `dotfiles/<tool>/`
2. Delete shell integration: `dotfiles/bash/.config/bashrc.d/##-<tool>.sh` (if exists)
3. Delete install script: `scripts/install-<tool>.sh` (if exists)
4. Optional: Update `README.md` "Tools Configured" list
5. Test: `./test.sh --interactive`

**Note:** No hardcoded lists to update - the framework auto-discovers remaining tools!orks as expected.

## Review Checklist Before Staging

- [ ] Config follows stow structure (`<tool>/.config/` or `<tool>/.<tool>rc`)
- [ ] Install script only installs binary (no bashrc modification)
- [ ] Shell integration uses bashrc.d/ (not ~/.bashrc directly)
- [ ] Optional: Add specific verification to `Dockerfile.test`
- [ ] Optional: Update `README.md` "Tools Configured" list (documentation only)
- [ ] Docker test passes
- [ ] Changes follow framework principles (configs first, tools second)
- [ ] Human reviews and commits manually

**Remember:** The framework auto-discovers packages and install scripts - no hardcoded lists required!

## Key Patterns

**Stow structure:**
- `dotfiles/<tool>/.config/file` → `~/.config/file`
- `dotfiles/<tool>/.<tool>rc` → `~/.<tool>rc`

**Shell integration:**
- Create `dotfiles/bash/.config/bashrc.d/##-<tool>.sh`
- Never modify `~/.bashrc` directly

**Usage:**
- Users run stow from dotfiles directory: `cd dotfiles && stow */`
- No wrapper scripts for configuration management
- No `-t ~` flag needed (stow defaults to parent directory)

**Framework principle:**
The repository structure supports unlimited tools through consistent patterns and auto-discovery.

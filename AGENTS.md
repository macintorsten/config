# AI Agent Guide

Guide for AI agents working with this dotfiles repository.

## Quick Start

Run `make help` for all available commands. Use `make test` to verify changes.

## Repository Structure

**Separation of Concerns:**
- Tool installation: `scripts/install-<tool>.sh` (installs binaries only)
- Configuration: `<tool>/` directories (managed by GNU Stow)
- Shell integration: `bash/.config/bashrc.d/*.sh` (modular sourcing)

## Adding New Tools

1. Create `scripts/install-<tool>.sh` - **Install binary only**, no bashrc modification
2. Add config in `<tool>/` using GNU Stow structure (`.config/` or `.<tool>rc`)
3. If shell integration needed, create `bash/.config/bashrc.d/##-<tool>.sh` (use numbering: 00, 50, 60, etc.)
4. Add tool to stow command in `scripts/install-dotfiles.sh`
5. Add verification to `Dockerfile.test` (test config exists + binary in PATH)
6. Update all sections in `README.md` (see existing tools)
7. Run `make test`

**Example shell integration file** (`bash/.config/bashrc.d/50-newtool.sh`):
```bash
#!/usr/bin/env bash
# NewTool configuration

if command -v newtool &> /dev/null; then
    eval "$(newtool init bash)"
fi
```

## Removing Tools

Reverse the process: delete install script, config directory, bashrc.d file (if any), remove from `install-dotfiles.sh`, `Dockerfile.test`, and `README.md`. Then run `make test`.

## Testing

Use `make test` for automated verification. Use `make test-interactive` for manual testing in container.

## Review Before Staging

- [ ] Install script only installs binary (no bashrc modification)
- [ ] Config in proper stow structure
- [ ] Shell integration in bashrc.d/ if needed
- [ ] Verification added to `Dockerfile.test`
- [ ] `make test` passes
- [ ] README.md updated (all sections)
- [ ] Changes are minimal
- [ ] Human reviews and commits manually

## Key Patterns

**Stow maps**: `<tool>/.config/file` → `~/.config/file` and `<tool>/.<tool>rc` → `~/.<tool>rc`

**Shell integration**: Create `bash/.config/bashrc.d/##-<tool>.sh` instead of modifying ~/.bashrc

**Makefile**: Auto-discovers install scripts. Use `make install-tools` for tools only, `make install-configs` for configs only

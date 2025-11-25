# AI Agent Guide

Guide for AI agents working with this dotfiles repository.

## Quick Start

Run `make help` for all available commands. Use `make test` to verify changes.

## Adding New Tools

1. Create `scripts/install-<tool>.sh` (see existing scripts for patterns)
2. Add config in `<tool>/` using GNU Stow structure (`.config/` or `.<tool>rc`)
3. Add tool to stow command in `scripts/install-dotfiles.sh`
4. Add verification to `Dockerfile.test` (test file exists + binary in PATH)
5. Update all sections in `README.md` (see existing tools)
6. Run `make test`

## Removing Tools

Reverse the process above: delete script, config directory, remove from `install-dotfiles.sh`, `Dockerfile.test`, and `README.md`. Then run `make test`.

## Testing

Use `make test` for automated verification. Use `make test-interactive` for manual testing in container.

## Review Before Staging

- [ ] Verification added to `Dockerfile.test`
- [ ] `make test` passes
- [ ] Install script is idempotent
- [ ] README.md updated (all sections)
- [ ] Changes are minimal
- [ ] Human reviews and commits manually

## Key Patterns

**Stow maps**: `<tool>/.config/file` → `~/.config/file` and `<tool>/.<tool>rc` → `~/.<tool>rc`

**Makefile**: Auto-discovers install scripts, no edits needed for new tools

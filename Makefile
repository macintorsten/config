.PHONY: all install help test test-build test-run test-interactive install-tools install-configs remove-configs

SCRIPTS_DIR := scripts
TOOL_SCRIPTS := $(wildcard $(SCRIPTS_DIR)/install-*.sh)
TOOL_TARGETS := $(patsubst $(SCRIPTS_DIR)/install-%.sh,%,$(filter-out $(SCRIPTS_DIR)/install-stow.sh $(SCRIPTS_DIR)/install-dotfiles.sh $(SCRIPTS_DIR)/install-tmux-plugins.sh $(SCRIPTS_DIR)/install-bash-integration.sh,$(TOOL_SCRIPTS)))
IMAGE_NAME := config-test

all: install

# Full installation: tools + configs
install: install-stow install-tools install-configs install-bash-integration
	@echo ""
	@echo "=== Installation Complete ==="
	@echo "Run: source ~/.bashrc"

# Install only tools (no config stowing)
install-tools: install-stow
	@$(MAKE) -j $(words $(TOOL_TARGETS)) $(addprefix install-,$(TOOL_TARGETS))

# Install only configs (stow dotfiles, then install plugins that depend on configs)
install-configs:
	@$(MAKE) install-dotfiles
	@$(MAKE) install-tmux-plugins

install-%:
	@bash $(SCRIPTS_DIR)/install-$*.sh

remove-configs:
	@bash remove-configs.sh

test: test-build test-run

test-build:
	@echo "Building test container..."
	@docker build -f Dockerfile.test -t $(IMAGE_NAME) .

test-run: test-build
	@echo "Running verification tests..."
	@docker run --rm $(IMAGE_NAME) bash -c "echo 'All installation checks passed!' && starship --version"

test-interactive: test-build
	@echo "Starting interactive test container..."
	@echo "Press Ctrl+D or type 'exit' to leave the container"
	@docker run --rm -it $(IMAGE_NAME) bash

help:
	@echo "Available targets:"
	@echo "  make install           - Install all components (default)"
	@echo "  make install-tools     - Install only tools (no configs)"
	@echo "  make install-configs   - Install only configs (stow dotfiles)"
	@echo "  make remove-configs    - Remove dotfile configs (interactive)"
	@echo "  make test              - Build and run automated tests"
	@echo "  make test-build        - Build test Docker container"
	@echo "  make test-run          - Run automated verification tests"
	@echo "  make test-interactive  - Start interactive test container"
	@echo "  make help              - Show this help"
	@echo ""
	@echo "Individual targets:"
	@for script in $(TOOL_SCRIPTS) $(SCRIPTS_DIR)/install-stow.sh $(SCRIPTS_DIR)/install-dotfiles.sh; do \
		target=$$(basename $$script .sh | sed 's/install-//'); \
		echo "  make install-$$target"; \
	done | sort -u


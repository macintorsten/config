.PHONY: all install help test test-build test-run test-interactive

SCRIPTS_DIR := scripts
TOOL_SCRIPTS := $(wildcard $(SCRIPTS_DIR)/install-*.sh)
TOOL_TARGETS := $(patsubst $(SCRIPTS_DIR)/install-%.sh,%,$(filter-out $(SCRIPTS_DIR)/install-stow.sh $(SCRIPTS_DIR)/install-dotfiles.sh $(SCRIPTS_DIR)/install-tmux-plugins.sh,$(TOOL_SCRIPTS)))
IMAGE_NAME := config-test

all: install

install: install-stow
	@$(MAKE) -j $(words $(TOOL_TARGETS)) $(addprefix install-,$(TOOL_TARGETS))
	@$(MAKE) install-dotfiles
	@$(MAKE) install-tmux-plugins

install-%:
	@bash $(SCRIPTS_DIR)/install-$*.sh

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


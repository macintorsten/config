.PHONY: all install help

SCRIPTS_DIR := scripts
TOOL_SCRIPTS := $(wildcard $(SCRIPTS_DIR)/install-*.sh)
TOOL_TARGETS := $(patsubst $(SCRIPTS_DIR)/install-%.sh,%,$(filter-out $(SCRIPTS_DIR)/install-stow.sh $(SCRIPTS_DIR)/install-dotfiles.sh $(SCRIPTS_DIR)/install-tmux-plugins.sh,$(TOOL_SCRIPTS)))

all: install

install: install-stow
	@$(MAKE) -j $(words $(TOOL_TARGETS)) $(addprefix install-,$(TOOL_TARGETS))
	@$(MAKE) install-dotfiles
	@$(MAKE) install-tmux-plugins

install-%:
	@bash $(SCRIPTS_DIR)/install-$*.sh

help:
	@echo "Available targets:"
	@echo "  make install  - Install all components (default)"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Individual targets:"
	@for script in $(TOOL_SCRIPTS) $(SCRIPTS_DIR)/install-stow.sh $(SCRIPTS_DIR)/install-dotfiles.sh; do \
		target=$$(basename $$script .sh | sed 's/install-//'); \
		echo "  make install-$$target"; \
	done | sort -u


FROM ubuntu:latest

# Install prerequisites (this layer will be cached)
RUN apt-get update && \
    apt-get install -y git sudo tmux vim curl make unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create test user
RUN useradd -m -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy only install scripts (cached unless scripts change)
COPY --chown=testuser:testuser scripts/ /home/testuser/config/scripts/

# Install tools by running all install scripts (cached unless scripts change)
RUN cd /home/testuser/config/scripts && \
    for script in install-*.sh; do \
        echo "Running $script..."; \
        bash "$script" || exit 1; \
    done

# Copy configuration files (invalidates cache when configs change)
COPY --chown=testuser:testuser dotfiles/ /home/testuser/config/dotfiles/

# Deploy all configurations using stow
RUN cd /home/testuser/config/dotfiles && \
    stow -t ~ */ && \
    echo '[ -f "$HOME/.bashrc.d" ] && . "$HOME/.bashrc.d"' >> /home/testuser/.bashrc

CMD ["/bin/bash"]

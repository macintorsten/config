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

# Copy dotfiles repo (this layer will change frequently)
COPY --chown=testuser:testuser . /home/testuser/config

# Install tools by running all install scripts
RUN cd /home/testuser/config/scripts && \
    for script in install-*.sh; do \
        echo "Running $script..."; \
        bash "$script" || exit 1; \
    done

# Deploy all configurations using stow
RUN cd /home/testuser/config/dotfiles && \
    stow -t ~ */ && \
    echo 'if [ -d "$HOME/.config/bashrc.d" ]; then for rc in "$HOME/.config/bashrc.d"/*.sh; do [ -f "$rc" ] && . "$rc"; done; unset rc; fi' >> /home/testuser/.bashrc

CMD ["/bin/bash"]

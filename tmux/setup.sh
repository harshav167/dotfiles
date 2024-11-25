#!/usr/bin/env bash

# Set up error handling
set -euo pipefail

# Define paths
CONFIG_DIR="$HOME/.config/tmux"
REPO_URL="https://github.com/tmux-plugins/tpm"
TPM_DIR="$HOME/.tmux/plugins/tpm"

# Function to display status messages
print_status() {
    echo "==> $1"
}

# Create ~/.config/tmux if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
    print_status "Creating tmux config directory at $CONFIG_DIR"
    mkdir -p "$CONFIG_DIR"
fi

# Clone TPM if it doesn't exist
if [ ! -d "$TPM_DIR" ]; then
    print_status "Cloning TPM (Tmux Plugin Manager)"
    mkdir -p "$TPM_DIR"
    git clone "$REPO_URL" "$TPM_DIR"
else
    print_status "TPM already installed, skipping..."
fi

# Copy tmux configuration files
if [ -d "tmux" ]; then
    print_status "Copying tmux configuration files"
    cp -r tmux/* "$CONFIG_DIR/"

    # Create symlink for tmux.conf if it doesn't exist
    if [ ! -f "$HOME/.tmux.conf" ]; then
        print_status "Creating symlink for tmux.conf"
        ln -s "$CONFIG_DIR/tmux.conf" "$HOME/.tmux.conf"
    fi

    print_status "Installation complete!"
    print_status "Please restart tmux and press 'prefix + I' to install plugins"
else
    print_status "Error: tmux configuration directory not found!"
    exit 1
fi

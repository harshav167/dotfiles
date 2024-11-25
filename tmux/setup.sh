#!/usr/bin/env bash

# Set up error handling
set -euo pipefail

# Define paths
CONFIG_DIR="$HOME/.config/tmux"
REPO_URL="https://github.com/tmux-plugins/tpm"
TPM_DIR="$HOME/.tmux/plugins/tpm"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to display status messages
print_status() {
    echo "==> $1"
}

# Remove existing tmux config directory if it exists
if [ -d "$CONFIG_DIR" ]; then
    print_status "Removing existing tmux config directory"
    rm -rf "$CONFIG_DIR"
fi

# Create symlink from current directory to ~/.config/tmux
print_status "Creating symlink for tmux config directory"
ln -s "$CURRENT_DIR" "$CONFIG_DIR"

# Clone TPM if it doesn't exist
if [ ! -d "$TPM_DIR" ]; then
    print_status "Cloning TPM (Tmux Plugin Manager)"
    mkdir -p "$TPM_DIR"
    git clone "$REPO_URL" "$TPM_DIR"
else
    print_status "TPM already installed, skipping..."
fi

# Create symlink for tmux.conf if it doesn't exist
if [ ! -f "$HOME/.tmux.conf" ]; then
    print_status "Creating symlink for tmux.conf"
    ln -s "$CONFIG_DIR/tmux.conf" "$HOME/.tmux.conf"
fi

print_status "Installation complete!"
print_status "Please restart tmux and press 'prefix + I' to install plugins"

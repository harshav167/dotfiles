#!/bin/bash

# Exit on error
set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to print success message
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error message
print_error() {
    echo -e "${RED}✗ $1${NC}"
    exit 1
}

# Function to print info message
print_info() {
    echo -e "${YELLOW}i $1${NC}"
}

echo "Running dotfiles verification tests..."

# Check if essential tools are installed
echo "Checking essential tools..."

# Check Neovim
if command -v nvim >/dev/null 2>&1; then
    print_success "Neovim is installed"
else
    print_error "Neovim is not installed"
fi

# Check TMux
if command -v tmux >/dev/null 2>&1; then
    print_success "Tmux is installed"
else
    print_error "Tmux is not installed"
fi

# Check LazyGit
if command -v lazygit >/dev/null 2>&1; then
    print_success "LazyGit is installed"
else
    print_error "LazyGit is not installed"
fi

# Check ripgrep
if command -v rg >/dev/null 2>&1; then
    print_success "ripgrep is installed"
else
    print_error "ripgrep is not installed"
fi

# Check fd-find
if command -v fd >/dev/null 2>&1 || command -v fdfind >/dev/null 2>&1; then
    print_success "fd-find is installed"
else
    print_error "fd-find is not installed"
fi

# Check for LunarVim
if [ -d "$HOME/.local/share/lunarvim" ] || [ -d "$HOME/.config/lvim" ]; then
    print_success "LunarVim configuration is present"
else
    print_error "LunarVim configuration is missing"
fi

# Check for tmux configuration
if [ -d "$HOME/.tmux" ] || [ -f "$HOME/.tmux.conf" ]; then
    print_success "Tmux configuration is present"
else
    print_error "Tmux configuration is missing"
fi

# Check if zsh is the default shell
if [ "$(basename "$SHELL")" = "zsh" ]; then
    print_success "Zsh is the default shell"
else
    print_error "Zsh is not the default shell"
fi

echo ""
print_success "All tests passed! Your dotfiles installation looks good."

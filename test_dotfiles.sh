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

# Check if the dotfiles repository is cloned
if [ -d "$HOME/dotfiles" ]; then
    print_success "Dotfiles repository exists"
else
    print_error "Dotfiles repository is missing"
fi

# Check if essential tools are installed
echo "Checking essential tools..."

# Check vim
if command -v vim >/dev/null 2>&1; then
    print_success "Vim is installed"
else
    print_error "Vim is not installed"
fi

# Check TMux
if command -v tmux >/dev/null 2>&1; then
    print_success "Tmux is installed"
else
    print_error "Tmux is not installed"
fi

# Check ripgrep
if command -v rg >/dev/null 2>&1; then
    print_success "ripgrep is installed"
else
    print_error "ripgrep is not installed"
fi

# Check fd-find
if command -v fd >/dev/null 2>&1; then
    print_success "fd-find is installed"
else
    print_error "fd-find is not installed"
fi

# Check if zsh is the default shell
if [ "$(basename "$SHELL")" = "zsh" ]; then
    print_success "Zsh is the default shell"
else
    print_error "Zsh is not the default shell"
fi

# Check basic directory structure
if [ -d "$HOME/.config" ]; then
    print_success "Config directory exists"
else
    print_error "Config directory is missing"
fi

if [ -d "$HOME/.tmux" ]; then
    print_success "Tmux directory exists"
else
    print_error "Tmux directory is missing"
fi

echo ""
print_success "All tests passed! Your basic dotfiles environment is set up."

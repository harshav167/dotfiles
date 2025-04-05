#!/bin/bash

# Exit on error
set -e

echo "==== Starting dotfiles installation ===="

# Install Homebrew (idempotent)
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed, skipping installation."
fi

# Add Homebrew to PATH immediately for this script
if [[ $(uname) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    # Install build dependencies for Linux if needed
    if command -v apt-get &>/dev/null && ! dpkg -l build-essential &>/dev/null; then
        echo "Installing build essentials for Linux..."
        sudo apt-get update
        sudo apt-get install -y build-essential
    fi
fi

# Add Homebrew to shell profile if not already added
if [[ $(uname) == "Darwin" ]]; then
    if ! grep -q "brew shellenv" ~/.zshrc; then
        echo "Adding Homebrew to PATH in ~/.zshrc..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zshrc
    fi
else
    if ! grep -q "brew shellenv" ~/.zshrc && [ -d "/home/linuxbrew/.linuxbrew" ]; then
        echo "Adding Homebrew to PATH in ~/.zshrc..."
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
    fi
fi

# Install packages (brew handles idempotence)
echo "Installing packages with Homebrew..."
brew install neovim ripgrep git lazygit lazydocker tmux fd

# Install LunarVim if not already installed
if ! command -v lvim &>/dev/null; then
    echo "Installing LunarVim..."
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
else
    echo "LunarVim already installed, skipping installation."
fi

# Create config directories
echo "Setting up config directories..."
mkdir -p ~/.config/lvim
mkdir -p ~/.tmux

# Copy configurations (possibly overwrite existing ones to ensure latest version)
echo "Copying configurations..."
cp -r lvim/* ~/.config/lvim/
cp -r tmux/* ~/.tmux/
if [ -f tmux/tmux.conf ]; then
    cp tmux/tmux.conf ~/.tmux/
fi

# Set up shell config if not already set up
if ! grep -q "# Added by dotfiles install" ~/.zshrc; then
    echo "Configuring shell..."
    # Add PATH adjustments
    cat <<EOT >>~/.zshrc
# Added by dotfiles install
export PATH=\$HOME/.local/bin:\$PATH
# For fd-find alternatives that might be installed as fdfind
[ -f /usr/bin/fdfind ] && alias fd=fdfind
# Add LunarVim to path
export PATH=\$HOME/.local/bin:\$PATH
EOT
else
    echo "Shell already configured, skipping."
fi

echo "==== Dotfiles installation complete! ===="
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."

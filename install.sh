#!/bin/bash

set -e # Exit on error

echo "==== Starting dotfiles installation ===="

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH based on platform
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # Linux
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>$HOME/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Install required packages with Homebrew
echo "Installing packages with Homebrew..."
brew install neovim ripgrep git curl lazygit lazydocker tmux fd python3

# Install Rust and Cargo if not installed
if ! command -v rustc &>/dev/null; then
    echo "Installing Rust and Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Install pynvim for Python support
echo "Installing pynvim..."
pip3 install pynvim

# Install nvm (Node Version Manager) if not installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

    # Set up NVM in shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    # Install latest LTS version of Node.js
    nvm install --lts
    nvm use --lts

    # Install global packages
    npm install -g neovim
fi

# Install chezmoi if it's not already installed
if ! command -v chezmoi &>/dev/null; then
    echo "Installing chezmoi..."
    if command -v brew &>/dev/null; then
        brew install chezmoi
    else
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
        export PATH="$HOME/.local/bin:$PATH"
    fi
fi

# Initialize and apply dotfiles
echo "Initializing dotfiles with chezmoi..."
chezmoi init --apply https://github.com/harshav167/dotfiles.git

# Install LunarVim if not installed
if ! command -v lvim &>/dev/null; then
    echo "Installing LunarVim..."
    export LV_BRANCH='release-1.4/neovim-0.9'
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

    # Set up PATH for LunarVim
    export PATH="$HOME/.local/bin:$PATH"
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.zshrc
    else
        echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.bashrc
    fi
fi

# Install Nerd Font
echo "Installing Hack Nerd Font..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
else
    # Linux
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack-Regular-Nerd-Font-Complete.ttf"
    fc-cache -f -v
fi

echo "==== Installation complete! ===="
echo "Your dotfiles have been set up with chezmoi."
echo "You might need to restart your terminal or source your shell configuration."
echo "You can now use:"
echo "- lvim - LunarVim"
echo "- tmux - Terminal multiplexer"
echo "- lazygit - Git UI"
echo "- lazydocker - Docker UI"

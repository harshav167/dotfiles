#!/bin/bash

# Exit on error
set -e

echo "==== Starting dotfiles installation ===="

# Install Homebrew (idempotent and non-interactive)
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
        sudo apt-get update -y
        sudo apt-get install -y build-essential
    fi
fi

# Add Homebrew to shell profile if not already added
if [[ $(uname) == "Darwin" ]]; then
    if ! grep -q "brew shellenv" ~/.zshrc 2>/dev/null; then
        echo "Adding Homebrew to PATH in ~/.zshrc..."
        mkdir -p ~/.zshrc.d
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zshrc
    fi
else
    if ! grep -q "brew shellenv" ~/.zshrc 2>/dev/null && [ -d "/home/linuxbrew/.linuxbrew" ]; then
        echo "Adding Homebrew to PATH in ~/.zshrc..."
        mkdir -p ~/.zshrc.d
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
    fi
fi

# Install packages (brew handles idempotence) - we add the --no-quarantine flag to avoid macOS security prompts
echo "Installing packages with Homebrew..."
export HOMEBREW_NO_AUTO_UPDATE=1
brew install --no-quarantine neovim ripgrep git lazygit lazydocker tmux fd

# Setup Python dependencies for LunarVim
setup_python_deps() {
    echo "Installing Python dependencies for LunarVim globally..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y python3-pip
    fi
    python3 -m pip install --user --break-system-packages pynvim
}

# Setup Node.js with nvm for LunarVim
setup_nodejs() {
    echo "Setting up Node.js with nvm for LunarVim..."

    # Install nvm if not already installed
    if [ ! -d "$HOME/.nvm" ]; then
        echo "Installing nvm..."
        export PROFILE=/dev/null # Avoid modifying profile during installation
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

        # Load nvm immediately for this script
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    else
        echo "nvm already installed, loading it..."
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi

    # Install latest Node.js if not already installed (non-interactively)
    if ! command -v node &>/dev/null; then
        echo "Installing latest LTS Node.js..."
        nvm install --lts --no-progress
        nvm alias default node
    fi

    # Install neovim npm package
    echo "Installing neovim npm package..."
    npm install -g neovim --silent
}

# Setup Rust and Cargo with rustup
setup_rust() {
    echo "Setting up Rust and Cargo with rustup..."

    if ! command -v rustc &>/dev/null; then
        echo "Installing Rust via rustup..."
        # Use -y flag for non-interactive installation and disable modifying the PATH
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

        # Source cargo environment for this script
        source "$HOME/.cargo/env"
    else
        echo "Rust already installed, updating..."
        source "$HOME/.cargo/env"
        rustup update
    fi

    # Verify installation
    echo "Rust version: $(rustc --version)"
    echo "Cargo version: $(cargo --version)"
}

# Fix LunarVim TreeSitter compatibility issues
fix_lunarvim_compatibility() {
    echo "Fixing potential compatibility issues with LunarVim and newer Neovim versions..."

    if [ -d "$HOME/.local/share/lunarvim" ]; then
        echo "Updating nvim-treesitter to be compatible with your Neovim version..."

        # Define the path to nvim-treesitter
        TREESITTER_PATH="$HOME/.local/share/lunarvim/site/pack/lazy/opt/nvim-treesitter"

        if [ -d "$TREESITTER_PATH" ]; then
            echo "Found nvim-treesitter at $TREESITTER_PATH"
            echo "Updating nvim-treesitter from git..."
            git -C "$TREESITTER_PATH" pull origin master --rebase
            echo "nvim-treesitter updated successfully."
        else
            echo "nvim-treesitter not found at expected location. Checking for alternative paths..."

            # Try to find nvim-treesitter in other possible locations
            ALTERNATIVE_PATH=$(find "$HOME/.local/share/lunarvim" -type d -name "nvim-treesitter" | head -n 1)

            if [ -n "$ALTERNATIVE_PATH" ]; then
                echo "Found nvim-treesitter at $ALTERNATIVE_PATH"
                echo "Updating nvim-treesitter from git..."
                git -C "$ALTERNATIVE_PATH" pull origin master --rebase
                echo "nvim-treesitter updated successfully."
            else
                echo "Could not locate nvim-treesitter directory. Skipping update."
            fi
        fi

        echo "LunarVim compatibility fixes applied."
    else
        echo "LunarVim not found, skipping compatibility fixes."
    fi
}

# Install LunarVim if not already installed
if ! command -v lvim &>/dev/null; then
    echo "Installing LunarVim..."
    # Setup dependencies first
    setup_python_deps
    setup_nodejs
    setup_rust

    # Install LunarVim with the specified branch (using yes to auto-confirm prompts)
    # Using the latest release branch 1.4 for neovim 0.9
    yes | LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

    # Fix compatibility issues after installation
    fix_lunarvim_compatibility
else
    echo "LunarVim already installed, checking dependencies..."
    # Still ensure dependencies are set up
    setup_python_deps
    setup_nodejs
    setup_rust

    # Fix compatibility issues with existing installation
    fix_lunarvim_compatibility
fi

# Create config directories
echo "Setting up config directories..."
mkdir -p ~/.config/lvim
mkdir -p ~/.tmux

# Copy configurations (possibly overwrite existing ones to ensure latest version)
echo "Copying configurations..."
cp -r lvim/* ~/.config/lvim/ 2>/dev/null || true
cp -r tmux/* ~/.tmux/ 2>/dev/null || true

# Fix for tmux configuration - ensure the main tmux.conf is in the right location
if [ -f tmux/tmux.conf ]; then
    echo "Installing tmux.conf to home directory..."
    cp tmux/tmux.conf ~/.tmux.conf
    # Also keep a copy in the ~/.tmux directory
    cp tmux/tmux.conf ~/.tmux/
elif [ -f ~/.tmux/tmux.conf ]; then
    # If we have a config in ~/.tmux but not at the root, copy it to the root
    echo "Linking existing tmux.conf to home directory..."
    cp ~/.tmux/tmux.conf ~/.tmux.conf
fi

# Create tmux.conf with a source command if it doesn't exist
if [ ! -f ~/.tmux.conf ]; then
    echo "Creating default tmux.conf..."
    echo "source-file ~/.tmux/tmux.conf" >~/.tmux.conf
fi

# Set up shell config if not already set up
if ! grep -q "# Added by dotfiles install" ~/.zshrc 2>/dev/null; then
    echo "Configuring shell..."
    # Add PATH adjustments
    cat <<EOT >>~/.zshrc
# Added by dotfiles install
export PATH=\$HOME/.local/bin:\$PATH
# For fd-find alternatives that might be installed as fdfind
[ -f /usr/bin/fdfind ] && alias fd=fdfind
# Add LunarVim to path
export PATH=\$HOME/.local/bin:\$PATH
# Add Cargo to path
[ -f \$HOME/.cargo/env ] && source \$HOME/.cargo/env
# Add nvm to environment
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOT
else
    echo "Shell already configured, skipping."
fi

echo "==== Dotfiles installation complete! ===="
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."

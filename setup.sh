
#!/bin/bash

# Update the PATH to include the local bin directory
export PATH="$HOME/.local/bin:$PATH"

# Update package lists and install necessary packages
sudo apt update && sudo apt install -y npm curl python3-pip git neovim

# Configure npm to avoid permission issues
mkdir -p $HOME/.npm-global
npm config set prefix '~/.npm-global'
export PATH="$HOME/.npm-global/bin:$PATH"
echo "export PATH=$HOME/.npm-global/bin:$PATH" >> ~/.bashrc

# Install the pynvim package, required for neovim python support
pip3 install pynvim

# Install Rust and the ripgrep utility
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
cargo install ripgrep

# Non-interactive installation of LunarVim
export LV_BRANCH='release-1.4/neovim-0.9'
echo "yes" | bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

# Download and install Hack Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack-Regular-Nerd-Font-Complete.ttf"
fc-cache -f -v  # Refresh font cache

# Source the .bashrc to apply the path changes in the current session
source ~/.bashrc

echo "Installation and configuration completed successfully. You can start LunarVim by typing 'lvim'."

#!/bin/bash

set -e # Exit on error

echo "==== Setting up chezmoi structure ===="

# Create the chezmoi source directory
CHEZMOI_SRC="$HOME/.local/share/chezmoi"
mkdir -p "$CHEZMOI_SRC"

# Init chezmoi with the current repo
cd "$(dirname "$0")"
REPO_PATH="$(pwd)"

# Initialize chezmoi
chezmoi init

# Add LunarVim config files
echo "Adding LunarVim config files..."
if [ -d "$REPO_PATH/.config/lvim" ]; then
    mkdir -p "$CHEZMOI_SRC/private_dot_config/lvim"
    cp -r "$REPO_PATH/.config/lvim/"* "$CHEZMOI_SRC/private_dot_config/lvim/"
elif [ -d "$REPO_PATH/lvim" ]; then
    mkdir -p "$CHEZMOI_SRC/private_dot_config/lvim"
    cp -r "$REPO_PATH/lvim/"* "$CHEZMOI_SRC/private_dot_config/lvim/"
fi

# Add tmux config files
echo "Adding tmux config files..."
if [ -d "$REPO_PATH/.config/tmux" ]; then
    mkdir -p "$CHEZMOI_SRC/private_dot_config/tmux"
    cp -r "$REPO_PATH/.config/tmux/"* "$CHEZMOI_SRC/private_dot_config/tmux/"
elif [ -d "$REPO_PATH/tmux" ]; then
    mkdir -p "$CHEZMOI_SRC/dot_tmux"
    cp -r "$REPO_PATH/tmux/"* "$CHEZMOI_SRC/dot_tmux/"
fi

# Add scripts
echo "Adding scripts..."
mkdir -p "$CHEZMOI_SRC/bin"
cp "$REPO_PATH/install.sh" "$CHEZMOI_SRC/bin/install.sh"
chmod +x "$CHEZMOI_SRC/bin/install.sh"

# Create .chezmoi.toml.tmpl config file
echo "Creating chezmoi config template..."
cat >"$CHEZMOI_SRC/.chezmoi.toml.tmpl" <<'EOF'
# Chezmoi configuration file
# See https://www.chezmoi.io/reference/configuration-file/ for more details

[data]
    name = "{{ promptString "name" }}"
    email = "{{ promptString "email" }}"
    
    # Platform detection
    [data.platform]
        isMacOS = {{ eq .chezmoi.os "darwin" }}
        isLinux = {{ eq .chezmoi.os "linux" }}
EOF

echo "==== Chezmoi structure setup complete! ===="
echo "You can now use chezmoi to manage your dotfiles."
echo "Run 'chezmoi cd' to navigate to your source directory."
echo "Run 'chezmoi apply' to apply changes to your home directory."

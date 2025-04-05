# Dotfiles

A collection of dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's Included

- **LunarVim Configuration**: Preconfigured Neovim setup with plugins and sensible defaults
- **Tmux Configuration**: Terminal multiplexer setup with useful plugins
- **Homebrew Installation**: Package manager for macOS and Linux
- **Developer Tools**: Lazygit, Lazydocker, and other useful utilities
- **Nerd Fonts**: Developer-friendly fonts with icons
- **Development Dependencies**:
  - Rust and Cargo
  - Node.js via NVM
  - Python with pynvim
  - Various CLI utilities

## Quick Install

One-line installation:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/harshav167/dotfiles/main/install.sh)"
```

## Manual Setup

1. Install chezmoi:

   ```bash
   # macOS
   brew install chezmoi

   # Linux
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
   ```

2. Initialize dotfiles with chezmoi:
   ```bash
   chezmoi init --apply harshav167
   ```

## Dependencies

This setup installs and configures:

- **Neovim**: Text editor
- **LunarVim**: Neovim configuration framework
- **Rust/Cargo**: For ripgrep and other tools
- **Python with pynvim**: For Python integration
- **Node.js (via NVM)**: For JavaScript/TypeScript support
- **Tmux**: Terminal multiplexer
- **Lazygit**: Git terminal UI
- **Lazydocker**: Docker terminal UI
- **Nerd Fonts**: Patched fonts with icons

## Repository Structure

This repository uses a simple, clean directory structure:

- `lvim/`: LunarVim configuration (maps to `~/.config/lvim/`)
- `tmux/`: Tmux configuration (maps to `~/.tmux/`)
- `.chezmoiscripts/`: Scripts that run during chezmoi setup
- `.chezmoi.toml.tmpl`: Template for the chezmoi configuration

## Managing Dotfiles

After installation, you can use chezmoi to manage your dotfiles:

- Apply changes: `chezmoi apply`
- Edit a file: `chezmoi edit ~/.config/lvim/config.lua`
- Add a new file: `chezmoi add ~/.config/some-config`
- Update from repo: `chezmoi update`
- See what would change: `chezmoi diff`

## Components

### LunarVim

LunarVim is a Neovim configuration focused on providing a great out-of-the-box experience:

- LSP support
- Syntax highlighting
- Fuzzy finding
- File navigation
- Modern UI

### Tmux

Terminal multiplexer configuration with:

- Sensible defaults
- Mouse support
- Custom keybindings
- Status bar customizations
- Plugin management

### Lazygit and Lazydocker

Terminal UIs for:

- Git repository management
- Docker container management
- Easy navigation and commands
- Visual representation of complex operations

## Customization

You can customize your setup by editing the files in `~/.local/share/chezmoi` and applying the changes with `chezmoi apply`.

### Adding New Dotfiles

To add a new configuration file to chezmoi:

```bash
chezmoi add ~/.some-config
```

### Platform-Specific Configuration

The dotfiles automatically adapt to different platforms (macOS vs Linux) using chezmoi's templating features.

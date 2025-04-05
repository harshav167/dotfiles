#!/bin/bash

set -e # Exit on error

echo "===== Testing Dotfiles Installation ====="

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to test commands
test_command() {
    local cmd="$1"
    local name="$2"

    echo -n "Testing $name... "
    if eval "$cmd" &>/dev/null; then
        echo -e "${GREEN}OK${NC}"
        return 0
    else
        echo -e "${RED}FAILED${NC}"
        return 1
    fi
}

# Array to track failures
failures=()

# Test various components
test_command "command -v lvim" "LunarVim" || failures+=("LunarVim")
test_command "command -v tmux" "Tmux" || failures+=("Tmux")
test_command "command -v lazygit" "Lazygit" || failures+=("Lazygit")
test_command "command -v lazydocker" "Lazydocker" || failures+=("Lazydocker")
test_command "command -v rustc" "Rust" || failures+=("Rust")
test_command "command -v cargo" "Cargo" || failures+=("Cargo")
test_command "command -v node" "Node.js" || failures+=("Node.js")
test_command "command -v npm" "npm" || failures+=("npm")
test_command "python3 -c 'import pynvim'" "pynvim" || failures+=("pynvim")

# Test configuration files
test_command "[ -f ~/.config/lvim/config.lua ]" "LunarVim config" || failures+=("LunarVim config")
test_command "[ -f ~/.tmux/tmux.conf ]" "Tmux config" || failures+=("Tmux config")

# Print summary
echo ""
echo "===== Test Summary ====="
if [ ${#failures[@]} -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
else
    echo -e "${RED}${#failures[@]} test(s) failed:${NC}"
    for failure in "${failures[@]}"; do
        echo -e "  - ${RED}$failure${NC}"
    done
fi

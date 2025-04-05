#!/bin/bash

set -e # Exit on error

# Check if automated testing is requested
AUTOMATED_TEST=false
if [ "$1" = "--test" ]; then
    AUTOMATED_TEST=true
fi

echo "==== Building Docker test container ===="
docker build -t dotfiles-test -f Dockerfile.test .

if [ "$AUTOMATED_TEST" = "true" ]; then
    echo "==== Running automated tests ===="
    docker run --rm -e RUN_TESTS=true dotfiles-test
else
    echo "==== Running Docker test container in interactive mode ===="
    echo "Once inside the container, you can test that your dotfiles are correctly installed."
    echo "To exit the container, type 'exit' or press Ctrl+D."
    echo ""
    echo "====== Commands to test in container ======"
    echo "lvim --version                 # Check LunarVim version"
    echo "tmux -V                        # Check tmux version"
    echo "lazygit --version              # Check lazygit version"
    echo "which lazydocker               # Check lazydocker is in PATH"
    echo "rustc --version                # Check Rust is installed"
    echo "node --version                 # Check Node.js is installed"
    echo "python3 -c 'import pynvim'     # Check pynvim is installed"
    echo "./test_dotfiles.sh             # Run the automated test script"
    echo "======================================="
    echo ""

    # Start interactive shell in container
    docker run -it --rm dotfiles-test
fi

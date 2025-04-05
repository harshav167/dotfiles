#!/bin/bash

# Exit on error
set -e

# Check for Docker
if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not found in PATH"
    exit 1
fi

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKERFILE="$SCRIPT_DIR/Dockerfile.test"
IMAGE_NAME="dotfiles-test"
ARCH=$(uname -m)

# Handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Build the Docker image
echo "Building Docker test environment..."
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" "$SCRIPT_DIR" || handle_error "Failed to build Docker image"

echo "Dotfiles test environment is ready!"

# Run automated tests if --test is provided
if [[ "$1" == "--test" ]]; then
    echo "Running automated tests..."
    docker run --rm -e RUN_TESTS=true "$IMAGE_NAME" || handle_error "Tests failed"
    echo "All tests passed successfully!"
    exit 0
fi

# Run in interactive mode
echo "Starting interactive test shell..."
echo ""
echo "You can test your dotfiles within the container."
echo "Exit the container by typing 'exit' or pressing Ctrl+D."
echo "Run the test script with './test_dotfiles.sh'"
echo ""

docker run --rm -it "$IMAGE_NAME"

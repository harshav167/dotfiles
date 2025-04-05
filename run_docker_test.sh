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

# Set appropriate platform flag
PLATFORM_FLAG=""
case "$ARCH" in
x86_64)
    PLATFORM_FLAG="--platform=linux/amd64"
    ;;
arm64 | aarch64)
    PLATFORM_FLAG="--platform=linux/arm64"
    ;;
*)
    echo "Warning: Unsupported architecture $ARCH, will try native build"
    ;;
esac

# Handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Build the Docker image
echo "Building Docker test environment for $ARCH architecture..."
docker build $PLATFORM_FLAG -t "$IMAGE_NAME" -f "$DOCKERFILE" "$SCRIPT_DIR" || handle_error "Failed to build Docker image"

echo "Dotfiles test environment is ready!"

# Run the container - the installation will be tested automatically
echo "Running installation test..."
docker run $PLATFORM_FLAG --rm "$IMAGE_NAME"

echo "Docker test completed."

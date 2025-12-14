#!/bin/bash

# Test orchestrator - builds Docker image and runs interactive shell
# Usage: ./test.sh [--interactive]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="config-test"

echo "Building Docker test image..."
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"

if [ "$1" = "--interactive" ] || [ "$1" = "-i" ]; then
    echo ""
    echo "Starting interactive test container..."
    docker run --rm -it "$IMAGE_NAME" bash
else
    echo ""
    echo "✓ Docker image built successfully!"
    echo ""
    echo "To test interactively: ./test.sh --interactive"
fi

#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "Building kaspa-explorer"

docker build \
    --build-arg VERSION="dev" \
    --build-arg REPO_DIR=. \
    -f docker/Dockerfile \
    -t supertypo/kaspa-explorer:dev \
    .

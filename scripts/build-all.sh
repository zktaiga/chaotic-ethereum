#!/bin/bash
set -euo pipefail

CLIENTS=(besu erigon geth lighthouse lodestar nethermind nimbus prysm reth teku)

echo "🚀 Building chaotic-base..."
docker build -f Dockerfile.base -t chaotic-base:latest .

echo "🔨 Building all client images..."
for client in "${CLIENTS[@]}"; do
    echo "Building $client..."
    docker build -t "chaotic-$client:latest" "./$client"
    echo "✅ Built chaotic-$client:latest"
done

echo "🎉 All images built successfully!"
echo ""
echo "Available images:"
for client in "${CLIENTS[@]}"; do
    echo "  chaotic-$client:latest"
done
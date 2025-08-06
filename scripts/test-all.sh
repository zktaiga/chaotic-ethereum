#!/bin/bash
set -euo pipefail

CLIENTS=(besu erigon geth lighthouse lodestar nethermind nimbus prysm reth teku)
FAILED=()

echo "🧪 Building and testing all client images..."
echo ""

for client in "${CLIENTS[@]}"; do
    echo -n "Building and testing chaotic-$client... "
    
    # Build the image first
    if docker build -t "chaotic-$client:latest" "./$client" >/dev/null 2>&1; then
        # Test that toda binary exists and is executable
        if docker run --rm --entrypoint="" "chaotic-$client:latest" ls /usr/local/bin/toda >/dev/null 2>&1; then
            echo "✅ PASS"
        else
            echo "❌ FAIL (binary missing)"
            FAILED+=("$client")
        fi
    else
        echo "❌ FAIL (build failed)"
        FAILED+=("$client")
    fi
done

echo ""
if [ ${#FAILED[@]} -eq 0 ]; then
    echo "🎉 All tests passed! Toda is available in all images."
    exit 0
else
    echo "❌ Failed tests:"
    for client in "${FAILED[@]}"; do
        echo "  - chaotic-$client"
    done
    exit 1
fi
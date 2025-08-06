# Chaotic Ethereum

Docker images for Ethereum clients with [Toda](https://github.com/chaos-mesh/toda) integrated for IO chaos engineering.

## Available Images

All images are available at `ghcr.io/[username]/chaotic-ethereum/[client]:latest`

### Execution Clients
- **Besu**: `ghcr.io/[username]/chaotic-ethereum/besu:latest` (based on `hyperledger/besu:latest`)
- **Erigon**: `ghcr.io/[username]/chaotic-ethereum/erigon:latest` (based on `erigontech/erigon:latest`)
- **Geth**: `ghcr.io/[username]/chaotic-ethereum/geth:latest` (based on `ethereum/client-go:stable`)
- **Nethermind**: `ghcr.io/[username]/chaotic-ethereum/nethermind:latest` (based on `nethermind/nethermind:latest`)
- **Reth**: `ghcr.io/[username]/chaotic-ethereum/reth:latest` (based on `ethpandaops/reth:main`)

### Consensus Clients
- **Lighthouse**: `ghcr.io/[username]/chaotic-ethereum/lighthouse:latest` (based on `sigp/lighthouse:latest`)
- **Lodestar**: `ghcr.io/[username]/chaotic-ethereum/lodestar:latest` (based on `chainsafe/lodestar:latest`)
- **Nimbus**: `ghcr.io/[username]/chaotic-ethereum/nimbus:latest` (based on `statusim/nimbus-eth2:multiarch-latest`)
- **Prysm**: `ghcr.io/[username]/chaotic-ethereum/prysm:latest` (based on `gcr.io/prysmaticlabs/prysm/beacon-chain:latest`)
- **Teku**: `ghcr.io/[username]/chaotic-ethereum/teku:latest` (based on `consensys/teku:latest`)

## Usage

Each image functions identically to the original upstream image, with Toda available at `/usr/local/bin/toda`.

```bash
# Run normally (no chaos)
docker run ghcr.io/[username]/chaotic-ethereum/geth:latest --help

# With chaos injection (example - requires proper namespace setup)
docker run --pid=host --privileged ghcr.io/[username]/chaotic-ethereum/geth:latest
```

## Building Locally

```bash
# Build base image first
docker build -f Dockerfile.base -t chaotic-base:latest .

# Build a specific client
docker build -t chaotic-geth ./geth

# Build all clients (after base)
./scripts/build-all.sh

# Test all clients
./scripts/test-all.sh
```

## Testing

```bash
# Test that Toda is available in all images
./scripts/test-all.sh

# Test a specific client
docker run --rm chaotic-geth toda --help
```

## Automation

- **Dependabot**: Automatically monitors upstream image updates
- **GitHub Actions**: Rebuilds base + client images with proper dependency chain
- **Shared Base**: Toda binary cached once, reused across all clients

## About Toda

[Toda](https://github.com/chaos-mesh/toda) is a filesystem hook utility that enables IO chaos injection. It must be executed within the target process's PID and mount namespace for proper functionality.

## Status

![Test Status](https://github.com/zktaiga/chaotic-ethereum/workflows/Test%20All%20Clients/badge.svg)
#!/usr/bin/env bash
set -euo pipefail

OS=$(uname -s)
ARCH=$(uname -m)
VERSION="v1.0"
BASE_URL="https://github.com/theopn/xinu-i386-qemu/releases/download/$VERSION"

if [ -x ".toolchain/bin/i686-elf-gcc" ] && [ "${1:-}" != "--force" ]; then
  echo "Toolchain already installed in .toolchain/bin/ (use 'make setup FORCE=1' to reinstall)"
  exit 0
fi

echo "Host system: $OS ($ARCH)"
mkdir -p .toolchain

if [ "$OS" = "Darwin" ] && [ "$ARCH" = "arm64" ]; then
  FILE="i686-elf-toolchain-macos-14.tar.gz"
elif [ "$OS" = "Linux" ] && [ "$ARCH" = "x86_64" ]; then
  FILE="i686-elf-toolchain-ubuntu-22.04.tar.gz"
else
  echo "error: no pre-built toolchain available for $OS/$ARCH."
  echo "  Try native compilation instead — see the README."
  exit 1
fi

echo "Downloading the compiler..."
curl -fL -o toolchain.tar.gz "$BASE_URL/$FILE"

echo "Extracting toolchain..."
tar -xzf toolchain.tar.gz -C .toolchain
rm toolchain.tar.gz
echo "Done! The compiler is ready in .toolchain/bin/"

#!/bin/bash
# setup-toolchain.sh

OS=$(uname -s)
ARCH=$(uname -m)
VERSION="v1.0"
BASE_URL="https://github.com/theopn/xinu-i386-qemu/releases/download/$VERSION"

echo "Host system: $OS ($ARCH)"
mkdir -p .toolchain

if [ "$OS" = "Darwin" ] && [ "$ARCH" = "arm64" ]; then
    FILE="i686-elf-toolchain-macos-26.tar.gz"
elif [ "$OS" = "Darwin" ] && [ "$ARCH" = "x86_64" ]; then
  echo "Intel Macs are not supported. Consider using the providewd Docker image to compile and run Xinu."
else
    FILE="i686-elf-toolchain-ubuntu-22.04.tar.gz"
fi

echo "Downloading the compiler..."
curl -L -o toolchain.tar.gz "$BASE_URL/$FILE"

echo "Extracting toolchain..."
tar -xzf toolchain.tar.gz -C .toolchain
rm toolchain.tar.gz

echo "Done! The compiler is ready in .toolchain/bin/"

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    bison \
    flex \
    gawk \
    libfl-dev \
    gcc-i686-linux-gnu \
    binutils-i686-linux-gnu \
    qemu-system-x86 \
    && rm -rf /var/lib/apt/lists/*

ENV COMPILER_ROOT=i686-linux-gnu-

WORKDIR /xinu

# XINU for QEMU

This is a port of XINU with a support for the i386 architecture and the Intel 83545EM network controller.

This repository also includes a Docker/Podman environment for reproducible builds and documentation for native compilation across various platforms.

## Compilation

### Using Docker/Podman

The included `Dockerfile` provides a pre-configured Debian-based environment with the `i686-linux-gnu` cross-compilation toolchain.

```sh
# 1. Build and start the container in the background
docker compose up -d --build

# 2. Enter the Docker container shell
docker compose exec xinu-compile bash

# 3. Inside the container, compile the kernel
cd compile
make clean && make
```

> Note: If using Podman, simply replace `docker` with `podman` in the commands above.*

### Native Compilation

If you want to explore compiling Xinu natively in your Linux or macOS environment, make sure that the following dependencies are installed and available in your `$PATH`.

- `gnumake`
- `gcc`
- `binutils` (`ld` and `objcopy`)
- `flex` & `bison`    (required for `config/Makefile`)

> Note: You may need to manually modify the `COMPILER_ROOT` and other constants `Makefile` (in both `compile` and `config` directories) depending on the executable names provided by your distribution.

Since the developer of this patch is a NixOS user, you can use the following command to install all dependencies and compile Xinu.

```sh
nix-shell -p gnumake gcc_multi flex bison --run "make COMPILER_ROOT='' CC=gcc"
```

### Native Compilation in macOS

Reference the [`macos-native-compilation.md`](./macos-native-compilation.md) for more information.

## Running XINU with QEMU

You can boot the Xinu kernel directly from the `compile` directory.
Since the Docker image includes QEMU, you can run this either on your host system (with QEMU installed) or inside the container shell:

```sh
qemu-system-i386 -nographic -kernel xinu.elf            \
                 -netdev user,id=mynetdev               \
                 -device e1000-82545em,netdev=mynetdev
```

*Notes*:

- `-nographic`: Emulates a serial console, which is where XINU directs its output.
    See the [QEMU invocation documentation](https://www.qemu.org/docs/master/system/invocation.html) for details.
- Other network backend may work, though `user` is the standard.
    For more complex setups, refer to the [QEMU Wiki entry for networking](https://wiki.qemu.org/Documentation/Networking).
- **Since network initialization is a core part of the XINU boot process, the system may hang or panic if the `e1000-82545em` is missing or misconfigured.**
    See the [system/initialize.c](./system/initialize.c) for the implementation details.


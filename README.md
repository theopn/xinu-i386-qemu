# XINU for QEMU

This is a port of XINU with support for the i386 architecture and the Intel 82545EM network controller.

This repository also includes a set of pre-built binaries, Docker environment for reproducible builds, and documentation for native compilation across various platforms.

## Prerequisite

1. Download and install [QEMU](https://www.qemu.org/download/). QEMU is packaged in most Linux distributions.
    On macOS, use [Homebrew](https://brew.sh/) to install QEMU:
    ```sh
    brew install qemu
    ```
2. Clone and navigate to this repository:
    ```sh
    git clone https://github.com/theopn/xinu-i386-qemu.git
    cd xinu-i386-qemu
    ```
3. Modify the Xinu source code as needed.
4. Proceed with one of the compile options.

## Compilation

### Option 1: Using Pre-built Compiler Binaries

I have compiled and uploaded the pre-built compiler suite on the GitHub Release page.
Use the following commands to download and extract them into the Xinu source tree.

Prerequisite: `curl` and `tar`

```sh
cd compile

# Downloads the pre-built binaries from the GitHub Release page
make setup

# Build Xinu
make clean && make

# Run Xinu. (Press Ctrl+A then x to exit QEMU)
make run
```

### Option 2: Using Docker/Podman

The included `Dockerfile` provides a pre-configured Debian-based environment.

```sh
# 0. Navigate to the top (base) directory
cd ..

# 1. Build and start the container in the background
docker compose up -d --build

# 2. Enter the Docker container shell
docker compose exec xinu-compile bash

# 3. Inside the container, compile the kernel
cd compile
make clean && make

# 4. Run Xinu. (Press Ctrl+A then x to exit QEMU)
make run

# 5. Exit out of the Docker shell, then stop the background container
exit
docker compose down
```


> Note: If you are using Podman, simply replace `docker` with `podman` in the commands above.

### Option 3-1: Native Compilation (Linux)

If you want to explore compiling Xinu natively, make sure that the following dependencies are installed and available in your `$PATH`.

- `gnumake`
- `gcc`
- `binutils` (`ld` and `objcopy`)
- `flex` & `bison`    (required for `config/Makefile`)

For example:

```sh
# In Debian-based distributions:
sudo apt-get install gcc-i686-linux-gnu binutils-i686-linux-gnu bison flex
```

> Note: You may need to manually modify the `COMPILER_ROOT` and other constants in the `Makefile` (in both `compile` and `config` directories) depending on the executable names provided by your distribution.
> For example, to natively compile in NixOS, use the following command:
> ```sh
> nix-shell -p gnumake gcc_multi flex bison --run "make COMPILER_ROOT=''"
> ```


### Option 3-2: Native Compilation (macOS)

Refer to the [`macos-native-compilation.md`](./macos-native-compilation.md) for more information.



## Running XINU with QEMU

Make sure your host machine is connected to the internet; Xinu's boot sequence requires an internet connection.

`make run` is equivalent to running:

```sh
qemu-system-i386 -nographic -kernel xinu.elf            \
                 -netdev user,id=mynetdev               \
                 -device e1000-82545em,netdev=mynetdev
```

Advanced users may experiment with the QEMU flags.


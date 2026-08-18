# XINU for QEMU

This is a port of XINU with support for the i386 architecture and the Intel 82545EM network controller.

This repository also includes a Docker/Podman environment for reproducible builds and documentation for native compilation across various platforms.

## Compilation

### Using Pre-built Compiler Binaries

I have compiled and uploaded the pre-built compiler suite in the GitHub Release page.
Use the following commands to download them into the Xinu source tree and compile.

Prerequisite: `curl` and `tar`

```sh
cd compile

make setup   # downloads the pre-built binaries from the GitHub Release page

make clean && make

# Run Xinu. Ctrl+A to exit QEMU
make run
```

### Using Docker/Podman

The included `Dockerfile` provides a pre-configured Debian-based environment.

```sh
# 1. Build and start the container in the background
docker compose up -d --build

# 2. Enter the Docker container shell
docker compose exec xinu-compile bash

# 3. Inside the container, compile the kernel
cd compile
make clean && make

# 4. Run Xinu. Ctrl+A to exit QEMU
make run

# 5. Exit out of the Docker shell, stop the background container when your session is finished
exit && docker compose down
```

> Note: If are using Podman, simply replace `docker` with `podman` in the commands above.

### Native Compilation (Linux)

If you want to explore compiling Xinu natively, make sure that the following dependencies are installed and available in your `$PATH`.

- `gnumake`
- `gcc`
- `binutils` (`ld` and `objcopy`)
- `flex` & `bison`    (required for `config/Makefile`)

For example:

```sh
# In Debian based distros
sudo apt-get install gcc-i686-linux-gnu binutils-i686-linux-gnu bison flex
```

> Note: You may need to manually modify the `COMPILER_ROOT` and other constants the `Makefile` (in both `compile` and `config` directories) depending on the executable names provided by your distribution.

For example, to be natively compiled in NixOS, used the following command:

```sh
nix-shell -p gnumake gcc_multi flex bison --run "make COMPILER_ROOT=''"
```


### Native Compilation (macOS)

Refer to the [`macos-native-compilation.md`](./macos-native-compilation.md) for more information.



## Running XINU with QEMU

> [!NOTE]
> Make sure [QEMU](https://www.qemu.org/) (`qemu-system-i386`) is installed on your system.
> Alternatively, if you used the Docker image to compile the kernel, you can do `make run` inside of the Docker container, as it contains QEMU.

You can boot the Xinu kernel image directly from the `compile` directory.

```sh
cd compile
make run   # Exit out of the VM with CTRL+A
```

Make sure your host machine is connected to the internet; Xinu's boot sequence requires an internet connection.

`make run` is equivalent to running:

```sh
qemu-system-i386 -nographic -kernel xinu.elf            \
                 -netdev user,id=mynetdev               \
                 -device e1000-82545em,netdev=mynetdev
```

Advanced users may experiment with the QEMU flag.


# Xinu on Linux

Following steps are applicable for Ubuntu 22.04+ or Debian 12+ on a 64-bit machine.

For any other distribution, see [other distributions](#other-distributions) section.

## Step 1: Install the Required tools

```sh
sudo apt-get update
sudo apt-get install -y git make curl tar qemu-system-x86
```

Check that QEMU was installed:

```sh
qemu-system-i386 --version
```

## Step 2: Download the Xinu source code

```sh
cd ~
git clone https://github.com/theopn/xinu-i386-qemu.git
cd xinu-i386-qemu/compile
```

You are now in the `compile` directory. Stay here for the remaining steps.

## Step 3: Download the Pre-Built Compilers

```sh
make setup
```

## Step 4: Build Xinu

```sh
make clean && make
```

The first build takes a minute or so. When it finishes without errors, a file called `xinu.elf` is created.

## Step 5: Run Xinu

```sh
make run
```

Xinu boots inside QEMU, right in your terminal window.
Your computer must be connected to the internet.
Once it starts, type help to see the available commands.

**To quit**: press Ctrl+A, release both keys, then press x.

## Editing and Rebuilding

1. Edit the source files with any text editor.
2. In the `compile` directory:
   - If you only edited existing files: `make`
   - If you added a new file: `make rebuild && make`
3. Run `make run`.



## Other Distributions

The pre-built compiler is built for 64-bit Ubuntu/Debian systems and may not run elsewhere.
The easiest option for any other setup is Docker, which gives you the same environment on every distribution.

If you want to try the pre-built compiler anyway on another x86_64 distribution, follow the steps above.
It may work if your system is recent enough; if make setup succeeds but the build then fails with errors about missing libraries or a "not found" for a file that exists, use Docker instead.

### Advanced: Native Compilation

This uses your own system's compiler instead of the pre-built one.
It is more work and is intended for people who want to understand the toolchain.

You need (all available in your `$PATH`):

- `make`
- a C compiler that can produce 32-bit code (`gcc`)
- `binutils` (`ld` and `objcopy`)
- `flex` and `bison`
- `gawk`

By default the build looks for a compiler named `i686-linux-gnu-gcc`, which is what the packages above provide.
If you have already run make setup in this copy of the repository but want to use the system compiler, delete the `compile/.toolchain` directory.

On other distributions, the compiler may have a different name.
Tell `make` the prefix of your tools with `COMPILER_ROOT`.
For example, if your compiler is called `gcc` and your linker is `ld`, use an empty prefix:

```sh
make COMPILER_ROOT='' clean
make COMPILER_ROOT=''
```

For example, on NixOS, following command compiles Xinu with the tools available in `nixpkgs`:

```sh
nix-shell -p gnumake gcc_multi flex bison --run "make COMPILER_ROOT=''"
```

# Xinu on macOS (Apple Silicon)

This guide is for Macs with an Apple chip (M1, M2, M3, ...).
If you have an Intel Mac, use the Docker guide instead.

## Step 1: Install QEMU Through Homebrew

1. Go to https://brew.sh/ and copy the install command shown on the page. Follow the installation instruction.
   - The installer prints a "Next steps" section near the end with a couple of commands to add Homebrew to your `$PATH`.
      Skipping those the commands is the most common reason `brew` doesn't work afterward.
2. Close the Terminal window and open a new one, then check that it worked:
    ```sh
    brew --version
    ```
3. Install QEMU
    ```sh
    brew install qemu
    ```
    Check that it worked:
    ```sh
    qemu-system-i386 --version
    ```

## Step 2: Clone the Repository

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

## Optional: use your own compiler instead of the pre-built one

See [macos-native-compilation](./macos-native-compilation.md). Most people do not need this.

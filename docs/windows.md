# Xinu on Windows

On Windows, you run Xinu inside WSL (Windows Subsystem for Linux), which gives you a real Ubuntu Linux terminal within Windows.
Once WSL is set up, the steps are the same as on Linux.

## Step 1: Install WSL

Follow the [official Microsoft Guide](https://learn.microsoft.com/en-us/windows/wsl/install).

## Step 2: Install the Required tools

```sh
sudo apt-get update
sudo apt-get install -y git make curl tar qemu-system-x86
```

Check that QEMU was installed:

```sh
qemu-system-i386 --version
```

## Step 3: Download the Xinu source code

Important: clone into your Linux home directory (`~`), not into the shared directory (`/mnt/c/...`).
Builds on the Windows file system (`/mnt/c`) are much slower and can cause errors.

```sh
cd ~
git clone https://github.com/theopn/xinu-i386-qemu.git
cd xinu-i386-qemu/compile
```

You are now in the `compile` directory. Stay here for the remaining steps.

## Step 4: Download the Pre-Built Compilers

```sh
make setup
```

## Step 5: Build Xinu

```sh
make clean && make
```

The first build takes a minute or so. When it finishes without errors, a file called `xinu.elf` is created.

## Step 6: Run Xinu

```sh
make run
```

Xinu boots inside QEMU, right in your terminal window.
Your computer must be connected to the internet.
Once it starts, type help to see the available commands.

**To quit**: press Ctrl+A, release both keys, then press x.

## Editing and Rebuilding

Your files live inside WSL at `~/xinu-i386-qemu`.
Two ways to edit them:

- VS Code: install VS Code and its WSL extension.
    Then, in the WSL terminal window, run
    ```sh
    code ~/xinu-i386-qemu
    ```
- Windows File Explorer: type `\\wsl$\Ubuntu\home\<your-username>\xinu-i386-qemu` into the address bar. (Replace `<your-username>`.)

After editing, navigate back to the `compile` directory, then:
   - If you only edited existing files: `make`
   - If you added a new file: `make rebuild && make`

Followed by `make run`.

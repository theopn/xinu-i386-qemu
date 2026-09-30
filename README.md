# XINU for QEMU

This is a port of XINU with support for the i386 architecture and the Intel 82545EM network controller.

This repository also includes a set of pre-built binaries, Docker environment for reproducible builds, and documentation for compilation across various platforms.

## What you will do

Every guide has the same three phases:

1. Install the tools your computer needs (QEMU, and a compiler or Docker).
2. Build Xinu: turn the source code into a bootable kernel file called `xinu.elf`.
3. Run Xinu inside QEMU.

Once it works, you edit the source code, rebuild, and run again.

| Your system | Guide |
|---|---|
| macOS (Apple Silicon) | [macos.md](./docs/macos.md) |
| Windows (via WSL) | [windows.md](./docs/windows.md) |
| Ubuntu, Debian, or another Linux distribution | [linux.md](./docs/linux.md) |
| Anything else (Docker) | [docker.md](./docs/docker.md) |

## Everyday Commands

| I want to... | Command |
|---|---|
| Download the compiler (pre-built option only, once) | `make setup` |
| Build Xinu from scratch | `make clean && make` |
| Rebuild after editing an **existing** file | `make` |
| Rebuild after **adding a new file** | `make rebuild && make` |
| Run Xinu | `make run` |
| **Quit Xinu** | Press `Ctrl+A`, release both keys, then press `x` |
| Re-download the pre-built compiler (if it seems broken) | `make setup FORCE=1` |

When in doubt after editing the source, use `make clean && make`.

## Where is the source code?
 
| Directory | Contents |
|---|---|
| `system/` | Core kernel: processes, scheduling, memory, startup |
| `lib/` | C library (`printf`, `strcmp`, ...) |
| `device/` | Device drivers (tty, Ethernet, file systems, pipes, ...) |
| `net/` | Networking |
| `shell/` | The Xinu shell and its commands |
| `include/` | Header files |
| `config/` | The `Configuration` file that defines devices, and the tool that reads it |
| `compile/` | Where you build and run Xinu |


## Running Xinu: Extra Notes

- Your computer must be connected to the internet. Xinu's boot sequence needs a network connection.
- `make run` is equivalent to:
    ```sh
    qemu-system-i386 -nographic -kernel xinu.elf            \
                     -netdev user,id=mynetdev               \
                     -device e1000-82545em,netdev=mynetdev
    ```
    Advanced users may experiment with the QEMU flags.
- Once Xinu boots, type `help` at its prompt to list the available shell commands.


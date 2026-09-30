# Xinu with Docker

Docker runs Xinu's build tools inside a small, pre-configured Debian Linux environment (*a container*).
It works the same way on Windows, macOS (including Intel Macs), and Linux, and you do not need to install a compiler yourself.

## Step 1: Install Docker

Pick your system:

- Windows or macOS: install Docker Desktop, open it once, and wait until it says Docker is running.
- Linux: follow the install instructions for your distribution at https://docs.docker.com/engine/install/.
    Make sure the docker compose command works (see the check below).
- [Podman](https://podman.io/) is also supported. Wherever you see `docker` in commands below, use `podman` instead.

Check that Docker works:

```sh
docker --version
docker compose version
```

## Step 2: Clone the Repository

```sh
cd ~
git clone https://github.com/theopn/xinu-i386-qemu.git
cd xinu-i386-qemu
```

You should now be in the top (base) directory of the repository, the one that contains `docker-compose.yml`.

## Step 3: Build and start the container

```sh
docker compose up -d --build
```

The first time, this downloads and builds the environment, which can take several minutes.
`-d` means it runs in the background.

## Step 4: Open a shell inside the container

```sh
docker compose exec xinu-compile bash
```

Your prompt changes (for example, to `root@abc123:/xinu#`).
You are now inside the container.
Your repository is shared with the container, so edits you make in your normal editor on your computer appear inside the container.

## Step 5: Build Xinu

Inside the container:

```sh
cd compile
make clean && make
```

You do not need to run `make setup`.
The container already has a compiler.

## Step 6: Run Xinu

```sh
make run
```

Xinu boots inside QEMU (which is also included in the container).
Your computer must be connected to the internet.
Once it starts, type help to see the available commands.

**To quit Xinu**: press Ctrl+A, release both keys, then press x.

## Step 7: Leave the container when you are done

```sh
exit
docker compose down
```

Next time you want to work, start again from Step 3 (it will be much faster, since the environment is already built), then Step 4.

## Editing and Rebuilding

1. Edit the source files with any text editor, on your own computer.
2. If Docker isn't already running, start from Step 3, then Step 4 to get back into the container shell.
3. Inside the container, in the `compile` directory:
   - If you only edited existing files: `make`
   - If you added a new file: `make rebuild && make`
4. Run `make run`.

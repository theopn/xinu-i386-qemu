# XINU for QEMU

This is a port of XINU with a support for the i386 architecture and the Intel 83545EM network controller.

## Compilation

**Dependencies**

- `gnumake`
- `gcc` (version 4.8)
- `ld`
- `objcopy`
- `flex`    (required for `config/Makefile`)
- `bison`   (required for `config/Makefile`)

`cd` into `compile` directory and run `make`.

Since the developer of this patch is a NixOS user, you can use the following command to install all dependencies and compile.

```sh
nix-shell -p gnumake gcc_multi flex bison --run "make COMPILER_ROOT='' CC=gcc"
```

## Running XINU with QEMU

Use the following command in `compile` directory to boot the XINU kernel:

```sh
qemu-system-i386 -nographic -kernel xinu.elf -netdev user,id=mynetdev -device e1000-82545em,netdev=mynetdev
```

- `-nographic`: Emulates a serial console, which is where XINU directs its output.
    See the [QEMU invocation documentation](https://www.qemu.org/docs/master/system/invocation.html) for details.
- Other network backend may work, though `user` is the standard.
    For more complex setups, refer to the [QEMU Wiki entry for networking](https://wiki.qemu.org/Documentation/Networking).
- **Since network initialization is a core part of the XINU boot process, the system may hang or panic if the `e1000-82545em` is missing or misconfigured.**
    See the [system/initialize.c](./system/initialize.c) for the implementation details.


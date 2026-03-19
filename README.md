# Xinu for QEMU

This is a version of Xinu using i386 and Intel 83545EM network driver 

## Compilation

Dependencies:

-

## QEMU Command

```sh
qemu-system-i386 -nographic -kernel xinu.elf -netdev user,id=n0 -device e1000-82545em,netdev=n0
```

`-nographic` option emulates serial console where Xinu writes the output to. See [Xinu docs invocation chapter](https://www.qemu.org/docs/master/system/invocation.html) for more information.

Other network backend may work, though `user` is the most standard.
See [QEMU Wiki entry for networking](https://wiki.qemu.org/Documentation/Networking) for more information.

Do make sure that network device is properly configured, as network initialization is the core part of initialization and the Xinu will hang or panic without it.
See [system/initialize.c](./system/initialize.c) for more information.


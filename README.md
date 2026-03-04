# Running Xinu with QEMU

> [!NOTE]
> As of 2026-03-04, QEMU's Intel 82545EM is not recognized by this version of Xinu.
> I am actively working on this issue, but for now, the version of Xinu in this repository disables all Ethernet related code to prevent kernel panic.

1. `cd` into the `compile` directory and run `make` (necessary dependencies can be found in the official Xinu manual).
2. Run the following:
   ```sh
   qemu-system-i386        \
          -m 256           \
          -nographic       \
          -kernel xinu.elf
   ```

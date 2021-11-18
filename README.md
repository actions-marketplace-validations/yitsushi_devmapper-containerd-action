# Containerd with devmapper

This composite action installs and configures containerd to use
the devmapper snapshotter plugin.

## Example

```
name: Example
on: [push]

jobs:
  test:
    name: Pull and image
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          path: devmapper-containerd-action
      - name: Containerd and devmapper
        uses: yitsushi/devmapper-containerd-action@v1
      - name: Check
        run: |
          sudo ctr --debug plugin ls

          echo "::debug::Pull image with snapshotter"
          sudo ctr images pull --snapshotter devmapper docker.io/library/hello-world:latest

          echo "ctr --debug images ls"
          sudo ctr --debug images ls

          echo "ctr --debug snapshots ls"
          sudo ctr --debug snapshots ls

          echo "sudo ctr --debug snapshots --snapshotter=devmapper ls"
          sudo ctr --debug snapshots --snapshotter=devmapper ls
```

## With act

Nope, it does not work.

```
++ dmsetup reload dev-thinpool --table '0 209715200 thin-pool /dev/loop4 /dev/loop3 128 32768 1 skip_block_zeroing'
device-mapper: reload ioctl on dev-thinpool  failed: No such device or address
Command failed.

| + dmsetup create dev-thinpool --table '0  thin-pool   128 32768 1 skip_block_zeroing'
| /dev/mapper/control: open failed: Operation not permitted
| Failure to communicate with kernel device-mapper driver.
| Check that device-mapper is available in the kernel.
| Incompatible libdevmapper 1.02.167 (2019-11-30) and kernel driver (unknown version).
| Command failed.
```

![](./.assets/nice-things.jpeg)

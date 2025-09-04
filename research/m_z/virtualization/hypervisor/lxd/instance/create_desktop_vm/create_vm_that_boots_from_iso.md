# **[Create a VM that boots from an ISO](<https://documentation.ubuntu.com/lxd/latest/howto/instances_create/#create-a-vm-that-boots-from-an-iso>)**

## find and download a desktop image

**[How to launch an instantly functional Linux desktop VM with LXD](https://ubuntu.com/tutorials/how-to-launch-an-instantly-functional-linux-desktop-vm-with-lxd#1-overview)**

- To create a VM that boots from an ISO:

First, create an empty VM that we can later install from the ISO image:

```bash
lxc init iso-vm --empty --vm --config limits.cpu=2 --config limits.memory=4GiB --device root,size=30GiB

lxc launch images:ubuntu/22.04/desktop ubuntu --vm -c limits.cpu=4 -c limits.memory=4GiB --console=vga

wget https://mirror.sitsa.com.ar/ubuntu-releases/noble/ubuntu-24.04.3-desktop-amd64.iso
```

First, create an empty VM that we can later install from the ISO image:

```bash
lxc init iso-vm --empty --vm --config limits.cpu=2 --config limits.memory=4GiB --device root,size=50GiB
```

Note

Adapt the limits.cpu, limits.memory, and root size based on the hardware recommendations for the ISO image used.

The second step is to import an ISO image that can later be attached to the VM as a storage volume:

```bash
lxc storage volume import <pool> <path-to-image.iso> iso-volume --type=iso
lxc storage volume import remote ubuntu-24.04.3-desktop-amd64.iso iso-volume --type=iso

```

Lastly, attach the custom ISO volume to the VM using the following command:

```bash
# lxc config device add iso-vm iso-volume disk pool=<pool> source=iso-volume boot.priority=10
lxc config device add iso-vm iso-volume disk pool=remote source=iso-volume boot.priority=10

```

The boot.priority configuration key ensures that the VM will boot from the ISO first. Start the VM and connect to the **[console](https://documentation.ubuntu.com/lxd/latest/howto/instances_console/#instances-console)** as there might be a menu you need to interact with:

```bash
lxc start iso-vm --console
```

Once you’re done in the serial console, disconnect from the console using Ctrl+a q and connect to the VGA console using the following command:

```bash
lxc console iso-vm --type=vga
```

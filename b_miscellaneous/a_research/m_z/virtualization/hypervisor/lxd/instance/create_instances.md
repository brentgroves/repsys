# **[How to create instances](https://documentation.ubuntu.com/lxd/latest/howto/instances_create/)**

When creating an instance, you must specify the **[image](https://documentation.ubuntu.com/lxd/latest/image-handling/#about-images)** on which the instance should be based.

**[images](https://images.lxd.canonical.com/)**

Images contain a basic operating system (for example, a Linux distribution) and some LXD-related information. Images for various operating systems are available on the built-in remote image servers. See **[Images](https://documentation.ubuntu.com/lxd/latest/images/#images)** for more information.

If you don’t specify a name for the instance, LXD will automatically generate one. Instance names must be unique within a LXD deployment (also within a cluster). See **[Instance name requirements](https://documentation.ubuntu.com/lxd/latest/reference/instance_properties/#instance-name-requirements)** for additional requirements.

To create an instance, you can use either the lxc init or the lxc launch command. The lxc init command only creates the instance, while the lxc launch command creates and starts it.

Enter the following command to create a container:

`lxc launch|init <image_server>:<image_name> <instance_name> [flags]`

Unless the image is available locally, you must specify the name of the image server and the name of the image (for example, ubuntu:24.04 for the official Ubuntu 24.04 LTS image).

See `lxc launch --help` or `lxc init --help` for a full list of flags. The most common flags are:

--config to specify a configuration option for the new instance

--device to override device options for a device provided through a profile, or to specify an initial configuration for the root disk device (syntax: --device <device_name>,<device_option>=<value>)

--profile to specify a profile to use for the new instance

--network or --storage to make the new instance use a specific network or storage pool

--target to create the instance on a specific cluster member

--vm to create a virtual machine instead of a container

Instead of specifying the instance configuration as flags, you can pass it to the command as a YAML file.

For example, to launch a container with the configuration from config.yaml, enter the following command:

`lxc launch ubuntu:24.04 ubuntu-config < config.yaml`

Tip

Check the contents of an existing instance configuration (lxc config show <instance_name> --expanded) to see the required syntax of the YAML file.

## Examples

The following CLI and API examples create the instances, but don’t start them. If you are using the CLI client, you can use lxc launch instead of lxc init to automatically start them after creation.

In the UI, you can choose between Create and Create and start when you are ready to create the instance.

## Create a container

To create a container with an Ubuntu 24.04 LTS image from the ubuntu server using the instance name ubuntu-container:

```bash
# empheral storage so use a vm for desktop
lxc init images:ubuntu/noble/desktop c1
lxc config show c1 --expanded

lxc init ubuntu:24.04 uc1
```

## Create a virtual machine

To create a virtual machine with an Ubuntu 24.04 LTS image from the ubuntu server using the instance name ubuntu-vm:

```bash
lxc init images:ubuntu/noble/desktop v1 --vm
lxc config show c1 --expanded

lxc init ubuntu:24.04 ubuntu-vm --vm
lxc init ubuntu:24.04 uvm1 --device root,size=30GiB --config limits.cpu=2 --config limits.memory=8GiB --vm
lxc config show uvm1 --expanded

```

Or with a bigger disk:

```bash
lxc init ubuntu:24.04 ubuntu-vm-big --vm --device root,size=30GiB
```

## Create a container with specific configuration options

To create a container and limit its resources to one vCPU and 8 GiB of RAM:

```bash
lxc init ubuntu:24.04 ubuntu-limited --config limits.cpu=1 --config limits.memory=8GiB
```

## Create a VM on a specific cluster member

To create a virtual machine on the cluster member micro2, enter the following command:

```bash
lxc init ubuntu:24.04 ubuntu-vm-server2 --vm --target micro2
```

## Create a container with a specific instance type

LXD supports simple instance types for clouds. Those are represented as a string that can be passed at instance creation time.

The list of supported clouds and instance types can be found at **[images.lxd.canonical.com/meta/instance-types/all.yaml](https://images.lxd.canonical.com/meta/instance-types/all.yaml?_gl=1*blydvl*_gcl_au*MTcwMzEzOTMxMC4xNzUzMTIxNDg4*_ga*MTY2Njg1MzMxNS4xNzQ3NTE3NDk3*_ga_5LTL1CNEJM*czE3NTMzNzc1MDYkbzExJGcxJHQxNzUzMzc3NTM5JGoyNyRsMCRoMA..)**.

For example, the following three instance types are equivalent:

- t2.micro
- aws:t2.micro
- c1-m1

To create a container with this instance type:

```bash
lxc init ubuntu:24.04 my-instance --type t2.micro
```

## Create a VM that boots from an ISO

To create a VM that boots from an ISO:

First, create an empty VM that we can later install from the ISO image:

```bash
lxc init iso-vm --empty --vm --config limits.cpu=2 --config limits.memory=4GiB --device root,size=30GiB
```

Note

Adapt the limits.cpu, limits.memory, and root size based on the hardware recommendations for the ISO image used.

The second step is to import an ISO image that can later be attached to the VM as a storage volume:

```bash
lxc storage volume import <pool> <path-to-image.iso> iso-volume --type=iso
```

Lastly, attach the custom ISO volume to the VM using the following command:

```bash
lxc config device add iso-vm iso-volume disk pool=<pool> source=iso-volume boot.priority=10
```

The **[boot.priority](https://documentation.ubuntu.com/lxd/latest/reference/devices_disk/#device-disk-device-conf:boot.priority)** configuration key ensures that the VM will boot from the ISO first. Start the VM and **[connect to the console](https://documentation.ubuntu.com/lxd/latest/howto/instances_console/#instances-console)** as there might be a menu you need to interact with:

```bash
lxc start iso-vm --console
```

Once you’re done in the serial console, disconnect from the console using Ctrl+a q and connect to the VGA console using the following command:

```bash
lxc console iso-vm --type=vga
```

You should now see the installer. After the installation is done, detach the custom ISO volume:

```bash
lxc storage volume detach <pool> iso-volume iso-vm
```

Now the VM can be rebooted, and it will boot from disk.

Note

On Linux virtual machines, the **[LXD agent](https://documentation.ubuntu.com/lxd/latest/howto/instances_create/#lxd-agent-manual-install)** can be manually installed.

## Install the LXD agent into virtual machine instances

In order for features like direct command execution (lxc exec & lxc shell), file transfers (lxc file) and detailed usage metrics (lxc info) to work properly with virtual machines, an agent software is provided by LXD.

The virtual machine images from the official remote image servers are pre-configured to load that agent on startup.

For other virtual machines, you may want to manually install the agent.

Note

The LXD agent is currently available only on Linux virtual machines using systemd.

LXD provides the agent through a remote 9p file system and a virtiofs one that are both available under the mount name config. To install the agent, you’ll need to get access to the virtual machine and run the following commands as root:

```bash
modprobe 9pnet_virtio
mount -t 9p config /mnt -o access=0,transport=virtio || mount -t virtiofs config /mnt
cd /mnt
./install.sh
cd /
umount /mnt
reboot
```

You need to perform this task once.

## Create a Windows VM

To create a Windows VM, you must first prepare a Windows image. See Repack a Windows image.

The How to install a Windows 11 VM using LXD tutorial shows how to prepare the image and create a Windows VM from it.

## **[lxd images](https://images.lxd.canonical.com/)**

```bash
lxc launch images:ubuntu/noble/desktop v1 --vm
Fingerprints
ea6fa1ef943b (Virtual Machine)
Aliases
ubuntu/noble/desktop
ubuntu/24.04/desktop
Requirements
cgroup=v2
```

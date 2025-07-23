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

`lxc init ubuntu:24.04 ubuntu-container`

## Create a virtual machine

To create a virtual machine with an Ubuntu 24.04 LTS image from the ubuntu server using the instance name ubuntu-vm:

`lxc init ubuntu:24.04 ubuntu-vm --vm`

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

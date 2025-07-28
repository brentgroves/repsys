# **[Create a desktop VM](https://documentation.ubuntu.com/lxd/latest/howto/instances_create/#create-a-vm-that-boots-from-an-iso)**

## Create a virtual machine

To create a virtual machine with an Ubuntu 24.04 LTS image from the ubuntu server using the instance name ubuntu-vm:

```bash
lxc init images:ubuntu/noble/desktop v1 --vm
lxc config show v1 --expanded
```

Start the VM and **[connect to the VGA console](https://documentation.ubuntu.com/lxd/latest/howto/instances_console/#instances-console)** locally using the following command:

```bash
lxc console iso-vm --type=vga
```

## Connect to the VM's VGA console remotely

### **[How to expose LXD to the network](https://documentation.ubuntu.com/lxd/latest/howto/server_expose/#server-expose)**

By default, LXD can be used only by local users through a Unix socket and is not accessible over the network.

To expose LXD to the network, you must configure it to listen to addresses other than the local Unix socket. To do so, set the core.https_address server configuration option.

For example, allow access to the LXD server on port 8443:

```bash
lxc config set core.https_address :8443
lxc config get core.https_address
```

### On the server, generate a trust token

There are currently two ways to retrieve a trust token in LXD.

Create a certificate add token

To generate a trust token, enter the following command on the server:

```bash
lxc config trust add
```

Enter the name of the client that you want to add. The command generates and prints a token that can be used to add the client certificate.

```bash
lxc config trust add
Please provide client name: isdev
Client isdev certificate add token:
token...
```

The recipient of this token will have full access to LXD. To restrict the access of the client, you must use the --restricted flag. See Confine users to specific projects on the HTTPS API for more details.

## Authenticate the client

On the client, add the server with the following command:

```bash
sudo snap install lxd --channel=5.21/stable --cohort="+"
# sudo snap install microceph --channel=squid/stable --cohort="+"
# sudo snap install microovn --channel=24.03/stable --cohort="+"
# sudo snap install microcloud --channel=2/stable --cohort="+"

If this is your first time running LXD on this machine, you should also run: lxd init
To start your first container, try: lxc launch ubuntu:24.04
Or for a virtual machine: lxc launch ubuntu:24.04 --vm

Generating a client certificate. This may take a minute...

# To indefinitely hold all updates to the snaps needed for MicroCloud, run:

sudo snap refresh --hold lxd

lxc remote add <remote_name> <token>
lxc remote add micro11 token
```

1. Install a SPICE client:
.
If you don't have one already, install a SPICE client like virt-viewer or spicy. On Debian/Ubuntu: sudo apt install virt-viewer or sudo apt install spicy. On Fedora/CentOS: sudo dnf install virt-viewer or sudo dnf install spice-gtk. On Windows, you can use the manual installer or install via Chocolatey.

spicy is a legacy, and now obsolete, SPICE client, while virt-viewer is the recommended client for connecting to a virtual machine using the SPICE protocol. Virt-viewer provides a graphical interface for displaying the guest OS, supporting both VNC and SPICE protocols. Essentially, spicy is a test application and not the primary tool for SPICE connections.

Use the following command: lxc console <vm_name> --type vga. Replace <vm_name> with the name of your virtual machine. This command will launch the SPICE client and connect it to the VM's VGA console, allowing you to see the graphical output.
Example:
Code

```bash
sudo apt install virt-viewer
lxc remote list
lxc remote switch micro11

# To create an instance, you can use either the lxc init or the lxc launch command. The lxc init command only creates the instance, while the lxc launch command creates and starts it.

lxc init images:ubuntu/noble/desktop v1 --vm
lxc start v1 --console=vga
lxc console --type=vga v1
# images:ubuntu/noble/desktop: error: The remote isn't a private LXD server

# or create and start

lxc launch images:ubuntu/noble/desktop v1 --vm
lxc config show v1 --expanded
architecture: x86_64
config:
  image.architecture: amd64
  image.description: Ubuntu noble amd64 (20250724_0002)
  image.os: Ubuntu
  image.release: noble
  image.requirements.cgroup: v2
  image.serial: "20250724_0002"
  image.type: disk-kvm.img
  image.variant: desktop
  migration.stateful: "true"
  volatile.apply_template: create
  volatile.base_image: aeed887e1eb5d7df9f0ff4e2d80a3231f40c0abb8ef9ec4e547b94c2be0c88ab
  volatile.cloud-init.instance-id: 03dcad6b-171d-43f1-a178-a28e0c71e776
  volatile.eth0.hwaddr: 00:16:3e:a2:29:a3
  volatile.uuid: ce6a11a7-ef76-4026-b911-ca94ed039a37
  volatile.uuid.generation: ce6a11a7-ef76-4026-b911-ca94ed039a37
devices:
  eth0:
    name: eth0
    network: default
    type: nic
  root:
    path: /
    pool: remote
    type: disk
ephemeral: false
profiles:
- default
stateful: false
description: ""

lxc info v1                                 
Name: v1
Status: RUNNING
Type: virtual-machine
Architecture: x86_64
Location: micro11
PID: 125101
Created: 2025/07/24 18:34 EDT
Last Used: 2025/07/24 18:50 EDT

Resources:
  Processes: 107
  CPU usage:
    CPU usage (in seconds): 65
  Memory usage:
    Memory (current): 874.89MiB
  Network usage:
    enp5s0:
      Type: broadcast
      State: UP
      Host interface: tap96556afc
      MAC address: 00:16:3e:a2:29:a3
      MTU: 1442
      Bytes received: 14.88kB
      Bytes sent: 24.69kB
      Packets received: 48
      Packets sent: 192
      IP addresses:
        inet:  10.233.212.3/24 (global)
        inet6: fd42:40d7:53e9:d1cc:fa8e:ff5c:4f93:e479/64 (global)
        inet6: fd42:40d7:53e9:d1cc:216:3eff:fea2:29a3/64 (global)
        inet6: fe80::216:3eff:fea2:29a3/64 (link)
    lo:
      Type: loopback
      State: UP
      MTU: 65536
      Bytes received: 9.93kB
      Bytes sent: 9.93kB
      Packets received: 114
      Packets sent: 114
      IP addresses:
        inet:  127.0.0.1/8 (local)
        inet6: ::1/128 (local)

lxc console v1 --type vga
unshare: write failed /proc/self/uid_map: Operation not permitted
https://tbhaxor.com/exploiting-linux-capabilities-part-1/
https://blog.quarkslab.com/digging-into-linux-namespaces-part-2.html
```
<https://bugs.launchpad.net/ubuntu/+source/lxd/+bug/2057927#:~:text=When%20trying%20to%20attach%20a%20vga%20console,It%20seems%20to%20be%20related%20to%20apparmor>.

The "lxd write fail uid_map" error in LXD (or Incus, its successor) usually indicates an issue with user namespace ID mapping, specifically when trying to write to the /proc/self/uid_map file. This file is used to map user IDs inside a container to user IDs on the host system, and the error suggests that LXD is unable to create or modify these mappings, according to the Linux Containers Forum. This can prevent containers from starting or functioning correctly, particularly when dealing with nested containers or when the host system's ID mapping configuration is insufficient.

This will open a graphical window displaying the console of the VM named my_vm.
Note:
The lxc console command with --type vga is specifically designed for accessing the graphical console of VMs, providing access to the VM's output, even before the lxd-agent is running.
If you're having trouble connecting, ensure the LXD daemon is running and that the SPICE client is properly installed and configured.
You can also use the lxc query command with a POST request to the console endpoint for more control over the connection, including specifying the width and height of the console window, according to the Ubuntu documentation.
This video demonstrates how to connect to a remote LXD virtual machine using the lxc console command with the --type vga option:

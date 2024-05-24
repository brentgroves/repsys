# Multipass

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://multipass.run/docs>
<https://multipass.run/docs/create-an-instance#heading--create-an-instance>

## Multipass Documentation

Multipass is a tool to generate cloud-style Ubuntu VMs quickly on Linux, macOS, and Windows.

It gives you a simple but powerful CLI that allows you to quickly access an Ubuntu command line or create your own local mini-cloud.

Local development and testing is a pain, but Multipass makes it easier by automating all of your setup and teardown. Multipass has a growing library of images that give you the ability to launch purpose-built VMs, or custom VMs you’ve configured yourself through its powerful cloud-init interface.

Developers can use Multipass to prototype cloud deployments and to create fresh, customized Linux dev environments on any machine. Mac and Windows users can use Multipass as the quickest way to get an Ubuntu command line on their system. New Ubuntu users can use it as a sandbox to try new things without affecting their host machine, and without the need to dual boot.

## To uninstall Multipass, simply run

```sudo snap remove multipass```

## **[Install Multipass](https://multipass.run/docs/installing-on-linux#heading--install-upgrade-uninstall)**

To install Multipass, simply execute:

```bash
$ snap install multipass
multipass 1.13.0 from Canonical✓ installed
```

For architectures other than amd64, you’ll need the beta channel at the moment.

You can also use the edge channel to get the latest development build:

```bash
snap install multipass --edge
```

Make sure you’re part of the group that Multipass gives write access to its **[socket](../sockets/unix_domain_sockets.md)** (sudo in this case, but it may also be adm or admin, depending on your distribution):

Make sure you’re part of the group that Multipass gives write access to its socket (sudo in this case, but it may also be adm or admin, depending on your distribution):

```bash
$ ls -l /var/snap/multipass/common/multipass_socket
srw-rw---- 1 root sudo 0 Dec 19 09:47 /var/snap/multipass/common/multipass_socket
$ groups | grep sudo
brent adm cdrom sudo dip plugdev lpadmin lxd sambashare docker

```

## Create an instance

<https://multipass.run/docs/create-an-instance#heading--create-an-instance>

To create an instance with Multipass, execute:

```bash
$ multipass launch
…
Launched: keen-yak
This has launched a new instance, which has been randomly named keen-yak. In particular, when we run multipass info, we find out that it is an Ubuntu LTS release, namely 18.04, with 1GB RAM, 1 CPU, 5GB of disk:

$ multipass info keen-yak
Name:           keen-yak
State:          RUNNING
IPv4:           10.140.94.253
Release:        Ubuntu 18.04.1 LTS
Image hash:     d53116c67a41 (Ubuntu 18.04 LTS)
CPU(s):         1
Load:           0.00 0.12 0.18
Disk usage:     1.1G out of 4.7G
Memory usage:   71.6M out of 985.4M

```

## How to create an instance

See also: launch, Instance

This document demonstrates various ways to create an instance with Multipass. While every method is a one-liner involving the command launch, each showcases a different option that you can use to get exactly the instance that you want.

Contents:

Create an instance
Create an instance with a specific image
Create an instance with a custom name
Create an instance with custom CPU number, disk, and RAM
Create an instance with primary status
Create an instance with multiple network interfaces
Routing
Bridging
Create an instance with a custom DNS
The --cloud-init approach
The netplan.io approach

Create an instance
See also: launch, info

To create an instance with Multipass, execute:

```bash
$ multipass launch
…
Launched: keen-yak
This has launched a new instance, which has been randomly named keen-yak. In particular, when we run multipass info, we find out that it is an Ubuntu LTS release, namely 18.04, with 1GB RAM, 1 CPU, 5GB of disk:

$ multipass info keen-yak
Name:           keen-yak
State:          RUNNING
IPv4:           10.140.94.253
Release:        Ubuntu 18.04.1 LTS
Image hash:     d53116c67a41 (Ubuntu 18.04 LTS)
CPU(s):         1
Load:           0.00 0.12 0.18
Disk usage:     1.1G out of 4.7G
Memory usage:   71.6M out of 985.4M

Create an instance with a specific image
See also: find, launch <image>, info

To find out what images are available, run:

$ multipass find
snapcraft:core18            18.04             20201111         Snapcraft builder for Core 18
snapcraft:core20            20.04             20210921         Snapcraft builder for Core 20
snapcraft:core22            22.04             20220426         Snapcraft builder for Core 22
snapcraft:devel                               20220525         Snapcraft builder for the devel series
core                        core16            20200818         Ubuntu Core 16
core18                                        20211124         Ubuntu Core 18
18.04                       bionic            20220523         Ubuntu 18.04 LTS
20.04                       focal,lts         20220505         Ubuntu 20.04 LTS
21.10                       impish            20220309         Ubuntu 21.10
22.04                       jammy             20220506         Ubuntu 22.04 LTS
daily:22.10                 devel,kinetic     20220522         Ubuntu 22.10
appliance:adguard-home                        20200812         Ubuntu AdGuard Home Appliance
appliance:mosquitto                           20200812         Ubuntu Mosquitto Appliance
appliance:nextcloud                           20200812         Ubuntu Nextcloud Appliance
appliance:openhab                             20200812         Ubuntu openHAB Home Appliance
appliance:plexmediaserver                     20200812         Ubuntu Plex Media Server Appliance
anbox-cloud-appliance                         latest           Anbox Cloud Appliance
charm-dev                                     latest           A development and testing environment for charmers
docker                                        latest           A Docker environment with Portainer and related tools
minikube                                      latest           minikube is local Kubernetes
```

## To launch an instance with a specific image

To launch an instance with a specific image, pass the image name or alias to multipass launch:

```bash
$ multipass launch kinetic
Launched: tenacious-mink
multipass info confirms that we’ve launched an instance of the selected image.

$ multipass info tenacious-mink
Name:           tenacious-mink
State:          Running
IPv4:           10.49.93.29
Release:        Ubuntu Kinetic Kudu (development branch)
Image hash:     5cb61a7d834d (Ubuntu 22.10)
CPU(s):         1
Load:           0.10 0.06 0.02
Disk usage:     1.4G out of 4.7G
Memory usage:   161.8M out of 971.2M

```

## Create an instance with multiple network interfaces

See also: launch ... --network

Multipass can launch instances with additional network interfaces, via the --network option. That is complemented by the networks command, to find available host networks to bridge with.

This is supported only for images with cloud-init support for Version 2 network config, which in turn requires netplan to be installed. So, from 17.10 and core 16 onward, except for snapcraft:core16. And then only in the following scenarios:

on Linux, with LXD
on Windows, with both Hyper-V and VirtualBox
on macOS, with the QEMU and VirtualBox drivers
The --network option can be given multiple times, each one requesting an additional network interface (beyond the default one, which is always present). Each use takes an argument specifying the properties of the desired interface:

name — the only required value, it identifies the host network to connect the instance’s device to (see networks for possible values)
mode — either auto (the default) or manual; with auto, the instance will attempt automatic network configuration
mac — a custom MAC address to use for the device

These properties can be specified in the format <key>=<value>,…. but a simpler form with only <name> is available for the most common use-case. Here is an example:

$ multipass launch --network en0 --network name=bridge0,mode=manual
Launched: upbeat-whipsnake

$ multipass exec upbeat-whipsnake -- ip -br address show scope global
enp0s3           UP             10.0.2.15/24
enp0s8           UP             192.168.1.146/24
enp0s9           DOWN

$ ping -c1 192.168.1.146  # elsewhere in the same network
PING 192.168.1.146 (192.168.1.146): 56 data bytes
64 bytes from 192.168.1.146: icmp_seq=0 ttl=64 time=0.378 ms
[...]
In the example above, we got the following interfaces inside the instance:

enp0s3 — the default interface, that the instance can use to reach the outside world and which Multipass uses to communicate with the instance;
enp0s8 — the interface that is connected to en0 on the host and which is automatically configured;
enp0s9 — the interface that is connected to bridge0 on the host, ready for manual configuration.

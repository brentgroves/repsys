# **[How to bridge local LAN using Multipass](https://askubuntu.com/questions/1425752/how-to-bridge-local-lan-using-multipass)**

**[Back to Research List](../../research_list.md)**\
**[Back to Multipass Menu](./multipass_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

- **[bridged networks[(https://multipass.run/docs/bridged-network)**
- **[Multipass on Ubuntu with Bridged Network Interfaces](https://jon.sprig.gs/blog/post/2800)**

Looking for some assistance in trying to get the network bridging to work (consistently/more than once) when creating VMs with Multipass. I have tried so many things with the documentation I've found, yet nothing seems to work, or have any level of consistency.

My driver is lxd I am using network manager I initially used launch --network=en0, which is my physical ethernet adapter, and this worked the first time. I was prompted to create a bridge the first time I did this, and any VM I launched would show two IPs, one for the 10.x.x.x Multipass network and the other 192.168.1.x for my local LAN and everything was great.

After one reboot of my Ubuntu server, none of that works anymore and even when attempting to launch a VM with --network= I get a single 10.x.x.x address on the VM and is not accessible from my LAN.

The Ubuntu documentation on how to configure this is not clear, at least to me, and I have to believe this is possible and shouldn't be this difficult to configure. Any direction, tutorials, videos, blogs, instructions, anything - that somebody could throw my way to try and get this working would be hugely appreciated.

The functionality of multipass is awesome, and I would really like to use it.

Could really use and appreciate an assist here.

Almost a year later but here is a solution I found.

Context: This worked for me using Ubuntu 22.04, and a fresh install of Multipass.

This method uses LXD.

1. Install LXD.

sudo snap install lxd
2. Connect LXD to Multipass.

snap connect multipass:lxd lxd
3. Tell Multipass to use LXD:

multipass set local.driver=lxd

```bash
ssh repsys11
multipass networks
Name        Type       Description
docker0     bridge     Network bridge
eno1        ethernet   Ethernet device
eno2        ethernet   Ethernet device
eno3        ethernet   Ethernet device
eno4        ethernet   Ethernet device
enp66s0f0   ethernet   Ethernet device
enp66s0f1   ethernet   Ethernet device
enp66s0f2   ethernet   Ethernet device
enp66s0f3   ethernet   Ethernet device
mpbr0       bridge     Network bridge for Multipass
```

And when I brought my machine up with avahi-daemon installed and configured to broadcast it’s hostname?

```bash
user@host:~$ ip -4 addr

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
37: br-enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    inet 192.0.2.33/24 brd 192.0.2.255 scope global dynamic noprefixroute br-enp3s0
       valid_lft 6455sec preferred_lft 6455sec
user@host:~$ multipass list
Name         State       IPv4             Image
vm01         Running     203.0.113.15     Ubuntu 22.04 LTS
                         192.0.2.101
user@host:~$ ping vm01.local
PING vm01.local (192.0.2.101) 56(84) bytes of data.
```

Now when creating a new instance you can do so with a bridged network. For my setup it worked like this (edit: in case it wasn't obvious, below is an example where my vm instance will be named vm01, and my ethernet interface name is enp3p0)

multipass launch -n vm01 --network enp3s0

From the multipass **[manual](https://multipass.run/docs/launch-command)**, use the option

--bridged                             Adds one `--network bridged` network.

## **[Configure Static IP](https://multipass.run/docs/configure-static-ips)**

This document explains how to create instances with static IPs in a new network, internal to the host. With this approach, instances get an extra IP that does not change with restarts. By using a separate, local network we avoid any IP conflicts. Instances retain the usual default interface with a DHCP-allocated IP, which gives them connectivity to the outside.

![](https://jon.sprig.gs/blog/wp-content/uploads/2023/03/4405616339_69afc96727_c-750x410.jpg)

## Step 1: Create a Bridge

The first step is to create a new bridge/switch with a static IP on your host. This is beyond the scope of Multipass but, as an example, here is how this can be achieved with NetworkManager (e.g. on Ubuntu Desktop):

```bash
nmcli connection add type bridge con-name localbr ifname localbr \
    ipv4.method manual ipv4.addresses 10.13.31.1/24
This will create a bridge named localbr with IP 10.13.31.1/24. You can see the new device and address with ip -c -br addr show dev localbr. This should show:

localbr           DOWN           10.13.31.1/24
```

You can also run ```multipass networks``` to confirm the bridge is available for Multipass to connect to.

```bash
multipass networks
networks failed: The networks feature is not implemented on this backend.
```

**[Multipass on Ubuntu with Bridged Network Interfaces](https://jon.sprig.gs/blog/post/2800)**

I’m working on a new project, and I am using Multipass on an Ubuntu machine to provision some virtual machines on my local machine using cloudinit files. All good so far!

I wanted to expose one of the services I’ve created to the bridged network (so I can run avahi-daemon), and did this by running ```multipass launch -n vm01 --network enp3s0``` when, what should I see but: launch failed: The bridging feature is not implemented on this backend. OH NO!

By chance, I found a **[random Stack Overflow answer](https://askubuntu.com/a/1364507)**, which said:

Currently only the LXD driver supports the networks command on Linux.

So, let’s make multipass on Ubuntu use LXD! (Be prepared for entering your password a few times!)

Firstly, we need to install LXD. Dead simple:

LXD ( [lɛks'di:] 🔈) is a modern, secure and powerful system container and virtual machine manager. It provides a unified experience for running and managing full Linux systems inside containers or virtual machines.

```bash
sudo snap install lxd
lxd (5.21/stable) 5.21.1-d46c406 from Canonical✓ installed
```

Next, we need to tell snap that it’s allowed to connect LXD to multipass:

```bash
sudo snap connect multipass:lxd lxd
```

And lastly, we tell multipass to use lxd:

```bash
multipass set local.driver=lxd
```

Result?

```bash
user@host:~$ multipass networks
Name             Type      Description
enp3s0           ethernet  Ethernet device
mpbr0            bridge    Network bridge for Multipass

# repsys11
multipass networks
Name        Type       Description
docker0     bridge     Network bridge
eno1        ethernet   Ethernet device
eno2        ethernet   Ethernet device
eno3        ethernet   Ethernet device
eno4        ethernet   Ethernet device
enp66s0f0   ethernet   Ethernet device
enp66s0f1   ethernet   Ethernet device
enp66s0f2   ethernet   Ethernet device
enp66s0f3   ethernet   Ethernet device
mpbr0       bridge     Network bridge for Multipass

ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp66s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 00:0a:f7:3e:f4:30 brd ff:ff:ff:ff:ff:ff
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:ca:3a:6a:37:18 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
    inet 10.1.0.125/22 brd 10.1.3.255 scope global noprefixroute eno1
       valid_lft forever preferred_lft forever
    inet6 fe80::4b6a:b1de:224a:86e9/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
...
12: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:8e:af:fc:ce brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
13: mpbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:16:3e:0b:55:9e brd ff:ff:ff:ff:ff:ff
    inet 10.182.32.1/24 scope global mpbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:f307:746a:5edd::1/64 scope global 
       valid_lft forever preferred_lft forever       
```

And when I brought my machine up with avahi-daemon installed and configured to broadcast it’s hostname?

```bash
user@host:~$ ip -4 addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
37: br-enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    inet 192.0.2.33/24 brd 192.0.2.255 scope global dynamic noprefixroute br-enp3s0
       valid_lft 6455sec preferred_lft 6455sec
user@host:~$ multipass list
Name         State       IPv4             Image
vm01         Running     203.0.113.15     Ubuntu 22.04 LTS
                         192.0.2.101
user@host:~$ ping vm01.local
PING vm01.local (192.0.2.101) 56(84) bytes of data.
```

# lxd desktop vm access ovn network

**[try creating custom image from iso](https://www.youtube.com/watch?v=dfh_9aGQ9rE)**
So far the only desktop image that can see other ovn networked vms is archlinux. This time I am going to try the latest ubuntu desktop image after deleting its local cached image. If this don't work I will attempt to create a lxd network other than ovn.

```bash
lxc image list type=virtual-machine
lxc image info aeed887e1eb5
lxc image delete aeed887e1eb5

lxc image info d34c75ed0cd7
lxc image delete d34c75ed0cd7

lxc init images:ubuntu/noble/desktop dt1 --vm
lxc start v1 --console=vga
lxc console --type=vga v1

```

To access an LXD virtual machine (VM) on an OVN network from your desktop, you must connect the OVN virtual network to your physical local network. This is done by creating an uplink network in LXD that acts as a bridge between the OVN's software-defined network and your physical hardware.
Overview of the networking
An OVN logical network is isolated by default, providing a private network for your VMs.
To get traffic out of the OVN network to your physical desktop, it must pass through an "uplink".
This uplink can be an existing LXD bridge network or a physical network interface on your LXD host machine.
Connections from OVN are typically NATed to the IP address of the uplink, so your desktop sees traffic coming from the LXD host, not the individual VM.

Step 1: Create a physical uplink network
This configuration assumes you have an LXD host machine separate from your desktop. You will need a physical network interface (e.g., eth0) or an existing, unmanaged Linux bridge to serve as the uplink parent.
sh

# Create a physical network that will act as the uplink for OVN

# Replace `eth0` with your host's physical network interface

```bash
lxc network create UPLINK --type=physical parent=eth0
```

This command creates a LXD network that points to your host's physical interface.
Step 2: Create the OVN network with the uplink
Next, create the OVN network and configure it to use the UPLINK network you just created for external connectivity.
sh

```bash
# Create a new OVN network and set the `ipv4.dhcp` and `ipv4.ovn.ranges` to match

# a private subnet. The `bridge.external_uplink` connects it to your UPLINK network


lxc network create my-ovn --type=ovn \
    ipv4.dhcp=true ipv4.ovn.ranges=10.0.1.2-10.0.1.200 \
    ipv4.nat=true ipv4.ovn.nat=true \
    bridge.external_uplink=UPLINK

brent@micro11:~$ lxc network show default
name: default
description: Default OVN network
type: ovn
managed: true
status: Created
config:
  bridge.mtu: "1442"
  ipv4.address: 10.233.212.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:40d7:53e9:d1cc::1/64
  ipv6.nat: "true"
  network: UPLINK
  volatile.network.ipv4.address: 10.188.50.206
used_by:
- /1.0/instances/ubuntu
- /1.0/instances/v1
- /1.0/instances/v3
- /1.0/instances/win11
- /1.0/profiles/default
locations:
- micro11
- micro12
- micro13    
```

This sets up a new OVN network (my-ovn) with its own DHCP server and NAT rules. It uses the UPLINK network as the gateway for traffic leaving the OVN subnet.
Step 3: Launch your VM on the OVN network
Launch a new VM and attach it to the my-ovn network.
sh

# Launch a new Ubuntu VM called `my-vm` and connect it to the `my-ovn` network

```bash
# this has network access without network manager
# need to set a password it is locked
lxc launch images:archlinux/desktop-gnome archlinux --vm -c security.secureboot=false -c limits.cpu=4 -c limits.memory=4GiB --console=vga

# no network access only 10.233.212.1
lxc launch images:opensuse/15.6/desktop-kde susedt --vm

lxc console --type=vga susedt

# wont login
lxc init images:opensuse/tumbleweed/desktop-kde susedt1 --vm
lxc launch images:opensuse/tumbleweed/desktop-kde --vm --console=vga
lxc start susedt1 --console=vga
lxc console --type=vga susedt1

lxc init images:ubuntu/noble/desktop v1 --vm
lxc start v1 --console=vga
lxc console --type=vga v1

lxc launch ubuntu:24.04 my-vm --vm --network my-ovn
```

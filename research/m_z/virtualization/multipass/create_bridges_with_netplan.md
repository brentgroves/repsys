# **[How to Bridge Two Network Interfaces in Linux Using Netplan](https://www.tecmint.com/netplan-bridge-network-interfaces/)**

## **[50-cloud-init](https://ubuntuforums.org/showthread.php?t=2492108)**

## Brent's summary

I updated /etc/netplan/50-cloud-init.yaml at it's changes persisted on reboot but if I start having network problems this is the first place I will check. I also only tested this on ubuntu 24.04.

## netplan

Netplan is a utility for easily configuring networking on a Linux system, typically used in Ubuntu. It allows users to configure network interfaces through a simple YAML file.

One common use case is creating a network bridge, which is useful for connecting two or more network interfaces to share a network segment, which is particularly useful in virtualized environments.

## Why Bridging Interfaces is Useful

Bridging network interfaces can be highly beneficial in various scenarios:

- When running virtual machines (VMs), you often need the VMs to communicate with the external network. A bridge allows VMs to appear as if they are physically connected to the same network as the host machine.
- It allows multiple network interfaces to share a single IP subnet, facilitating easier management and communication within the network.
- In complex network setups, bridges can simplify configurations and reduce the need for additional routing.

## Installing bridge-utils in Ubuntu

To bridge network interfaces, you need to install a bridge-utils package which is used to configure and manage network bridges in Linux-based systems.

```bash
sudo apt install bridge-utils
```

## Creating a Network Bridge Using Static IP

Similar to the DHCP configuration, you can also configure static IP addresses on the bridge in the same configuration file.

```bash
# create backup
cd ~
sudo cp /etc/netplan/50-cloud-init.yaml .
sudo vi /etc/netplan/50-cloud-init.yaml
```

## Modify the configuration to assign a static IP to the bridge ‘br0‘

I did not include renderer: networkd when I updated 50-cloud-init.yaml.

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
    enp2s0f1:
      dhcp4: no
  bridges:
    br0:
      dhcp4: no
      addresses: [192.168.122.100/24]
      routes:
        - to: 0.0.0.0/0
          via: 192.168.122.1  # Adjust according to your network configuration
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]  # DNS servers
      interfaces: [enp1s0, enp2s0f1]
```

The actual 50-cloud-init.yaml looked like this.

```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        eno1:
            addresses:
            - 10.1.0.125/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            routes:
            -   to: default
                via: 10.1.1.205
        eno2:
            dhcp4: no
        eno3:
            dhcp4: true
        eno4:
            dhcp4: true
        enp66s0f0:
            dhcp4: true
        enp66s0f1:
            dhcp4: true
        enp66s0f2:
            dhcp4: true
        enp66s0f3:
            dhcp4: true
    bridges:
        br0:
            dhcp4: no
            addresses:
            - 10.1.0.126/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno2]
        br1:
            dhcp4: no
            addresses:
            - 10.13.31.1/24
    version: 2
```

Apply the Configuration Changes: Once you’ve edited the configuration file, apply the changes to update your network settings.

```bash
sudo netplan try
$ sudo netplan apply
reboot
```

## Verify routing tables

**[references iproute2 intro for ip commands](../networking/iproute2/introduction_to_iproute.md)**

```bash
ip route list table local
local 10.1.0.125 dev eno1 proto kernel scope host src 10.1.0.125 
local 10.1.0.126 dev br0 proto kernel scope host src 10.1.0.126 
broadcast 10.1.3.255 dev br0 proto kernel scope link src 10.1.0.126 
broadcast 10.1.3.255 dev eno1 proto kernel scope link src 10.1.0.125 
local 10.13.31.1 dev br1 proto kernel scope host src 10.13.31.1 
broadcast 10.13.31.255 dev br1 proto kernel scope link src 10.13.31.1 
local 10.127.233.1 dev mpbr0 proto kernel scope host src 10.127.233.1 
broadcast 10.127.233.255 dev mpbr0 proto kernel scope link src 10.127.233.1 
local 127.0.0.0/8 dev lo proto kernel scope host src 127.0.0.1 
local 127.0.0.1 dev lo proto kernel scope host src 127.0.0.1 
broadcast 127.255.255.255 dev lo proto kernel scope link src 127.0.0.1 

# there should be only 1 default route
ip route list table main
default via 10.1.1.205 dev eno1 proto static 
10.1.0.0/22 dev br0 proto kernel scope link src 10.1.0.126 
10.1.0.0/22 dev eno1 proto kernel scope link src 10.1.0.125 
10.13.31.0/24 dev br1 proto kernel scope link src 10.13.31.1 
10.127.233.0/24 dev mpbr0 proto kernel scope link src 10.127.233.1

# ip shows us our routes
ip route show
default via 10.1.1.205 dev eno1 proto static 
10.1.0.0/22 dev br0 proto kernel scope link src 10.1.0.126 
10.1.0.0/22 dev eno1 proto kernel scope link src 10.1.0.125 
10.13.31.0/24 dev br1 proto kernel scope link src 10.13.31.1 
10.127.233.0/24 dev mpbr0 proto kernel scope link src 10.127.233.1 

# You can view your machines current arp/neighbor cache/table like so:
ip neigh show
10.1.0.162 dev eno2 lladdr 4c:91:7a:64:0f:7d STALE
10.1.0.166 dev eno1 lladdr 4c:91:7a:63:c0:3a STALE
10.1.1.205 dev eno1 lladdr 34:56:fe:77:58:bc STALE

# view devices linked to bridge
ip link show master br0
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether b8:ca:3a:6a:37:19 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
14: tap34dcb760: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether 5a:8a:38:e5:66:f1 brd ff:ff:ff:ff:ff:ff
18: tap38ceeb39: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether ce:80:f5:53:04:fb brd ff:ff:ff:ff:ff:ff

ip link show master mpbr0
13: tape518c5a7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP mode DEFAULT group default qlen 1000
    link/ether e6:53:77:50:74:f1 brd ff:ff:ff:ff:ff:ff

# show vm routing table
multipass exec -n microk8s-vm -- ip route list table local
local 10.1.0.129 dev enp6s0 proto kernel scope host src 10.1.0.129 
broadcast 10.1.3.255 dev enp6s0 proto kernel scope link src 10.1.0.129 
local 10.127.233.194 dev enp5s0 proto kernel scope host src 10.127.233.194 
broadcast 10.127.233.255 dev enp5s0 proto kernel scope link src 10.127.233.194 
local 127.0.0.0/8 dev lo proto kernel scope host src 127.0.0.1 
local 127.0.0.1 dev lo proto kernel scope host src 127.0.0.1 
broadcast 127.255.255.255 dev lo proto kernel scope link src 127.0.0.1 

multipass exec -n microk8s-vm -- ip route list table main
default via 10.127.233.1 dev enp5s0 proto dhcp src 10.127.233.194 metric 100 
10.1.0.0/22 dev enp6s0 proto kernel scope link src 10.1.0.129 
10.127.233.0/24 dev enp5s0 proto kernel scope link src 10.127.233.194 metric 100 
10.127.233.1 dev enp5s0 proto dhcp scope link src 10.127.233.194 metric 100
```

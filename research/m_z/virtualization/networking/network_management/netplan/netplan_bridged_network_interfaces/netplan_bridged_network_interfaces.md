# **[How to Bridge Two Network Interfaces in Linux Using Netplan](https://www.tecmint.com/netplan-bridge-network-interfaces/)**

## summary

**Use nmcli rather than netplan yaml** to create devices when Network Manager is being used.

Netplan is a utility for easily configuring networking on a Linux system, typically used in Ubuntu. It allows users to configure network interfaces through a simple YAML file.

One common use case is creating a network bridge, which is useful for connecting two or more network interfaces to share a network segment, which is particularly useful in virtualized environments.

In this article, we will discuss how to bridge two interfaces using Netplan, explaining both DHCP and static IP configurations.

## Why Bridging Interfaces is Useful

Bridging network interfaces can be highly beneficial in various scenarios:

- When running virtual machines (VMs), you often need the VMs to communicate with the external network. A bridge allows VMs to appear as if they are physically connected to the same network as the host machine.
- It allows multiple network interfaces to share a single IP subnet, facilitating easier management and communication within the network.
- In complex network setups, bridges can simplify configurations and reduce the need for additional routing.

## Prerequisites

- An Ubuntu system with Netplan installed (usually comes by default with newer Ubuntu versions).
- At least two network interfaces that you want to bridge.

## Installing bridge-utils in Ubuntu

To bridge network interfaces, you need to install a bridge-utils package which is used to configure and manage network bridges in Linux-based systems.

```sudo apt install bridge-utils```

To configure a network bridge between two or more network interfaces, you need to list your network interface using the following ip command.

```bash
ssh brent@repsys13
ip address show 
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:ca:3a:6a:35:98 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
    inet 10.1.0.135/22 brd 10.1.3.255 scope global noprefixroute eno1
       valid_lft forever preferred_lft forever
    inet6 fe80::5e6:ac5:7cdd:c873/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br-eno2 state UP group default qlen 1000
    link/ether b8:ca:3a:6a:35:99 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
8: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:ca:3a:6a:35:9a brd ff:ff:ff:ff:ff:ff
    altname enp1s0f2
    inet 10.1.0.138/22 brd 10.1.3.255 scope global noprefixroute eno3
       valid_lft forever preferred_lft forever
    inet6 fe80::4418:3ffb:954b:9cea/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
11: mybr: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether e2:4f:b4:dd:f4:1b brd ff:ff:ff:ff:ff:ff
    inet 10.15.31.1/24 brd 10.15.31.255 scope global noprefixroute mybr
       valid_lft forever preferred_lft forever
12: localbr: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether ae:6f:d9:34:27:8a brd ff:ff:ff:ff:ff:ff
    inet 10.13.31.1/24 brd 10.13.31.255 scope global noprefixroute localbr
       valid_lft forever preferred_lft forever
13: br-eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether de:28:04:da:3a:48 brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.136/22 brd 10.1.3.255 scope global noprefixroute br-eno2
       valid_lft forever preferred_lft forever
    inet6 fe80::5597:8f60:13a3:3a3/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
14: mpbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:16:3e:0f:04:ee brd ff:ff:ff:ff:ff:ff
    inet 10.161.38.1/24 scope global mpbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:b403:217:3a62::1/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:fe0f:4ee/64 scope link 
       valid_lft forever preferred_lft forever
15: tape2d6a87f: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP group default qlen 1000
    link/ether a6:d8:40:07:0f:ba brd ff:ff:ff:ff:ff:ff
16: tapcbec9d22: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br-eno2 state UP group default qlen 1000
    link/ether fa:8c:d4:8e:92:20 brd ff:ff:ff:ff:ff:ff
17: tap6c832e4a: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mybr state UP group default qlen 1000
    link/ether 76:4b:e9:bd:42:55 brd ff:ff:ff:ff:ff:ff
18: tap94ba3c22: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP group default qlen 1000
    link/ether b6:e8:47:f0:b4:50 brd ff:ff:ff:ff:ff:ff
19: tapc81944ca: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br-eno2 state UP group default qlen 1000
    link/ether 0a:b7:e3:73:67:1f brd ff:ff:ff:ff:ff:ff
20: tapb2ca18ab: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mybr state UP group default qlen 1000
    link/ether ee:c3:82:8a:82:65 brd ff:ff:ff:ff:ff:ff
21: tap314bc2d9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP group default qlen 1000
    link/ether b2:05:a1:80:7e:ae brd ff:ff:ff:ff:ff:ff
22: tapf2e6a72a: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mybr state UP group default qlen 1000
    link/ether ee:f1:e0:ea:0a:06 brd ff:ff:ff:ff:ff:ff

 ```

Noticed that br-eno2 which was created by multipass when I launched ubuntu 24.04 as such:

```bash
multipass launch --name test7 --network eno2 --network name=mybr
```

But I wanted more control over the bridge so I will try creating it using netplan rather than passing the ethernet interface and having multipass create it.

First check the default netplan config file.

```bash
ssh brent@repsys13
cat /etc/netplan/01-network-manager-all.yaml
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager

```

Note that NetworkManager rather than networkd is the default renderer in netplan on repsys13.

Some netplan bridge examples assume networkd rather than NetworkManager is running but on repsys13 NetworkManager is running and networkd is not.

## **[Netplan bridge example 2](https://gist.github.com/ynott/f4bdc89b940522f2a0e4b32790ddb731)**

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp2s0:
      dhcp4: false
      dhcp6: true
      match:
        macaddress: 80:ee:73:zz:zz:zz
  bridges:
    br0:
      dhcp4: false
      addresses: [192.168.xxx.yyy/24]
      interfaces:
        - enp2s0
      gateway4: 192.168.xxx.1
      nameservers:
        addresses: [192.168.xxx.1,8.8.8.8,1.1.1.1 ]
      parameters:
        forward-delay: 0
        stp: false
      optional: true
```

## **[Netplan bridge example 1](https://www.tecmint.com/netplan-bridge-network-interfaces/)**

```yaml
network:
  version: 2
  renderer: networkd
#   renderer: NetworkManager
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

## My own netplan bridge attempt 1

```yaml
network:
  version: 2
  renderer: NetworkManager
    ethernets:
      eno3:
        dhcp4: no
    bridges:
      br0:
        dhcp4: no
        addresses: [10.1.0.138/22]
        routes: # i believe this replaces the gateway4 parameter
          - to: 0.0.0.0/0
            via: 10.1.1.205  # Adjust according to your network configuration
        nameservers:
          addresses: [10.1.2.69,10.1.2.70,172.20.0.39]
        interfaces: [eno3]
```

Indentation is meaningful in YAML. Make sure that you use spaces, rather than tab characters, to indent sections. In the default configuration files and in all the examples in the documentation, we use 2 spaces per indentation level. We recommend you do the same.

```bash
cd ~
cp /etc/netplan/01-network-manager-all.yaml .
sudo nvim /etc/netplan/01-network-manager-all.yaml

cat << EOF > /etc/netplan/10-custom.yaml

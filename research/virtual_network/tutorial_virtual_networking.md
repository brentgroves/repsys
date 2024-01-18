# Tutorial on Virtual Networking

![](https://developers.redhat.com/sites/default/files/styles/article_feature/public/blog/2018/10/bridge.webp?itok=fic3r7Jv)

## references

<https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking>

## Introduction to Linux interfaces for virtual networking

Linux has rich virtual networking capabilities that are used as basis for hosting VMs and containers, as well as cloud environments. In this post, I will give a brief introduction to all commonly used virtual network interface types. There is no code analysis, only a brief introduction to the interfaces and their usage on Linux. Anyone with a network background might be interested in this blog post. A list of interfaces can be obtained using the command ip link help.

This post covers the following frequently used interfaces and some interfaces that can be easily confused with one another:

Bridge
Bonded interface
Team device
VLAN (Virtual LAN)
VXLAN (Virtual eXtensible Local Area Network)
MACVLAN
IPVLAN
MACVTAP/IPVTAP
MACsec (Media Access Control Security)
VETH (Virtual Ethernet)
VCAN (Virtual CAN)
VXCAN (Virtual CAN tunnel)
IPOIB (IP-over-InfiniBand)
NLMON (NetLink MONitor)
Dummy interface
IFB (Intermediate Functional Block)
netdevsim

After reading this article, you will know what these interfaces are, what's the difference between them, when to use them, and how to create them. For other interfaces like tunnel, please see **[An introduction to Linux virtual interfaces: Tunnels](https://developers.redhat.com/blog/2019/05/17/an-introduction-to-linux-virtual-interfaces-tunnels/)**

Bridge
A Linux bridge behaves like a network switch. It forwards packets between interfaces that are connected to it. It's usually used for forwarding packets on routers, on gateways, or between VMs and network namespaces on a host. It also supports STP, VLAN filter, and multicast snooping.

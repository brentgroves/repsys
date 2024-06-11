# **[IP route2 bridge commands](https://developers.redhat.com/articles/2022/04/06/introduction-linux-bridging-commands-and-features)**

## An introduction to Linux bridging commands and features

A Linux bridge is a kernel module that behaves like a network switch, forwarding packets between interfaces that are connected to it. It's usually used for forwarding packets on routers, on gateways, or between VMs and network namespaces on a host.

The Linux bridge has included basic support for the Spanning Tree Protocol (STP), multicast, and Netfilter since the 2.4 and 2.6 kernel series. Features that have been added in more recent releases include:

- Configuration via **[Netlink](https://man7.org/linux/man-pages/man7/netlink.7.html)**
- VLAN filter
- VxLAN tunnel mapping
- Internet Group Management Protocol version 3 (IGMPv3) and Multicast Listener Discovery version 2 (MLDv2)
- Switchdev

In this article, you'll get an introduction to these features and some useful commands to enable and control them. You'll also briefly examine **[Open vSwitch](https://www.openvswitch.org/)** as an alternative to Linux bridging.

## Basic bridge commands

All the commands used in this article are part of the iproute2 module, which invokes Netlink messages to configure the bridge. There are two iproute2 commands for setting and configuring bridges: ip link and bridge.

ip link can add and remove bridges and set their options. bridge displays and manipulates bridges on final distribution boards (FDBs), main distribution boards (MDBs), and virtual local area networks (VLANs).

**Final Distribution Boards:** A distribution board is a component of an electricity supply system which divides an electrical power feed into subsidiary circuits, ...

**MDB – Main Distribution Boards:** MDB is a panel or enclosure that houses the fuses, circuit breakers and ground leakage protection units where the electrical energy is used to distribute ...

The listings that follow demonstrate some basic uses for the two commands. Both require administrator privileges, and therefore the listings are shown with the # root prompt instead of a regular user prompt.

The listings that follow demonstrate some basic uses for the two commands. Both require administrator privileges, and therefore the listings are shown with the # root prompt instead of a regular user prompt.

Show help information about the bridge object:

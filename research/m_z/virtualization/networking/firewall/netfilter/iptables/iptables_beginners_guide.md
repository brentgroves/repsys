# **[iptables Tutorial: A Beginner's Guide to the Linux Firewall](https://phoenixnap.com/kb/iptables-linux)**


**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Status](../../../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../../../README.md)**

All modern operating systems come with a firewall, an application that regulates network traffic to and from a computer. Firewalls use rules to control incoming and outgoing traffic, creating a network security layer.

iptables is the primary firewall utility program developed for Linux systems. The program enables system administrators to define rules and policies for filtering network traffic.

In this tutorial, learn how to install, configure, and use iptables in Linux.

## Prerequisites

- A user account with sudo privileges.
- Access to a terminal window/command line.


## What Is iptables?

iptables is a command-line utility for configuring the built-in Linux kernel firewall. It enables administrators to define chained rules that control incoming and outgoing network traffic.

The rules provide a robust security mechanism, defining which network packets can pass through and which should be blocked. iptables protects Linux systems from data breaches, unauthorized access, and other network security threats.

Administrators use iptables to enforce network security policies and protect a Linux system from various network-based attacks.

## How Does iptables Work?

iptables uses rules to determine what to do with a network packet. The utility consists of the following components:

- Tables. Tables are files that group similar rules. A table consists of several rule chains.
- Chains. A chain is a string of rules. When a packet is received, iptables finds the appropriate table and filters it through the rule chain until it finds a match.
- Rules. A rule is a statement that defines the conditions for matching a packet, which is then sent to a target.
- Targets. A target is a decision of what to do with a packet. The packet is either accepted, dropped, or rejected.

The sections below cover each of these components in greater depth.

## Tables
Linux firewall iptables have four default tables that manage different rule chains:

Filter. The default packet filtering table. It acts as a gatekeeper that decides which packets enter and leave a network.
Network Address Translation (NAT). Contains NAT rules for routing packets to remote networks. It is used for packets that require alterations.
Mangle. Adjusts the IP header properties of packets.
Raw. Exempts packets from connection tracking.
Some Linux distributions include a security table that implements mandatory access control (MAC) rules for stricter access management.

## Chains
Chains are rule lists within tables. The lists control how to handle packets at different processing stages. There are different chains, each with a specific purpose:

INPUT. Handles incoming packets whose destination is a local application or service. The chain is in the filter and mangle tables.
OUTPUT. Manages outgoing packets generated on a local application or service. All tables contain this chain.
FORWARD. Works with packets that pass through the system from one network interface to another. The chain is in the filter, mangle, and security tables.
PREROUTING. Alters packets before they are routed. The alteration happens before a routing decision. The NAT, mangle, and raw tables contain this chain.
POSTROUTING. Alters packets after they are routed. The alteration happens after a routing decision. The NAT and mangle tables contain this chain.

![c](https://phoenixnap.com/kb/wp-content/uploads/2024/05/iptables-tables-and-chains.png)

## Rules
Rules are statements that define conditions for matching packets. Every rule is part of a chain and contains specific criteria, such as source or destination IP addresses, port numbers, or protocols. Any packet matching a rule's conditions is forwarded to a target that determines what happens to the packet.

Targets
A target is what happens after a packet matches a rule criteria. Common targets include:

ACCEPT. Allows the packet to pass through the firewall.
DROP. Discards the packet without informing the sender.
REJECT. Discards the packet and returns an error response to the sender.
LOG. Records packet information into a log file.
SNAT. Stands for Source Network Address Translation. Alters the packet's source address.
DNAT. Stands for Destination Network Address Translation. Changes the packet's destination address.
MASQUERADE. Alters a packet's source address for dynamically assigned IPs.

## How to Install iptables on Linux
iptables is installed by default on most Linux distributions. To confirm that iptables is installed, run:

```bash
iptables --version
iptables v1.8.10 (nf_tables)
```

The command shows the version number. If the package is not found, see OS-specific installation steps below.

Debian and Debian-based Distributions (Ubuntu)
For Debian-based distributions (such as Ubuntu), do the following:

1. Install iptables using the APT package manager:

```bash
sudo apt install iptables
```
2. To keep iptables firewall rules after reboot, install the persistent package:

```bash
sudo apt install iptables-persistent
```

The installation shows the file path where the rules are saved and asks whether to save the current IPv4 and IPv6 rules.

Note: There are two different versions of iptables, for IPv4 and IPv6. This guide covers the rules for IPv4.
To configure iptables for IPv6, use the iptables6 utility. These two protocols do not work together and must be configured independently.

3. Enable the netfilter-persistent service on restart:

```bash
sudo systemctl enable netfilter-persistent
```

The command enables the service to start on reboot automatically.


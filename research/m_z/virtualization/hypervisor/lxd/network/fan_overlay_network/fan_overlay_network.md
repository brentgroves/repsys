# **[fan networking](https://wiki.ubuntu.com/FanNetworking)**

## **[lxd with fan](https://www.youtube.com/watch?v=5cwd0vZJ5bw)**

**[trevor lxd fan](https://www.youtube.com/watch?v=VhkxIY-jCjA&t=634s)**

**[lxd and ceph](https://www.youtube.com/watch?v=kVLGbvRU98A&t=948s)**

**[lxd cluster and ovn](https://www.youtube.com/watch?v=1M__Rm9iZb8)**
  This is very helpful, thank you! Don't forget to have openvswitch installed. Below are the config strings if you want to simply cut and paste them (and replace with your IPs).

  OVN_CTL_OPTS="--db-nb-addr=SERVER1 --db-nb-create-insecure-remote=yes --db-sb-addr=SERVER1 --db-sb-create-insecure-remote=yes --db-nb-cluster-local-addr=LOCAL --db-sb-cluster-local-addr=LOCAL --ovn-northd-nb-db=tcp:SERVER1:6641,tcp:SERVER2:6641,tcp:SERVER3:6641 --ovn-northd-sb-db=tcp:SERVER1:6642,tcp:SERVER2:6642,tcp:SERVER3:6642"

An alternative to using ovn.

Introduction
Containers enable tremendously dense virtualisation -- it is easy to run hundreds or even thousands of containers on a single host machine. Whether for whole machine containers (LXD) or process containers (Docker), it is easiest for these containers to be managed as separate networking entities, which means they need their own IP addresses. The proliferation of containers thus creates demand for additional network address space. Typically, the number of extra addresses needed is roughly constant across each container host.

A new solution to this problem of increased demand for IP address space is the fan. The fan is a mapping between a smaller network address space (typically a /16 network) and a larger one (typically a /8), which assigns subnets from the larger one to IP addresses on the smaller one, and enables automatic and simple tunnelling and routing between systems on the larger address space. Fan addresses are assigned as subnets on a virtual bridge on the host, which are mathematically related to the primary (or underlay) IP address behind which they are mapped. The fan system can be considered “address expansion,” as it simply multiplies the number of available IP addresses on the host, providing an extra 253 usable addresses for each host IP address on the /16.

This document describes the implementation of the fan on Ubuntu, beginning with the principles on which it’s based. Next up are outlines of some common use cases for the fan. The user-mode fan tools are then described, along with how to create a persistent configuration. Finally, detailed configuration instructions for using the fan with both LXC/LXD and Docker are presented.

## Fan Principles

Consider the case of VPCs on EC2:

EC2 VPCs allow you to designate the /16 address space you wish to use. This document adopts the 172.16.0.0/16 network as an “underlay” network.
EC2 by default allows you to have 5 VPCs, so it would be normal to have 172.16.0.0/16, 172.17.0.0/16, etc.
That in turn means that address expansion to anywhere in the 172.0.0.0 range is problematic, as it might cause parts of your VPC to be unable to route to other VPCs in your organisation.

These are highly specialised assumptions that are not always true of traditional network infrastructures, but they are true in many of today’s public cloud infrastructures, which is where we believe the fan overlay is going to be extremely valuable as a bridging story to IPv6. The following sections elaborate on how the fan can help you get the most out of the address space provided by such a set of addresses.

## How it Works

Fan trades access to one user-selected /8 (potentially external) address range for an expanded pool of “organisation-internal” addresses to be used by containers or virtual machines. Fan does this by mapping the addresses in a way that can be computed, rather than one that requires maintenance of distributed state (e.g., routing tables).

## Trading IP Address Ranges

We trade the ability to route to a /8 network, such as 10.0.0.0/8, for an additional 253 IP addresses accessible behind every local IP address. This is suitable for container environments where it avoids the need to track a database of arbitrary overlay addresses for each container mapped to host addresses, and simplifies routing because a single fan route accounts for the entire system on each host.

In other words, for each local underlay IP address you might have on a machine, say 172.16.3.4, you gain an additional 253 overlay IP addresses that can be used by containers on that machine, each within the single /8 selected. This /8 network cannot be used for its original purpose inside the fan. Figure 1 presents a high-level overview of the fan.

![i1](https://wiki.ubuntu.com/FanNetworking?action=AttachFile&do=get&target=fan-figure1.png)

Figure 1: The fan uses IP addresses on the underlay network that bridge to larger overlay networks.

A set of underlay IP addresses can see one another on the existing local network. There may be as many of these as you like from your standard 172.16.0.0/16 VPC address space (a maximum of 65,534 addresses). These may be divided into whatever structure of subnets you like, with whatever routing and firewalling you desire between those subnets. They may also be allocated to virtual machines in whatever pattern you like -- you might have a single network interface per machine with one or more local addresses, or even multiple network interfaces per machine, as long as all of those interfaces have addresses on the 172.16.0.0 space.

## overlay networks

10.3.4.0/24
10.3.5.0/24

## underlay network

172.16.0.0/16

## Our overlay networks

10.188.40.0/24
10.187.40.0/24

## Our underlay network

10.0.0.0/8

Each machine running the fan overlay system now gains a set of virtual network bridges, one for each IP address on the machine from the VPC

Thus, a machine with two network interfaces that has a total of two IP addresses would gain two virtual bridges internally. Each of those virtual bridges would have a /24 subnet routed to it, onto which you can connect container network interfaces and allocate addresses from that /24 subnet.

The net effect is that each single address on the /16 network gains an additional 253 IP addresses on its corresponding host-specific virtual network bridge. This is where we get the 253-fold multiplier of address space.

Addresses created on the fan can reach the Internet (or other private addresses) by use of NAT from their host. Because they are behind NAT on their host, they themselves cannot be reached directly from non-fan addresses unless special port mapping arrangements have been made. Generally, it is easiest for containers on the same fan to talk to one another.

## Address Mapping

The cunning part of the fan is in the way these host-specific virtual bridge subnets are allocated. We map from the /16 local address space into a larger /8 address space in order to create the illusion of a larger but still “flat” address space for these container IP addresses.

We need to know two things:

- The specific local address space being used for the underlay address space on the local network. On a VPC this could be 172.16.0.0/16. You want to know the first two octets (172.16, in this example) of these addresses. This is the underlay address.
- The /8 network to which you do not care to route from this VPC at all, such as 10.0.0.0/8. As this /8 network is utilized for the overlay, if the selected /8 is publicly routed on the Internet, you will lose all connectivity to that /8 network address space from all hosts participating in the fan.

Private IP network classes, defined by RFC 1918, are reserved IP address ranges for private use within local networks, preventing conflicts on the global internet. These are: Class A (10.0.0.0-10.255.255.255) for very large networks, Class B (172.16.0.0-172.31.255.255) for medium-sized networks, and Class C (192.168.0.0-192.168.255.255) for small networks like homes or small offices.  

In this example, the address mapping is simply:

172.16.3.4 -> 10.3.4.0/24

In other words, the machine which has an IP address 172.16.3.4 will also have a private fan bridge called fan-10-3-4 on which the subnet 10.3.4.0/24 is hosted.

Behind the scenes, the fan mapping device encapsulates any traffic routed through it and addresses the outer packet to the appropriate underlay IP address. For instance, suppose a process or container on 172.16.5.6 wanted to communicate with a container that announced its address as 10.3.4.25. The fan-10 would encapsulate that packet and address it to the appropriate underlay address, which is 172.16.3.4. When the packet arrives at 172.16.3.4, it will be unwrapped, leaving the packet addressed to 10.3.4.25. The fan-10-3-4 device on that system will be hosting 10.3.4.0/24 and so the packet is neatly delivered to that bridge and hence the container on the bridge. This arrangement is illustrated in Figure 2. Of course, the containers need not be on separate hosts, but direct communication does not require encapsulating their traffic.

Behind the scenes, the fan mapping device encapsulates any traffic routed through it and addresses the outer packet to the appropriate underlay IP address. For instance, suppose a process or container on 172.16.5.6 wanted to communicate with a container that announced its address as 10.3.4.25. The fan-10 would encapsulate that packet and address it to the appropriate underlay address, which is 172.16.3.4. When the packet arrives at 172.16.3.4, it will be unwrapped, leaving the packet addressed to 10.3.4.25. The fan-10-3-4 device on that system will be hosting 10.3.4.0/24 and so the packet is neatly delivered to that bridge and hence the container on the bridge. This arrangement is illustrated in Figure 2. Of course, the containers need not be on separate hosts, but direct communication does not require encapsulating their traffic.

![i2](https://wiki.ubuntu.com/FanNetworking?action=AttachFile&do=get&target=fan-encapsulation-v2.png)

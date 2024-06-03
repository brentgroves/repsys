# **[Understanding Open vSwitch: Part 1](https://medium.com/@ozcankasal/understanding-open-vswitch-part-1-fd75e32794e4)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Networking Menu](../networking_menu.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## referenences

<https://medium.com/@technbd/multi-hosts-container-networking-a-practical-guide-to-open-vswitch-vxlan-and-docker-overlay-70ec81432092>

## Open vSwitch

Open vSwitch is a production quality, multilayer, software-based,
Ethernet virtual switch. It is designed to enable massive network
automation through programmatic extension, while still supporting
standard management interfaces and protocols (e.g. NetFlow, IPFIX,
sFlow, SPAN, RSPAN, CLI, LACP, 802.1ag). In addition, it is designed
to support distribution across multiple physical servers similar to
VMware's vNetwork distributed vswitch or Cisco's Nexus 1000V.

Welcome to the first phase of our Open vSwitch (OVS) journey! This post takes a closer look at a single bridge handling two VLANs, both with a common VLAN tag.

Open vSwitch (OVS) is an open-source, multilayer virtual switch designed to enable efficient networking within virtualized environments. It was initially developed by Nicira Networks and later became a collaborative project within the open-source community. OVS gained prominence due to its flexibility, scalability, and robust features, making it a popular choice for managing network connections in virtualized infrastructures.

The history of OVS dates back to its first release in 2009, and it has since evolved through contributions from a diverse community of developers. Its adoption has been widespread in various virtualization and cloud computing platforms.

One notable integration is with the OVN-Kubernetes plugin. OVN (Open Virtual Network) is a virtual networking subsystem that builds on OVS to provide additional features like logical switches, routers, and security groups. The OVN-Kubernetes plugin leverages OVS and OVN to enhance networking capabilities within Kubernetes clusters. This integration is crucial for orchestrating communication between containers and ensuring efficient networking in dynamic and scalable containerized environments.

The OVN-Kubernetes plugin extends the capabilities of OVS to provide network virtualization services in Kubernetes clusters, allowing for better isolation, scalability, and management of networking resources. This integration is especially significant in the context of containerized applications, where dynamic scaling and efficient networking are essential for the success of platforms like OpenShift and Kubernetes.

Open vSwitch (OVS) operates at the Data Link Layer (Layer 2) of the OSI model, making it a crucial component for managing Ethernet frames within virtualized environments. Here’s an explanation of how OVS operates at the L2 level and how it extends network segments:

## Switching and Forwarding

- OVS functions as a virtual switch, much like a physical Ethernet switch.
- It examines the MAC addresses in incoming Ethernet frames and uses a MAC address table to make forwarding decisions.

The MAC address table is where the switch stores information about the other Ethernet interfaces to which it is connected on a network. The table enables the switch to send outgoing data (Ethernet frames) on the specific port required to reach its destination, instead of broadcasting the data on all ports (flooding).

## MAC Address Learning

- OVS employs MAC address learning to build and maintain a table that maps MAC addresses to specific switch ports.
- When a frame arrives, OVS records the source MAC address and the port through which the frame entered.

## Broadcast and Multicast Handling

OVS handles broadcast and multicast frames, ensuring they are forwarded only to the relevant ports, minimizing unnecessary network traffic.

## Bridging and Bridging Domains

OVS creates bridges that act as virtual switches connecting multiple ports.
Each bridge represents a bridging domain, allowing devices connected to different ports to be part of the same logical network.

## VLAN Tagging

OVS supports VLAN tagging, allowing the segmentation of a physical network into multiple logical networks (VLANs).
This feature enhances network isolation and security, as traffic from different VLANs does not interfere with each other.

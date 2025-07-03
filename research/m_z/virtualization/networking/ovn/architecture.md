# **[Architecture](https://www.ovn.org/en/architecture/)**

OVN, the Open Virtual Network, is a system to support logical network abstraction in virtual machine and container environments. OVN complements the existing capabilities of OVS to add native support for logical network abstractions, such as logical L2 and L3 overlays and security groups. Services such as DHCP are also desirable features. Just like OVS, OVN’s design goal is to have a production-quality implementation that can operate at significant scale.

In network architecture, an underlay network refers to the physical infrastructure (hardware, cables, routers, etc.) that provides the basic connectivity for data transmission. An overlay network, on the other hand, is a virtual network built on top of the underlay, using software to create logical connections and manage traffic flow. Essentially, the underlay is the foundation, while the overlay is a layer of abstraction that provides flexibility and control.

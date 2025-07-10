# **[try 1]()**

## **[ovn underlay network](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/ovn_underlay/)**

### physical server underlay

For an explanation of the benefits of using an OVN underlay network, see **[Dedicated underlay network](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/networking/#exp-networking-ovn-underlay)**.

When running microcloud init, if you chose to set up distributed networking and you have at least one network interface per cluster member with an **IP address**, MicroCloud asks if you want to configure an underlay network for OVN:

Configure dedicated underlay networking? (yes/no) [default=no]: <answer>

You can choose to skip this question (just hit Enter). MicroCloud then uses its internal network as an OVN ‘underlay’, which is the same as the OVN management network (‘overlay’ network).

You could also choose to configure a dedicated underlay network for OVN by typing yes. A list of available network interfaces with an **IP address** will be displayed. You can then select one network interface per cluster member to be used as the interfaces for the underlay network of OVN.

```yaml
underlay_network: "10.188.50.0/24"
ip: "10.188.50.231"

```

### physical server **[ceph network](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/ceph_networking/#howto-ceph-networking)**

## How to configure Ceph networking

When running microcloud init, you are asked if you want to provide custom subnets for the Ceph cluster. Here are the questions you will be asked:

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph internal traffic on? [default: 203.0.113.0/24]: <answer>

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph public traffic on? [default: 203.0.113.0/24]: <answer>

You can choose to skip both questions (just hit Enter) and use the default value which is the subnet used for the internal MicroCloud traffic. This is referred to as a usual Ceph networking setup.

![i1](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_usual_setup.svg)

Sometimes, you want to be able to use different network interfaces for some Ceph related usages. Let’s imagine you have machines with network interfaces that are tailored for high throughput and low latency data transfer, like 100 GbE+ QSFP links, and other ones that might be more suited for management traffic, like 1 GbE or 10 GbE links.

In this case, it would probably be ideal to set your Ceph internal (or cluster) traffic on the high throughput network interface and the Ceph public traffic on the management network interface. This is referred to as a fully disaggregated Ceph networking setup.

![i2](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_full_setup.svg)

In a Ceph storage cluster, public traffic refers to the network communication between Ceph clients (like virtual machines or applications) and the Ceph storage cluster, as well as communication between different Ceph daemons. It's essentially the "front-side" network, handling client requests and data access.

![i3](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_partial_setup.svg)

### internal traffic (unsure)

10.188.220.0/24

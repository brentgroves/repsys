# **[configure ceph networking](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/ceph_networking/#howto-ceph-networking)**

When running microcloud init, you are asked if you want to provide custom subnets for the Ceph cluster. Here are the questions you will be asked:

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph internal traffic on? [default: 203.0.113.0/24]: <answer>

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph public traffic on? [default: 203.0.113.0/24]: <answer>

You can choose to skip both questions (just hit Enter) and use the default value which is the subnet used for the internal MicroCloud traffic. This is referred to as a usual Ceph networking setup.

![i1](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_usual_setup.svg)

Sometimes, you want to be able to use different network interfaces for some Ceph related usages. Let’s imagine you have machines with network interfaces that are tailored for high throughput and low latency data transfer, like 100 GbE+ QSFP links, and other ones that might be more suited for management traffic, like 1 GbE or 10 GbE links.

In this case, it would probably be ideal to set your Ceph internal (or cluster) traffic on the high throughput network interface and the Ceph public traffic on the management network interface. This is referred to as a fully disaggregated Ceph networking setup.

![i2](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_full_setup.svg)

You could also decide to put both types of traffic on the same high throughput and low latency network interface. This is referred to as a partially disaggregated Ceph networking setup.

![i3](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_partial_setup.svg)

To use a fully or partially disaggregated Ceph networking setup with your MicroCloud, specify the corresponding subnets during the MicroCloud initialization process.

The following instructions build on the **[Get started with MicroCloud](https://documentation.ubuntu.com/microcloud/latest/microcloud/tutorial/get_started/#get-started)** tutorial and show how you can test setting up a MicroCloud with disaggregated Ceph networking inside a LXD setup.

## 1. Create the dedicated networks for Ceph

First, just like when you created an uplink network for MicroCloud so that the cluster members could have external connectivity, you will need to create a dedicated network for the Ceph cluster members to communicate with each other. Let’s call it cephbr0:

```bash
lxc network create cephbr0
```

Create a second network. Let’s call it cephbr1:

```bash
lxc network create cephbr1
```

Enter the following commands to find out the assigned IPv4 and IPv6 addresses for the networks and note them down:

```bash
lxc network get cephbr0 ipv4.address
lxc network get cephbr0 ipv6.address
lxc network get cephbr1 ipv4.address
lxc network get cephbr1 ipv6.address
```

Create the network interfaces that will be used for the Ceph networking setup for each VM:

Add the network device for the cephbr0 and cephbr1 network:

```bash
lxc config device add micro1 eth2 nic network=cephbr0 name=eth2
lxc config device add micro2 eth2 nic network=cephbr0 name=eth2
lxc config device add micro3 eth2 nic network=cephbr0 name=eth2
lxc config device add micro4 eth2 nic network=cephbr0 name=eth2
lxc config device add micro1 eth3 nic network=cephbr1 name=eth3
lxc config device add micro2 eth3 nic network=cephbr1 name=eth3
lxc config device add micro3 eth3 nic network=cephbr1 name=eth3
lxc config device add micro4 eth3 nic network=cephbr1 name=eth3
```

Now, just like in the tutorial, start the VMs.

On each VM, bring the network interfaces up and give them an IP address within their network subnet:

For the cephbr0 network, do the following for each VM:

```bash
# If the `cephbr0` gateway address is `10.0.1.1/24` (subnet should be `10.0.1.0/24`)
ip link set enp7s0 up
# `X` should be a number between 2 and 254, different for each VM
ip addr add 10.0.1.X/24 dev enp7s0
```

Do the same for cephbr1 on each VM:

```bash
# If the `cephbr1` gateway address is `10.0.2.1/24` (subnet should be `10.0.2.0/24`)
ip link set enp8s0 up
# `X` should be a number between 2 and 254, different for each VM
ip addr add 10.0.2.X/24 dev enp8s0
```

Now, you can start the MicroCloud initialization process and provide the subnets you noted down in step 1.c when asked for the Ceph networking subnets.

We will use cephbr0 for the Ceph internal traffic and cephbr1 for the Ceph public traffic. In a production setup, you’d choose the fast subnet for the internal Ceph traffic:

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph internal traffic on? [default: 203.0.113.0/24]: 10.0.1.0/24

```bash
Interface "enp7s0" ("10.0.1.3") detected on cluster member "micro2"
Interface "enp7s0" ("10.0.1.4") detected on cluster member "micro3"
Interface "enp7s0" ("10.0.1.2") detected on cluster member "micro1"
```

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph public traffic on? [default: 10.0.1.0/24]: 10.0.2.0/24

```bash
Interface "enp8s0" ("10.0.2.3") detected on cluster member "micro2"
Interface "enp7s0" ("10.0.2.4") detected on cluster member "micro3"
Interface "enp7s0" ("10.0.2.2") detected on cluster member "micro1"
```

The MicroCloud initialization process will now continue as usual and the Ceph cluster will be configured with the networking setup you provided.

You can now inspect the Ceph network setup:

Inspect the Ceph configuration file:

```bash
sudo snap install microceph
microceph.ceph config dump
WHO     MASK  LEVEL     OPTION                       VALUE        RO
global        advanced  cluster_network              10.0.1.0/24  *
global        advanced  public_network               10.0.2.0/24  *
global        advanced  osd_pool_default_crush_rule  2
```

Inspect your Ceph-related network traffic:

```bash
lxc launch ubuntu:22.04 u5 -s remote
Creating c1
Starting c1
```

At the same time, observe the Ceph traffic on the enp7s0 (or enp8s0 in a fully disaggregated setup) interface (on any cluster member) using tcpdump:

```bash
tcpdump -i enp7s0
17:48:48.600971 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329386555:329422755, ack 245889462, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909539], length 36200
17:48:48.601012 IP micro1.48746 > 10.0.1.4.6804: Flags [.], ack 329386555, win 24317, options [nop,nop,TS val 3647909564 ecr 3552095031], length 0
17:48:48.600971 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329422755:329451715, ack 245889462, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909563], length 28960
17:48:48.601089 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329451715:329516875, ack 245889462, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909563], length 65160
17:48:48.601089 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329516875:329582035, ack 245889462, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909563], length 65160
17:48:48.601089 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329582035:329624764, ack 245889462, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909563], length 42729
17:48:48.601204 IP micro1.48746 > 10.0.1.4.6804: Flags [.], ack 329624764, win 23357, options [nop,nop,TS val 3647909564 ecr 3552095031], length 0
17:48:48.601206 IP 10.0.1.4.6803 > micro1.33328: Flags [P.], seq 938255:938512, ack 359644195, win 24576, options [nop,nop,TS val 3552095031 ecr 3647909540], length 257
17:48:48.601310 IP micro1.48746 > 10.0.1.4.6804: Flags [P.], seq 245889462:245889506, ack 329624764, win 24576, options [nop,nop,TS val 3647909564 ecr 3552095031], length 44
17:48:48.602839 IP micro1.48746 > 10.0.1.4.6804: Flags [P.], seq 245889506:245889707, ack 329624764, win 24576, options [nop,nop,TS val 3647909566 ecr 3552095031], length 201
17:48:48.602947 IP 10.0.1.4.6804 > micro1.48746: Flags [.], ack 245889707, win 24576, options [nop,nop,TS val 3552095033 ecr 3647909564], length 0
17:48:48.602975 IP 10.0.1.4.6804 > micro1.48746: Flags [P.], seq 329624764:329624808, ack 245889707, win 24576, options [nop,nop,TS val 3552095033 ecr 3647909564], length 44
17:48:48.603028 IP 10.0.1.4.6803 > micro1.33328: Flags [P.], seq 938512:938811, ack 359644195, win 24576, options [nop,nop,TS val 3552095033 ecr 3647909540], length 299
17:48:48.603053 IP micro1.33328 > 10.0.1.4.6803: Flags [.], ack 938811, win 1886, options [nop,nop,TS val 3647909566 ecr 3552095031], length 0
17:48:48.604594 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359644195:359709355, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095031], length 65160
17:48:48.604644 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359709355:359774515, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095031], length 65160
17:48:48.604688 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359774515:359839675, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095031], length 65160
17:48:48.604733 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359839675:359904835, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095031], length 65160
17:48:48.604751 IP 10.0.1.4.6803 > micro1.33328: Flags [.], ack 359709355, win 24317, options [nop,nop,TS val 3552095035 ecr 3647909568], length 0
17:48:48.604757 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359904835:359910746, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095035], length 5911
17:48:48.604797 IP micro1.33328 > 10.0.1.4.6803: Flags [P.], seq 359910746:359975906, ack 938811, win 1886, options [nop,nop,TS val 3647909568 ecr 3552095035], length 65160
```

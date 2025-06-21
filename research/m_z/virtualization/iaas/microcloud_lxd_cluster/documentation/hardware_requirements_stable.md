# **[hardware requirements](https://documentation.ubuntu.com/microcloud/stable/microcloud/reference/#hardware-requirements)**

MicroCloud requires a minimum of three machines. It supports up to 50 machines.

Each machine must have at least 8 GiB of RAM (more depending on the connected disks). You can mix different processor architectures within the same MicroCloud cluster.

If you want to add further machines after the initial initialisation, you can use the microcloud add command.

To use local storage, each machine requires a local disk. To use distributed storage, at least three additional disks (not only partitions) for use by Ceph are required, and these disks must be on at least three different machines.

Also see Ceph’s **[hardware recommendations](https://docs.ceph.com/en/latest/start/hardware-recommendations/#hardware-recommendations)**.

## Networking requirements

For networking, MicroCloud requires at least two dedicated network interfaces: one for intra-cluster communication and one for external connectivity. If you want to segregate the Ceph networks and the OVN underlay network, you might need more dedicated interfaces.

To allow for external connectivity, MicroCloud requires an uplink network that supports broadcast and multicast. See **[Networking](https://documentation.ubuntu.com/microcloud/stable/microcloud/explanation/microcloud/#explanation-networking)** for more information.

The IP addresses of the machines must not change after installation, so DHCP is not supported.

## Software requirements

MicroCloud requires snapd version 2.59 or newer.

Also see **[LXD’s Requirements](https://documentation.ubuntu.com/en/latest/lxd/requirements/#requirements)** and Ceph’s **[OS Recommendations](https://docs.ceph.com/en/latest/start/os-recommendations/)**.

## Snaps

To run MicroCloud, you must install the following snaps:

MicroCloud snap

LXD snap

MicroCeph snap

MicroOVN snap

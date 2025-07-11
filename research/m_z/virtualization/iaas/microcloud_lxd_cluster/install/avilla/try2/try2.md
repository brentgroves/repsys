# **[try 2 - single node setup from video](https://www.youtube.com/watch?v=M0y0hQ16YuE&t=359s)**

**[try 2 - single node setup](https://documentation.ubuntu.com/microcloud/latest/microcloud/tutorial/get_started/)**

- need 2 additional network interfaces
1 for uplink, 1 for microceph, 1 for microovn
- Use the latest docs.
- View the matrix of compatible versions to determine whether you need to upgrade the snap to a different channel. Follow either the update or upgrade instructions below.

| Ubuntu LTS | MicroCloud | LXD   | MicroCeph | MicroOVN |
|------------|------------|-------|-----------|----------|
| 22.04      | 2.1*       | 5.21* | Squid     | 24.03    |
| 24.04      | 2.1*       | 5.21* | Squid     | 24.03    |

```bash
sudo snap install lxd --channel=5.21/stable --cohort="+"
sudo snap install microceph --channel=squid/stable --cohort="+"
sudo snap install microovn --channel=24.03/stable --cohort="+"
sudo snap install microcloud --channel=2/stable --cohort="+"

sudo -i


snap list
snap list
Name        Version                 Rev    Tracking       Publisher   Notes
core22      20250612                2045   latest/stable  canonical✓  base
core24      20250526                1006   latest/stable  canonical✓  base
lxd         5.21.3-c5ae129          33110  5.21/stable    canonical✓  in-cohort
microceph   19.2.0+snapab139d4a1f   1393   squid/stable   canonical✓  in-cohort
microcloud  2.1.0-3e8b183           1144   2/stable       canonical✓  in-cohort
microovn    24.03.2+snapa2c59c105b  667    24.03/stable   canonical✓  in-cohort
snapd       2.70                    24792  latest/stable  canonical✓  snapd

snap services --global
snap services --global
Service                          Startup   Current   Notes
lxd.activate                     enabled   inactive  -
lxd.daemon                       enabled   inactive  socket-activated
lxd.user-daemon                  enabled   inactive  socket-activated
microceph.daemon                 enabled   active    -
microceph.mds                    disabled  inactive  -
microceph.mgr                    disabled  inactive  -
microceph.mon                    disabled  inactive  -
microceph.osd                    disabled  inactive  -
microceph.rbd-mirror             disabled  inactive  -
microceph.rgw                    disabled  inactive  -
microcloud.daemon                enabled   active    -
microovn.chassis                 disabled  inactive  -
microovn.daemon                  enabled   active    -
microovn.ovn-northd              disabled  inactive  -
microovn.ovn-ovsdb-server-nb     disabled  inactive  -
microovn.ovn-ovsdb-server-sb     disabled  inactive  -
microovn.refresh-expiring-certs  enabled   inactive  timer-activated
microovn.switch                  disabled  inactive  -

# reboot system
# reboot
# did not reboot
```

The --cohort flag ensures that versions remain **[synchronized during later updates](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/update_upgrade/#howto-update-sync)**.

Following installation, make sure to **[hold updates](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/update_upgrade/#howto-update-hold)**.

To indefinitely hold all updates to the snaps needed for MicroCloud, run:

`sudo snap refresh --hold lxd microceph microovn microcloud`

```bash
sudo -i
microcloud init
Waiting for services to start ...
Do you want to set up more than one cluster member? (yes/no) [default=yes]: no
Select an address for MicroCloud's internal traffic:
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------------+----------+
       |    ADDRESS     |  IFACE   |
       +----------------+----------+
> [x]  | 10.188.50.201  | eno150   |
  [ ]  | 10.188.220.201 | eno1220  |
  [ ]  | 10.187.220.201 | eno11220 |
       +----------------+----------+

Select exactly one disk from each cluster member:
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
       | LOCATION |         MODEL          | CAPACITY  | TYPE  |                          PATH                          |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
  [ ]  | micro11  | HL-DT-ST DVD-ROM DU70N | 0B        | cdrom | /dev/disk/by-id/wwn-0x5001480000000000                 |
> [x]  | micro11  | PERC H710              | 1.82TiB   | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002fef43a819011d8a |
  [ ]  | micro11  | PERC H710              | 1.82TiB   | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002fef438b174afe15 |
  [ ]  | micro11  | PERC H710              | 465.25GiB | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002ffb00930d3d91c9 |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+       

Select which disks to wipe:
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
       | LOCATION |         MODEL          | CAPACITY  | TYPE  |                          PATH                          |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
> [x]  | micro11  | PERC H710              | 1.82TiB   | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002fef43a819011d8a |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+

Would you like to set up distributed storage? (yes/no) [default=yes]: yes
Select from the available unpartitioned disks:
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
       | LOCATION |         MODEL          | CAPACITY  | TYPE  |                          PATH                          |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
  [ ]  | micro11  | HL-DT-ST DVD-ROM DU70N | 0B        | cdrom | /dev/disk/by-id/wwn-0x5001480000000000                 |
> [x]  | micro11  | PERC H710              | 1.82TiB   | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002fef438b174afe15 |
  [ ]  | micro11  | PERC H710              | 465.25GiB | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002ffb00930d3d91c9 |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+

Select which disks to wipe:
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
       | LOCATION |         MODEL          | CAPACITY  | TYPE  |                          PATH                          |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+
> [x]  | micro11  | PERC H710              | 1.82TiB   | scsi  | /dev/disk/by-id/wwn-0x6c81f660dba9cd002fef438b174afe15 |
       +----------+------------------------+-----------+-------+--------------------------------------------------------+    

Disk configuration does not meet recommendations for fault tolerance. At least 3 systems must supply disks.
Continuing with this configuration will inhibit MicroCloud's ability to retain data on system failure
Change disk selection? (yes/no) [default=yes]: no

# diff from tutorial. he selected yes
Do you want to encrypt the selected disks? (yes/no) [default=no]: no
Would you like to set up CephFS remote storage? (yes/no) [default=yes]: yes
# diff from tutorial. he selected another subnet for both internal and public traffic.
What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph internal traffic on? [default: 10.188.50.0/24]
What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph public traffic on? [default: 10.188.50.0/24]

Configure distributed networking? (yes/no) [default=yes]: yes
Select an available interface per system to provide external connectivity for distributed network(s):
Space to select; enter to confirm; type to filter results.
Up/down to move; right to select all; left to select none.
       +----------+--------+----------+
       | LOCATION | IFACE  |   TYPE   |
       +----------+--------+----------+
  [ ]  | micro11  | eno1   | physical |
  [ ]  | micro11  | eno2   | physical |
  [ ]  | micro11  | eno3   | physical |
> [x]  | micro11  | eno250 | vlan     |
  [ ]  | micro11  | eno350 | vlan     |
       +----------+--------+----------+

nmap -sP 10.188.50.0/24

 Using "eno250" on "micro11" for OVN uplink

Specify the IPv4 gateway (CIDR) on the uplink network (empty to skip IPv4): 10.188.50.254/24
Specify the first IPv4 address in the range to use on the uplink network: 10.188.50.6
Specify the last IPv4 address in the range to use on the uplink network: 10.188.50.12
# no ipv6 on network
Specify the IPv6 gateway (CIDR) on the uplink network (empty to skip IPv6):
Specify the DNS addresses (comma-separated IPv4 / IPv6 addresses) for the distributed network (default: 10.188.50.254): 10.225.50.203,10.224.50.203
Configure dedicated OVN underlay networking? (yes/no) [default=no]: 
Initializing new services
 Local MicroCloud is ready
 Local MicroOVN is ready
 Local MicroCeph is ready
 Local LXD is ready
Awaiting cluster formation ...
Configuring cluster-wide devices ...
MicroCloud is ready

microcloud cluster list
+---------+--------------------+-------+------------------------------------------------------------------+--------+
|  NAME   |      ADDRESS       | ROLE  |                           FINGERPRINT                            | STATUS |
+---------+--------------------+-------+------------------------------------------------------------------+--------+
| micro11 | 10.188.50.201:9443 | voter | 39546f950581d217671bf58b0b990bda4da6035c48a73c2a6c7c01e07c8ebf7f | ONLINE |
+---------+--------------------+-------+------------------------------------------------------------------+--------+

lxc launch ubuntu:24.04
Or for a virtual machine: lxc launch ubuntu:24.04 --vm

+---------+----------------------------+-----------------+--------------+----------------+-------------+--------+-------------------+
|  NAME   |            URL             |      ROLES      | ARCHITECTURE | FAILURE DOMAIN | DESCRIPTION | STATE  |      MESSAGE      |
+---------+----------------------------+-----------------+--------------+----------------+-------------+--------+-------------------+
| micro11 | https://10.188.50.201:8443 | database-leader | x86_64       | default        |             | ONLINE | Fully operational |
|         |                            | database        |              |                |             |        |                   |
+---------+----------------------------+-----------------+--------------+----------------+-------------+--------+-------------------+
microceph cluster list
+---------+--------------------+-------+------------------------------------------------------------------+--------+
|  NAME   |      ADDRESS       | ROLE  |                           FINGERPRINT                            | STATUS |
+---------+--------------------+-------+------------------------------------------------------------------+--------+
| micro11 | 10.188.50.201:7443 | voter | cc16466a5a699f8b60beec6da73984f22acc66f78bb86b4dbab36611e0c2b387 | ONLINE |
+---------+--------------------+-------+------------------------------------------------------------------+--------+
microovn cluster list
microovn cluster list
+---------+--------------------+-------+------------------------------------------------------------------+--------+
|  NAME   |      ADDRESS       | ROLE  |                           FINGERPRINT                            | STATUS |
+---------+--------------------+-------+------------------------------------------------------------------+--------+
| micro11 | 10.188.50.201:6443 | voter | 26a367389e3bd0905b7c01a670cf777b83750e068774a250ed42f3624db38f1d | ONLINE |
+---------+--------------------+-------+------------------------------------------------------------------+--------+

lxc profile list
+---------+---------------------+---------+
|  NAME   |     DESCRIPTION     | USED BY |
+---------+---------------------+---------+
| default | Default LXD profile | 0       |
+---------+---------------------+---------+

lxc profile show default
name: default
description: Default LXD profile
config: {}
devices:
  eth0:
    name: eth0
    network: default
    type: nic
  root:
    path: /
    pool: remote
    type: disk
used_by: []
```

## START HERE VIDE TIME 10:23

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

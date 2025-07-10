# **[How to initialize Microcloud](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/initialize/)**

The **[initialization process](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/initialization/#explanation-initialization)** bootstraps the MicroCloud cluster. You run the initialization on one of the machines, and it configures the required services on all of the machines that have been joined.

## Pre-initialization requirements

Complete the steps in **[How to install MicroCloud](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/install/#howto-install)** before initialization.

If you intend to use full disk encryption (FDE) on any cluster member, that member must meet the prerequisites listed on this page: Full disk encryption.

Follow only the instructions in the Prerequisites section on that page. Skip its Usage section; the MicroCloud initialization process handles the disk encryption.

## Interactive configuration

If you run the initialization process in interactive mode (the default), you are prompted for information about your machines and how you want to set them up. The questions that you are asked might differ depending on your setup. For example, if you do not have the MicroOVN snap installed, you will not be prompted to configure your network; if your machines don’t have local disks, you will not be prompted to set up storage.

The following instructions show the full initialization process.

Tip

During initialization, MicroCloud displays tables of entities to choose from.

To select specific entities, use the Up and Down keys to choose a table row and select it with the Space key. To select all rows, use the Right key. You can filter the table rows by typing one or more characters.

When you have selected the required entities, hit Enter to confirm.

Complete the following steps to initialize MicroCloud:

## 1. On one of the machines, enter the following command

`sudo microcloud init`

## 2. Select whether you want to set up more than one machine

This allows you to create a MicroCloud using a single cluster member. It will skip the **[Trust establishment session](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/initialization/#trust-establishment-session)** if no more machines should be part of the MicroCloud.

Additional machines can always be added at a later point in time. See **[How to add a machine](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/add_machine/#howto-add)** for more information.

## 3. Select the IP address that you want to use for MicroCloud’s internal traffic (see **[Network interface for intra-cluster traffic](https://documentation.ubuntu.com/microcloud/latest/microcloud/reference/requirements/#reference-requirements-network-interfaces-intracluster)**)

MicroCloud automatically detects the available addresses (IPv4 and IPv6) on the existing network interfaces and displays them in a table.

MicroCloud requires one network interface that is pre-configured with an IP address (IPv4 or IPv6) that is within the same subnet as the IPs of the other cluster members. The network that it is connected to must support multicast.  

You must select exactly one address.

```yaml
micro11:
  vlan: eno150
  network: "10.188.50.0/24"
  ip: "10.188.50.201"
```

## 4. On all the other machines, enter the following command and repeat the address selection

`sudo microcloud join`

It will automatically detect the machine acting as the initiator. See **[Trust establishment session](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/initialization/#trust-establishment-session)** for more information and **[Automatic server detection](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/initialization/#automatic-server-detection)** in case the network doesn’t support multicast.

## 5. Select the machines that you want to add to the MicroCloud cluster

MicroCloud displays all machines that have reached out during the trust establishment session. Make sure that all machines that you select have the required snaps installed.

## 6. Select whether you want to set up local storage

### Note

To set up local storage, each machine must have a local disk.

- The disks must not contain any partitions.
- A disk used for local storage will not be available for distributed storage.
- If you choose yes, configure the local storage:
- Select the disks that you want to use for local storage.

You must select exactly one disk from each machine.

```yaml
micro11:
  disks:
    local_storage: sdb
micro12:
  disks:
    local_storage: sda
micro13:
  disks:
    local_storage: sdb
```

Select whether you want to wipe any of the disks. Wiping a disk will destroy all data on it.

## 7. Select whether you want to set up distributed storage (using MicroCeph)

Note

- You can set up distributed storage on a single cluster member.
- High availability requires a minimum of 3 cluster members, with 3 separate disks across 3 different cluster members.
- The disks must not contain any partitions.

A disk that was previously selected for local storage will not be shown for distributed storage.

If you choose yes, configure the distributed storage:

Select the disks that you want to use for distributed storage.

```yaml
micro11:
  disks:
    distributed_storage: sdc

micro12:
  disks:
    distributed_storage: sdb

micro13:
  disks:
    distributed_storage: sdc
```

You must select at least one disk.

Select whether you want to wipe any of the disks. Wiping a disk will destroy all data on it. `yes`

Select whether you want to encrypt any of the disks. Encrypting a disk will store the encryption keys in the Ceph key ring inside the Ceph configuration folder.
`no`

Warning

Cluster members with disks to be encrypted require a kernel with dm-crypt enabled. The snap dm-crypt plug must also be connected. See the Prerequisites section of this page for more information: Full disk encryption.

If you have not enabled and connected dm-crypt on any cluster member that you want to encrypt, do so now before you continue.

You can choose to optionally set up a CephFS distributed file system. `no`

## 8. Select either an IPv4 or IPv6 CIDR subnet for the Ceph internal traffic

You can leave it empty to use the default value, which is the MicroCloud internal network (see **[How to configure Ceph networking for how to configure it](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/ceph_networking/#howto-ceph-networking)**).

When running microcloud init, you are asked if you want to provide custom subnets for the Ceph cluster. Here are the questions you will be asked:

```bash
What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph internal traffic on? [default: 203.0.113.0/24]: 

What subnet (either IPv4 or IPv6 CIDR notation) would you like your Ceph public traffic on? [default: 203.0.113.0/24]: 
```

You can choose to **skip both questions (just hit Enter)** and use the default value which is the subnet used for the internal MicroCloud traffic. This is referred to as a usual Ceph networking setup.

![i1](https://documentation.ubuntu.com/microcloud/latest/microcloud/_images/ceph_network_usual_setup.svg)

## 9: Select whether you want to set up distributed networking (using MicroOVN)

If you choose yes, configure the distributed networking: `yes`

## a: Select the network interfaces that you want to use (see **[Network interface to connect to the uplink network](https://documentation.ubuntu.com/microcloud/latest/microcloud/reference/requirements/#reference-requirements-network-interfaces-uplink)**)

You must select one network interface per machine.

```yaml
micro11:
  ceph:
    uplink: eno250
  disks:
    os: sda3
    local_storage: sdb
    distributed_storage: sdc

micro12:
  ceph:
    uplink: eno250
micro13:
  ceph:
    uplink: eno250
```

## b: If you want to use IPv4, specify the IPv4 gateway on the uplink network (in CIDR notation) and the first and last IPv4 address in the range that you want to use with LXD

```bash
nmap -sP 10.188.50.0/24
Nmap done: 256 IP addresses (21 hosts up) scanned in 3.11 seconds
```

```yaml
gw: 10.188.50.254
first: 10.188.50.x
last:
```

If you want to use IPv6, specify the IPv6 gateway on the uplink network (in CIDR notation).

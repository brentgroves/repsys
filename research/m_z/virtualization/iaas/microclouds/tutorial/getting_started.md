# **[Getting Started](https://documentation.ubuntu.com/microcloud/stable/microcloud/tutorial/get_started/#get-started)**

MicroCloud is quick to set up. Once **[installed](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/install/#howto-install)**, you can start using MicroCloud in the same way as a regular LXD cluster.

This tutorial guides you through installing MicroCloud in a confined environment and then starting some instances to see what you can do with MicroCloud. It uses virtual machines in LXD, so you don’t need any extra hardware to follow the tutorial.

Tip

In this tutorial, we use four virtual machines in LXD for the MicroCloud cluster members. You can use a different number of machines if you want, but the minimum number of required machines is three.

We limit each virtual machine to 2 GiB of RAM, which is less than the recommended hardware requirements. In the context of the tutorial, this amount of RAM is sufficient. However, in a production environment, make sure to use machines that fulfil the **[Hardware requirements](https://documentation.ubuntu.com/microcloud/stable/microcloud/reference/#hardware-requirements)**.

## Install and initialise LXD

Note

You can skip this step if you already have a LXD server installed and initialised. However, you should make sure that you have a storage pool set up that is big enough to store four virtual machines. We recommend a storage pool size of at least 40 GiB for that.

MicroCloud requires LXD version 5.21:

Install snapd:

Run snap version to find out if snap is installed on your system:

```bash
user@host:~$snap version
snap    2.59.4
snapd   2.59.4
series  16
ubuntu  22.04
kernel  5.15.0-73-generic
```

If you see a table of version numbers, snap is installed. If the version for snapd is 2.59 or later, you are all set and can continue with the next step of installing LXD.

If LXD is already installed, enter the following command to update it:

```bash
sudo snap refresh lxd --channel=5.21/stable
```

Otherwise, enter the following command to install LXD:

`sudo snap install lxd`

## 3. Enter the following command to initialise LXD

```bash
lxd init
```

Accept the default values except for the following questions:

Size in GiB of the new loop device (1GiB minimum)

Enter 40GiB.

Would you like the LXD server to be available over the network? (yes/no)

Enter yes.

```bash
lxd init
Would you like to use LXD clustering? (yes/no) [default=no]: 
Do you want to configure a new storage pool? (yes/no) [default=yes]: 
Name of the new storage pool [default=default]: 
Name of the storage backend to use (ceph, dir, lvm, powerflex, zfs, btrfs) [default=zfs]: 
Create a new ZFS pool? (yes/no) [default=yes]: 
Would you like to use an existing empty block device (e.g. a disk or partition)? (yes/no) [default=no]: 
Size in GiB of the new loop device (1GiB minimum) [default=30GiB]: 40GiB
Would you like to connect to a MAAS server? (yes/no) [default=no]: 
Would you like to create a new local network bridge? (yes/no) [default=yes]: 
What should the new bridge be called? [default=lxdbr0]: 
What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
Would you like the LXD server to be available over the network? (yes/no) [default=no]: yes
Address to bind LXD to (not including port) [default=all]: 
Port to bind LXD to [default=8443]: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]: 
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes
config:
  core.https_address: '[::]:8443'
networks:
- config:
    ipv4.address: auto
    ipv6.address: auto
  description: ""
  name: lxdbr0
  type: ""
  project: default
storage_pools:
- config:
    size: 40GiB
  description: ""
  name: default
  driver: zfs
storage_volumes: []
profiles:
- config: {}
  description: ""
  devices:
    eth0:
      name: eth0
      network: lxdbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
projects: []
cluster: null

```

## 2. Provide storage disks

MicroCloud supports both local and remote storage. For local storage, you need one disk per cluster member. For remote storage, you need at least three disks that are located on different cluster members.

In this tutorial, we’ll set up four cluster members, which means that we need a minimum of seven disks (four for local storage and three for remote storage).

Complete the following steps to create the required disks in a LXD storage

1. Create a ZFS storage pool called disks:

```bash
lxc storage create disks zfs size=100GiB
Storage pool disks created
```

## 2. Configure the default volume size for the disks pool

```bash
lxc storage set disks volume.size 10GiB
```

## 3. Create four disks to use for local storage

```bash
lxc storage volume create disks local1 --type block
Storage volume local1 created
lxc storage volume create disks local2 --type block
Storage volume local2 created
lxc storage volume create disks local3 --type block
Storage volume local3 created
lxc storage volume create disks local4 --type block
Storage volume local4 created
```

## 4. Create three disks to use for remote storage

```bash
lxc storage volume create disks remote1 --type block size=20GiB
Storage volume remote1 created
lxc storage volume create disks remote2 --type block size=20GiB
Storage volume remote2 created
lxc storage volume create disks remote3 --type block size=20GiB
Storage volume remote3 created
```

## 5. Check that the disks have been created correctly

```bash
root@micro1:~#lxc storage volume list disks
+--------+---------+-------------+--------------+---------+
|  TYPE  |  NAME   | DESCRIPTION | CONTENT-TYPE | USED BY |
+--------+---------+-------------+--------------+---------+
| custom | local1  |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | local2  |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | local3  |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | local4  |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | remote1 |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | remote2 |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
| custom | remote3 |             | block        | 0       |
+--------+---------+-------------+--------------+---------+
```

## 3. Create a network

MicroCloud requires an uplink network that the cluster members can use for external connectivity. See **[Networking](https://documentation.ubuntu.com/microcloud/stable/microcloud/explanation/microcloud/#explanation-networking)** for more information.

Complete the following steps to set up this network:

### 1. Create a bridge network without any parameters

```bash
lxc network create microbr0
Network microbr0 created
```

### 2. Enter the following commands to find out the assigned IPv4 and IPv6 addresses for the network and note them down

```bash
lxc network get microbr0 ipv4.address
10.125.146.1/24
lxc network get microbr0 ipv6.address
fd42:631f:69fb:acb4::1/64
```

## 4. Create and configure your VMs

Next, we’ll create the VMs that will serve as the MicroCloud cluster members.

Complete the following steps:

### 1. Create the VMs, but don’t start them yet

```bash
lxc init ubuntu:22.04 micro1 --vm --config limits.cpu=2 --config limits.memory=2GiB
Creating micro1
lxc init ubuntu:22.04 micro2 --vm --config limits.cpu=2 --config limits.memory=2GiB
Creating micro2
lxc init ubuntu:22.04 micro3 --vm --config limits.cpu=2 --config limits.memory=2GiB
Creating micro3
lxc init ubuntu:22.04 micro4 --vm --config limits.cpu=2 --config limits.memory=2GiB
Creating micro4
```

LXD downloads the image the first time you use it to initialise a VM. Therefore, the init command will take longer to complete on the first run. For subsequent runs, LXD uses the cached image.

Therefore, you shouldn’t run these commands in parallel.

### 2. Attach the disks to the VMs

```bash
lxc storage volume attach disks local1 micro1
lxc storage volume attach disks local2 micro2
lxc storage volume attach disks local3 micro3
lxc storage volume attach disks local4 micro4
lxc storage volume attach disks remote1 micro1
lxc storage volume attach disks remote2 micro2
lxc storage volume attach disks remote3 micro3
```

### 3. Create and add network interfaces that use the dedicated MicroCloud network to each VM

```bash
lxc config device add micro1 eth1 nic network=microbr0
Device eth1 added to micro1
lxc config device add micro2 eth1 nic network=microbr0
Device eth1 added to micro2
lxc config device add micro3 eth1 nic network=microbr0
Device eth1 added to micro3
lxc config device add micro4 eth1 nic network=microbr0
Device eth1 added to micro4
```

### 4. Start the VMs

```bash
lxc start micro1
lxc start micro2
lxc start micro3
lxc start micro4
```

### 5. Install MicroCloud on each VM

Before you can create the MicroCloud cluster, you must install the required snaps on each VM. In addition, you must configure the network interfaces so they can be used by MicroCloud.

Complete the following steps on each VM (micro1, micro2, micro3, and micro4):

#### 1. Access the shell in the VM. For example, for micro1

```bash
lxc exec micro1 -- bash
```

Tip

If you get an error message stating that the LXD VM agent is not currently running, the VM hasn’t fully started up yet. Wait a while and then try again. If the error persists, try restarting the VM (lxc restart micro1).

#### 2. Configure the network interface connected to microbr0 to not accept any IP addresses (because MicroCloud requires a network interface that doesn’t have an IP address assigned)

```bash
cat << EOF > /etc/netplan/99-microcloud.yaml
# MicroCloud requires a network interface that doesn't have an IP address
network:
    version: 2
    ethernets:
        enp6s0:
            accept-ra: false
            dhcp4: false
            link-local: []
EOF

chmod 0600 /etc/netplan/99-microcloud.yaml
```

Note

enp6s0 is the name that the VM assigns to the network interface that we previously added as eth1.

#### 3. Bring the network interface up

```bash
netplan apply
** (generate:1256): WARNING **: 19:39:46.155: Permissions for /etc/netplan/99-microcloud.yaml are too open. Netplan configuration should NOT be accessible by others.
WARNING:root:Cannot call Open vSwitch: ovsdb-server.service is not running.

** (process:1254): WARNING **: 19:39:46.767: Permissions for /etc/netplan/99-microcloud.yaml are too open. Netplan configuration should NOT be accessible by others.

** (process:1254): WARNING **: 19:39:47.090: Permissions for /etc/netplan/99-microcloud.yaml are too open. Netplan configuration should NOT be accessible by others.

** (process:1254): WARNING **: 19:39:47.090: Permissions for /etc/netplan/99-microcloud.yaml are too open. Netplan configuration should NOT be accessible by others.
```

#### 4. Install the required snaps

```bash
snap install microceph --channel=squid/stable --cohort="+"
microceph (squid/stable) 19.2.0+snap3b53da1c21 from Canonical✓ installed
snap install microovn --channel=24.03/stable --cohort="+"
microovn (24.03/stable) 24.03.2+snapa2c59c105b from Canonical✓ installed
snap install microcloud --channel=2/stable --cohort="+"
microcloud (2/stable) 2.1.0-3e8b183 from Canonical✓ installed
```

Note

The --cohort="+" flag in the command ensures that the same version of the snap is installed on all machines. See Keep cluster members in sync for more information.

#### 5. The LXD snap is already installed. Refresh it to the latest version

```bash
snap refresh lxd --channel=5.21/stable --cohort="+"
lxd (5.21/stable) 5.21.3-c5ae129 from Canonical✓ refreshed
```

## 6. 6. Initialise MicroCloud

After installing all snaps on all VMs, you can initialise MicroCloud. We use micro1, but you can choose another machine.

Complete the following steps:

### 1. Access the shell in micro1 and start the initialisation process

```bash
lxc exec micro1 microcloud init
```

Tip

In this tutorial, we initialise MicroCloud interactively. Alternatively, you can use a preseed file for **[Non-interactive configuration](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/initialise/#howto-initialise-preseed)**.

### 2. Answer the questions

Select yes to select more than one cluster member.

```bash
lxc exec micro1 microcloud init
Waiting for services to start ...
Do you want to set up more than one cluster member? (yes/no) [default=yes]: 
Select an address for MicroCloud's internal traffic:

 Using address "10.240.139.251" for MicroCloud

Use the following command on systems that you want to join the cluster:

 microcloud join

When requested enter the passphrase:

 justifying cynicism sisterhood sassy

Verify the fingerprint "66fc6099b203" is displayed on joining systems.
Waiting to detect systems ...
```

As the address for MicroCloud’s internal traffic, select the listed IPv4 address.

Copy the session passphrase. `justifying cynicism sisterhood sassy`

```bash
Select an address for MicroCloud's internal traffic:

 Using address "10.240.139.251" for MicroCloud

Use the following command on systems that you want to join the cluster:

 microcloud join

When requested enter the passphrase:

 cakewalk scenario cylinder zeppelin

Verify the fingerprint "66fc6099b203" is displayed on joining systems.
Waiting to detect systems ...
```

Head to the other servers (micro02, micro03, and micro04) and start the join process:

`lxc exec micro02 microcloud join`

Tip

Open up three additional terminals to run the commands concurrently.

In each terminal select an address for MicroCloud’s internal traffic. When prompted enter the passphrase in each terminal and return to micro01.

Select all listed servers (these should be micro2, micro3, and micro4).

Select yes to set up local storage.

Select the listed local disks (local1, local2, local3, and local4).

Tip

Type local to display only the local disks. The table is filtered by the characters that you type.

You don’t need to wipe any disks (because we just created them).

Select yes to set up distributed storage.

Select yes to confirm that there are fewer disks available than machines.

Select all listed disks (these should be remote1, remote2, and remote3).

You don’t need to wipe any disks (because we just created them).

You don’t need to encrypt any disks to get started.

Select yes to optionally configure the CephFS distributed file system.

Leave the question empty for the IPv4 or IPv6 CIDR subnet address used for the Ceph internal network.

Leave the question empty for the IPv4 or IPv6 CIDR subnet address used for the Ceph public network.

Select yes to configure distributed networking.

Select all listed network interfaces (these should be enp6s0 on the four different VMs).

Specify the IPv4 address that you noted down for your microbr0 network as the IPv4 gateway.

```bash
lxc network get microbr0 ipv4.address
10.125.146.1/24
lxc network get microbr0 ipv6.address
fd42:631f:69fb:acb4::1/64
```

Specify an IPv4 address in the address range as the first IPv4 address. For example, if your IPv4 gateway is 192.0.2.1/24, the first address could be 192.0.2.100.

```bash
10.125.146.100
```

Specify a higher IPv4 address in the range as the last IPv4 address. As we’re setting up four machines only, the range must contain a minimum of four addresses, but setting up a bigger range is more fail-safe. For example, if your IPv4 gateway is 192.0.2.1/24, the last address could be 192.0.2.254.

```bash
10.125.146.254
```

Specify the IPv6 address that you noted down for your microbr0 network as the IPv6 gateway.

```bash
lxc network get microbr0 ipv4.address
10.125.146.1/24
lxc network get microbr0 ipv6.address
fd42:631f:69fb:acb4::1/64
```

Leave the question empty for the DNS addresses for the distributed network.

Leave the question empty for configuring an underlay network for OVN.

MicroCloud will now initialise the cluster. See **[About the initialisation process](https://documentation.ubuntu.com/microcloud/stable/microcloud/explanation/initialisation/#explanation-initialisation)** for more information.

```bash
...
Initializing new services
 Local MicroCloud is ready
 Local MicroOVN is ready
 Local MicroCeph is ready
 Local LXD is ready
Awaiting cluster formation ...
 Peer "micro4" has joined the cluster
 Peer "micro2" has joined the cluster
 Peer "micro3" has joined the cluster
Configuring cluster-wide devices ...
MicroCloud is ready
```

## 7. Inspect your MicroCloud setup

You can now inspect your cluster setup.

Tip

You can run these commands on any of the cluster members. We continue using micro1, but you will see the same results on the other VMs.

### 1. Inspect the cluster setup

```bash
lxc exec micro1 bash
lxc cluster list
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
|  NAME  |             URL             |      ROLES       | ARCHITECTURE | FAILURE DOMAIN | DESCRIPTION | STATE  |      MESSAGE      |
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro1 | https://10.240.139.251:8443 | database-leader  | x86_64       | default        |             | ONLINE | Fully operational |
|        |                             | database         |              |                |             |        |                   |
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro2 | https://10.240.139.79:8443  | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro3 | https://10.240.139.202:8443 | database-standby | x86_64       | default        |             | ONLINE | Fully operational |
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro4 | https://10.240.139.67:8443  | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+-----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+


microcloud cluster list
+--------+---------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |       ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.240.139.251:9443 | voter    | 66fc6099b203564f7c5506a73c2bcf47483667e9d3076fcc1a955d03e2d21761 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.240.139.79:9443  | voter    | b09b212eebd6dd736811cb154048614bfff9c5c26a247643552af1498ff416b5 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.240.139.202:9443 | stand-by | fee40ff81acbecc82dcd4e34d1987f8ba489ddf80f57a3c3d80e6b807bdfe1e4 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.240.139.67:9443  | voter    | 892340702c56621d8559fc340c6e52e20c46c5dbd778224556da0b1947dcdbe9 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+

microceph cluster list
+--------+---------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |       ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.240.139.251:7443 | voter    | 3186fec5237e615a673722281fbccaa626def176d5efb01aae41b779b2a40f5a | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.240.139.79:7443  | voter    | 11ebe7daf21295f1d6a7991b8a9dac3bf286096676691bfe174ed40e34f3031d | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.240.139.202:7443 | voter    | dbd8723cbbbf20a8e9106b2820f98eb036821b18a203d5d9dc121416ca1dc047 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.240.139.67:7443  | stand-by | 8f37367ed3d23ba267964658838e6a278d010f8f46c2050f6c2cbfb902072b46 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+

microovn cluster list
+--------+---------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |       ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.240.139.251:6443 | voter    | d4f9d853235cca82207d283c31b9d98da7a9a689200ab98da2867045f32738d1 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.240.139.79:6443  | voter    | b42060f074407ff11dedf68428f57d14701576f79f9c8eeee47d96dd7e2a62c8 | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.240.139.202:6443 | voter    | c6aae1afc9e795185e08cf7017f10f03924f8c0ecf11d4a189523b6e94c997cd | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.240.139.67:6443  | stand-by | d7c62c6e6d36d8f705a6f9867b0a9ed3780aef6fd82eed0542c194831334c19d | ONLINE |
+--------+---------------------+----------+------------------------------------------------------------------+--------+
```

### 2. Inspect the storage setup

```bash
lxc storage list
+-----------+--------+----------------------------------------------+---------+---------+
|   NAME    | DRIVER |                 DESCRIPTION                  | USED BY |  STATE  |
+-----------+--------+----------------------------------------------+---------+---------+
| local     | zfs    | Local storage on ZFS                         | 8       | CREATED |
+-----------+--------+----------------------------------------------+---------+---------+
| remote    | ceph   | Distributed storage on Ceph                  | 1       | CREATED |
+-----------+--------+----------------------------------------------+---------+---------+
| remote-fs | cephfs | Distributed file-system storage using CephFS | 0       | CREATED |
+-----------+--------+----------------------------------------------+---------+---------+

remote-fs not used but created

lxc storage info local
info:
  description: Local storage on ZFS
  driver: zfs
  name: local
  space used: 703.50KiB
  total space: 9.20GiB
used by:
  volumes:
  - backups (location "micro1")
  - backups (location "micro2")
  - backups (location "micro3")
  - backups (location "micro4")
  - images (location "micro1")
  - images (location "micro2")
  - images (location "micro3")
  - images (location "micro4")

lxc storage info remote
info:
  description: Distributed storage on Ceph
  driver: ceph
  name: remote
  space used: 36.00KiB
  total space: 18.97GiB
used by:
  profiles:
  - default

lxc storage info remote-fs  
info:
  description: Distributed file-system storage using CephFS
  driver: cephfs
  name: remote-fs
  space used: 0B
  total space: 18.97GiB
used by: {}
```

### 3. Inspect the OVN network setup

```bash
lxc network list
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
|  NAME   |   TYPE   | MANAGED |      IPV4       |           IPV6            | DESCRIPTION | USED BY |  STATE  |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| UPLINK  | physical | YES     |                 |                           |             | 1       | CREATED |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| br-int  | bridge   | NO      |                 |                           |             | 0       |         |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| default | ovn      | YES     | 10.239.227.1/24 | fd42:fd5c:6670:caad::1/64 |             | 1       | CREATED |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| enp5s0  | physical | NO      |                 |                           |             | 0       |         |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| enp6s0  | physical | NO      |                 |                           |             | 1       |         |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+
| lxdovn1 | bridge   | NO      |                 |                           |             | 0       |         |
+---------+----------+---------+-----------------+---------------------------+-------------+---------+---------+

lxc network show default
name: default
description: ""
type: ovn
managed: true
status: Created
config:
  bridge.mtu: "1442"
  ipv4.address: 10.239.227.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:fd5c:6670:caad::1/64
  ipv6.nat: "true"
  network: UPLINK
  volatile.network.ipv4.address: 10.125.146.100
  volatile.network.ipv6.address: fd42:631f:69fb:acb4:216:3eff:fe96:36b1
used_by:
- /1.0/profiles/default
locations:
- micro1
- micro4
- micro2
- micro3
```

#### 4. Make sure that you can ping the virtual router within OVN. You can find the IPv4 and IPv6 addresses of the virtual router under volatile.network.ipv4.address and volatile.network.ipv6.address, respectively, in the output of lxc network show default

```bash
ping 10.125.146.100
ping fd42:631f:69fb:acb4:216:3eff:fe96:36b1
```

### 5. Inspect the default profile

```bash
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

## 8. 8. Launch some instances

Now that your MicroCloud cluster is ready to use, let’s launch a few instances:

Launch an Ubuntu container with the default settings:

```bash
lxc launch ubuntu:22.04 u1
Launching u1
```

Launch another Ubuntu container, but use the local storage instead of the remote storage that is the default:

```bash
lxc launch ubuntu:22.04 u2 --storage local
Launching u2
```

Launch an Ubuntu VM:

```bash
lxc launch ubuntu:22.04 u3 --vm
```

Check the list of instances. You will see that the instances are running on different cluster members.

```bash
lxc list
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.239.227.2 (eth0) | fd42:fd5c:6670:caad:216:3eff:fe2a:6665 (eth0) | CONTAINER       | 0         | micro1   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.239.227.3 (eth0) | fd42:fd5c:6670:caad:216:3eff:fe99:c46f (eth0) | CONTAINER       | 0         | micro4   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING | 10.239.227.4 (eth0) | fd42:fd5c:6670:caad:216:3eff:fee0:6360 (eth0) | VIRTUAL-MACHINE | 0         | micro2   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
```

### 5. Check the storage. You will see that the instance volumes are located on the specified storage pools

```bash
lxc storage volume list remote
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
|      TYPE       |                               NAME                               | DESCRIPTION | CONTENT-TYPE | USED BY | LOCATION |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| container       | u1                                                               |             | filesystem   | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image           | 18b1e751a2080edf43221536d7b5a5b1c2f6b3f67afbc7443767f7a74edcc8e9 |             | filesystem   | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image           | d4104f351699896891aa4c41fb521a15a96cb9c70de0b5e83cb9067faf03833a |             | block        | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| virtual-machine | u3                                                               |             | block        | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+

lxc storage volume list local
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
|   TYPE    |                               NAME                               | DESCRIPTION | CONTENT-TYPE | USED BY | LOCATION |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| container | u2                                                               |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro1   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro3   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro1   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro3   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image     | 18b1e751a2080edf43221536d7b5a5b1c2f6b3f67afbc7443767f7a74edcc8e9 |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
```

## 9. Inspect your networking

The instances that you have launched are all on the same subnet. You can, however, create a different network to isolate some instances from others.

Check the list of instances that are running:

```bash
lxc list
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.239.227.2 (eth0) | fd42:fd5c:6670:caad:216:3eff:fe2a:6665 (eth0) | CONTAINER       | 0         | micro1   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.239.227.3 (eth0) | fd42:fd5c:6670:caad:216:3eff:fe99:c46f (eth0) | CONTAINER       | 0         | micro4   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
| u3   | ERROR   |                     |                                               | VIRTUAL-MACHINE | 0         | micro2   |
+------+---------+---------------------+-----------------------------------------------+-----------------+-----------+----------+
```

### trouble shoot

An error in an LXC (Linux Containers) virtual machine (VM) can manifest in various ways, such as failing to start, encountering network issues, or experiencing storage-related problems. To troubleshoot, first, check the LXC instance logs (using lxc info <instance_name> --show-log) and the server logs for error messages. If the VM is in an "ERROR" state, it could be due to resource limits, disk issues, or problems with the storage pool.

```bash
lxc info u3 --show-log
Error: Missing event connection with target cluster member
```

```bash
lxc exec u1 -- bash
```

Ping the IPv4 address of u2:

```bash
ping 10.239.227.3
```

Ping the IPv6 address of u3:

```bash
ping6 -n 2001:db8:d960:91cf:216:3eff:fe66:f24b
```

Confirm that the instance has connectivity to the outside world:

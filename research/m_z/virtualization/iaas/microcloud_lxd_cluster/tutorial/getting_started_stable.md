# **[Getting Started stable](https://documentation.ubuntu.com/microcloud/stable/microcloud/tutorial/get_started/#get-started)**

## **[Getting Started latest](https://documentation.ubuntu.com/microcloud/latest/microcloud/tutorial/get_started/)**

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

# In LXD, a loop device is a virtual block device that allows a file to be treated as if it were a physical storage device. Essentially, it allows you to mount a regular file as a file system, enabling access to its contents as if it were a disk partition. LXD uses loop devices to manage storage for containers, either by creating loop files on the host system or by using existing loop devices passed through from the host. 

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

ZFS is a powerful, advanced file system and logical volume manager that combines features like RAID, data integrity checks, and snapshotting into a single, unified system. It's known for its scalability, reliability, and ease of administration, particularly in enterprise server environments.

```bash
# create disks loop file storage pool
lxc storage create disks zfs size=500GiB
Storage pool disks created

sudo ls -alh /var/snap/lxd/common/lxd/disks
total 18G
drwx------  2 root root 4.0K Jun 20 00:06 .
drwx--x--x 17 root root 4.0K Jun 21 18:19 ..
-rw-------  1 root root  40G Jun 21 19:43 default.img
-rw-------  1 root root 500G Jun 21 19:40 disks.img

sudo zpool list
NAME      SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
default  39.5G  4.57G  34.9G        -         -    19%    11%  1.00x    ONLINE  -
disks     496G  13.1G   483G        -         -     0%     2%  1.00x    ONLINE  -

zpool status -P disks
sudo zpool status -P disks
  pool: disks
 state: ONLINE
config:

        NAME                                        STATE     READ WRITE CKSUM
        disks                                       ONLINE       0     0     0
          /var/snap/lxd/common/lxd/disks/disks.img  ONLINE       0     0     0

errors: No known data errors

sudo zfs list
NAME                                                                                            USED  AVAIL  REFER  MOUNTPOINT
default                                                                                        4.54G  33.7G    24K  legacy
default/buckets                                                                                  24K  33.7G    24K  legacy
default/containers                                                                               24K  33.7G    24K  legacy
default/custom                                                                                   24K  33.7G    24K  legacy
default/deleted                                                                                 800M  33.7G    24K  legacy
default/deleted/buckets                                                                          24K  33.7G    24K  legacy
default/deleted/containers                                                                       24K  33.7G    24K  legacy
default/deleted/custom                                                                           24K  33.7G    24K  legacy
default/deleted/images                                                                          800M  33.7G    24K  legacy
default/deleted/images/8f5c1382df05f355311a84c0f15de77cb52399aaf66f18f86e1af941c98a7b83        26.5K   100M  25.5K  legacy
default/deleted/images/8f5c1382df05f355311a84c0f15de77cb52399aaf66f18f86e1af941c98a7b83.block   799M  33.7G   799M  -
default/deleted/virtual-machines                                                                 24K  33.7G    24K  legacy
default/images                                                                                  800M  33.7G    24K  legacy
default/images/293da0a379e57234c03a35e95465a99da99a9900ec2e1fc30b70c4cbbb092caa                25.5K   100M  25.5K  legacy
default/images/293da0a379e57234c03a35e95465a99da99a9900ec2e1fc30b70c4cbbb092caa.block           800M  33.7G   800M  -
default/virtual-machines                                                                       2.95G  33.7G    24K  legacy
default/virtual-machines/micro1                                                                7.23M  92.8M  7.24M  legacy
default/virtual-machines/micro1.block                                                           814M  33.7G  1.53G  -
default/virtual-machines/micro2                                                                7.23M  92.8M  7.24M  legacy
default/virtual-machines/micro2.block                                                           752M  33.7G  1.47G  -
default/virtual-machines/micro3                                                                7.23M  92.8M  7.24M  legacy
default/virtual-machines/micro3.block                                                           752M  33.7G  1.47G  -
default/virtual-machines/micro4                                                                7.23M  92.8M  7.24M  legacy
default/virtual-machines/micro4.block                                                           680M  33.7G  1.40G  -
disks                                                                                          13.1G   468G    24K  legacy
disks/buckets                                                                                    24K   468G    24K  legacy
disks/containers                                                                                 24K   468G    24K  legacy
disks/custom                                                                                   13.1G   468G    24K  legacy
disks/custom/default_local1                                                                    1.03G   468G  1.03G  -
disks/custom/default_local2                                                                    1.81G   468G  1.81G  -
disks/custom/default_local3                                                                    1.03G   468G  1.03G  -
disks/custom/default_local4                                                                     880M   468G   880M  -
disks/custom/default_remote1                                                                   2.77G   468G  2.77G  -
disks/custom/default_remote2                                                                   2.77G   468G  2.77G  -
disks/custom/default_remote3                                                                   2.77G   468G  2.77G  -
disks/deleted                                                                                   144K   468G    24K  legacy
disks/deleted/buckets                                                                            24K   468G    24K  legacy
disks/deleted/containers                                                                         24K   468G    24K  legacy
disks/deleted/custom                                                                             24K   468G    24K  legacy
disks/deleted/images                                                                             24K   468G    24K  legacy
disks/deleted/virtual-machines                                                                   24K   468G    24K  legacy
disks/images                                                                                     24K   468G    24K  legacy
disks/virtual-machines                                                                           24K   468G    24K  legacy
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

sudo apt install zfsutils-linux
sudo zpool status -v
  pool: default
 state: ONLINE
config:

        NAME                                          STATE     READ WRITE CKSUM
        default                                       ONLINE       0     0     0
          /var/snap/lxd/common/lxd/disks/default.img  ONLINE       0     0     0

errors: No known data errors

  pool: disks
 state: ONLINE
config:

        NAME                                        STATE     READ WRITE CKSUM
        disks                                       ONLINE       0     0     0
          /var/snap/lxd/common/lxd/disks/disks.img  ONLINE       0     0     0

errors: No known data errors

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

ip link show type bridge
4: microbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:16:3e:04:4e:1e brd ff:ff:ff:ff:ff:ff
5: lxdbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:16:3e:63:b4:74 brd ff:ff:ff:ff:ff:ff
```

### 2. Enter the following commands to find out the assigned IPv4 and IPv6 addresses for the network and note them down

```bash
lxc network get microbr0 ipv4.address
10.37.122.1/24
lxc network get microbr0 ipv6.address
fd42:f253:67d3:2222::1/64

ip addr show microbr0
4: microbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:16:3e:04:4e:1e brd ff:ff:ff:ff:ff:ff
    inet 10.37.122.1/24 scope global microbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:f253:67d3:2222::1/64 scope global 
       valid_lft forever preferred_lft forever

```

## 4. Create and configure your VMs

Next, we’ll create the VMs that will serve as the MicroCloud cluster members.

Complete the following steps:

### 1. Create the VMs, but don’t start them yet

```bash
free
               total        used        free      shared  buff/cache   available
Mem:        49418820     2047124    45261620        4600     2596376    47371696
Swap:        8388604           0     8388604

lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          40 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Vendor ID:                GenuineIntel
  Model name:             Intel(R) Xeon(R) CPU           E5503  @ 2.00GHz
    CPU family:           6
    Model:                26
    Thread(s) per core:   1
    Core(s) per socket:   2
    Socket(s):            2
    Stepping:             5
    BogoMIPS:             3989.89
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ht tm pbe syscall nx rdtscp lm con
                          stant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pd
                          cm dca sse4_1 sse4_2 popcnt lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow flexpriority ept vpid dtherm vnmi flush_l1d
Virtualization features:  
  Virtualization:         VT-x
Caches (sum of all):      
  L1d:                    128 KiB (4 instances)
  L1i:                    128 KiB (4 instances)
  L2:                     1 MiB (4 instances)
  L3:                     8 MiB (2 instances)
NUMA:                     
  NUMA node(s):           2
  NUMA node0 CPU(s):      0,2
  NUMA node1 CPU(s):      1,3
Vulnerabilities:          
  Gather data sampling:   Not affected
  Itlb multihit:          KVM: Mitigation: VMX disabled
  L1tf:                   Mitigation; PTE Inversion; VMX conditional cache flushes, SMT disabled
  Mds:                    Vulnerable: Clear CPU buffers attempted, no microcode; SMT disabled
  Meltdown:               Mitigation; PTI
  Mmio stale data:        Unknown: No mitigations
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:             Mitigation; Retpolines; IBPB conditional; IBRS_FW; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected

lxc init ubuntu:22.04 micro1 --vm --config limits.cpu=2 --config limits.memory=8GiB
Creating micro1
lxc init ubuntu:22.04 micro2 --vm --config limits.cpu=2 --config limits.memory=8GiB
Creating micro2
lxc init ubuntu:22.04 micro3 --vm --config limits.cpu=2 --config limits.memory=8GiB
Creating micro3
lxc init ubuntu:22.04 micro4 --vm --config limits.cpu=2 --config limits.memory=8GiB
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

 lxc exec micro1 -- bash
root@micro1:~# lsblk
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0     7:0    0  73.9M  1 loop /snap/core22/2010
loop1     7:1    0  63.8M  1 loop /snap/core20/2599
loop2     7:2    0  66.8M  1 loop /snap/core24/988
loop3     7:3    0  89.4M  1 loop /snap/lxd/31333
loop4     7:4    0 114.4M  1 loop /snap/lxd/33110
loop5     7:5    0 111.9M  1 loop /snap/microceph/1355
loop6     7:6    0  10.4M  1 loop /snap/microcloud/1144
loop7     7:7    0  21.1M  1 loop /snap/microovn/667
loop8     7:8    0  50.9M  1 loop /snap/snapd/24671
loop9     7:9    0  66.8M  1 loop /snap/core24/1006
sda       8:0    0    10G  0 disk 
├─sda1    8:1    0   9.9G  0 part /
├─sda14   8:14   0     4M  0 part 
└─sda15   8:15   0   106M  0 part /boot/efi
sdb       8:16   0    10G  0 disk 
├─sdb1    8:17   0    10G  0 part 
└─sdb9    8:25   0     8M  0 part 
sdc       8:32   0    20G  0 disk 

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

 generator rarity buzzard geographer

Verify the fingerprint "66fc6099b203" is displayed on joining systems.
Waiting to detect systems ...
```

As the address for MicroCloud’s internal traffic, select the listed IPv4 address.

Copy the session passphrase. `generator rarity buzzard geographer`

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
10.37.122.1/24
lxc network get microbr0 ipv6.address
fd42:f253:67d3:2222::1/64
```

Specify an IPv4 address in the address range as the first IPv4 address. For example, if your IPv4 gateway is 192.0.2.1/24, the first address could be 192.0.2.100.

```bash
10.37.122.100
```

Specify a higher IPv4 address in the range as the last IPv4 address. As we’re setting up four machines only, the range must contain a minimum of four addresses, but setting up a bigger range is more fail-safe. For example, if your IPv4 gateway is 192.0.2.1/24, the last address could be 192.0.2.254.

```bash
10.37.122.254
```

Specify the IPv6 address that you noted down for your microbr0 network as the IPv6 gateway.

```bash
lxc network get microbr0 ipv4.address
10.37.122.1/24
lxc network get microbr0 ipv6.address
fd42:f253:67d3:2222::1/64
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
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
|  NAME  |            URL             |      ROLES       | ARCHITECTURE | FAILURE DOMAIN | DESCRIPTION | STATE  |      MESSAGE      |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro1 | https://10.109.66.123:8443 | database-leader  | x86_64       | default        |             | ONLINE | Fully operational |
|        |                            | database         |              |                |             |        |                   |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro2 | https://10.109.66.131:8443 | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro3 | https://10.109.66.64:8443  | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro4 | https://10.109.66.86:8443  | database-standby | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+

microcloud cluster list
+--------+--------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |      ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.109.66.123:9443 | voter    | f75a982a7a7fbd83ea79b977e6eeddc1e62ec6dced78547938716a4ab8d7e275 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.109.66.131:9443 | voter    | eb5b96b3d3a5209a4dce8cc23dbb7b619c5d3f63229c7b551c84e5b81ce79cda | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.109.66.64:9443  | stand-by | aca7d0fbdc0d00c63ae19d292cbfae6c2f0ae6ddbcab947f9a8613c1528bd788 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.109.66.86:9443  | voter    | 87b4272893654cf5740c4d947e24af6e6dbbbe7e64b971057390582b5cb69a99 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+

microceph cluster list
+--------+--------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |      ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.109.66.123:7443 | voter    | ad9c6cdabd7b0f1139925dffd7c4d76433238ebb86382c4d1e54b23e9f60809b | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.109.66.131:7443 | stand-by | a4dde28f15355400a6ef2388ffb6020b91a5db2f03efb2a3c449ddcaacec2c8b | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.109.66.64:7443  | voter    | ab7bc611bfc2f007d774d85a77d4c4a494c48c0fecf43b56533a1c46fdee6730 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.109.66.86:7443  | voter    | 1d6cf8451f904da6afbb37beb021ec421e5a6f16e3413d76e122d45006afe25a | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+

microovn cluster list
+--------+--------------------+----------+------------------------------------------------------------------+--------+
|  NAME  |      ADDRESS       |   ROLE   |                           FINGERPRINT                            | STATUS |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro1 | 10.109.66.123:6443 | voter    | 68f23337fd0b534a8740e4e99887a439a563ca823f829c57f8d991b51fe94569 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro2 | 10.109.66.131:6443 | voter    | 108a7945982bf51fc0d0810b1b88b19ac106623b0cc4028820af93d83ec184dc | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro3 | 10.109.66.64:6443  | stand-by | 8c3fe778473ad38ee0692abeeb2cc57af396e424bb32cca1538be65dd92de2b9 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
| micro4 | 10.109.66.86:6443  | voter    | 608ebe89b10e72554308b6d3837de4b90e4fa2f26c0c9ba16a3c54a04dba1e15 | ONLINE |
+--------+--------------------+----------+------------------------------------------------------------------+--------+
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
  space used: 715.50KiB
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
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
|  NAME   |   TYPE   | MANAGED |     IPV4      |           IPV6           | DESCRIPTION | USED BY |  STATE  |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| UPLINK  | physical | YES     |               |                          |             | 1       | CREATED |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| br-int  | bridge   | NO      |               |                          |             | 0       |         |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| default | ovn      | YES     | 10.64.30.1/24 | fd42:401f:5e9:ab1f::1/64 |             | 1       | CREATED |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| enp5s0  | physical | NO      |               |                          |             | 0       |         |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| enp6s0  | physical | NO      |               |                          |             | 1       |         |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+
| lxdovn1 | bridge   | NO      |               |                          |             | 0       |         |
+---------+----------+---------+---------------+--------------------------+-------------+---------+---------+

lxc network show default
name: default
description: ""
type: ovn
managed: true
status: Created
config:
  bridge.mtu: "1442"
  ipv4.address: 10.64.30.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:401f:5e9:ab1f::1/64
  ipv6.nat: "true"
  network: UPLINK
  volatile.network.ipv4.address: 10.37.122.100
  volatile.network.ipv6.address: fd42:f253:67d3:2222:216:3eff:fe47:1536
used_by:
- /1.0/profiles/default
locations:
- micro4
- micro1
- micro2
- micro3
```

#### 4. Make sure that you can ping the virtual router within OVN. You can find the IPv4 and IPv6 addresses of the virtual router under volatile.network.ipv4.address and volatile.network.ipv6.address, respectively, in the output of lxc network show default

```bash
ping 10.37.122.100
ping fd42:f253:67d3:2222:216:3eff:fe47:1536
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
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |       IPV4        |                     IPV6                     |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.64.30.2 (eth0) | fd42:401f:5e9:ab1f:216:3eff:fe26:e339 (eth0) | CONTAINER       | 0         | micro1   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.64.30.3 (eth0) | fd42:401f:5e9:ab1f:216:3eff:fec1:67ce (eth0) | CONTAINER       | 0         | micro2   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING | 10.64.30.4 (eth0) | fd42:401f:5e9:ab1f:216:3eff:fea0:b9c4 (eth0) | VIRTUAL-MACHINE | 0         | micro3   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
root@micro1:~# lxc list
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |       IPV4        |                     IPV6                     |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.64.30.2 (eth0) | fd42:401f:5e9:ab1f:216:3eff:fe26:e339 (eth0) | CONTAINER       | 0         | micro1   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.64.30.3 (eth0) | fd42:401f:5e9:ab1f:216:3eff:fec1:67ce (eth0) | CONTAINER       | 0         | micro2   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING |                   |                                              | VIRTUAL-MACHINE | 0         | micro3   |
+------+---------+-------------------+----------------------------------------------+-----------------+-----------+----------+
root@micro1:~# lxc list
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |        IPV4         |                      IPV6                      |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.64.30.2 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fe26:e339 (eth0)   | CONTAINER       | 0         | micro1   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.64.30.3 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fec1:67ce (eth0)   | CONTAINER       | 0         | micro2   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING | 10.64.30.4 (enp5s0) | fd42:401f:5e9:ab1f:216:3eff:fea0:b9c4 (enp5s0) | VIRTUAL-MACHINE | 0         | micro3   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
```

### 5. Check the storage. You will see that the instance volumes are located on the specified storage pools

```bash
lxc storage volume list remote
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
|      TYPE       |                               NAME                               | DESCRIPTION | CONTENT-TYPE | USED BY | LOCATION |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| container       | u1                                                               |             | filesystem   | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image           | 8f5c1382df05f355311a84c0f15de77cb52399aaf66f18f86e1af941c98a7b83 |             | block        | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image           | 517753074081a26679675d03be854d3a1c50a93a24ac21d5d8c366ed8f14ebdb |             | filesystem   | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| virtual-machine | u3                                                               |             | block        | 1       |          |
+-----------------+------------------------------------------------------------------+-------------+--------------+---------+----------+

lxc storage volume list local
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
|   TYPE    |                               NAME                               | DESCRIPTION | CONTENT-TYPE | USED BY | LOCATION |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| container | u2                                                               |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro1   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | backups                                                          |             | filesystem   | 1       | micro3   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro4   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro1   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| custom    | images                                                           |             | filesystem   | 1       | micro3   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
| image     | 517753074081a26679675d03be854d3a1c50a93a24ac21d5d8c366ed8f14ebdb |             | filesystem   | 1       | micro2   |
+-----------+------------------------------------------------------------------+-------------+--------------+---------+----------+
```

## 9. Inspect your networking

The instances that you have launched are all on the same subnet. You can, however, create a different network to isolate some instances from others.

Check the list of instances that are running:

```bash
lxc list
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |        IPV4         |                      IPV6                      |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.64.30.2 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fe26:e339 (eth0)   | CONTAINER       | 0         | micro1   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.64.30.3 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fec1:67ce (eth0)   | CONTAINER       | 0         | micro2   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING | 10.64.30.4 (enp5s0) | fd42:401f:5e9:ab1f:216:3eff:fea0:b9c4 (enp5s0) | VIRTUAL-MACHINE | 0         | micro3   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
```

### trouble shoot

An error in an LXC (Linux Containers) virtual machine (VM) can manifest in various ways, such as failing to start, encountering network issues, or experiencing storage-related problems. To troubleshoot, first, check the LXC instance logs (using lxc info <instance_name> --show-log) and the server logs for error messages. If the VM is in an "ERROR" state, it could be due to resource limits, disk issues, or problems with the storage pool.

```bash
lxc info u3 --show-log
Error: Missing event connection with target cluster member
lxc exec micro2 bash
sudo systemctl restart snap.lxd.daemon

```

```bash
lxc exec u1 -- bash
```

Ping the IPv4 address of u2:

```bash
ping 10.64.30.2
ping 10.64.30.3
ping 10.64.30.4


```

Ping the IPv6 address of u3:

```bash
ping fd42:401f:5e9:ab1f:216:3eff:fe26:e339
ping fd42:401f:5e9:ab1f:216:3eff:fec1:67ce
ping fd42:401f:5e9:ab1f:216:3eff:fea0:b9c4
```

Confirm that the instance has connectivity to the outside world:

```bash
ping www.example.com
```

## Create an OVN network with the default settings

```bash
lxc network create isolated --type=ovn
Network isolated created
```

There is only one UPLINK network, so the new network will use this one as its parent.

## 8. Show information about the new network

```bash
lxc network show isolated
name: isolated
description: ""
type: ovn
managed: true
status: Created
config:
  bridge.mtu: "1442"
  ipv4.address: 10.212.250.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:7cce:a88:310a::1/64
  ipv6.nat: "true"
  network: UPLINK
  volatile.network.ipv4.address: 10.37.122.101
  volatile.network.ipv6.address: fd42:f253:67d3:2222:216:3eff:fe0f:7ebc
used_by: []
locations:
- micro3
- micro4
- micro1
- micro2
```

## 9. Check that you can ping the volatile.network.ipv4.address

```bash
ping 10.37.122.101
ping fd42:f253:67d3:2222:216:3eff:fe0f:7ebc
```

## 10. Launch an Ubuntu container that uses the new network

```bash
lxc launch ubuntu:22.04 u4 --network isolated
```

## 11. Access the shell in u4

```bash
lxc exec u4 -- bash
```

## 12. Confirm that the instance has connectivity to the outside world

```bash
root@u4:~#ping www.example.com
```

## 13. Ping the IPv4 address of u2

```bash
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
8: eth0@if9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1442 qdisc noqueue state UP group default qlen 1000
    link/ether 00:16:3e:dd:63:c1 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.212.250.2/24 metric 100 brd 10.212.250.255 scope global dynamic eth0
       valid_lft 3512sec preferred_lft 3512sec
    inet6 fd42:7cce:a88:310a:216:3eff:fedd:63c1/64 scope global mngtmpaddr noprefixroute 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:fedd:63c1/64 scope link 
       valid_lft forever preferred_lft forever
ping 10.64.30.3
14 packets transmitted, 0 received, 100% packet loss, time 13301ms
You will see that u2 is not reachable, because it is on a different OVN subnet.
```

## 10. 10. Access the UI

Instead of managing your instances and your LXD setup from the command line, you can also use the LXD UI. See How to access the LXD web UI for more information.

Check the LXD cluster list to determine the IP addresses of the cluster members:

```bash
lxc cluster list
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
|  NAME  |            URL             |      ROLES       | ARCHITECTURE | FAILURE DOMAIN | DESCRIPTION | STATE  |      MESSAGE      |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro1 | https://10.109.66.123:8443 | database-leader  | x86_64       | default        |             | ONLINE | Fully operational |
|        |                            | database         |              |                |             |        |                   |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro2 | https://10.109.66.131:8443 | database-standby | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro3 | https://10.109.66.64:8443  | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+
| micro4 | https://10.109.66.86:8443  | database         | x86_64       | default        |             | ONLINE | Fully operational |
+--------+----------------------------+------------------+--------------+----------------+-------------+--------+-------------------+

lxc list
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| NAME |  STATE  |        IPV4         |                      IPV6                      |      TYPE       | SNAPSHOTS | LOCATION |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u1   | RUNNING | 10.64.30.2 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fe26:e339 (eth0)   | CONTAINER       | 0         | micro1   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u2   | RUNNING | 10.64.30.3 (eth0)   | fd42:401f:5e9:ab1f:216:3eff:fec1:67ce (eth0)   | CONTAINER       | 0         | micro2   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u3   | RUNNING | 10.64.30.4 (enp5s0) | fd42:401f:5e9:ab1f:216:3eff:fea0:b9c4 (enp5s0) | VIRTUAL-MACHINE | 0         | micro3   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
| u4   | RUNNING | 10.212.250.2 (eth0) | fd42:7cce:a88:310a:216:3eff:fedd:63c1 (eth0)   | CONTAINER       | 0         | micro4   |
+------+---------+---------------------+------------------------------------------------+-----------------+-----------+----------+
```

In your web browser, navigate to the URL of one of the machines. For example, for micro1, navigate to <https://10.109.66.123:8443>.

By default, MicroCloud uses a self-signed certificate, which will cause a security warning in your browser. Use your browser’s mechanism to continue despite the security warning.

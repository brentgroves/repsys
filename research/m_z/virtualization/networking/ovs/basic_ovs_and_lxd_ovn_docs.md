# **[](https://albertomolina.wordpress.com/2022/06/10/openvswitch-basic-usage/)**

Note: This tutorial use lxc not lxd. lxc cli is lxc-x the lxd cli is lxc only and it uses a database and not config files to change container configurations.

Open vSwitch (OVS) is an open source OpenFlow implementation mainly used in virtualized environments. OpenvSwitch has a lot of features and it can be confusing when starting out, so the idea is to write several post with information related to the the use of OpenvSwitch, virtual network interfaces and related items, which can be used as a reference in the future

To start working with OVS only a linux box is needed (debian of course! :) ) and OVS is installed just with the openvswitch-switch package:

don't install this yet. in ubuntu it is different.

`apt install openvswitch-switch`

It’s also possible to install the package openvswitch-switch-dpdk for DPDK enabled OVS used in specific situations where high performance network throughput is needed, but it implies the use of network interfaces supported by dpdk.

## Basic OVS CLI

There are different OVS related command line interfaces, the main ones are the following:

```bash
ovs-appctl
ovs-ofctl
ovs-dpctl
ovs-vsctl
```

For example, to create a new OVS bridge, just type (autocomplete is enabled when used by root user):

Don't do this yet!

```bash
ovs-vsctl br-add br1

ovs-vsctl show 
572ef28b-6429-4a71-aad8-f634d8274930
    Bridge br1
        Port br1
            Interface br1
                type: internal
    ovs_version: "2.15.0"

8: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 4e:e6:18:c3:77:20 brd ff:ff:ff:ff:ff:ff
9: br1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 4e:76:98:43:ff:44 brd ff:ff:ff:ff:ff:ff
```

The ovs bridge is down, the following steps are taken to bring it up, assign an IP address and set iptables rule to allow NAT access to the Internet:

```bash
ip l set br1 up

ip a add 192.168.100.1/24 dev br1

iptables -t nat -A POSTROUTING -s 192.168.100.0/24 ! -d 192.168.100.0/24 \
-j MASQUERADE

ip a show dev br1
9: br1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 4e:76:98:43:ff:44 brd ff:ff:ff:ff:ff:ff
    inet 192.168.100.1/24 scope global br1
       valid_lft forever preferred_lft forever
    inet6 fe80::4c76:98ff:fe43:ff44/64 scope link 
       valid_lft forever preferred_lft forever
```

br1 shows an administrative state UP (because we have brought it up), the operational state LOWER_UP means that the link is detected at the «physical layer» (Driver signals L1 up according to **[netdevice man page](https://man7.org/linux/man-pages/man7/netdevice.7.html)**) and the state will remain UNKNOWN becase iproute2 can’t obtain ovs states.

netdevice - low-level access to Linux network devices. SYNOPSIS top #include <sys/ioctl.h> #include <net/if.h> DESCRIPTION top NOTES top

## LXC test environment

Once OVS is installed on the host machine, several virtual instances can be created to connect to OVS bridges and to interact to each other. In this case we’re going to use LXC (linux containers), but any other virtualization technology can be used.

The default bridge used can be changed to br1 on /etc/lxc/default.conf, and the container can be easily created:

```bash
lxc init ubuntu:24.04 uvm1 --device root,size=50GiB --config limits.cpu=2 --config limits.memory=8GiB --vm
lxc start uvm1
lxc exec uvm1 -- bash

apt update
snap install lxd --channel=5.21/stable --cohort="+"
snap refresh --hold lxd
```

## **[lxd init](https://documentation.ubuntu.com/lxd/latest/howto/initialize/)**

How to initialize LXD
Before you can create a LXD instance, you must configure and initialize LXD.

Interactive configuration
Run the following command to start the interactive configuration process:

Note

For simple configurations, you can run this command as a normal user. However, some more advanced operations during the initialization process (for example, joining an existing cluster) require root privileges. In this case, run the command with sudo or as root.

```bash
lxd init
```

## **[basic ovn/lxd setup](https://documentation.ubuntu.com/lxd/latest/howto/network_ovn_setup/#how-to-set-up-ovn-with-lxd)**

## LXD Minimal setup on vm

To create a minimal setup with default options, you can skip the configuration steps by adding the --minimal flag to the lxd init command:

```bash
lxc exec uvm1 -- bash
lxd init --minimal
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:16:3e:65:64:13 brd ff:ff:ff:ff:ff:ff
    inet 10.181.197.193/24 metric 100 brd 10.181.197.255 scope global dynamic enp5s0
       valid_lft 3460sec preferred_lft 3460sec
    inet6 fd42:deb7:6459:9916:216:3eff:fe65:6413/64 scope global mngtmpaddr noprefixroute 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:fe65:6413/64 scope link 
       valid_lft forever preferred_lft forever
3: lxdbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:16:3e:b9:64:1e brd ff:ff:ff:ff:ff:ff
    inet 10.44.173.1/24 scope global lxdbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:918a:5074:9366::1/64 scope global 
       valid_lft forever preferred_lft forever
```

Note

The minimal setup provides a basic configuration, but the configuration is not optimized for speed or functionality. Especially the dir storage driver, which is used by default, is slower than other drivers and doesn’t provide fast snapshots, fast copy/launch, quotas and optimized backups.

If you want to use an optimized setup, go through the interactive configuration process instead.

See the following sections for how to set up a basic OVN network, either as a standalone network or to host a small LXD cluster.

<!-- GOTO different article of ovn setup with lxd -->
## **[Set up a standalone OVN network](https://documentation.ubuntu.com/lxd/latest/howto/network_ovn_setup/)**

Complete the following steps to create a standalone OVN network that is connected to a managed LXD parent bridge network (for example, lxdbr0) for outbound connectivity.

## 1. Install the OVN tools on the local server

```bash
lxc exec uvm1 -- bash
apt install ovn-host ovn-central
```

## 2. Configure the OVN integration bridge

```bash
lxc exec uvm1 -- bash
ovs-vsctl set open_vswitch . \
   external_ids:ovn-remote=unix:/var/run/ovn/ovnsb_db.sock \
   external_ids:ovn-encap-type=geneve \
   external_ids:ovn-encap-ip=127.0.0.1
```

## 3. Create an OVN network

First look at the ovs configuration.

```bash
## look at network on host vm

```bash
ovs-vsctl show
fe406455-697a-44b0-94a2-13caf1463fab
    Bridge lxdovn1
        Port lxdovn1
            Interface lxdovn1
                type: internal
        Port patch-lxd-net2-ls-ext-lsp-provider-to-br-int
            Interface patch-lxd-net2-ls-ext-lsp-provider-to-br-int
                type: patch
                options: {peer=patch-br-int-to-lxd-net2-ls-ext-lsp-provider}
        Port lxdovn1b
            Interface lxdovn1b
    Bridge br-int
        fail_mode: secure
        datapath_type: system
        Port br-int
            Interface br-int
                type: internal
        Port patch-br-int-to-lxd-net2-ls-ext-lsp-provider
            Interface patch-br-int-to-lxd-net2-ls-ext-lsp-provider
                type: patch
                options: {peer=patch-lxd-net2-ls-ext-lsp-provider-to-br-int}
    ovs_version: "3.3.4"
```

```bash
# https://discuss.linuxcontainers.org/t/static-ip-addresses-dhcp-ranges-and-non-interactive-network-configuration-commands/8282
# lxc network set <parent_network> ipv4.dhcp.ranges=<IP_range> ipv4.ovn.ranges=<IP_range>

# find lxdbr0 ip and use it for dhcp and ovn ip ranges

ip a
...
2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:16:3e:65:64:13 brd ff:ff:ff:ff:ff:ff
    inet 10.181.197.193/24 metric 100 brd 10.181.197.255 scope global dynamic enp5s0
       valid_lft 3460sec preferred_lft 3460sec
    inet6 fd42:deb7:6459:9916:216:3eff:fe65:6413/64 scope global mngtmpaddr noprefixroute 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:fe65:6413/64 scope link 
       valid_lft forever preferred_lft forever
3: lxdbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:16:3e:b9:64:1e brd ff:ff:ff:ff:ff:ff
    inet 10.44.173.1/24 scope global lxdbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:918a:5074:9366::1/64 scope global 
       valid_lft forever preferred_lft forever

# ipv4.ovn.ranges -> IPv4 ranges to use for child OVN network routers
lxc network set lxdbr0 ipv4.dhcp.ranges=10.44.173.2-10.44.173.199 ipv4.ovn.ranges=10.44.173.205-10.44.173.254
# lxc network create ovntest --type=ovn network=<parent_network>
lxc network create ovntest --type=ovn network=lxdbr0
Network ovntest created

```

Note we did not specify an ip range for the ovn network. It seems to default to one not used by lxdbr0

## 4.Create an instance that uses the ovntest network

```bash
lxc init ubuntu:24.04 c1
lxc config show c1 --expanded
architecture: x86_64
config:
  image.architecture: amd64
  image.description: ubuntu 24.04 LTS amd64 (release) (20250805)
  image.label: release
  image.os: ubuntu
  image.release: noble
  image.serial: "20250805"
  image.type: squashfs
  image.version: "24.04"
  volatile.apply_template: create
  volatile.base_image: 5199328c409d5b9763c2eaead13eff38489b36510f97a43a681f5b9ee69b38eb
  volatile.cloud-init.instance-id: de9e6e56-c884-42a0-a47e-2c57a901efb2
  volatile.eth0.hwaddr: 00:16:3e:12:71:57
  volatile.idmap.base: "0"
  volatile.idmap.next: '[{"Isuid":true,"Isgid":false,"Hostid":1000000,"Nsid":0,"Maprange":1000000000},{"Isuid":false,"Isgid":true,"Hostid":1000000,"Nsid":0,"Maprange":1000000000}]'
  volatile.last_state.idmap: '[]'
  volatile.uuid: 1e348380-a0c2-4f33-9b00-602f27671c65
  volatile.uuid.generation: 1e348380-a0c2-4f33-9b00-602f27671c65
devices:
  eth0:
    name: eth0
    network: lxdbr0
    type: nic
  root:
    path: /
    pool: default
    type: disk
ephemeral: false
profiles:
- default
stateful: false
description: ""

# notice eth0 is set to lxdbr0 network. change this to ovn network.
lxc config device override c1 eth0 network=ovntest
Device eth0 overridden for c1
lxc config show c1 --expanded
...
devices:
  eth0:
    name: eth0
    network: ovntest
    type: nic
  root:
    path: /
    pool: default
    type: disk
ephemeral: false
profiles:
- default
stateful: false
description: ""
lxc start c1
```

## 5. Run lxc list to show the instance information

```bash
lxc ls
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |   TYPE    | SNAPSHOTS |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c1   | RUNNING | 10.136.192.2 (eth0) | fd42:7180:738e:7cb8:216:3eff:fee2:d1b6 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
```

looks like lxd used a 10.136.19.0/24 network ip and not an ip from the lxdbr0 range.

```bash
lxc network set lxdbr0 ipv4.dhcp.ranges=10.44.173.2-10.44.173.199 ipv4.ovn.ranges=10.44.173.205-10.44.173.254
```

## look at network on host vm

```bash
ovs-vsctl show
fe406455-697a-44b0-94a2-13caf1463fab
    Bridge lxdovn1
        Port lxdovn1
            Interface lxdovn1
                type: internal
        Port patch-lxd-net2-ls-ext-lsp-provider-to-br-int
            Interface patch-lxd-net2-ls-ext-lsp-provider-to-br-int
                type: patch
                options: {peer=patch-br-int-to-lxd-net2-ls-ext-lsp-provider}
        Port lxdovn1b
            Interface lxdovn1b
    Bridge br-int
        fail_mode: secure
        datapath_type: system
        Port br-int
            Interface br-int
                type: internal
        Port patch-br-int-to-lxd-net2-ls-ext-lsp-provider
            Interface patch-br-int-to-lxd-net2-ls-ext-lsp-provider
                type: patch
                options: {peer=patch-lxd-net2-ls-ext-lsp-provider-to-br-int}
        Port veth8598645e
            Interface veth8598645e
    ovs_version: "3.3.4"
```

We now have a new port on br-int and we can see a new network interface.

```bash
ip a
...
10: veth8598645e@if9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master ovs-system state UP group default qlen 1000
    link/ether 9a:d2:fa:4e:79:5e brd ff:ff:ff:ff:ff:ff link-netnsid 0
```

## from host system notice that the host vm has a tap device with lxdbr0 as master

```bash
ip a
...
4: lxdbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:16:3e:ac:6c:f3 brd ff:ff:ff:ff:ff:ff
    inet 10.181.197.1/24 scope global lxdbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:deb7:6459:9916::1/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:feac:6cf3/64 scope link 
       valid_lft forever preferred_lft forever
6: tapf33ccc71: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master lxdbr0 state UP group default qlen 1000
    link/ether 4e:d3:ad:e7:ea:fb brd ff:ff:ff:ff:ff:ff
```

Create another instance that uses the ovntest network:

```bash
lxc ls
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |   TYPE    | SNAPSHOTS |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c1   | RUNNING | 10.136.192.2 (eth0) | fd42:7180:738e:7cb8:216:3eff:fee2:d1b6 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+

lxc init ubuntu:24.04 c2
lxc config device override c2 eth0 network=ovntest
Device eth0 overridden for c2
lxc start c2

lxc ls
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |   TYPE    | SNAPSHOTS |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c1   | RUNNING | 10.136.192.2 (eth0) | fd42:7180:738e:7cb8:216:3eff:fee2:d1b6 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c2   | RUNNING | 10.136.192.3 (eth0) | fd42:7180:738e:7cb8:216:3eff:fef3:3574 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
```

## ping test

```bash
# create 2 terminals 
# from 1st terminal
lxc exec uvm1 -- bash
lxc exec c1 -- bash
# from 2nd terminal
lxc exec uvm1 -- bash
lxc exec c2 -- bash
ping c1
PING c1 (fd42:7180:738e:7cb8:216:3eff:fee2:d1b6) 56 data bytes
64 bytes from c1.lxd (fd42:7180:738e:7cb8:216:3eff:fee2:d1b6): icmp_seq=1 ttl=255 time=0.706 ms
64 bytes from c1.lxd (fd42:7180:738e:7cb8:216:3eff:fee2:d1b6): icmp_seq=2 ttl=255 time=0.086 ms
^C
--- c1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.086/0.396/0.706/0.310 ms

ping google.com
PING google.com (142.250.191.238) 56(84) bytes of data.
64 bytes from ord38s32-in-f14.1e100.net (142.250.191.238): icmp_seq=1 ttl=114 time=7.76 ms
64 bytes from ord38s32-in-f14.1e100.net (142.250.191.238): icmp_seq=2 ttl=114 time=7.59 ms

```

## create a container using the default non-ovn network

```bash
# from a 3rd terminal
lxc exec uvm1 -- bash
lxc init ubuntu:24.04 c3
lxc start c3

lxc ls
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| NAME |  STATE  |        IPV4         |                     IPV6                      |   TYPE    | SNAPSHOTS |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c1   | RUNNING | 10.136.192.2 (eth0) | fd42:7180:738e:7cb8:216:3eff:fee2:d1b6 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c2   | RUNNING | 10.136.192.3 (eth0) | fd42:7180:738e:7cb8:216:3eff:fef3:3574 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
| c3   | RUNNING | 10.44.173.62 (eth0) | fd42:918a:5074:9366:216:3eff:fe29:fac1 (eth0) | CONTAINER | 0         |
+------+---------+---------------------+-----------------------------------------------+-----------+-----------+
```

Notice the container using the default network is using the ip range configured for lxdbr0 on the host vm.

```bash
lxc network set lxdbr0 ipv4.dhcp.ranges=10.44.173.2-10.44.173.199 ipv4.ovn.ranges=10.44.173.205-10.44.173.254
lxc exec c3 -- bash
root@c3:~# ping c1
ping: c1: Temporary failure in name resolution

ping google.com
PING google.com (142.250.191.238) 56(84) bytes of data.
64 bytes from ord38s32-in-f14.1e100.net (142.250.191.238): icmp_seq=1 ttl=115 time=6.82 ms
64 bytes from ord38s32-in-f14.1e100.net (142.250.191.238): icmp_seq=2 ttl=115 time=7.36 ms
```

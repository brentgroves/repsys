# **[Configure Static IPs in Multipass](https://multipass.run/docs/configure-static-ips)**

**[Back to Research List](../../research_list.md)**\
**[Back to Networking Menu](./networking_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

- **[bridge on ubuntu server](https://multipass.run/docs/create-an-instance#heading--create-an-instance-with-multiple-network-interfaces)**
- **[nmcli bridge tutorial](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-a-network-bridge_configuring-and-managing-networking)**
- **[Add network bridge with nmcli (NetworkManager)](https://www.cyberciti.biz/faq/how-to-add-network-bridge-with-nmcli-networkmanager-on-linux/#google_vignette)**
- **[How to add network interfaces in Multipass](https://discourse.ubuntu.com/t/how-to-add-network-interfaces/19544)**

## Create a network internal to the host

This document explains how to create instances with static IPs in a new network, internal to the host. With this approach, instances get an extra IP that does not change with restarts. By using a separate, local network we avoid any IP conflicts. Instances retain the usual default interface with a DHCP-allocated IP, which gives them connectivity to the outside.

Install multipass

```bash
ssh brent@repsys13
# To uninstall Multipass, simply run:
snap remove multipass

snap install multipass
# Make sure you’re part of the group that Multipass gives write access to its socket (sudo in this case, but it may also be adm or admin, depending on your distribution):

ls -l /var/snap/multipass/common/multipass_socket
srw-rw---- 1 root sudo 0 May 29 16:14 /var/snap/multipass/common/multipass_socket
groups | grep sudo
brent adm cdrom sudo dip plugdev lpadmin lxd sambashare
```

## **[Step 0: Change to LXD driver](https://jon.sprig.gs/blog/post/2800)**

Currently only the LXD driver supports the networks command on Linux.

So, let’s make multipass on Ubuntu use LXD! (Be prepared for entering your password a few times!)

```bash
multipass networks

networks failed: The networks feature is not implemented on this backend.
```

Firstly, we need to install LXD. Dead simple:

LXD ( [lɛks'di:] 🔈) is a modern, secure and powerful system container and virtual machine manager. It provides a unified experience for running and managing full Linux systems inside containers or virtual machines.

```bash
sudo snap install lxd
lxd (5.21/stable) 5.21.1-d46c406 from Canonical✓ installed
```

Next, we need to tell snap that it’s allowed to connect LXD to multipass:

```bash
sudo snap connect multipass:lxd lxd
sudo snap connections multipass
Interface          Plug                         Slot                Notes
firewall-control   multipass:firewall-control   :firewall-control   -
home               multipass:all-home           :home               -
home               multipass:home               :home               -
kvm                multipass:kvm                :kvm                -
libvirt            multipass:libvirt            -                   -
lxd                multipass:lxd                lxd:lxd             -
multipass-support  multipass:multipass-support  :multipass-support  -
network            multipass:network            :network            -
network-bind       multipass:network-bind       :network-bind       -
network-control    multipass:network-control    :network-control    -
network-manager    multipass:network-manager    :network-manager    -
network-observe    multipass:network-observe    :network-observe    -
removable-media    multipass:removable-media    -                   -
system-observe     multipass:system-observe     :system-observe     -
unity7             multipass:unity7             :unity7             -
wayland            multipass:wayland            :wayland            -
x11                multipass:x11                :x11                -```

And lastly, we tell multipass to use lxd:

```bash
multipass set local.driver=lxd
multipass networks

Name        Type       Description
eno1        ethernet   Ethernet device
eno2        ethernet   Ethernet device
eno3        ethernet   Ethernet device
eno4        ethernet   Ethernet device
enp66s0f0   ethernet   Ethernet device
enp66s0f1   ethernet   Ethernet device
enp66s0f2   ethernet   Ethernet device
enp66s0f3   ethernet   Ethernet device
mpbr0       bridge     Network bridge for Multipass
```

## Step 1: Create a Bridge

A **[network bridge](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-a-network-bridge_configuring-and-managing-networking)** is a link-layer device which forwards traffic between networks based on a table of MAC addresses. A bridge requires a network device in each network the bridge should connect. When you configure a bridge, the bridge is called controller and the devices it uses ports. To set a static IPv4 address, network mask, default gateway, and DNS server to the bridge0 connection, enter:

```bash
# nmcli connection modify bridge0 ipv4.addresses '192.0.2.1/24' ipv4.gateway '192.0.2.254' ipv4.dns '192.0.2.253' ipv4.dns-search 'example.com' ipv4.method manual
```

The first step is to create a new bridge/switch with a static IP on your host. This is beyond the scope of Multipass but, as an example, here is how this can be achieved with NetworkManager (e.g. on Ubuntu Desktop):

```bash
# clean install of ubuntu 22.04 desktop and multipass
ssh brent@repsys13
nmcli -t -f UUID,TYPE,DEVICE connection show
nmcli connection delete $UUID
sudo nmcli connection delete 65380f4f-d384-4d03-8b8c-bdf9160ea065

sudo nmcli connection add type bridge con-name localbr ifname localbr \
    ipv4.method manual ipv4.addresses 10.13.31.1/24

Connection 'localbr' (65380f4f-d384-4d03-8b8c-bdf9160ea065) successfully added.

nmcli connection show 
NAME                UUID                                  TYPE      DEVICE      
Wired connection 2  74830679-74b4-3a2a-8711-e20103c77322  ethernet  eno2        
mpbr0               88ee5396-79df-46b9-a4c9-46ac56fb0798  bridge    mpbr0       
Wired connection 1  dff312d7-ea1c-3537-8be5-a1f7043797ce  ethernet  eno1        
localbr             65380f4f-d384-4d03-8b8c-bdf9160ea065  bridge    localbr 

nmcli device show localbr
GENERAL.DEVICE:                         localbr
GENERAL.TYPE:                           bridge
GENERAL.HWADDR:                         AE:6F:D9:34:27:8A
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected)
GENERAL.CONNECTION:                     localbr
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/4
IP4.ADDRESS[1]:                         10.13.31.1/24
IP4.GATEWAY:                            --
IP4.ROUTE[1]:                           dst = 10.13.31.0/24, nh = 0.0.0.0, mt = 425
IP6.GATEWAY:                            --
```

This created a bridge named localbr with IP 10.13.31.1/24. You can see the new device and address with:

```bash
ip -c -br addr show dev localbr 

localbr           DOWN           10.13.31.1/24
```

Use the ip utility to display the link status of Ethernet devices that are ports of a specific bridge:

```bash
ip link show master localbr
14: tap3910decf: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master localbr state UP mode DEFAULT group default qlen 1000
    link/ether ae:da:0f:d7:33:6a brd ff:ff:ff:ff:ff:ff

nmcli device show tap3910decf
GENERAL.DEVICE:                         tap3910decf
GENERAL.TYPE:                           tun
GENERAL.HWADDR:                         AE:DA:0F:D7:33:6A
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected (externally))
GENERAL.CONNECTION:                     tap3910decf
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/7
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

```

You can also run multipass networks to confirm the bridge is available for Multipass to connect to.

```bash
multipass networks
Name        Type       Description
eno1        ethernet   Ethernet device
eno2        ethernet   Ethernet device
eno3        ethernet   Ethernet device
eno4        ethernet   Ethernet device
enp66s0f0   ethernet   Ethernet device
enp66s0f1   ethernet   Ethernet device
enp66s0f2   ethernet   Ethernet device
enp66s0f3   ethernet   Ethernet device
localbr     bridge     Network bridge
mpbr0       bridge     Network bridge for Multipass
```

**[Display the network interfaces](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-a-network-bridge_configuring-and-managing-networking)**, and note the names of the interfaces you want to add to the bridge:

```bash
nmcli device status
DEVICE     TYPE      STATE                   CONNECTION         
eno2       ethernet  connected               Wired connection 2 
mpbr0      bridge    connected (externally)  mpbr0              
eno1       ethernet  connected               Wired connection 1 
localbr    bridge    connected               localbr  

ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    altname enp1s0f0
    inet 10.1.0.135/22 brd 10.1.3.255 scope global noprefixroute eno1
       valid_lft forever preferred_lft forever
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    altname enp1s0f1
    inet 10.1.0.136/22 brd 10.1.3.255 scope global noprefixroute eno2
       valid_lft forever preferred_lft forever
10: mpqemubr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    inet 10.195.237.1/24 brd 10.195.237.255 scope global mpqemubr0
       valid_lft forever preferred_lft forever
11: localbr: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    inet 10.13.31.1/24 brd 10.13.31.255 scope global noprefixroute localbr
       valid_lft forever preferred_lft forever

```

## Step 2: Launch an instance with a manual network

**[Generate 5 MAC address](https://www.browserling.com/tools/random-mac)**

```bash
5c:13:55:48:43:58
d5:eb:35:ee:b4:14
3f:40:f5:5d:17:65
7f:71:f0:b2:55:dd
03:dc:c9:c4:c4:14
```

**[Notes launch command](https://multipass.run/docs/launch-command)**

```bash
--network <spec>                      Add a network interface to the
                                        instance, where <spec> is in the
                                        "key=value,key=value" format, with the
                                        following keys available:
                                         name: the network to connect to
                                        (required), use the networks command for
                                        a list of possible values, or use
                                        'bridged' to use the interface
                                        configured via `multipass set
                                        local.bridged-network`.
                                         mode: auto|manual (default: auto)
                                         mac: hardware address (default:
                                        random).
                                        You can also use a shortcut of "<name>"
                                        to mean "name=<name>".
```

Next we launch an instance with an extra network in manual mode, connecting it to this bridge:

```bash
multipass launch --name test1 --network name=localbr,mode=manual,mac="5c:13:55:48:43:58"
```

## Step 3: Configure the extra interface

We now need to configure the manual network interface inside the instance. We can achieve that using Netplan. The following command plants the required Netplan configuration file in the instance:

```bash
$ multipass exec -n test1 -- sudo bash -c 'cat << EOF > /etc/netplan/10-custom.yaml
network:
    version: 2
    ethernets:
        extra0:
            dhcp4: no
            match:
                macaddress: "5c:13:55:48:43:58"
            addresses: [10.13.31.13/24]
EOF'

multipass exec -n test1 -- sudo bash -c 'cat /etc/netplan/10-custom.yaml'
multipass exec -n test1 -- sudo netplan apply
** (generate:2661): WARNING **: 18:37:57.672: Permissions for /etc/netplan/10-custom.yaml are too open. Netplan configuration should NOT be accessible by others.
```

Step 5: Confirm that it works
You can confirm that the new IP is present in the instance with Multipass:

```bash
multipass info test1

Name:           test1
State:          Running
IPv4:           10.161.38.77
                10.13.31.13
Release:        Ubuntu 24.04 LTS
Image hash:     08c7ba960c16 (Ubuntu 24.04 LTS)
CPU(s):         1
Load:           0.00 0.00 0.00
Disk usage:     1.4GiB out of 9.6GiB
Memory usage:   343.6MiB out of 945.6MiB
Mounts:         --

```

The command above should show two IPs, the second of which is the one we just configured (10.13.31.13). You can use ping to confirm that it can be reached from the host:

```bash
PING 10.13.31.13 (10.13.31.13) 56(84) bytes of data.
64 bytes from 10.13.31.13: icmp_seq=1 ttl=64 time=0.648 ms
```

Conversely, you can also ping from the instance to the host:

```bash
multipass exec -n test1 -- ping 10.13.31.1

PING 10.13.31.1 (10.13.31.1) 56(84) bytes of data.
64 bytes from 10.13.31.1: icmp_seq=1 ttl=64 time=0.273 ms
```

Step 6: More instances
If desired, repeat steps 2-5 with different names/MACs/IP terminations (e.g. 10.13.31.14) to launch other instances with static IPs in the same network. You can ping from one instance to another to confirm that they are connected. For example:

```bash
multipass exec -n test1 -- ping 10.13.31.14
multipass exec -n test1 -- ping google.com
PING google.com (142.250.191.238) 56(84) bytes of data.
64 bytes from ord38s32-in-f14.1e100.net (142.250.191.238): icmp_seq=1 ttl=116 time=9.71 ms
```

## Verify network interfaces

```bash
nmcli connection show 
NAME                UUID                                  TYPE      DEVICE      
Wired connection 2  74830679-74b4-3a2a-8711-e20103c77322  ethernet  eno2        
mpbr0               88ee5396-79df-46b9-a4c9-46ac56fb0798  bridge    mpbr0       
Wired connection 1  dff312d7-ea1c-3537-8be5-a1f7043797ce  ethernet  eno1        
localbr             65380f4f-d384-4d03-8b8c-bdf9160ea065  bridge    localbr     
tap3910decf         5e15a73d-d042-4196-931f-302f9054de6a  tun       tap3910decf 
tape518c5a7         f43135b4-cc0a-4d41-8110-39d553800c23  tun       tape518c5a7 

nmcli connection show localbr 
GENERAL.NAME:                           localbr
GENERAL.UUID:                           65380f4f-d384-4d03-8b8c-bdf9160ea065
GENERAL.DEVICES:                        localbr
GENERAL.IP-IFACE:                       localbr
GENERAL.STATE:                          activated
GENERAL.DEFAULT:                        no
GENERAL.DEFAULT6:                       no
GENERAL.SPEC-OBJECT:                    --
GENERAL.VPN:                            no
GENERAL.DBUS-PATH:                      /org/freedesktop/NetworkManager/ActiveConnection/4
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/Settings/10
GENERAL.ZONE:                           --
GENERAL.MASTER-PATH:                    --
IP4.ADDRESS[1]:                         10.13.31.1/24


ip link show master mpbr0
13: tape518c5a7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP mode DEFAULT group default qlen 1000
    link/ether e6:53:77:50:74:f1 brd ff:ff:ff:ff:ff:ff

ip link show master localbr
14: tap3910decf: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master localbr state UP mode DEFAULT group default qlen 1000
    link/ether ae:da:0f:d7:33:6a brd ff:ff:ff:ff:ff:ff

# Network **[Tap device](https://blog.cloudflare.com/virtual-networking-101-understanding-tap)**

ip tuntap list           
tape518c5a7: tap one_queue multi_queue vnet_hdr persist
tap3910decf: tap one_queue multi_queue vnet_hdr persist

nmcli con show tape518c5a7

nmcli con show tape518c5a7

connection.id:                          tape518c5a7
connection.uuid:                        f43135b4-cc0a-4d41-8110-39d553800c23
connection.stable-id:                   --
connection.type:                        tun
connection.interface-name:              tape518c5a7
connection.autoconnect:                 no
connection.autoconnect-priority:        0
connection.autoconnect-retries:         -1 (default)
connection.multi-connect:               0 (default)
connection.auth-retries:                -1
connection.timestamp:                   1717108605
connection.read-only:                   no
connection.permissions:                 --
connection.zone:                        --
connection.master:                      mpbr0
connection.slave-type:                  bridge
connection.autoconnect-slaves:          -1 (default)
connection.secondaries:                 --
connection.gateway-ping-timeout:        0
connection.metered:                     unknown
connection.lldp:                        default
connection.mdns:                        -1 (default)
connection.llmnr:                       -1 (default)
connection.dns-over-tls:                -1 (default)
connection.wait-device-timeout:         -1
bridge-port.priority:                   32
bridge-port.path-cost:                  2
bridge-port.hairpin-mode:               no
bridge-port.vlans:                      --
tun.mode:                               2 (tap)
tun.owner:                              --
tun.group:                              --
tun.pi:                                 no
tun.vnet-hdr:                           no
tun.multi-queue:                        yes
GENERAL.NAME:                           tape518c5a7
GENERAL.UUID:                           f43135b4-cc0a-4d41-8110-39d553800c23
GENERAL.DEVICES:                        tape518c5a7
GENERAL.IP-IFACE:                       tape518c5a7
GENERAL.STATE:                          activated
GENERAL.DEFAULT:                        no
GENERAL.DEFAULT6:                       no
GENERAL.SPEC-OBJECT:                    --
GENERAL.VPN:                            no
GENERAL.DBUS-PATH:                      /org/freedesktop/NetworkManager/ActiveConnection/6
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/Settings/12
GENERAL.ZONE:                           --
GENERAL.MASTER-PATH:                    /org/freedesktop/NetworkManager/Devices/12
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

nmcli device show tape518c5a7

GENERAL.DEVICE:                         tape518c5a7
GENERAL.TYPE:                           tun
GENERAL.HWADDR:                         E6:53:77:50:74:F1
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected (externally))
GENERAL.CONNECTION:                     tape518c5a7
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/6
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

nmcli device show tap3910decf

GENERAL.DEVICE:                         tap3910decf
GENERAL.TYPE:                           tun
GENERAL.HWADDR:                         AE:DA:0F:D7:33:6A
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected (externally))
GENERAL.CONNECTION:                     tap3910decf
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/7
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

nmcli connection show tap3910decf

connection.id:                          tap3910decf
connection.uuid:                        5e15a73d-d042-4196-931f-302f9054de6a
connection.stable-id:                   --
connection.type:                        tun
connection.interface-name:              tap3910decf
connection.autoconnect:                 no
connection.autoconnect-priority:        0
connection.autoconnect-retries:         -1 (default)
connection.multi-connect:               0 (default)
connection.auth-retries:                -1
connection.timestamp:                   1717108905
connection.read-only:                   no
connection.permissions:                 --
connection.zone:                        --
connection.master:                      localbr
connection.slave-type:                  bridge
connection.autoconnect-slaves:          -1 (default)
connection.secondaries:                 --
connection.gateway-ping-timeout:        0
connection.metered:                     unknown
connection.lldp:                        default
connection.mdns:                        -1 (default)
connection.llmnr:                       -1 (default)
connection.dns-over-tls:                -1 (default)
connection.wait-device-timeout:         -1
bridge-port.priority:                   32
bridge-port.path-cost:                  2
bridge-port.hairpin-mode:               no
bridge-port.vlans:                      --
tun.mode:                               2 (tap)
tun.owner:                              --
tun.group:                              --
tun.pi:                                 no
tun.vnet-hdr:                           no
tun.multi-queue:                        yes
GENERAL.NAME:                           tap3910decf
GENERAL.UUID:                           5e15a73d-d042-4196-931f-302f9054de6a
GENERAL.DEVICES:                        tap3910decf
GENERAL.IP-IFACE:                       tap3910decf
GENERAL.STATE:                          activated
GENERAL.DEFAULT:                        no
GENERAL.DEFAULT6:                       no
GENERAL.SPEC-OBJECT:                    --
GENERAL.VPN:                            no
GENERAL.DBUS-PATH:                      /org/freedesktop/NetworkManager/ActiveConnection/7
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/Settings/13
GENERAL.ZONE:                           --
GENERAL.MASTER-PATH:                    /org/freedesktop/NetworkManager/Devices/11
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --


ip shows us our links
multipass exec -n test1 -- ip link list
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:c9:3e:64 brd ff:ff:ff:ff:ff:ff
3: enp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 5c:13:55:48:43:58 brd ff:ff:ff:ff:ff:ff


multipass exec -n test1 -- networkctl
IDX LINK   TYPE     OPERATIONAL SETUP     
  1 lo     loopback carrier     unmanaged
  2 enp5s0 ether    routable    configured
  3 enp6s0 ether    routable    configured

multipass exec -n test1 -- networkctl status
● Interfaces: 1, 3, 2
         State: routable                                      
  Online state: online                                        
       Address: 10.161.38.77 on enp5s0
                10.13.31.13 on enp6s0
                fd42:b403:217:3a62:5054:ff:fec9:3e64 on enp5s0
                fe80::5054:ff:fec9:3e64 on enp5s0
                fe80::5e13:55ff:fe48:4358 on enp6s0
       Gateway: 10.161.38.1 on enp5s0
                fe80::216:3eff:fe0f:4ee on enp5s0
           DNS: 10.161.38.1
                fd42:b403:217:3a62::1
                fe80::216:3eff:fe0f:4ee
Search Domains: lxd

May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained carrier
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[5396]: Enumeration completed
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Configuring with /run/systemd/network/10-netplan-enp5s0.network.
May 30 06:36:09 test1 systemd[1]: Started systemd-networkd.service - Network Configuration.
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Configuring with /run/systemd/network/10-netplan-extra0.network.
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: DHCPv4 address 10.161.38.77/24, gateway 10.161.38.1 acquired from 10.161.38.1
May 30 06:36:09 test1 systemd[1]: Starting systemd-networkd-wait-online.service - Wait for Network to be Configured...
May 30 06:36:09 test1 systemd[1]: Finished systemd-networkd-wait-online.service - Wait for Network to be Configured.
```

To list various details of specific network interface called enp7s0, you can run the following command, which will list network configuration files, type, state, IP addresses (both IPv4 and IPv6), broadcast addresses, gateway, DNS servers, domain, routing information, maximum transmission unit (MTU), and queuing discipline (QDisc).

```bash
multipass exec -n test1 -- networkctl status enp5s0
● 2: enp5s0
                   Link File: /run/systemd/network/10-netplan-enp5s0.link
                Network File: /run/systemd/network/10-netplan-enp5s0.network
                       State: routable (configured)
                Online state: online                                         
                        Type: ether
                        Path: pci-0000:05:00.0
                      Driver: virtio_net
                      Vendor: Red Hat, Inc.
                       Model: Virtio 1.0 network device
            Hardware Address: 52:54:00:c9:3e:64
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: mq
IPv6 Address Generation Mode: eui64
    Number of Queues (Tx/Rx): 2/2
            Auto negotiation: no
                     Address: 10.161.38.77 (DHCP4 via 10.161.38.1)
                              fd42:b403:217:3a62:5054:ff:fec9:3e64
                              fe80::5054:ff:fec9:3e64
                     Gateway: 10.161.38.1
                              fe80::216:3eff:fe0f:4ee
                         DNS: 10.161.38.1
                              fd42:b403:217:3a62::1
                              fe80::216:3eff:fe0f:4ee
              Search Domains: lxd
           Activation Policy: up
         Required For Online: yes
             DHCP4 Client ID: IAID:0x49721f47/DUID
           DHCP6 Client IAID: 0x49721f47
           DHCP6 Client DUID: DUID-EN/Vendor:0000ab11fa956945a47e6700

May 29 18:37:58 test1 systemd-networkd[715]: enp5s0: Configuring with /run/systemd/network/10-netplan-enp5s0.network.
May 29 18:37:58 test1 systemd-networkd[715]: enp5s0: DHCP lease lost
May 29 18:37:58 test1 systemd-networkd[715]: enp5s0: DHCPv6 lease lost
May 29 18:37:58 test1 systemd-networkd[715]: enp5s0: DHCPv4 address 10.161.38.77/24, gateway 10.161.38.1 acquired from 10.161.38.1
May 30 06:36:09 test1 systemd-networkd[715]: enp5s0: DHCPv6 lease lost
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Link UP
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Gained carrier
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: Configuring with /run/systemd/network/10-netplan-enp5s0.network.
May 30 06:36:09 test1 systemd-networkd[5396]: enp5s0: DHCPv4 address 10.161.38.77/24, gateway 10.161.38.1 acquired from 10.161.38.1


multipass exec -n test1 -- networkctl status enp6s0

● 3: enp6s0
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: /run/systemd/network/10-netplan-extra0.network
                       State: routable (configured)
                Online state: online                                         
                        Type: ether
                        Path: pci-0000:06:00.0
                      Driver: virtio_net
                      Vendor: Red Hat, Inc.
                       Model: Virtio 1.0 network device
            Hardware Address: 5c:13:55:48:43:58
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: mq
IPv6 Address Generation Mode: eui64
    Number of Queues (Tx/Rx): 2/2
            Auto negotiation: no
                     Address: 10.13.31.13
                              fe80::5e13:55ff:fe48:4358
           Activation Policy: up
         Required For Online: yes
           DHCP6 Client DUID: DUID-EN/Vendor:0000ab11fa956945a47e6700

May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Link UP
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Gained carrier
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Configuring with /run/systemd/network/10-netplan-extra0.network.
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: DHCPv6 lease lost
May 29 18:38:00 test1 systemd-networkd[715]: enp6s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[715]: enp6s0: DHCPv6 lease lost
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Link UP
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained carrier
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Configuring with /run/systemd/network/10-netplan-extra0.network.

```

Conclusion
You have now created a small internal network, local to your host, with Multipass instances that you can reach on the same IP across reboots. Instances still have the default NAT-ed network, which they can use to reach the outside world. You can combine this with other networks if you want to (e.g. for bridging).

## Start Here

**[Create an instance with multiple network interfaces](https://multipass.run/docs/create-an-instance#heading--create-an-instance-with-multiple-network-interfaces)**

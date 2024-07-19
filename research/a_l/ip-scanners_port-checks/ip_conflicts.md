# **[IDENTIFYING AND RESOLVING IP ADDRESS CONFLICTS WITH LINUX](http://techthrob.com/2010/06/identifying-and-resolving-ip-address-conflicts-with-linux/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

One of the most frustrating problems a network administrator can come across is an IP address conflict, when two or more machines on a network try to use the same IP. The result is typically that some packets on the network go to one machine, and some packets go to the other – leading to intermittent packet loss and dropped connections.

Luckily, however, resolving IP address conflicts is easy if you know the right tools. This how to will teach you to find and resolve IP address conflicts on your network.

## references

- **[IDENTIFYING AND RESOLVING IP ADDRESS CONFLICTS WITH LINUX](http://techthrob.com/2010/06/identifying-and-resolving-ip-address-conflicts-with-linux/)**
- **[How can I determine if there are two machines on the subnet with the same IP?](https://superuser.com/questions/587024/how-can-i-determine-if-there-are-two-machines-on-the-subnet-with-the-same-ip)**

## Tools

In order to identify the IP address conflict, you are going to need a Linux machine on the subnet that has the conflict, and a copy of arp-scan. You can install arp-scan on Fedora/RedHat or Ubuntu by using the following commands:

```bash
sudo apt-get install arp-scan
```

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## Finding the IP Conflict

Finding an IP conflict is as simple as a single command, “arp-scan -l”. You may also wish to specify the -I option, which will allow you to pick an interface. Below, I have identified an IP address that is being claimed by two machines:

```bash
sudo arp-scan -I enp0s25 -l
[sudo] password for brent: 
Interface: enp0s25, type: EN10MB, MAC: 18:03:73:1f:84:a4, IPv4: 10.1.0.113
Starting arp-scan 1.9.7 with 1024 hosts (https://github.com/royhills/arp-scan)
10.1.0.10 84:7b:eb:f4:d1:82 Dell Inc.
10.1.0.11 14:18:77:49:21:20 Dell Inc.
10.1.0.12 00:0c:29:bf:1a:a3 VMware, Inc.
10.1.0.13 2c:ea:7f:bf:b1:ea (Unknown)
10.1.0.22 00:50:56:a9:a2:8c VMware, Inc.
10.1.0.30 d4:ad:71:bc:e7:c0 Cisco Systems, Inc
10.1.0.33 64:00:f1:ce:09:c0 Cisco Systems, Inc
10.1.0.32 cc:70:ed:1b:4f:c0 Cisco Systems, Inc
10.1.0.34 50:57:a8:61:05:40 Cisco Systems, Inc
10.1.0.31 70:35:09:91:8f:40 Cisco Systems, Inc
10.1.0.50 00:80:f0:fd:cf:d8 Panasonic Communications Co., Ltd.
10.1.0.51 00:80:f0:fd:cf:d9 Panasonic Communications Co., Ltd.
10.1.0.90 b8:ca:3a:6a:37:18 Dell Inc.
10.1.0.90 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 2)
10.1.0.90 72:ef:98:43:45:aa (Unknown: locally administered) (DUP: 3)
10.1.0.91 b8:ca:3a:6a:37:18 Dell Inc.
10.1.0.91 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 2)
10.1.0.91 72:ef:98:43:45:aa (Unknown: locally administered) (DUP: 3)
10.1.0.92 b8:ca:3a:6a:37:18 Dell Inc.
10.1.0.92 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 2)
10.1.0.92 72:ef:98:43:45:aa (Unknown: locally administered) (DUP: 3)
10.1.0.93 52:54:00:a6:3d:3e QEMU
10.1.0.94 52:54:00:90:6f:18 QEMU

```

## Specifying the Target IP Addresses

You can specify the target IP addresses instead of using --localnet. The following target specifications are supported:

- A single IP address, e.g. 192.168.1.1 or hostname. Use the --numeric (-n) option to prevent DNS resolution of target hostnames.
- A network in CIDR format, e.g. 192.168.1.0/24 (includes network and broadcast addresses).
- A network in <network>:<netmask> format, e.g. 192.168.1.0:255.255.255.0 (includes network and broadcast addresses).
- An inclusive range in <start>-<end> format, e.g. 192.168.1.3-192.168.1.27

The targets can be specified in two ways:

As command line arguments, e.g. arp-scan 192.168.1.1 192.168.1.2 192.168.1.3 or arp-scan 192.168.1.0/24
Use the --file (-f) option to read from the specified file. One target specification per line. Use - for standard input. e.g. echo 192.168.1.0/24 | arp-scan -f -
For example here is a scan of the 16 addresses in 10.133.170.16/28:

```bash
sudo arp-scan 10.1.0.0/24
Interface: enp0s25, type: EN10MB, MAC: 18:03:73:1f:84:a4, IPv4: 10.1.0.113
Starting arp-scan 1.9.7 with 128 hosts (https://github.com/royhills/arp-scan)
10.1.0.10 84:7b:eb:f4:d1:82 Dell Inc.
10.1.0.11 14:18:77:49:21:20 Dell Inc.
10.1.0.12 00:0c:29:bf:1a:a3 VMware, Inc.
10.1.0.13 2c:ea:7f:bf:b1:ea (Unknown)
10.1.0.22 00:50:56:a9:a2:8c VMware, Inc.
10.1.0.30 d4:ad:71:bc:e7:c0 Cisco Systems, Inc
10.1.0.31 70:35:09:91:8f:40 Cisco Systems, Inc
10.1.0.33 64:00:f1:ce:09:c0 Cisco Systems, Inc
10.1.0.34 50:57:a8:61:05:40 Cisco Systems, Inc
10.1.0.32 cc:70:ed:1b:4f:c0 Cisco Systems, Inc
10.1.0.50 00:80:f0:fd:cf:d8 Panasonic Communications Co., Ltd.
10.1.0.51 00:80:f0:fd:cf:d9 Panasonic Communications Co., Ltd.
10.1.0.90 72:ef:98:43:45:aa (Unknown: locally administered)
10.1.0.90 b8:ca:3a:6a:37:18 Dell Inc. (DUP: 2)
10.1.0.90 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 3)
10.1.0.91 72:ef:98:43:45:aa (Unknown: locally administered)
10.1.0.91 b8:ca:3a:6a:37:18 Dell Inc. (DUP: 2)
10.1.0.91 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 3)
10.1.0.92 72:ef:98:43:45:aa (Unknown: locally administered)
10.1.0.92 b8:ca:3a:6a:37:18 Dell Inc. (DUP: 2)
10.1.0.92 b6:8c:21:19:97:af (Unknown: locally administered) (DUP: 3)
10.1.0.93 52:54:00:a6:3d:3e QEMU
10.1.0.94 52:54:00:90:6f:18 QEMU
10.1.0.110 f4:8e:38:b7:c4:33 Dell Inc.
10.1.0.111 98:90:96:b7:e7:d1 Dell Inc.
10.1.0.112 98:90:96:c3:f4:83 Dell Inc.
10.1.0.116 00:50:56:a9:8f:1c VMware, Inc.
10.1.0.117 00:50:56:a9:e3:a1 VMware, Inc.
10.1.0.118 00:50:56:a9:c2:bd VMware, Inc.
10.1.0.120 00:15:5d:00:0e:00 Microsoft Corporation

$ arp-scan 10.133.170.16/28
Interface: eth0, type: EN10MB, MAC: a0:b3:cc:e8:0e:94, IPv4: 10.133.170.8
Starting arp-scan 1.10.0 with 16 hosts (https://github.com/royhills/arp-scan)
10.133.170.16   bc:30:5b:e8:da:76       Dell Inc.
10.133.170.17   00:0c:29:25:cc:09       VMware, Inc.
10.133.170.18   a0:b3:cc:e2:1b:e8       Hewlett Packard
10.133.170.19   a0:b3:cc:ea:8c:72       Hewlett Packard
10.133.170.20   a0:b3:cc:df:a6:00       Hewlett Packard
10.133.170.23   94:18:82:ab:1b:8f       Hewlett Packard Enterprise
10.133.170.24   28:92:4a:30:76:0b       Hewlett Packard
10.133.170.25   00:0c:29:5a:89:4d       VMware, Inc.
10.133.170.27   84:34:97:11:8d:40       Hewlett Packard
10.133.170.29   9c:b6:54:bb:dc:e0       Hewlett Packard
10.133.170.31   00:0c:29:c4:89:eb       VMware, Inc.

11 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0 16 hosts scanned in 1.833 seconds (8.73 hosts/sec). 11 responded
```

## In-Use IP addresses

nmap -sP 10.1.0.0/22

## sort the list

arp -n | sort -n
This will print the IP address and the MAC address of the machines. You'll also know the MAC addresses of the machines in question, so you can identify them. You can check for duplicates by hand or use this handy line:

arp -n | sort -n | uniq -cw15
and watch out for lines not having a 1 in the first column.

It's probably helpful to run a ping -bc3 192.168.1.255 (or whatever your broadcast address of your network is) beforehand so that more machines will be known to your machine.

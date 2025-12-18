# **[arp scan](https://github.com/royhills/arp-scan/wiki/arp-scan-User-Guide)**

arp-scan is a network scanning tool that uses the ARP protocol to discover and fingerprint IPv4 hosts on the local network. It is available for Linux, BSD, macOS and Solaris under the GPLv3 licence.

This is README.md for arp-scan version 1.10.1-git.

## Documentation

For usage information use:

arp-scan --help

For detailed information, see the manual pages: arp-scan(1), arp-fingerprint(1), get-oui(1) and mac-vendor(5).

See the arp-scan wiki at <https://github.com/royhills/arp-scan/wiki>

## references

- **[arp-scan source](https://github.com/royhills/arp-scan)**

## **[Introduction to arp-scan](https://github.com/royhills/arp-scan/wiki/arp-scan-User-Guide)**

arp-scan is a command-line tool for IPv4 host discovery and fingerprinting. It sends ARP requests for the specified hosts and displays the responses received. arp-scan allows you to:

- Send ARP packets to any number of destination hosts, using a configurable output bandwidth or packet rate, permitting efficient scanning of large address ranges.
- Construct the outgoing ARP packet in a flexible way. arp-scan gives control of all of the fields in the ARP packet, the fields in the Ethernet frame header and any padding data after the ARP packet.
- Decode and display any returned packets. arp-scan will decode and display any received ARP packets and lookup the vendor using the MAC address.
- Fingerprint IP hosts using the arp-fingerprint tool.

## Using arp-scan for system discovery

arp-scan can be used to discover IPv4 hosts on the local Ethernet or wireless network, including hosts that block IP traffic.

## Scanning the local network with --localnet

The simplest way to scan the local network is with arp-scan --localnet. This will scan all IPv4 addresses within the network defined by the interface IP address and netmask (network and broadcast addresses included). For example:

```bash
$ arp-scan --localnet
Interface: eth0, type: EN10MB, MAC: 50:65:f3:f0:70:a4, IPv4: 192.168.1.104
Target list from interface network 192.168.1.0 netmask 255.255.255.0
Starting arp-scan 1.10.1 with 256 hosts (https://github.com/royhills/arp-scan)
192.168.1.68    00:0c:29:67:b9:12       VMware, Inc.
192.168.1.69    00:0c:29:f7:56:b6       VMware, Inc.
192.168.1.70    00:0c:29:44:f7:70       VMware, Inc.
192.168.1.71    00:0c:29:a1:ad:df       VMware, Inc.
192.168.1.73    00:0c:29:20:21:e2       VMware, Inc.
192.168.1.74    00:0c:29:90:07:e9       VMware, Inc.
192.168.1.75    00:0c:29:66:9e:c2       VMware, Inc.
192.168.1.76    00:0c:29:d0:e1:ea       VMware, Inc.
192.168.1.82    9c:b6:54:bb:f3:ec       Hewlett Packard
192.168.1.83    00:9c:02:a5:7b:26       Hewlett Packard
192.168.1.84    00:21:9b:fd:b9:b3       Dell Inc.
192.168.1.85    00:02:b3:eb:5a:f8       Intel Corporation
192.168.1.91    00:9c:02:a5:7b:29       Hewlett Packard
192.168.1.92    d4:ae:52:d0:07:6f       Dell Inc.
192.168.1.93    d4:ae:52:d0:04:9b       Dell Inc.
192.168.1.94    9c:b6:54:bb:f3:ee       Hewlett Packard
192.168.1.96    9c:b6:54:bb:f5:35       Hewlett Packard
192.168.1.97    00:0c:29:0e:95:20       VMware, Inc.
192.168.1.102   00:80:91:cd:a7:45       TOKYO ELECTRIC CO.,LTD
192.168.1.106   50:65:f3:f0:6d:7c       Hewlett Packard
192.168.1.107   50:65:f3:f0:6d:7e       Hewlett Packard
192.168.1.202   08:f1:ea:af:f6:08       Hewlett Packard Enterprise
192.168.1.203   08:f1:ea:af:f6:b8       Hewlett Packard Enterprise
192.168.1.204   08:f1:ea:af:f6:0b       Hewlett Packard Enterprise
192.168.1.205   08:f1:ea:af:f6:bb       Hewlett Packard Enterprise
192.168.1.206   00:08:a2:11:89:d8       ADI Engineering, Inc.
192.168.1.208   b8:cb:29:e6:b7:1f       Dell Inc.

29 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.1: 256 hosts scanned in 2.322 seconds (110.25 hosts/sec). 27 responded
```

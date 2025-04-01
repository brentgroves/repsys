# Firewall Notes

**[Research List](../../../../../research_list.md)**\
**[Detailed Status](../../../../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../../../../a_status/current_tasks.md)**\

**[Main](../../../../../../README.md)**

## Tables

Tables are the top-level containers within an nftables ruleset; they hold chains, sets, maps, flowtables, and stateful objects.

Each table belongs to exactly one family. So your ruleset requires at least one table for each family you want to filter.

Following are some basic operations and commands for configuring tables:

## Address Families

Each table in nftables must have an address family assigned, which determines the type of packets it processes.
ip: IPv4 packets.
ip6: IPv6 packets.
inet: Both IPv4 and IPv6 packets.
arp: ARP packets.
bridge: Packets passing through a bridge device.
netdev: Packets from ingress.

```bash
root@isdev:/home/brent# nft list tables
table ip filter
table ip nat
table ip mangle
table ip6 filter
table ip6 nat
table ip6 mangle
table inet lxc
table ip lxc
table inet lxd
```

## Chains

type refers to the kind of chain to be created. Possible types are:

- filter: Supported by arp, bridge, ip, ip6 and inet table families.
- route: Mark packets (like mangle for the output hook, for other hooks use the type filter instead), supported by ip and ip6.
- nat: In order to perform Network Address Translation, supported by ip and ip6.

## Hooks

hook refers to an specific stage of the packet while it's being processed through the kernel. More info in Netfilter hooks.

- The hooks for ip, ip6 and inet families are: prerouting, input, forward, output, postrouting.
- The hooks for arp family are: input, output.
- The bridge family handles ethernet packets traversing bridge devices.
- The hooks for netdev are: ingress, egress.

## Rules

handle is an internal number that identifies a certain rule.

```bash
% nft add rule [<family>] <table> <chain> <matches> <statements>
% nft insert rule [<family>] <table> <chain> [position <handle>] <matches> <statements>
% nft replace rule [<family>] <table> <chain> [handle <handle>] <matches> <statements>
% nft delete rule [<family>] <table> <chain> [handle <handle>]
```

```bash
nft list ruleset
# Warning: table ip filter is managed by iptables-nft, do not touch!
table ip filter {
        chain LIBVIRT_INP {
                iifname "virbr0" udp dport 53 counter packets 0 bytes 0 accept
                iifname "virbr0" tcp dport 53 counter packets 0 bytes 0 accept
                iifname "virbr0" udp dport 67 counter packets 0 bytes 0 accept
                iifname "virbr0" tcp dport 67 counter packets 0 bytes 0 accept
        }

        chain INPUT {
                type filter hook input priority filter; policy accept;
                counter packets 646185 bytes 907675352 jump LIBVIRT_INP
        }

        chain LIBVIRT_OUT {
                oifname "virbr0" udp dport 53 counter packets 0 bytes 0 accept
                oifname "virbr0" tcp dport 53 counter packets 0 bytes 0 accept
                oifname "virbr0" udp dport 68 counter packets 0 bytes 0 accept
                oifname "virbr0" tcp dport 68 counter packets 0 bytes 0 accept
        }

        chain OUTPUT {
                type filter hook output priority filter; policy accept;
                counter packets 380676 bytes 1331501809 jump LIBVIRT_OUT
        }

        chain LIBVIRT_FWO {
                ip saddr 192.168.122.0/24 iifname "virbr0" counter packets 0 bytes 0 accept
                iifname "virbr0" counter packets 0 bytes 0 reject
        }

        chain FORWARD {
                type filter hook forward priority filter; policy accept;
                counter packets 9616 bytes 2622504 jump LIBVIRT_FWX
                counter packets 9616 bytes 2622504 jump LIBVIRT_FWI
                counter packets 9616 bytes 2622504 jump LIBVIRT_FWO
                ip saddr 10.1.0.0/16  counter packets 0 bytes 0 accept
                ip daddr 10.1.0.0/16  counter packets 0 bytes 0 accept
        }

        chain LIBVIRT_FWI {
                ip daddr 192.168.122.0/24 oifname "virbr0" ct state related,established counter packets 0 bytes 0 accept
                oifname "virbr0" counter packets 0 bytes 0 reject
        }

        chain LIBVIRT_FWX {
                iifname "virbr0" oifname "virbr0" counter packets 0 bytes 0 accept
        }
}

```

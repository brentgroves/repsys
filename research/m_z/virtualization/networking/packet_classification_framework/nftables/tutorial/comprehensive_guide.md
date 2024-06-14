# **[comprehensive guide](https://www.linkedin.com/pulse/comprehensive-guide-nftables-leading-packet-filtering-arash-shirvar/)**

## 3. Nftables pre-configurations

Nftables configuration consists of hierarchical modules including tables, chains, sets and rules. To configure nftables, first, it is necessary to check the current content of nftables configuration file using the following command. By default, nftables configurations are located in /etc/nftables.conf.

```bash
ssh brent@repsys11
nft list ruleset

table inet lxd {
 chain pstrt.mpbr0 {
  type nat hook postrouting priority srcnat; policy accept;
  ip saddr 10.161.38.0/24 ip daddr != 10.161.38.0/24 masquerade
  ip6 saddr fd42:b403:217:3a62::/64 ip6 daddr != fd42:b403:217:3a62::/64 masquerade
 }

 chain fwd.mpbr0 {
  type filter hook forward priority filter; policy accept;
  ip version 4 oifname "mpbr0" accept
  ip version 4 iifname "mpbr0" accept
  ip6 version 6 oifname "mpbr0" accept
  ip6 version 6 iifname "mpbr0" accept
 }

 chain in.mpbr0 {
  type filter hook input priority filter; policy accept;
  iifname "mpbr0" tcp dport 53 accept
  iifname "mpbr0" udp dport 53 accept
  iifname "mpbr0" icmp type { destination-unreachable, time-exceeded, parameter-problem } accept
  iifname "mpbr0" udp dport 67 accept
  iifname "mpbr0" icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, nd-router-solicit, nd-neighbor-solicit, nd-neighbor-advert, mld2-listener-report } accept
  iifname "mpbr0" udp dport 547 accept
 }

 chain out.mpbr0 {
  type filter hook output priority filter; policy accept;
  oifname "mpbr0" tcp sport 53 accept
  oifname "mpbr0" udp sport 53 accept
  oifname "mpbr0" icmp type { destination-unreachable, time-exceeded, parameter-problem } accept
  oifname "mpbr0" udp sport 67 accept
  oifname "mpbr0" icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, echo-request, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, mld2-listener-report } accept
  oifname "mpbr0" udp sport 547 accept
 }
}
```

Note that each rule has a certain number called handle, by using -a or --handle all rules’ handles are also shown. These numbers are important as they can be used to remove a specific rule to add a rule before or after a specific rule with a specific handle number.

```nft -a list ruleset```

Second) in case you need to clear all the current data in the configuration file and then create your nftables modules, the next command should be followed.

```nft flush ruleset```

## 5. Nftables modules

### 5.1 Tables

A table is at the apex of the ruleset as a container in which chains that are the containers for rules are kept. In terms of operations that can be done on a table, adding, deleting, displaying, or listing, and emptying or flushing can be mentioned. Considering the importance of tables, the hierarchical overview of nftables’s structure is as follows:

Tables > Chains > Rules

When adding a table, chain, and a rule either by using nft command tools or directly writing them inside the nftablrs configuration file, the following structure can be seen in the nftables configuration file as shown in the next figure. As it is clear from this example below, a table followed by an address family, that is “inet” explained later, and then it is followed by its defined name that is “table1” with an open and a close curly bracket.

![](https://media.licdn.com/dms/image/C4E12AQH2PTa9jgTSLQ/article-inline_image-shrink_1000_1488/0/1595554863963?e=1723680000&v=beta&t=3PFo0QTloC8WdeKeqnS_XSCrohHHCAbQOCls6xoxE94)

## 5.2 Address Families

Address families determine the type of incoming and outgoing packets processed by nftables. For each address family, the Linux kernel contains specific hooks at different stages of the packet processing paths, which invoke nftables to decide either allow or drop a packet only if relevant rules for these hooks such as input or output are defined. These address families are as follows:

- **ip:** IPv4 address family.
- **ip6:** IPv6 address family.
- **inet:** Supports Both IPv4 and IPv6 address families.
- **arp:** ARP address family, handling IPv4 ARP packets at layer 2 OSI model.
- **bridge:** Bridge address family, handling packets traversing a bridge device at layer 2.
- **netdev:** Netdev address family, handling packets from ingress hook working before layer 3.

Table with netdev family, be means of ingress hook, allows early filtering traffic before they reach other filters below layer 3 on the OSI model. netdev family with ingress hook is an ideal stage to drop packets that result from DDOS attacks since this hook works very early in the packet path of networking.

## 5.3 Chains

Chains are a container of rules and are located inside a table created beforehand. Chains can be a base chain that can control packets destined into a node and has a hook whereas a non-base chain is a chain that is used for organization of chains and has no hook hence no control on packets. Similar to a table, all operational activities can be done on a chain in addition to renaming a chain. Chains should be followed by a name and an open and a close curly bracket. They also come with a type, a hook, a priority, and a policy that must be defined when creating a chain as shown in the next figure.

Chain chain-name { type <type> hook <hook> priority <priority> ; policy <policy> ; }

![](https://media.licdn.com/dms/image/C4E12AQFdVnsFuLkuNQ/article-inline_image-shrink_1000_1488/0/1595554904614?e=1723680000&v=beta&t=ZvrOd9Dwc-o2nV15BYUSY0Z8DEbwXjNEfOYrJBcDND8)

## 5.3.1 Chains types

- **Filter:** This is a standard chain type and supports all address families namely ARP, bridge, IP, IP6, and inet and hooks.
- **Route:** It supports only IP and IPv6 address families and only output hook. If relevant parts of the IP header have changed, a new route lookup is performed.
- **Nat:** It can perform Network Address Translation, and only supports IP and IPv6 address families. prerouting, input, output, postrouting hooks are also supported.

## 5.3.2 Chains hooks

A Hook in a chain refers to a specific stage that a packet is being processed through a Linux kernel based on defined rules. These hooks are ingress, prerouting, input, forward, output, and postrouting and are explaind in detail in the next section. Prerouting, input, forward, output, and postrouting hook can also support IP, IPv6, and inet address families. To support arp address family, input, output hooks can be used while for netdev family, ingress hook should be used.

- **Prerouting:** All packets entering a node are processed by this hook. It is invoked before the routing process and is used for early filtering or changing packet attributes that affect routing.
- **Input:** This hook are executed after the routing decision. Packets delivered to a local system are processed by this hook.
- **Forward:** This hook also happens after the routing decision. Packets that are not directed to the local machine are processed by this hook.
- **Output:** This hook controls the packets that are originated from processes in a local machine.
- **Postrouting:** This hook is used for the packets leaving a local system after the routing decision
- **Ingress (only available at the netdev family):** Since Linux kernel 4.2, traffic can be filtered before layer 3 and way before prerouting, after the packets are passed up from a NIC driver.

## 5.4 Policies

Chains have to have their policies by which packets are treated to be either dropped or accepted by default. These policy values can be “accept”, which is the default policy, or “drop”. Accept policy means that all the network packets based on their locations defined by the hook should be accepted by default whereas drop policy means that by default all network packets must be dropped based on their locations defined by the hook in a chain and then based on defined rules inside a chain will be accepted or otherwise.

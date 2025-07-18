# **[](https://documentation.ubuntu.com/lxd/stable-5.0/reference/network_ovn/)**

OVN network
OVN is a software-defined networking system that supports virtual network abstraction. You can use it to build your own private cloud. See <www.ovn.org> for more information.

The ovn network type allows to create logical networks using the OVN SDN. This kind of network can be useful for labs and multi-tenant environments where the same logical subnets are used in multiple discrete networks.

A LXD OVN network can be connected to an existing managed Bridge network or Physical network to gain access to the wider network. By default, all connections from the OVN logical networks are NATed to an IP allocated from the uplink network.

See How to set up OVN with LXD for basic instructions for setting up an OVN network.

Note

Static DHCP assignments depend on the client using its MAC address as the DHCP identifier. This method prevents conflicting leases when copying an instance, and thus makes statically assigned leases work properly.

Configuration options
The following configuration key namespaces are currently supported for the ovn network type:

bridge (L2 interface configuration)

dns (DNS server and resolution configuration)

ipv4 (L3 IPv4 configuration)

ipv6 (L3 IPv6 configuration)

security (network ACL configuration)

user (free-form key/value for user metadata)

Note

LXD uses the CIDR notation where network subnet information is required, for example, 192.0.2.0/24 or 2001:db8::/32. This does not apply to cases where a single address is required, for example, local/remote addresses of tunnels, NAT addresses or specific addresses to apply to an instance.

The following configuration options are available for the ovn network type:

| Key                                  | Type    | Condition     | Default               | Description                                                                                                   |
|--------------------------------------|---------|---------------|-----------------------|---------------------------------------------------------------------------------------------------------------|
| network                              | string  | -             | -                     | Uplink network to use for external network access                                                             |
| bridge.hwaddr                        | string  | -             | -                     | MAC address for the bridge                                                                                    |
| bridge.mtu                           | integer | -             | 1442                  | Bridge MTU (default allows host to host Geneve tunnels)                                                       |
| dns.domain                           | string  | -             | lxd                   | Domain to advertise to DHCP clients and use for DNS resolution                                                |
| dns.search                           | string  | -             | -                     | Full comma-separated domain search list, defaulting to dns.domain value                                       |
| dns.zone.forward                     | string  | -             | -                     | DNS zone name for forward DNS records                                                                         |
| dns.zone.reverse.ipv4                | string  | -             | -                     | DNS zone name for IPv4 reverse DNS records                                                                    |
| dns.zone.reverse.ipv6                | string  | -             | -                     | DNS zone name for IPv6 reverse DNS records                                                                    |
| ipv4.address                         | string  | standard mode | auto (on create only) | IPv4 address for the bridge (use none to turn off IPv4 or auto to generate a new random unused subnet) (CIDR) |
| ipv4.dhcp                            | bool    | IPv4 address  | true                  | Whether to allocate addresses using DHCP                                                                      |
| ipv4.nat                             | bool    | IPv4 address  | false                 | Whether to NAT (defaults to true if unset and a random ipv4.address is generated)                             |
| ipv4.nat.address                     | string  | IPv4 address  | -                     | The source address used for outbound traffic from the network (requires uplink ovn.ingress_mode=routed)       |
| ipv6.address                         | string  | standard mode | auto (on create only) | IPv6 address for the bridge (use none to turn off IPv6 or auto to generate a new random unused subnet) (CIDR) |
| ipv6.dhcp                            | bool    | IPv6 address  | true                  | Whether to provide additional network configuration over DHCP                                                 |
| ipv6.dhcp.stateful                   | bool    | IPv6 DHCP     | false                 | Whether to allocate addresses using DHCP                                                                      |
| ipv6.nat                             | bool    | IPv6 address  | false                 | Whether to NAT (defaults to true if unset and a random ipv6.address is generated)                             |
| ipv6.nat.address                     | string  | IPv6 address  | -                     | The source address used for outbound traffic from the network (requires uplink ovn.ingress_mode=routed)       |
| security.acls                        | string  | -             | -                     | Comma-separated list of Network ACLs to apply to NICs connected to this network                               |
| security.acls.default.egress.action  | string  | security.acls | reject                | Action to use for egress traffic that doesn’t match any ACL rule                                              |
| security.acls.default.egress.logged  | bool    | security.acls | false                 | Whether to log egress traffic that doesn’t match any ACL rule                                                 |
| security.acls.default.ingress.action | string  | security.acls | reject                | Action to use for ingress traffic that doesn’t match any ACL rule                                             |
| security.acls.default.ingress.logged | bool    | security.acls | false                 | Whether to log ingress traffic that doesn’t match any ACL rule                                                |
| user.*                               | string  | -             | -                     | User-provided free-form key/value pairs                                                                       |

Supported features
The following features are supported for the ovn network type:

How to configure network ACLs

How to configure network forwards

How to configure network zones

How to create peer routing relationships

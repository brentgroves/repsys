# **[show and info](https://documentation.ubuntu.com/lxd/latest/explanation/lxc_show_info/)**

## lxc show and info

For the entities managed by LXD, the lxc command provides a list sub-command, and might provide show and info sub-commands. The purpose of the info sub-command is to show current state information, and the purpose of the show sub-command is to show configuration information and how the entity is used by other entities.

For example, the `lxc network info` command shows IP address and traffic statistics:

```bash
Name: lxdbr0
MAC address: 00:16:3e:d3:ec:41
MTU: 1500
State: up

Ips:
  inet    192.0.2.1
  inet6   2001:db8:f4a1:53d2::1
  inet6   fe80::216:3eff:fed3:ec41

Network usage:
  Bytes received: 127.66kB
  Bytes sent: 15.54kB
  Packets received: 1433
  Packets sent: 175
```

The lxc network show command, on the other hand, shows how the network is configured, and which entities are using the network:

```bash
config:
  ipv4.address: 192.0.2.1/24
  ipv4.nat: "true"
  ipv6.address: 2001:db8:f4a1:53d2::1/64
  ipv6.nat: "true"
description: ""
name: lxdbr0
type: bridge
used_by:

- /1.0/instances/ubuntu
- /1.0/profiles/default
managed: true
status: Created
locations:
- none
```

## **[lxc info](https://documentation.ubuntu.com/lxd/latest/reference/manpages/lxc/info/#lxc-info-md)**

Show instance or server information

Synopsis
Description: Show instance or server information

lxc info [<remote>:][<instance>] [flags]

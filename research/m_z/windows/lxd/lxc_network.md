# **[create lxc network](https://documentation.ubuntu.com/lxd/en/latest/howto/network_create/)**

## **[config network](https://documentation.ubuntu.com/lxd/en/latest/howto/network_configure/)**

## How to configure a network

To configure an existing network, use either the lxc network set and lxc network unset commands (to configure single settings) or the lxc network edit command (to edit the full configuration). To configure settings for specific cluster members, add the --target flag.

For example, the following command configures a DNS server for a physical network:

```bash
lxc network set UPLINK dns.nameservers=8.8.8.8
```

## **[lxd reset](https://discuss.linuxcontainers.org/t/lxd-4-1-reset-lxd-init/8210)**

I unsucessfuly tried to reset lxd after making an error on the lxd init process. How can I do that ?

What do you want changed?

lxd init is only a convenient way to do a bunch of commands at once:

lxc config set
lxc network create
lxc storage create
lxc profile device add
So it’s often far easier to undo and reconfigure the bits you need than wipe everything clean and run init again.

```bash
lxc network show lxdbr0

name: lxdbr0
description: ""
type: bridge
managed: true
status: Created
config:
  ipv4.address: 10.223.105.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:9d25:8ccd:5ac8::1/64
  ipv6.nat: "true"
used_by:
- /1.0/profiles/default
locations:
- none
```

## usage

```bash
lxc network -h  
Description:
  Manage and attach instances to networks

Usage:
  lxc network [flags]
  lxc network [command]

Available Commands:
  acl              Manage network ACLs
  attach           Attach network interfaces to instances
  attach-profile   Attach network interfaces to profiles
  create           Create new networks
  delete           Delete networks
  detach           Detach network interfaces from instances
  detach-profile   Detach network interfaces from profiles
  edit             Edit network configurations as YAML
  forward          Manage network forwards
  get              Get values for network configuration keys
  info             Get runtime information on networks
  list             List available networks
  list-allocations List network allocations in use
  list-leases      List DHCP leases
  load-balancer    Manage network load balancers
  peer             Manage network peerings
  rename           Rename networks
  set              Set network configuration keys
  show             Show network configurations
  unset            Unset network configuration keys
  zone             Manage network zones
```

## delete network

```bash
lxc network detach-profile lxdbr0 default
lxc network delete lxdbr0 

For the sake of whoever will come here at a later time… actually the step "network delete <whatever came from list>" is not going to work for (at least) two reasons: (trivial) lxc network list will list all networks and you don’t want to delete them all. (less trivial) even after all containers/images are gone lxdbr0 network is still owned by default so an lxc network detach-profile lxdbr0 default is needed before lxc network delete lxdbr0. (nitpick) you forgot backticks around echo '{"config…

sudo ip link set lxdbr0 down
sudo brctl delbr lxdbr0


It works but after a reboot br0 is still up !

How to delete it for good ?

Thank you,
Max.
kaker
October 6th, 2020, 04:43 PM
Found it :

sudo nmcli connection delete lxdbr0

lxc network delete -h

lxc network delete -h
Description:
  Delete networks

Usage:
  lxc network delete [<remote>:]<network> [flags]

Aliases:
  delete, rm

Global Flag
      --debug          Show all debug messages
      --force-local    Force using the local unix socket
  -h, --help           Print help
      --project        Override the source project
  -q, --quiet          Don't show progress information
      --sub-commands   Use with help or --help to view sub-commands
  -v, --verbose        Show all information messages
      --version        Print version number
```

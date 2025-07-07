# **[How to set up OVN with LXD](https://documentation.ubuntu.com/lxd/stable-5.21/howto/network_ovn_setup/)**

See the following sections for how to set up a basic OVN network, either as a standalone network or to host a small LXD cluster.

## Set up a standalone OVN network

Complete the following steps to create a standalone OVN network that is connected to a managed LXD parent bridge network (for example, lxdbr0) for outbound connectivity.

Install the OVN tools on the local server:

`sudo apt install ovn-host ovn-central`

Configure the OVN integration bridge:

```bash
sudo ovs-vsctl set open_vswitch . \
   external_ids:ovn-remote=unix:/var/run/ovn/ovnsb_db.sock \
   external_ids:ovn-encap-type=geneve \
   external_ids:ovn-encap-ip=127.0.0.1
```

Create an OVN network:

```bash
lxc network set <parent_network> ipv4.dhcp.ranges=<IP_range> ipv4.ovn.ranges=<IP_range>
lxc network create ovntest --type=ovn network=<parent_network>
```

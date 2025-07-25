# **[How to configure an OVN underlay network](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/ovn_underlay/)**

For an explanation of the benefits of using an OVN underlay network, see **[Dedicated underlay network](https://documentation.ubuntu.com/microcloud/latest/microcloud/explanation/networking/#exp-networking-ovn-underlay)**.

When running microcloud init, if you chose to set up distributed networking and you have at least one network interface per cluster member with an IP address, MicroCloud asks if you want to configure an underlay network for OVN:

Configure dedicated underlay networking? (yes/no) [default=no]: <answer>

You can choose to skip this question (just hit Enter). MicroCloud then uses its internal network as an OVN ‘underlay’, which is the same as the OVN management network (‘overlay’ network).

You could also choose to configure a dedicated underlay network for OVN by typing yes. A list of available network interfaces with an IP address will be displayed. You can then select one network interface per cluster member to be used as the interfaces for the underlay network of OVN.

The following instructions build on the **[Get started with MicroCloud](https://documentation.ubuntu.com/microcloud/latest/microcloud/tutorial/get_started/#get-started)** tutorial and show how you can test setting up a MicroCloud with an OVN underlay network.

Create the dedicated network for the OVN underlay:

First, create a dedicated network for the OVN cluster members to be used as an underlay. Let’s call it ovnbr0:

```bash
lxc network create ovnbr0
```

Enter the following commands to find out the assigned IPv4 and IPv6 addresses for the networks and note them down:

```bash
lxc network get ovnbr0 ipv4.address
lxc network get ovnbr0 ipv6.address
```

Create the network interfaces that will be used for the OVN underlay setup for each VM:

Add the network device for the ovnbr0 network:

```bash
lxc config device add micro1 eth2 nic network=ovnbr0 name=eth2
lxc config device add micro2 eth2 nic network=ovnbr0 name=eth2
lxc config device add micro3 eth2 nic network=ovnbr0 name=eth2
lxc config device add micro4 eth2 nic network=ovnbr0 name=eth2
```

Now, just like in the tutorial, start the VMs.

On each VM, bring the network interfaces up and give them an IP address within their network subnet:

For the ovnbr0 network, do the following for each VM::

```bash
 # If the `ovnbr0` gateway address is `10.0.1.1/24` (subnet should be `10.0.1.0/24`)
 ip link set enp7s0 up
 # `X` should be a number between 2 and 254, different for each VM
 ip addr add 10.0.1.X/24 dev enp7s0
 ```

 Now, you can start the MicroCloud initialization process and provide the subnets you noted down when asked for the OVN underlay.

We will use ovnbr0 for the OVN underlay traffic. In a production setup, you’d choose the fast subnet for this traffic:

```bash
    Configure dedicated underlay networking? (yes/no) [default=no]: yes
    Select exactly one network interface from each cluster member:
    Space to select; enter to confirm; type to filter results.
    Up/down to move; right to select all; left to select none.
           +----------+--------+----------+-------------------------------------------+
           | LOCATION | IFACE  |   TYPE   |             IP ADDRESS (CIDR)             |
           +----------+--------+----------+-------------------------------------------+
      [x]  | micro1   | enp7s0 | physical | 10.0.1.2/24                               |
      [ ]  | micro1   | enp7s0 | physical | fd42:5782:5902:5b9e:216:3eff:fe01:67af/64 |
      [x]  | micro3   | enp7s0 | physical | 10.0.1.4/24                               |
      [ ]  | micro3   | enp7s0 | physical | fd42:5782:5902:5b9e:216:3eff:fe36:d29c/64 |
    > [x]  | micro2   | enp7s0 | physical | 10.0.1.3/24                               |
      [ ]  | micro2   | enp7s0 | physical | fd42:5782:5902:5b9e:216:3eff:fedb:f04e/64 |
           +----------+--------+----------+-------------------------------------------+
```

The MicroCloud initialization process will now continue as usual and the OVN cluster will be configured with the underlay network you provided.

You can now inspect the OVN underlay setup:

Inspect the OVN southbound encapsulation parameters:

```bash
root@micro1:~#microovn.ovn-sbctl --columns=ip,type find Encap type=geneve
  ip                  : "10.77.55.2"
  type                : geneve
 
  ip                  : "10.77.55.4"
  type                : geneve
 
  ip                  : "10.77.55.3"
  type                : geneve
```

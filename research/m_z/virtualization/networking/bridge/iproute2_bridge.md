# **[Creating a bridge](https://wiki.archlinux.org/title/network_bridge)**

## summary

Compared the bridge I created to the bridge multipass makes below. the commented lines are the lines of the automatically generated bridge multipass makes when it enslaves the interface.  There are several differences so I let multipass create this bridge and then add a static ip address afterwards so we can still use the network interface from the host.

## With iproute2

This section describes the management of a network bridge using the ip tool from the iproute2 package, which is required by the base meta package.

Adding the main network interface
If you are doing this on a remote server, and the plan is to add the main network interface (e.g. eth0) to the bridge, first take note of the current network status:

```bash
ip address show eno3
8: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b8:ca:3a:6a:35:9a brd ff:ff:ff:ff:ff:ff
    altname enp1s0f2
    inet 10.1.3.172/22 brd 10.1.3.255 scope global dynamic noprefixroute eno3
       valid_lft 182918sec preferred_lft 182918sec
    inet6 fe80::4418:3ffb:954b:9cea/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

ip route show dev eno3

default via 10.1.1.205 proto dhcp metric 102 
10.1.0.0/22 proto kernel scope link src 10.1.0.138 metric 102 
```

For this example, this is the relevant info:

IP address attached to eno3: 10.1.0.138/22
Default gateway: 10.1.1.205
Bridge name: br-eno3

Initial setup for the bridge:

```bash
ip address del 10.2.3.4/8 dev eth0
# ip link add name br0 type bridge
sudo ip link add name mybr-eno3 type bridge
# show bridge details
ip -d link show mybr-eno3
# Show bridge details in a pretty JSON format (which is a good way to get bridge key-value pairs):
ip -j -p -d link how mybr-eno3
# NOTE: compared this bridge to the bridge multipass makes below. the commented lines are the lines of the automatically generated bridge multipass makes when it enslaves the interface
ip -j -p -d link show mybr-eno3
[ {
        # "flags": [ "BROADCAST","MULTICAST","UP","LOWER_UP" ],
        "flags": [ "BROADCAST","MULTICAST" ],
        # "operstate": "UP",
        "operstate": "DOWN",
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
                # "stp_state": 1,
                "stp_state": 0,
                # "root_port": 1,
                # "root_path_cost": 127,
                "root_port": 0,
                "root_path_cost": 0,
                # "gc_timer": 31.25,
                "gc_timer": 0.00,
            }
        },
        # "inet6_addr_gen_mode": "none",
        "inet6_addr_gen_mode": "eui64",
    } ]

# ip link set dev br0 up DONT DO THIS YET
sudo ip link set dev mybr-eno3 up

# ip address add 10.2.3.4/8 dev br0
sudo ip address add 10.1.0.138/22 dev mybr-eno3
NOTE: at this step the ssh connection hangs.

# ip route append default via 10.0.0.1 dev br0
sudo ip route append default via 10.1.1.205 dev mybr-eno3
```

Then, execute these commands in quick succession. It is advisable to put them in a script file and execute the script:

```bash
ip link set eno3 master mybr-eno3

Linux bridging has supported STP since the 2.4 and 2.6 kernel series. To enable STP on a bridge, enter:

# ip link set br0 type bridge stp_state 1
ip link set mybr-eno3 type bridge stp_state 1

# ip address del 10.2.3.4/8 dev eth0
ip address del 10.1.0.138/22 dev en03
```

To add an interface (e.g. eth1) into the bridge, its state must be up:

```bash
# ip link set eth1 up
ip link set eno3 up
```

Adding the interface into the bridge is done by setting its master to bridge_name:

```bash
# ip link set eth1 master bridge_name
ip link set eno3 master br-eno3
```

To show the existing bridges and associated interfaces, use the bridge utility (also part of iproute2). See bridge(8) for details.

```bash
# bridge link
bridge link show dev eno3   
7: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br-eno3 state forwarding priority 32 cost 100 
```

This is how to remove an interface from a bridge:

```bash
# ip link set en03 nomaster
```

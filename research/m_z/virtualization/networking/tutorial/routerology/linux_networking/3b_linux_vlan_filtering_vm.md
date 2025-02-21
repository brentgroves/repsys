# **[Linux VLAN Filtering](https://www.youtube.com/watch?v=a8ghZoBZcE0&list=PLmZU6NElARbZtvrVbfz9rVpWRt5HyCeO7&index=3)**

**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Status](../../../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../../../README.md)**

## references

- **[Linux Networking](https://www.youtube.com/@routerologyblog1111/playlists)**

## netfilter subsystem hooks

![pf](https://people.netfilter.org/pablo/nf-hooks.png)

The following hooks represent these well-defined points in the networking stack:

- **NF_IP_PRE_ROUTING:** This hook will be triggered by any incoming traffic very soon after entering the network stack. This hook is processed before any routing decisions have been made regarding where to send the packet.
- **NF_IP_LOCAL_IN:** This hook is triggered after an incoming packet has been routed if the packet is destined for the local system.
- **NF_IP_FORWARD:** This hook is triggered after an incoming packet has been routed if the packet is to be forwarded to another host.
- **NF_IP_LOCAL_OUT:** This hook is triggered by any locally created outbound traffic as soon as it hits the network stack.
- **NF_IP_POST_ROUTING:** This hook is triggered by any outgoing or forwarded traffic after routing has taken place and just before being sent out on the wire.

| Tables↓/Chains→               | PREROUTING | INPUT | FORWARD | OUTPUT | POSTROUTING |
|-------------------------------|------------|-------|---------|--------|-------------|
| (routing decision)            |            |       |         | ✓      |             |
| raw                           | ✓          |       |         | ✓      |             |
| (connection tracking enabled) | ✓          |       |         | ✓      |             |
| mangle                        | ✓          | ✓     | ✓       | ✓      | ✓           |
| nat (DNAT)                    | ✓          |       |         | ✓      |             |
| (routing decision)            | ✓          |       |         | ✓      |             |
| filter                        |            | ✓     | ✓       | ✓      |             |
| security                      |            | ✓     | ✓       | ✓      |             |
| nat (SNAT)                    |            | ✓     |         |        | ✓           |

## new setup

- default
  - br0
    - vth1 -> vth_1
    - vth2 -> vth_2
    - vth3 -> vth_3
    - vth4 -> vth_4
- netns ns1
  - vlan 10
    - vth_1, 192.168.10.1/24
- netns ns2
  - vlan 10
    - vth_2 192.168.10.2/24
- netns ns3
  - vlan 20
    - vth_3, 192.168.10.3/24
- netns ns4
  - vlan 20
    - vth_4, 192.168.10.4/24
- greenbox/ns

```bash
sudo su

# show devices in bridge br0
# If you have just completed 3_linux_vlan_tutorial then you should see 4 virtual ethernet interfaces in bridge.

bridge link show 
11: vth1@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 2 
13: vth2@if12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 2 
15: vth3@if14: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 2 
17: vth4@if16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 2 

...
vth(1-4)

# To show the VLAN traffic state, enable VLAN statistics (added in kernel 4.7) as follows:
ip link set br0 type bridge vlan_stats_enabled 1

# create ubuntu 24.04 server vm from virt-manager called greenbox
# select the br0 bridge device as the network.
# don't give it an ip address yet

bridge link show

# From greenbox
ip link show
lo
enp1s0

sudo su
ip link add name brgb type bridge
ip -c -j -p -d link show type bridge

ip -c -j -p -d link show brgb | grep vlan

# enable vlan filtering
ip link set brgb type bridge vlan_filtering 1

# To show the VLAN traffic state, enable VLAN statistics (added in kernel 4.7) as follows:

ip link set brgb type bridge vlan_stats_enabled 1
ip -c -j -p -d link show brgb | grep vlan

# put the greenbox network interface in a bridge
ip link set enp1s0 master brgb
ip link set enp1s0 up
ip link set brgb up
ip -c -br -j -p d link show 
bridge link show

# create virtual interface
ip link add name vthgb0 type veth peer vthgb_0
ip -c -br -j -p link show type veth

# create namespace
ip netns add nsgb0
ip link set dev vthgb_0 netns nsgb0

ip -n nsgb0 link set dev vthgb_0 up
ip -n nsgb0 address add 192.168.10.10/24 dev vthgb_0

bridge link show brgb0
ip link set dev vthgb0 master brgb
ip link set dev vthgb0 up

ip -c -br -j -p d link show 
bridge link show

# bridge vlan add dev veth2 vid 2 pvid untagged`
# The pvid parameter causes untagged frames to be assigned to this VLAN at ingress (veth2 to bridge), and the untagged parameter causes the packet to be untagged on egress (bridge to veth2):
bridge vlan add vid 10 dev vthgb pvid untagged
bridge vlan add vid 10 dev enp1s0 pvid untagged
bridge vlan del vid 1 dev brgb self 
bridge vlan del vid 1 dev enp1s0

# from host
bridge vlan add vid 10 dev vnet10 pvid untagged
bridge vlan del vid 1 dev vnet10

ip netns exec ns1 ping 192.168.10.4

# vlan filtering is not enabled
ip -c -j -p -d link show br0 | grep vlan

9: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 42:86:f0:20:a4:84 brd ff:ff:ff:ff:ff:ff promiscuity 0  allmulti 0 minmtu 68 maxmtu 65535 
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.42:86:f0:20:a4:84 designated_root 8000.42:86:f0:20:a4:84 root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer    0.00 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 no_linklocal_learn 0 mcast_vlan_snooping 0 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 

ip link set dev br0 type bridge help

# bridge vlan help
# Usage: bridge vlan { add | del } vid VLAN_ID dev DEV [ tunnel_info id TUNNEL_ID ]
# [ pvid ] [ untagged ] parameters pvid any frame that enters this interface untagged will be put in this vlan,

#  [ self ] [ master ]
# master use this when not bridge itself, br0, is the default
# self when configuring bridge itself

# The following command, similar to the previous one, makes the veth2 bridge port transmit VLAN 2 data. The pvid parameter causes untagged frames to be assigned to this VLAN at ingress (veth2 to bridge), and the untagged parameter causes the packet to be untagged on egress (bridge to veth2):

# bridge vlan add dev veth2 vid 2 pvid untagged`
# The pvid parameter causes untagged frames to be assigned to this VLAN at ingress (veth2 to bridge), and the untagged parameter causes the packet to be untagged on egress (bridge to veth2):


bridge vlan add vid 10 dev vth1 pvid untagged
# master is not necessary here
bridge vlan add vid 10 dev vth2 pvid untagged master

bridge vlan show
port              vlan-id  
virbr0            1 PVID Egress Untagged
lxcbr0            1 PVID Egress Untagged
lxdbr0            1 PVID Egress Untagged
tapd957706b       1 PVID Egress Untagged
br0               1 PVID Egress Untagged
vth1              1 Egress Untagged
                  10 PVID Egress Untagged
vth2              1 Egress Untagged
                  10 PVID Egress Untagged
vth3              1 PVID Egress Untagged
vth4              1 PVID Egress Untagged

# enable vlan filtering
ip -d link show br0 | grep vlan_filterin
ip link set br0 type bridge vlan_filtering 1
# vth1 can communicate with vth2 because they share a common vlan
ip netns exec ns1 ping 192.168.10.4

bridge vlan del vid 1 dev vth1
bridge vlan del vid 1 dev vth2
bridge vlan del vid 1 dev vth3
bridge vlan del vid 1 dev vth4

# if you want to delete vid 1 from the bridge you must add the self keyword.
bridge vlan del vid 1 dev br0 self

# tag on ingress untag on egress
bridge vlan add vid 10 dev vth4 pvid untagged

bridge vlan show
port              vlan-id  
port              vlan-id  
virbr0            1 PVID Egress Untagged
lxcbr0            1 PVID Egress Untagged
lxdbr0            1 PVID Egress Untagged
tapd957706b       1 PVID Egress Untagged
vth1              10 PVID Egress Untagged
vth2              10 PVID Egress Untagged
vth4              10 PVID Egress Untagged

ip netns exec ns1 ping 192.168.10.3
# fails
ip netns exec ns1 ping 192.168.10.4

bridge vlan add vid 10 dev vth3 pvid untagged
# The pvid parameter causes untagged frames to be assigned to this VLAN at ingress (veth2 to bridge), and the untagged parameter causes the packet to be untagged on egress (bridge to veth2):

ip netns exec ns1 ping 192.168.10.3
# works now

bridge fdb show dynamic
00:16:3e:46:a8:a7 dev tapd957706b vlan 1 master lxdbr0 
92:99:9b:e4:da:1a dev vth1 vlan 10 master br0 
fe:bc:30:9c:dd:64 dev vth3 vlan 10 master br0 

# change vid
bridge vlan add vid 30 dev vth3 pvid untagged
bridge vlan add vid 20 dev vth3 pvid untagged
bridge vlan add vid 20 dev vth4 pvid untagged
bridge vlan del vid 30 dev vth3

bridge vlan show
port              vlan-id  
virbr0            1 PVID Egress Untagged
lxcbr0            1 PVID Egress Untagged
lxdbr0            1 PVID Egress Untagged
tapd957706b       1 PVID Egress Untagged
vth1              10 PVID Egress Untagged
vth2              10 PVID Egress Untagged
vth3              20 PVID Egress Untagged
vth4              20 PVID Egress Untagged

# test
# does not work
ip netns exec ns1 ping 192.168.10.4
# allowed
ip netns exec ns3 ping 192.168.10.4

 bridge fdb show dynamic
00:16:3e:46:a8:a7 dev tapd957706b vlan 1 master lxdbr0 
92:99:9b:e4:da:1a dev vth1 vlan 10 master br0 
f6:69:7c:7a:9b:ea dev vth2 vlan 10 master br0 
fe:bc:30:9c:dd:64 dev vth3 vlan 20 master br0 
26:25:dc:ec:90:fe dev vth4 vlan 20 master br0 

bridge vlan help
Usage: bridge vlan { add | del } vid VLAN_ID dev DEV [ tunnel_info id TUNNEL_ID ]
[ pvid ] [ untagged ]
[ self ] [ master ]
# stopped at 10:41

## original setup

default
- veth1
- veth2
- br0
ns1
- veth_1 peer to veth1
- 192.168.1.50
ns2
- veth_2 peer to veth2
- 192.168.1.51

```bash
```

# **[Linux Bridging Part 1](https://www.youtube.com/watch?v=oVu0O0UMBCc&list=PLmZU6NElARbZtvrVbfz9rVpWRt5HyCeO7)**


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


## configuration 

vth_2 is peer interface for vth2 - br0 - vth1's peer interface is vth_1

default namespace:
- vth2
- br0
- vth1
namespace ns1:
- vth_2 peer interfaces
- 192.168.10.2/24
namespace ns2:
- vth_1 peer interfaces
- 192.168.10.1/24

tools
- iproute2
  - ip link
  - bridge

## commands

```bash
# moto
sudo su
# -c is coloring
# -br is brief
ip -c -br link show 
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
enp0s31f6        UP             f4:8e:38:b7:1e:fd <BROADCAST,MULTICAST,UP,LOWER_UP> 
br-2c4c88ba5dfd  DOWN           02:42:ff:bd:27:1c <NO-CARRIER,BROADCAST,MULTICAST,UP> 
docker0          DOWN           02:42:7f:e9:b2:91 <NO-CARRIER,BROADCAST,MULTICAST,UP> 

ip link add name br0 type bridge
ip -c -br link show 
ip -c link show # more details
```



# **[Kubernetes Networking](https://www.tigera.io/learn/guides/kubernetes-networking/)**

## references

<https://www.tigera.io/learn/guides/kubernetes-networking/>
<https://docs.tigera.io/calico/latest/about/>
<https://opensource.com/article/22/6/kubernetes-networking-fundamentals>

## **[A visual guide to Kubernetes networking fundamentals](https://opensource.com/article/22/6/kubernetes-networking-fundamentals)**

Networking within Kubernetes isn't so different from networking in the physical world. Remember networking basics, and you'll have no trouble enabling communication between containers, Pods, and Services.

Moving from physical networks using switches, routers, and ethernet cables to virtual networks using software-defined networks (SDN) and virtual interfaces involves a slight learning curve. Of course, the principles remain the same, but there are different specifications and best practices. Kubernetes has its own set of rules, and if you're dealing with containers and the cloud, it helps to understand how Kubernetes networking works.

The Kubernetes Network Model has a few general rules to keep in mind:

- Every Pod gets its own IP address: There should be no need to create links between Pods and no need to map container ports to host ports.
- NAT is not required: Pods on a node should be able to communicate with all Pods on all nodes without NAT.
- Agents get all-access passes: Agents on a node (system daemons, Kubelet) can communicate with all the Pods in that node.
- Shared namespaces: Containers within a Pod share a network namespace (IP and MAC address), so they can communicate with each other using the loopback address.

## **[Kubernetes Networking: The Complete Guide](https://www.tigera.io/learn/guides/kubernetes-networking)**

Kubernetes defines a network model that helps provide simplicity and consistency across a range of networking environments and network implementations. The Kubernetes network model provides the foundation for understanding how containers, pods, and services within Kubernetes communicate with each other. This guide explains the key concepts and how they fit together.

This is part of an extensive series of guides about **[Kubernetes](https://komodor.com/learn/kubernetes/)**.

In this guide, you will learn:

The fundamental network behaviors the Kubernetes network model defines

- How Kubernetes works with a variety of different network implementations
- What Kubernetes services are
- How DNS works within Kubernetes
- What “NAT outgoing” is and when you would want to use it
- What “dual stack” is

## Dual stack

If you want to use a mix of IPv4 and IPv6, you can enable Kubernetes dual-stack mode. When enabled, all pods will be assigned both an IPv4 and IPv6 address, and Kubernetes services can specify whether they should be exposed as IPv4 or IPv6 addresses.

## The Kubernetes network model

The Kubernetes network model specifies:

- Every pod gets its own IP address
- Containers within a pod share the pod IP address and can communicate freely with each other
- Pods can communicate with all other pods in the cluster using pod IP addresses (without NAT)
- Isolation (restricting what each pod can communicate with) is defined using network policies

As a result, pods can be treated much like VMs or hosts (they all have unique IP addresses), and the containers within pods can be treated like processes running within a VM or host (they run in the same network namespace and share an IP address). This model makes it easier for applications to be migrated from VMs and hosts to pods managed by Kubernetes. In addition, because isolation is defined using network policies rather than the structure of the network, the network remains simple to understand. This style of network is sometimes referred to as a “flat network.”

A flat network is a type of network architecture where all the devices in the data center can reach each other without having to go through intermediary devices like routers.

In a flat network, all devices are linked to a single switch, meaning that all the workstations connected to the flat network are part of the same network segment. Since all devices are connected to a single switch, it becomes one of the easiest network designs to manage. It is also very cost-effective.

Intermediate System to Intermediate System (IS-IS), Interior Gateway Routing Protocol (IGRP), and Routing Information Protocol (RIP) are some examples of flat network routing protocols.

Note that, although very rarely needed, Kubernetes does also support the ability to map host ports through to pods, or to run pods directly within the host network namespace sharing the host’s IP address.

## Kubernetes network implementations

Kubernetes’s built-in network support, kubenet, can provide some basic network connectivity. However, it is more common to use third-party network implementations that plug into Kubernetes using the CNI (Container Network Interface) API.

There are lots of different kinds of CNI plugins, but the two main ones are:

- Network plugins, which are responsible for connecting pods to the network
- IPAM (IP Address Management) plugins, which are responsible for allocating pod IP addresses

Calico provides both network and IPAM plugins, but can also integrate and work seamlessly with some other CNI plugins, including AWS, Azure, and Google network CNI plugins, in addition to the host local IPAM plugin. This flexibility allows you to choose the best networking options for your specific needs and deployment environment.

## What is Calico?

Calico is a networking and security solution that enables Kubernetes workloads and non-Kubernetes/legacy workloads to communicate seamlessly and securely.

Components and features
In Kubernetes, the default for networking traffic to/from pods is default-allow. If you do not lock down network connectivity using network policy, then all pods can communicate freely with other pods.

Calico consists of networking to secure network communication, and advanced network policy to secure cloud-native microservices/applications at scale.

| Component                                      | Description                                                                                                                                                                                                                                                                                                                                                                                                             | Main features                                                                                                                                                                                                                                                                                                                                                                                                        |
|------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Calico CNI for networking                      | Calico CNI is a control plane that programs several dataplanes. It is an L3/L4 networking solution that secure containers, Kubernetes clusters, virtual machines, and native host-based workloads.                                                                                                                                                                                                                      | • Built-in data encryption • Advanced IPAM management • Overlay and non-overlay networking options • Choice of dataplanes: iptables, eBPF, Windows HNS, or VPP                                                                                                                                                                                                                                                       |
| Calico network policy suite for network policy | Calico network policy suite is an interface to the Calico CNI that contains rules for the dataplane to execute.  Calico network policy: • Is designed with a zero-trust security model (deny-all, allow only where needed) • Integrates with the Kubernetes API server (so you can still use Kubernetes network policy) •  Supports legacy systems (bare metal, non-cluster hosts) using the same network policy model. | • Namespace and global policy to allow/deny traffic within a cluster, between pods and the outside world, and for non-cluster hosts.  • Network sets (an arbitrary set of IP subnetworks, CIDRs, or domains) to limit IP ranges for egress and ingress traffic to workloads.  • Application layer (L7) policy to enforce traffic using attributes like HTTP methods, paths, and cryptographically-secure identities. |

## Feature summary

The following table summarizes the main Calico features. To search for specific features, see Product comparison.

| Feature                   | Description                                                                                                     |
|---------------------------|-----------------------------------------------------------------------------------------------------------------|
| Dataplanes                | eBPF, standard Linux iptables, Windows HNS, VPP.                                                                |
| Networking                | • Scalable pod networking using BGP or overlay networking • Advanced IP address management that is customizable |
| Security                  | • Network policy enforcement for workload and host endpoints • Data-in-transit encryption using WireGuard       |
| Monitor Calico components | Uses Prometheus to monitor Calico component metrics.                                                            |
| User interfaces           | CLIs: kubectl and calicoctl                                                                                     |
| APIs                      | • Calico API for Calico resources • Installation API for operator installation and configuration                |
| Support and maintenance   | Community-driven. Calico powers 2M+ nodes daily across 166 countries.                                           |

## OSI Networking Model

## What are the differences between the **[L2, L3, and L4 protocols](https://www.quora.com/What-are-the-differences-between-the-L2-L3-and-L4-protocols)**?

- **Layer Focus**: L2: Local network communication, data frames, and MAC addressing.L3: Inter-network communication, logical addressing (IP), and routing.L4: End-to-end communication, data segmentation, error handling, and port-based addressing.
- **Addressing**: L2: Uses MAC addresses for physical device identification within the local network.L3: Uses IP addresses for logical device identification, allowing routing between networks.L4: Utilizes port numbers to distinguish different services on a device.
- **Communication** Scope:L2: Local network (e.g., LAN) communication.L3: Inter-network (e.g., internet) communication.L4: End-to-end communication across networks.
- **Error Handling**:L2: Basic error detection (CRC), but limited error correction capabilities.L3: No error handling, but relies on L4 for error detection (e.g., ICMP for error reporting).L4: Provides error detection and correction (e.g., TCP's acknowledgment and retransmission mechanisms).

![](https://cf-assets.www.cloudflare.com/slt3lc6tev37/6ZH2Etm3LlFHTgmkjLmkxp/59ff240fb3ebdc7794ffaa6e1d69b7c2/osi_model_7_layers.png)

## **[The purpose of a VLAN](https://www.techtarget.com/searchnetworking/definition/virtual-LAN)**

Network engineers use VLANs for multiple reasons, including the following:

- to improve performance
- to tighten security
- to ease administration

![](https://cdn.ttgtmedia.com/rms/onlineimages/how_a_virtual_lan_works-f.png)

## Types of VLANs

VLANs can be port-based (sometimes called static) or use-based (sometimes called dynamic).

## Port-based or static VLAN

Network engineers create port-based VLANs by assigning ports on a network switch to a VLAN. Those ports only communicate on the assigned VLANs, and each port is on one VLAN only. While port-based VLANs are sometimes called static VLANs, it's important to remember they aren't truly static because the VLANs assigned to the port can be changed on the fly, manually or by network automation.

## Use-based or dynamic VLAN

Network engineers create use-based VLANs by assigning traffic to a VLAN dynamically, based on the traffic type or the device creating the traffic. A port might be assigned to a VLAN based on the identity of the device attached -- as indicated by a security certificate -- or on the network protocols in use. One port can be associated with multiple dynamic VLANs. Changing which device is connected through a port, or even how the existing device is used, might change the VLAN assigned to the port.

## How VLANs work

A VLAN is identified on network switches by a VLAN ID. Each port on a switch can have one or more VLAN IDs assigned to it and will land in a default VLAN if no other one is assigned. Each VLAN provides data-link access to all hosts connected to switch ports configured with its VLAN ID.

A VLAN ID is translated to a VLAN tag, a 12-bit field in the header data of every Ethernet frame sent to that VLAN. Because a tag is 12 bits long, up to 4,096 VLANs can be defined per switching domain. VLAN tagging is defined by IEEE in the 802.1Q standard.

When an Ethernet frame is received from an attached host, it has no VLAN tag. The switch adds the VLAN tag. In a static VLAN, the switch inserts the tag associated with the ingress port's VLAN ID. In a dynamic VLAN, it inserts the tag associated with that device's ID or the type of traffic it generates.

Switches forward tagged frames toward their destination media access control address, forwarding only to ports with which the VLAN is associated. Broadcast, unknown unicast and multicast traffic is forwarded to all ports in the VLAN. Trunk links between switches know which VLANs span the switches, accepting and passing along all traffic for any VLAN in use on both sides of the trunk. When a frame reaches its destination switch port, the VLAN tag is removed before the frame is transmitted to the destination device.

Spanning Tree Protocol (STP) is used to create loop-free topology among the switches in each Layer 2 domain. A per-VLAN STP instance can be used, which enables different Layer 2 topologies. A multi-instance STP can also be used to reduce STP overhead if the topology is the same among multiple VLANs.

## K8s mappings to OSI Model

## MetalLB for K8s

MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols. It will monitor for services with the type LoadBalancer and assign them an IP address from a virtual pool.

## **[METALLB IN LAYER 2 MODE](https://metallb.universe.tf/concepts/layer2/)**

## Configure Metallb to Layer 2 mode

In layer 2 mode, one node assumes the responsibility of advertising a service to the local network. From the network’s perspective, it simply looks like that machine has multiple IP addresses assigned to its network interface.

Under the hood, MetalLB responds to ARP requests for IPv4 services, and NDP requests for IPv6.

The major advantage of the layer 2 mode is its universality: it will work on any Ethernet network, with no special hardware required, not even fancy routers.

- Load-Balancing Behavior

In layer 2 mode, all traffic for a service IP goes to one node. From there, kube-proxy spreads the traffic to all the service’s pods.

In that sense, layer 2 does not implement a load balancer. Rather, it implements a failover mechanism so that a different node can take over should the current leader node fail for some reason.

If the leader node fails for some reason, failover is automatic: the failed node is detected using memberlist, at which point new nodes take over ownership of the IP addresses from the failed node.

## Limitations

Layer 2 mode has two main limitations you should be aware of: single-node bottlenecking, and potentially slow failover.

As explained above, in layer2 mode a single leader-elected node receives all traffic for a service IP. This means that your service’s ingress bandwidth is limited to the bandwidth of a single node. This is a fundamental limitation of using ARP and NDP to steer traffic.

In the current implementation, failover between nodes depends on cooperation from the clients. When a failover occurs, MetalLB sends a number of gratuitous layer 2 packets (a bit of a misnomer - it should really be called “unsolicited layer 2 packets”) to notify clients that the MAC address associated with the service IP has changed.

Most operating systems handle “gratuitous” packets correctly, and update their neighbor caches promptly. In that case, failover happens within a few seconds. However, some systems either don’t implement gratuitous handling at all, or have buggy implementations that delay the cache update.

All modern versions of major OSes (Windows, Mac, Linux) implement layer 2 failover correctly, so the only situation where issues may happen is with older or less common OSes.

To minimize the impact of planned failover on buggy clients, you should keep the old leader node up for a couple of minutes after flipping leadership, so that it can continue forwarding traffic for old clients until their caches refresh.

During an unplanned failover, the service IPs will be unreachable until the buggy clients refresh their cache entries.

If you encounter a situation where layer 2 mode failover is slow (more than about 10s), please file a bug! We can help you investigate and determine if the issue is with the client, or a bug in MetalLB.

# **[Metallb BPG mode](https://metallb.universe.tf/concepts/bgp/)**

## METALLB IN BGP MODE

In BGP mode, each node in your cluster establishes a BGP peering session with your network routers, and uses that peering session to advertise the IPs of external cluster services.

Assuming your routers are configured to support **[multipath](https://en.wikipedia.org/wiki/Multipath_routing#:~:text=Multipath%20routing%20is%20a%20routing,increased%20bandwidth%2C%20and%20improved%20security.)**, this enables true load balancing: the routes published by MetalLB are equivalent to each other, except for their nexthop. This means that the routers will use all nexthops together, and load balance between them.

After the packets arrive at the node, kube-proxy is responsible for the final hop of traffic routing, to get the packets to one specific pod in the service.

- **Multipath routing** is a routing technique simultaneously using multiple alternative paths through a network. This can yield a variety of benefits such as fault tolerance, increased bandwidth, and improved security.

## Load-Balancing Behavior

The exact behavior of the load balancing depends on your specific router model and configuration, but the common behavior is to balance per-connection, based on a packet hash. What does this mean?

Per-connection means that all the packets for a single TCP or UDP session will be directed to a single machine in your cluster. The traffic spreading only happens between different connections, not for packets within one connection.

This is a good thing, because spreading packets across multiple cluster nodes would result in poor behavior on several levels:

- Spreading a single connection across multiple paths results in packet reordering on the wire, which drastically impacts performance at the end host.
- On-node traffic routing in Kubernetes is not guaranteed to be consistent across nodes. This means that two different nodes could decide to route packets for the same connection to different pods, which would result in connection failures.

**[Packet hashing]** is how high-performance routers can statelessly spread connections across multiple backends. For each packet, they extract some of the fields, and use those as a “seed” to deterministically pick one of the possible backends. If all the fields are the same, the same backend will be chosen.

The exact hashing methods available depend on the router hardware and software. Two typical options are 3-tuple and 5-tuple hashing. 3-tuple uses (protocol, source-ip, dest-ip) as the key, meaning that all packets between two unique IPs will go to the same backend. 5-tuple hashing adds the source and destination ports to the mix, which allows different connections from the same clients to be spread around the cluster.

In general, it’s preferable to put as much entropy as possible into the packet hash, meaning that using more fields is generally good. This is because increased entropy brings us closer to the “ideal” load-balancing state, where every node receives exactly the same number of packets. We can never achieve that ideal state because of the problems we listed above, but what we can do is try and spread connections as evenly as possible, to try and prevent hotspots from forming.

## MetalLB BPG Mode Limitations

Using BGP as a load-balancing mechanism has the advantage that you can use standard router hardware, rather than bespoke load balancers. However, this comes with downsides as well.

The biggest downside is that BGP-based load balancing does not react gracefully to changes in the backend set for an address. What this means is that when a cluster node goes down, you should expect all active connections to your service to be broken (users will see “Connection reset by peer”).

BGP-based routers implement stateless load balancing. They assign a given packet to a specific next hop by hashing some fields in the packet header, and using that hash as an index into the array of available backends.

The problem is that the hashes used in routers are usually not stable, so whenever the size of the backend set changes (for example when a node’s BGP session goes down), existing connections will be rehashed effectively randomly, which means that the majority of existing connections will end up suddenly being forwarded to a different backend, one that has no knowledge of the connection in question.

The consequence of this is that any time the IP→Node mapping changes for your service, you should expect to see a one-time hit where most active connections to the service break. There’s no ongoing packet loss or blackholing, just a one-time clean break.

Depending on what your services do, there are a couple of mitigation strategies you can employ:

- Your BGP routers might have an option to use a more stable ECMP hashing algorithm. This is sometimes called “resilient ECMP” or “resilient LAG”. Using such an algorithm hugely reduces the number of affected connections when the backend set changes.
- Pin your service deployments to specific nodes, to minimize the pool of nodes that you have to be “careful” about.
- Schedule changes to your service deployments during “trough”, when most of your users are asleep and your traffic is low.
- Split each logical service into two Kubernetes services with different IPs, and use DNS to gracefully migrate user traffic from one to the other prior to disrupting the “drained” service.
- Add transparent retry logic on the client side, to gracefully recover from sudden disconnections. This works especially well if your clients are things like mobile apps or rich single-page web apps.
- Put your services behind an ingress controller. The ingress controller itself can use MetalLB to receive traffic, but having a stateful layer between BGP and your services means you can change your services without concern. You only have to be careful when changing the deployment of the ingress controller itself (e.g. when adding more NGINX pods to scale up).
- Accept that there will be occasional bursts of reset connections. For low-availability internal services, this may be acceptable as-is.

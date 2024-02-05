# NAT

## references

<https://www.tigera.io/learn/guides/kubernetes-networking/#NAT-outgoing>

## **[NAT outgoing](https://www.tigera.io/learn/guides/kubernetes-networking/#NAT-outgoing)**

The Kubernetes network model specifies that pods must be able to communicate with each other directly using pod IP addresses. But it does not mandate that pod IP addresses are routable beyond the boundaries of the cluster. Many Kubernetes network implementations use overlay networks. Typically for these deployments, when a pod initiates a connection to an IP address outside of the cluster, the node hosting the pod will use SNAT (Source Network Address Translation) to map the source address of the packet from the pod IP to the node IP. This enables the connection to be routed across the rest of the network to the destination (because the node IP is routable). Return packets on the connection are automatically mapped back by the node, replacing the node IP with the pod IP before forwarding the packet to the pod.

When using Calico, depending on your environment, you can generally choose whether you prefer to run an overlay network or have fully routable pod IPs. You can read more about this in the Calico determine best networking option guide. Calico also allows you to configure outgoing NAT for specific IP address ranges if more granularity is desired.

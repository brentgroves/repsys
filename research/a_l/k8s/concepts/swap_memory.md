# **[swap memory](https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Swap memory management

FEATURE STATE: Kubernetes v1.30 [beta]

To enable swap on a node, the NodeSwap feature gate must be enabled on the kubelet (default is true), and the --fail-swap-on command line flag or failSwapOn configuration setting must be set to false. To allow Pods to utilize swap, swapBehavior should not be set to NoSwap (which is the default behavior) in the kubelet config.

## Warning

When the memory swap feature is turned on, Kubernetes data such as the content of Secret objects that were written to tmpfs now could be swapped to disk.

A user can also optionally configure memorySwap.swapBehavior in order to specify how a node will use swap memory. For example,

```yaml
memorySwap:
  swapBehavior: LimitedSwap
```

- NoSwap (default): Kubernetes workloads will not use swap.
- LimitedSwap: The utilization of swap memory by Kubernetes workloads is subject to limitations. Only Pods of Burstable QoS are permitted to employ swap.

If configuration for memorySwap is not specified and the feature gate is enabled, by default the kubelet will apply the same behaviour as the NoSwap setting.

With LimitedSwap, Pods that do not fall under the Burstable QoS classification (i.e. BestEffort/Guaranteed Qos Pods) are prohibited from utilizing swap memory. To maintain the aforementioned security and node health guarantees, these Pods are not permitted to use swap memory when LimitedSwap is in effect.

Prior to detailing the calculation of the swap limit, it is necessary to define the following terms:

- nodeTotalMemory: The total amount of physical memory available on the node.
- totalPodsSwapAvailable: The total amount of swap memory on the node that is available for use by Pods (some swap memory may be reserved for system use).
- containerMemoryRequest: The container's memory request.

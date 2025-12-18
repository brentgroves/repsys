# **[k8s releases](https://www.infoq.com/news/2024/01/kubernetes-1-29/)**

Kubernetes 1.29 Released with KMS V2 Improvements and nftables Support

The Cloud Native Computing Foundation (CNCF) released Kubernetes 1.29, named Mandala, last month. The latest release introduced features such as load balancer IP mode for services, mutable pod resources for Windows containers, and nftables for the kube-proxy.

Some features have been elevated to beta, such as sidecar containers and the separation of the node lifecycle controller from taint management.

There are several stable or generally available features in this release, such as KMS v2 encryption at rest and the addition of a new access mode called ReadWriteOncePod for persistent volumes.

In version 1.29, in-tree integrations with cloud providers are removed and the .status.kubeProxyVersion field for node objects is now deprecated.

In the new release, a new backend to the kube-proxy based on nftables is introduced. This is added because some Linux distributions are on their way to deprecate and remove iptables. Also, this is to address some of the performance problems of iptables, the default implementation of the kube-proxy.

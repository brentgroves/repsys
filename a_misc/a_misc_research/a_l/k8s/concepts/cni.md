# **[Kubernetes CNI Explained](https://www.tigera.io/learn/guides/kubernetes-networking/kubernetes-cni/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What Is a Container Network Interface (CNI)?
Container Network Interface (CNI) is a framework for dynamically configuring networking resources. It uses a group of libraries and specifications written in Go. The plugin specification defines an interface for configuring the network, provisioning IP addresses, and maintaining connectivity with multiple hosts.

When used with Kubernetes, CNI can integrate smoothly with the kubelet to enable the use of an overlay or underlay network to automatically configure the network between pods. Overlay networks encapsulate network traffic using a virtual interface such as Virtual Extensible LAN (VXLAN). Underlay networks work at the physical level and comprise switches and routers.

Once you’ve specified the type of network configuration type, the container runtime defines the network that containers join. The runtime adds the interface to the container namespace via a call to the CNI plugin and allocates the connected subnetwork routes via calls to the IP Address Management (IPAM) plugin.

CNI supports Kubernetes networking, and can also be used with other Kubernetes-based container orchestration platforms such as OpenShift. CNI uses a software-defined networking (SDN) approach to unify container communication throughout clusters.
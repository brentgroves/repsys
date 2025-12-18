# **[container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Container Runtimes

Note: Dockershim has been removed from the Kubernetes project as of release 1.24. Read the Dockershim Removal FAQ for further details.

You need to install a container runtime into each node in the cluster so that Pods can run there. This page outlines what is involved and describes related tasks for setting up nodes.

Kubernetes 1.30 requires that you use a runtime that conforms with the Container Runtime Interface (CRI).

See **[CRI version support](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cri-versions)** for more information.

This page provides an outline of how to use several common container runtimes with Kubernetes.

- **[containerd
CRI-O
Docker Engine
Mirantis Container Runtime

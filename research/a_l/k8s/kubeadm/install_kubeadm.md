# **[Install Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)**

## references

- **[kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)**

## Installing kubeadm

This page shows how to install the kubeadm toolbox. For information on how to create a cluster with kubeadm once you have performed this installation process, see the Creating a cluster with kubeadm page.

This installation guide is for Kubernetes v1.30. If you want to use a different Kubernetes version, please refer to the following pages instead:

## Before you begin

- A compatible Linux host. The Kubernetes project provides generic instructions for Linux distributions based on Debian and Red Hat, and those distributions without a package manager.
- 2 GB or more of RAM per machine (any less will leave little room for your apps).
- 2 CPUs or more.
- Full network connectivity between all machines in the cluster (public or private network is fine).
- Unique hostname, MAC address, and product_uuid for every node. See **[here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#verify-mac-address)** for more details.
- Certain ports are open on your machines. See **[here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports)** for more details.
- Swap configuration. The default behavior of a kubelet was to fail to start if swap memory was detected on a node. See **[Swap memory management](https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory)** for more details.
  - You MUST disable swap if the kubelet is not properly configured to use swap. For example, sudo swapoff -a will disable swapping temporarily. To make this change persistent across reboots, make sure swap is disabled in config files like /etc/fstab, systemd.swap, depending how it was configured on your system.

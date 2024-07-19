# **[Install Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)**

## references

- **[kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)**

## Installing kubeadm

This page shows how to install the kubeadm toolbox. For information on how to create a cluster with kubeadm once you have performed this installation process, see the **[Creating a cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)** page.

This installation guide is for Kubernetes v1.30. If you want to use a different Kubernetes version, please refer to the following pages instead:

## Before you begin

- A compatible Linux host. The Kubernetes project provides generic instructions for Linux distributions based on Debian and Red Hat, and those distributions without a package manager.
- 2 GB or more of RAM per machine (any less will leave little room for your apps).
- 2 CPUs or more.
- Full network connectivity between all machines in the cluster (public or private network is fine).
- Unique hostname, MAC address, and product_uuid for every node. See **[here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#verify-mac-address)** for more details.

```bash
ssh brent@repsys12
multipass shell repsys12-c1-n1
sudo cat /sys/class/dmi/id/product_uuid
46d89ce1-54f9-44ce-99a7-4b4d4137220c
```

- Certain ports are open on your machines. See **[here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports)** for more details.
- Swap configuration. The default behavior of a kubelet was to fail to start if swap memory was detected on a node. See **[Swap memory management](https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory)** for more details.
  - You MUST disable swap if the kubelet is not properly configured to use swap. For example, sudo swapoff -a will disable swapping temporarily. To make this change persistent across reboots, make sure swap is disabled in config files like /etc/fstab, systemd.swap, depending how it was configured on your system.

## Verify the MAC address and product_uuid are unique for every node

You can get the MAC address of the network interfaces using the command

```bash
ip link 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:d2:75:85 brd ff:ff:ff:ff:ff:ff
3: enp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:c6:66:bf brd ff:ff:ff:ff:ff:ff

ifconfig -a
```

The product_uuid can be checked by using the command:

```bash
sudo cat /sys/class/dmi/id/product_uuid
46d89ce1-54f9-44ce-99a7-4b4d4137220c
```

It is very likely that hardware devices will have unique addresses, although some virtual machines may have identical values. Kubernetes uses these values to uniquely identify the nodes in the cluster. If these values are not unique to each node, the installation process may fail.

## Check network adapters

If you have more than one network adapter, and your Kubernetes components are not reachable on the default route, we recommend you add IP route(s) so Kubernetes cluster addresses go via the appropriate adapter.

## Check required ports

These required ports need to be open in order for Kubernetes components to communicate with each other. You can use tools like netcat to check if a port is open. For example:

```bash
nc 127.0.0.1 6443 -v
```

The pod network plugin you use may also require certain ports to be open. Since this differs with each pod network plugin, please see the documentation for the plugins about what port(s) those need.

## Installing a container runtime

To run containers in Pods, Kubernetes uses a container runtime.

By default, Kubernetes uses the Container Runtime Interface (CRI) to interface with your chosen container runtime.

If you don't specify a runtime, kubeadm automatically tries to detect an installed container runtime by scanning through a list of known endpoints.

If multiple or no container runtimes are detected kubeadm will throw an error and will request that you specify which one you want to use.

See **[container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)** for more information.

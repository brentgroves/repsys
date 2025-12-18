# **[Installing MicroK8s Offline or in an airgapped environment](https://microk8s.io/docs/install-offline)**

## references

- **[What is Squid Proxy](https://wiki.squid-cache.org/)**
- **[config examples](https://wiki.squid-cache.org/ConfigExamples/)**
- **[services and ports](https://microk8s.io/docs/services-and-ports)**

There are situations where it is necessary or desirable to run MicroK8s on a machine not connected to the internet. This is possible, but there are a few extra things to be aware of, and some different strategies depending on the extend of separation from the network. This guide explains the necessary preparation required and the steps required for the potential scenarios.

## Prepare for deployment

The main things to consider when deploying MicroK8s in an airgap environment are:

1. Download the MicroK8s snap
From a machine that has access to the internet, download the core20 and microk8s snaps and assertion files.

NOTE: For MicroK8s versions 1.26 or earlier, the core18 snap is required instead.

```bash
sudo snap download microk8s --channel 1.27
sudo snap download core20
sudo mv microk8s_*.snap microk8s.snap
sudo mv microk8s_*.assert microk8s.assert
sudo mv core20_*.snap core20.snap
sudo mv core20_*.assert core20.assert
```

We will use core20.snap and microk8s.snap to install MicroK8s on the next steps. The core20.assert and microk8s.assert are the snap assertion files, required to verify the integrity of the snap packages.

## AI Overview: What core snap is needed for microk8s version 1.32

For MicroK8s version 1.32, you need the core20 snap as the base, not core18.

### MicroK8s and Snap

MicroK8s is a Kubernetes cluster delivered as a single snap package, meaning it relies on the snap package system for installation and management.

### Core Snap

The "core" snap is a foundational snap that provides the necessary environment for other snaps to run, including MicroK8s

#### Core Snap Versions

For MicroK8s versions 1.26 or earlier, the core18 snap was required, but for version 1.32 and later, you need the core20 snap.

## 2. Networking Requirements

Air-gap deployments are typically associated with a number of constraints and restrictions with the networking connectivity of the machines. Below we discuss the requirements that the deployment needs to fulfil.

### Verify networking access between machines for the Kubernetes services

Make sure that all cluster nodes are reachable from each other. Refer to Services and ports used for a list of all network ports used by MicroK8s.

### Ensure machines have a default gateway

Kubernetes services use the default interface of the machine for discovery reasons:

- kube-apiserver (part of kubelite) uses the default interface to advertise this address to other nodes in the cluster. Starting kube-apiserver without a default route will fail.
- kubelet (part of kubelite) uses the default interface to pick the node InternalIP address.
- A default gateway greatly simplifies the process of setting up the Calico CNI.

In case your airgap environment does not have a default gateway, you can add a dummy default route on interface eth0 using the following command:

```bash
ip route add default dev eth0
```

NOTE: The dummy gateway will only be used by the Kubernetes services to know which interface to use, actual connectivity to the internet is not required.

NOTE: Make sure that the dummy gateway rule survives a node reboot.

## (Optional) Ensure proxy access

This is only required if an HTTP proxy (e.g. squid) is used to allow limited access to image registries (e.g. docker.io, quay.io, rocks.canonical.com, etc) (see the **[Access to upstream registries via an HTTP proxy section below](https://microk8s.io/docs/install-offline#b-access-to-upstream-registries-via-an-http-proxy)**).

Ensure that all nodes can use the proxy to access the registry. For example, if using <http://squid.internal:3128> to access docker.io, an easy way to test connectivity is:

```bash
export https_proxy=<http://squid.internal:3128>
curl -v <https://registry-1.docker.io>
```

## 3. Images

All workloads in a Kubernetes cluster are running as an OCI image. Kubernetes needs to be able to fetch these images and load them into the container runtime, otherwise the cluster will be unable to run any workload. For a MicroK8s deployment, you will need to fetch the images used by the MicroK8s core (calico, coredns, etc) as well as any images that are needed to run your workloads.

For airgap deployments, there are 3 main options, ordered by ease of use.

NOTE: For a list of all images used by MicroK8s, see **[images.txt](https://github.com/canonical/microk8s/blob/master/build-scripts/images.txt)**. This is the list of core images required to bring up MicroK8s (e.g. CoreDNS, Calico CNI, etc). Make sure that you also include any images for the workloads that you intend to run on the cluster.

NOTE: Depending on the use case, more than one of the methods below may be required.

```bash
docker.io/calico/cni:v3.28.1
docker.io/calico/kube-controllers:v3.28.1
docker.io/calico/node:v3.28.1
docker.io/cdkbot/hostpath-provisioner:1.5.0
docker.io/coredns/coredns:1.12.0
docker.io/library/busybox:1.28.4
registry.k8s.io/ingress-nginx/controller:v1.12.0
registry.k8s.io/metrics-server/metrics-server:v0.7.2
registry.k8s.io/pause:3.10
```

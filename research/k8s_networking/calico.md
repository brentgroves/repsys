# Calico k8s

## references

<https://qdnqn.com/networking-on-kubernetes-calico-and-ebpf/>
<https://docs.tigera.io/calico/latest/about/>

## Kubernetes Network

Introduction
Kubernetes networking is a complex topic. There are multiple layers present — from the containers to the underlying infrastructure. Let’s dig in.

Kubernetes defined the network model and the network drivers are implementations of that model. In that way, you can have multiple network drivers implementing the model which makes it modularised. Similar thing to what Docker did.

What does that mean? It means Kubernetes is decoupled from network implementation and it is on the network driver to provide networking functionality but the network driver.

## What is **[Calico](https://docs.tigera.io/calico/latest/about/)**?

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

# **[Kubernetes Networking}(https://www.tigera.io/learn/guides/kubernetes-networking/)**

## references

<https://www.tigera.io/learn/guides/kubernetes-networking/>

## Kubernetes Networking: The Complete Guide

Kubernetes defines a network model that helps provide simplicity and consistency across a range of networking environments and network implementations. The Kubernetes network model provides the foundation for understanding how containers, pods, and services within Kubernetes communicate with each other. This guide explains the key concepts and how they fit together.

This is part of an extensive series of guides about **[Kubernetes](https://komodor.com/learn/kubernetes/)**.

In this guide, you will learn:

The fundamental network behaviors the Kubernetes network model defines
How Kubernetes works with a variety of different network implementations
What Kubernetes services are
How DNS works within Kubernetes
What “NAT outgoing” is and when you would want to use it
What “dual stack” is

## The Kubernetes network model

The Kubernetes network model specifies:

- Every pod gets its own IP address
- Containers within a pod share the pod IP address and can communicate freely with each other
- Pods can communicate with all other pods in the cluster using pod IP addresses (without NAT)
- Isolation (restricting what each pod can communicate with) is defined using network policies

As a result, pods can be treated much like VMs or hosts (they all have unique IP addresses), and the containers within pods can be treated like processes running within a VM or host (they run in the same network namespace and share an IP address). This model makes it easier for applications to be migrated from VMs and hosts to pods managed by Kubernetes. In addition, because isolation is defined using network policies rather than the structure of the network, the network remains simple to understand. This style of network is sometimes referred to as a “flat network.”

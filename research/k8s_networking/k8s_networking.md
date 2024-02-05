# **[Kubernetes Networking}(https://www.tigera.io/learn/guides/kubernetes-networking/)**

## references

<https://www.tigera.io/learn/guides/kubernetes-networking/>

## Kubernetes Networking: The Complete Guide

Kubernetes defines a network model that helps provide simplicity and consistency across a range of networking environments and network implementations. The Kubernetes network model provides the foundation for understanding how containers, pods, and services within Kubernetes communicate with each other. This guide explains the key concepts and how they fit together.

This is part of an extensive series of guides about **[Kubernetes](https://komodor.com/learn/kubernetes/)**.

In this guide, you will learn:

The fundamental network behaviors the Kubernetes network model defines

- How Kubernetes works with a variety of different network implementations
- What Kubernetes services are
- How DNS works within Kubernetes
- What “NAT outgoing” is and when you would want to use it
- What “dual stack” is

## Dual stack

If you want to use a mix of IPv4 and IPv6, you can enable Kubernetes dual-stack mode. When enabled, all pods will be assigned both an IPv4 and IPv6 address, and Kubernetes services can specify whether they should be exposed as IPv4 or IPv6 addresses.

## The Kubernetes network model

The Kubernetes network model specifies:

- Every pod gets its own IP address
- Containers within a pod share the pod IP address and can communicate freely with each other
- Pods can communicate with all other pods in the cluster using pod IP addresses (without NAT)
- Isolation (restricting what each pod can communicate with) is defined using network policies

As a result, pods can be treated much like VMs or hosts (they all have unique IP addresses), and the containers within pods can be treated like processes running within a VM or host (they run in the same network namespace and share an IP address). This model makes it easier for applications to be migrated from VMs and hosts to pods managed by Kubernetes. In addition, because isolation is defined using network policies rather than the structure of the network, the network remains simple to understand. This style of network is sometimes referred to as a “flat network.”

A flat network is a type of network architecture where all the devices in the data center can reach each other without having to go through intermediary devices like routers.

In a flat network, all devices are linked to a single switch, meaning that all the workstations connected to the flat network are part of the same network segment. Since all devices are connected to a single switch, it becomes one of the easiest network designs to manage. It is also very cost-effective.

Intermediate System to Intermediate System (IS-IS), Interior Gateway Routing Protocol (IGRP), and Routing Information Protocol (RIP) are some examples of flat network routing protocols.

Note that, although very rarely needed, Kubernetes does also support the ability to map host ports through to pods, or to run pods directly within the host network namespace sharing the host’s IP address.

## Kubernetes network implementations

Kubernetes’s built-in network support, kubenet, can provide some basic network connectivity. However, it is more common to use third-party network implementations that plug into Kubernetes using the CNI (Container Network Interface) API.

There are lots of different kinds of CNI plugins, but the two main ones are:

- Network plugins, which are responsible for connecting pods to the network
- IPAM (IP Address Management) plugins, which are responsible for allocating pod IP addresses

Calico provides both network and IPAM plugins, but can also integrate and work seamlessly with some other CNI plugins, including AWS, Azure, and Google network CNI plugins, in addition to the host local IPAM plugin. This flexibility allows you to choose the best networking options for your specific needs and deployment environment.

# **[pod sandboxing](https://samcogan.com/wth-is-pod-sandboxing-for-aks/)**

## What is Pod Sandboxing?

Containers and Virtual Machines differ in several ways, but one of the key areas is how the operating system kernel works. In a VM, each VM on a host gets a separate copy of the kernel, whereas with a container, all containers on a host share the same kernel. This is part of what makes containers so fast, small and flexible, but it brings issues, especially around security. If an attacker manages to compromise one container running on a host and get access to the kernel, it can likely get access to all the containers running on a host. This concerns anyone running hostile multi-tenanted workloads in containers and Kubernetes.

Pod Sandboxing is a solution to this problem, bringing a way to run a container with its own copy of the kernel rather than sharing it with the rest of the host. An attack on one container on the host will no longer compromise all containers on the host.

## How does Pod Sandboxing work?

Pod Sandboxing in AKS is based on a technology called Kata Containers. Kata Containers look and behave like containers, but wrap your container in a small, lightweight virtual machine. This virtual machine has its own kernel that is separate from the host kernel, and this means you are now protected from an attack on one container, being able to access that host kernel.

![](https://res.cloudinary.com/samcogan/image/upload/v1678004257/2023-03-05_08-15-34_dzwtji.png)

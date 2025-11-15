# **[](https://medium.com/@ion.stefanache0/installing-charmed-k8s-to-a-local-machine-using-lxd-4492ffae8b4a)

Installing Charmed-Kubernetes(K8s) to a local bare-metal(BM) machine(single-node) using LXD(VM&Containers-tool)…

- **[Charmed-K8s deploying into/with(in) micro-cloud(single-node), on bare-metal hosted(without MAAS)](https://ubuntu.com/kubernetes/charmed-k8s/docs/install-local)**

**[calico](https://docs.tigera.io/)**

## **[authentik](https://goauthentik.io/)**

A self-hosted, open source identity provider means prioritizing security and taking control of your most sensitive data.

## Charmed-Kubernetes(K8s-charmed) installer using LXD(Linux Container Hypervisor)

In this story, using LXD(and Juju), I intend to create the installer(charmed-k8s_installer.sh) for (minimalist)Charmed-K8s On-prem/locally-cluster, with single-node(one single bare-metal machine; in my case was desktop Ubuntu 24.04.3 LTS, i5, 32GB RAM, 1TB SSD with GPU: NVIDIA Geforce RTX4060, 8GB VRAM).

Charmed-K8s on single machine(single-node self-contained) — variant is good/adequate for testing and development(as use-case/scope).

# **[Charm](https://juju.is/docs/sdk/charm-taxonomy)**

## references

<https://juju.is/docs/sdk/charm-taxonomy>
<https://juju.is/docs/olm/charmed-operator#:~:text=In%20Juju%2C%20a%20charm%20is,any%20cloud%20using%20the%20Juju>

## Juju charm

In Juju, a charm is an operator – software that wraps an application and that contains all of the instructions necessary for deploying, configuring, scaling, integrating, etc., the application on any cloud using the Juju.

## **[Charm taxonomy](https://juju.is/docs/sdk/charm-taxonomy)**

Juju has been around for some time. As a result, charm writing has gone through multiple frameworks and patterns. Here we describe the resulting charm taxonomy.

Contents:

- Charm types, by substrate
  - Machine charms
    - Roles
      - Principal charms
      - Subordinate charms
    - Patterns
      - Proxy
  - Kubernetes charms
        - Patterns
            - Sidecar
            - Workload-less
            - Podspec
- Charm types, by generation
  - Bare
  - Ops
  - Reactive

Firstly, we can differentiate charms by the substrate they are intended to run on; either machines or containers on Kubernetes. For machine charms, we can further draw a line between principal and subordinate charms. In Kubernetes charms, we can identify a few fuzzy but useful categories of charms, depending on the type of the workload they manage.

Finally, we can differentiate charms by the technology they are written with. Several generations of libraries have been used, the latest of which is ops.

## Charm types, by substrate

There are ‘machine charms’, meant to be deployed on VMs, and ‘Kubernetes charms’, meant to be deployed on Kubernetes.

## Machine charms

Juju’s beginnings were centered around simplifying the deployment of complex applications and services in a cloud-first world. At the time, many of those applications were run in virtual machines or on bare-metal servers, and deployments to these environments continue to enjoy first-class support. A machine charm can be deployed to a number of different underlying compute/storage resource providers:

- Bare-metal (using MAAS)
- Virtual machine (using KVM in Openstack, EC2 in AWS, VMware Environment etc.)
- Container (using LXD cluster)

Examples of machine charms include:

**[Ubuntu](https://charmhub.io/ubuntu)**
Vault
Rsyslog

## KVM

Kernel-based Virtual Machine is a free and open-source virtualization module in the Linux kernel that allows the kernel to function as a hypervisor. It was merged into the mainline Linux kernel in version 2.6.20, which was released on February 5, 2007

## **[LXD](https://www.techtarget.com/searchitoperations/definition/LXD-Linux-container-hypervisor)**

LXD (pronounced lex-dee) is the lightervisor, or lightweight container hypervisor. LXC (lex-see) is a program which creates and administers “containers” on a local system. It also provides an API to allow higher level managers, such as LXD, to administer containers.

LXD is an open source container management extension for Linux Containers (LXC). LXD both improves upon existing LXC features and provides new features and ...

Run system containers with LXD

Fast, dense, and secure container and VM management at any scale. LXD provides a unified user experience for managing system containers and virtual machines.

The LXD project is no longer part of the Linux Containers project but can now be found directly on Canonical's websites. Website: <https://ubuntu.com/lxd>

## list charms

```bash
juju status
Model  Controller  Cloud/Region        Version  SLA          Timestamp
chat   31microk8s  microk8s/localhost  3.1.8    unsupported  16:17:23-04:00

App             Version  Status   Scale  Charm           Channel    Rev  Address         Exposed  Message
mattermost-k8s           waiting      1  mattermost-k8s  stable      27                  no       Waiting for database relation
postgresql-k8s  14.10    active       1  postgresql-k8s  14/stable  193  10.152.183.124  no       Primary

Unit               Workload  Agent      Address      Ports  Message
mattermost-k8s/0*  waiting   idle                           Waiting for database relation
postgresql-k8s/0*  active    executing  10.1.32.147         Primary
```

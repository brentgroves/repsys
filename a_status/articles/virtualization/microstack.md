# Nutanix / OpenStack / JuJu

Hi Team,

This is a short description of 2 Software-defined infastructure platforms. The Structures Information System team is testing MicroStack. The Nutanix cluster is being tested by IT.

## Software Defined Infastructure

There are many categories of virtualization software. There is a least 6 but 3 of which are: Hypervisor, Software Defined Network (SDN), and storage. These providers unify these services.

## **[Nutanix](https://www.nutanix.com/what-we-do#:~:text=Our%20software%2Ddefined%20infrastructure%20brings,secure%2C%20resilient%2C%20and%20adaptive.)**

A unified platform to run applications and manage data across on-premises datacenters, and public clouds.

Uses:

- AHV / KVM hypervisors
- Open Virtual Switch (OVS)
- AOS storage
- CentOS

Notes:

- Comes with physically enclosed servers.
- The hardware and software have been tested together thoroughly.
- Good support.
...

## **[OpenStack](https://www.openstack.org/#:~:text=Cloud%20Infrastructure%20for%20Virtual%20Machines,READ%20MORE)**

OpenStack supports several different virtualization service combinations. MicroStack uses the combination given below.

Uses:

- libvirt+QEMU hypervisors
- Open Virtual Switch (OVS) / Open Virtual Network (OVN)
- Ceph storage
- Ubuntu

Notes:

- Uses **Juju** to deploy in five steps.
- Also uses **MicroK8s** to manage the MicroStack deployment and upgrades.
- Can also deploy Kubernetes.
- Has an one API to manage all services.
- Canonical provides an ACL list of internet domains that are needed for MicroStack to work with a Proxy Server.
- OpenStack is one of the largest open source projects.

## **[Juju](https://juju.is/#:~:text=Revolutionise%20the%20speed%20and%20quality,on%20any%20infrastructure%20using%20charms.)**

Canonical Juju is an open-source orchestration engine developed by Canonical Ltd. It's a tool that simplifies the deployment, configuration, and management of applications and services across various infrastructures, including virtual machines, Kubernetes, and cloud environments.

### Application Management

Juju helps manage the entire lifecycle of applications, from deployment to upgrades, on different platforms.

### Model-Driven Approach

Juju uses a model-driven approach, allowing users to define the desired state of their applications and their relationships.

### Charms

Juju uses "charms," which are operators that **encapsulate the operational knowledge** for deploying and managing specific applications.

### Infrastructure Agnostic

Juju supports various infrastructures, including virtual machines, Kubernetes clusters, and cloud providers.

### Open Source

Juju is an open-source project, meaning its code is available for free and anyone can contribute to it.

...

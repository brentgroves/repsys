# Nutanix / OpenStack / IAAS

Hi Team,

This is a short description of 2 IAAS platforms.

## IAAS

There are many categories of virtualization software. There is a least 6 but 3 of which are: Hypervisor, SDN, and storage. An IAAS provider provides a countrol plane for managing theee services.

## Nutanix

We have several of these clusters.  

Uses:

- AHV / KVM hypervisora
- Open Virtual Switch (OVS)
- AOS storage
- CentOS

Notes:

- Comes with servers.
- Good support.
...

## OpenStack

OpenStack supports several different virtualization service combinations. MicroStack uses the combination given below.

Uses:

- KVM / QEMU hypervisors
- Open Virtual Switch (OVS) / Open Virtual Network (OVN)
- Ceph storage
- Ubuntu

Notes:

- Uses Juju to deploy in five steps.
- Also uses MicroK8s to manage the MicroStack deployment and upgrades.
- Can also deploy Kubernetes.
- Canonical provides an ACL list of internet domains that are needed for MicroStack to work with a Proxy Server.
- One of the largest open source projects.

...

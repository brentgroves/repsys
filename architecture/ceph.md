# Setup Ceph Storage Cluster and Rook-Ceph management operator

We need Mayastor or Ceph to give use the ability to dynamically increase storage volume size.

## What is Rook-Ceph

<https://rook.github.io/docs/rook/latest/Getting-Started/intro/>
Rook is an open source cloud-native storage orchestrator, providing the platform, framework, and support for Ceph storage to natively integrate with cloud-native environments. Ceph is a distributed storage system that provides file, block and object storage and is deployed in large scale production clusters.

Note: Before enabling the rook-ceph addon on a strictly confined MicroK8s, make sure the rbd kernel module is loaded with sudo modprobe rbd

## What is Ceph RPD

Ceph RBD (RADOS Block Device) block storage stripes virtual disks over objects within a Ceph storage cluster, distributing data and workload ...

RPD is a utility for manipulating rados block device (RBD) images, used by the Linux rbd driver and the rbd storage driver for QEMU/KVM. RBD images are simple block devices that are striped over objects and stored in a RADOS object store. The size of the objects the image is striped over must be a power of two.

## Ceph Cluster Info:

- 3 nodes
- 3 20 GB virtual disks per node
- 2 replica sets meaning 3 copies of every object.
- Prometheus Alertmanager alerts
- Metrics collection with Prometheus

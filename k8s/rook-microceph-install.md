# HowTo setup MicroK8s with (Micro)Ceph storage

With the 1.28 release, we introduced a new rook-ceph addon that allows users to easily setup, import, and manage Ceph deployments via rook.

In this guide we show how to setup a Ceph cluster with MicroCeph, give it three virtual disks backed up by local files, and import the Ceph cluster in MicroK8s using the rook-ceph addon.

## references

<https://microk8s.io/docs/how-to-ceph>
<https://canonical-microceph.readthedocs-hosted.com/en/latest/tutorial/multi-node/>
<https://docs.ceph.com/en/reef/>

Visit <https://rook.io/docs/rook/latest> for instructions on how to create and configure Rook clusters

<https://rook.github.io/docs/rook/latest/Getting-Started/intro/>

## When to use Ceph

This was just introduced in 1.28 and by default creates storage on only one node, so I'm thinking maybe use if for S3 storage and not a database operator which probably should have its storage on whatever pod its server is running on.

## Remove MicroCeph

sudo snap remove microceph

## Install MicroCeph

MicroCeph is a lightweight way of deploying a Ceph cluster with a focus on reduced ops. It is distributed as a snap and thus it gets deployed with:

```bash
ssh brent@reports11
 --channel=latest/edge
# Prevent the software from being auto-updated:
sudo snap refresh --hold microceph
ssh brent@reports12
sudo snap install microceph --channel=latest/edge
sudo snap refresh --hold microceph
ssh brent@reports13
sudo snap install microceph --channel=latest/edge
sudo snap refresh --hold microceph

# Allowing the snap to be auto-updated can lead to unintended consequences. In enterprise environments especially, it is better to research the ramifications of software changes before those changes are implemented.

```

## Prepare the cluster

On node-1 we will now:

- initialise the cluster
- create registration tokens

## First, we need to bootstrap the Ceph cluster

Initialise the cluster with the cluster bootstrap command:

```bash
sudo microceph cluster bootstrap
```

Tokens are needed to join the other two nodes to the cluster. Generate these with the cluster add command.

Token for node-2:

```bash
sudo microceph cluster add node-2
eyJuYW1lIjoibm9kZS0yIiwic2VjcmV0IjoiMzcyNDY1OGEzOWUwMjM4M2ZkMTExZTRjNGYxMDU2ODUzNTUwNTQxN2RiNGUwZmIzMDI1ZTg0OGRhYWJjY2ZhYiIsImZpbmdlcnByaW50IjoiMzEzOGM4YmU5MDM0YWVjZGRkNTEwMzUwZTZiYjMyNTFhOTU0ZTZlMTUxMjZiNGI4N2IwZTE3MDBkMTg4Y2NhMSIsImpvaW5fYWRkcmVzc2VzIjpbIjEwLjEuMC4xMTA6NzQ0MyJdfQ==
```

Token for node-3:

```bash
sudo microceph cluster add node-3
eyJuYW1lIjoibm9kZS0zIiwic2VjcmV0IjoiOWJjNDg5NjEyNTFlZmZiZDZlYzEwNTgwY2U2MjIxYWY1ZjA1MjU5YWY3ZTFkM2U0NmQyMDhiZmQzYzQxYjI5YyIsImZpbmdlcnByaW50IjoiMzEzOGM4YmU5MDM0YWVjZGRkNTEwMzUwZTZiYjMyNTFhOTU0ZTZlMTUxMjZiNGI4N2IwZTE3MDBkMTg4Y2NhMSIsImpvaW5fYWRkcmVzc2VzIjpbIjEwLjEuMC4xMTA6NzQ0MyJdfQ==
```

Keep these tokens in a safe place. They’ll be needed in the next step.

Join the non-primary nodes to the cluster
The cluster join command is used to join nodes to a cluster.

On node-2, add the machine to the cluster using the token assigned to node-2:

```bash
ssh brent@reports12
sudo microceph cluster join eyJuYW1lIjoibm9kZS0yIiwic2VjcmV0IjoiMzcyNDY1OGEzOWUwMjM4M2ZkMTExZTRjNGYxMDU2ODUzNTUwNTQxN2RiNGUwZmIzMDI1ZTg0OGRhYWJjY2ZhYiIsImZpbmdlcnByaW50IjoiMzEzOGM4YmU5MDM0YWVjZGRkNTEwMzUwZTZiYjMyNTFhOTU0ZTZlMTUxMjZiNGI4N2IwZTE3MDBkMTg4Y2NhMSIsImpvaW5fYWRkcmVzc2VzIjpbIjEwLjEuMC4xMTA6NzQ0MyJdfQ==
```

On node-3, add the machine to the cluster using the token assigned to node-3:

```bash

ssh brent@reports13
sudo microceph cluster join eyJuYW1lIjoibm9kZS0zIiwic2VjcmV0IjoiOWJjNDg5NjEyNTFlZmZiZDZlYzEwNTgwY2U2MjIxYWY1ZjA1MjU5YWY3ZTFkM2U0NmQyMDhiZmQzYzQxYjI5YyIsImZpbmdlcnByaW50IjoiMzEzOGM4YmU5MDM0YWVjZGRkNTEwMzUwZTZiYjMyNTFhOTU0ZTZlMTUxMjZiNGI4N2IwZTE3MDBkMTg4Y2NhMSIsImpvaW5fYWRkcmVzc2VzIjpbIjEwLjEuMC4xMTA6NzQ0MyJdfQ==
```

At this point we can check the status of the cluster and query the list of available disks that should be empty. The disk status is queried with:

```bash
sudo microceph.ceph status  
  cluster:
    id:     c6d1ee89-e471-45af-86a7-bf5b54a1902f
    health: HEALTH_WARN
          clock skew detected on mon.reports12
          
  services:
    mon: 3 daemons, quorum reports11,reports12,reports13 (age 34m)
    mgr: reports11(active, since 44m), standbys: reports12, reports13
    osd: 0 osds: 0 up, 0 in

  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   0 B used, 0 B / 0 B avail
    pgs:

# The disk list is shown with:
sudo microceph disk list   
Disks configured in MicroCeph:
+-----+----------+------+
| OSD | LOCATION | PATH |
+-----+----------+------+

Available unpartitioned disks on this system:
+-------+----------+------+------+
| MODEL | CAPACITY | TYPE | PATH |
+-------+----------+------+------+

# Add virtual disks
# The following loop creates three files under /mnt that will back respective loop devices. Each Virtual disk is then added as an OSD to Ceph:

ssh brent@reports11
pushd ~/src/reports/k8s/microceph
./vdisk1.sh
ssh brent@reports12
pushd ~/src/reports/k8s
./vdisk1.sh
ssh brent@reports13
pushd ~/src/reports/k8s
./vdisk1.sh

sudo microceph disk list 
sudo microceph status

```

## Managing Ceph

Your Ceph cluster is now deployed and can be managed by following the resources found in the **[Howto section](https://canonical-microceph.readthedocs-hosted.com/en/latest/how-to/)**.

It is worth looking into customizing your Ceph setup at this point. Here, as this cluster is a local one and is going to be used by a local MicroK8s deployment we set the replica count to be 2, we disable manager redirects, and we set the bucket type to use for chooseleaf in a CRUSH rule to 0:

```bash
# By default, Ceph creates two replicas of an object, that is a total of three copies, or a size of 3 .
sudo microceph.ceph config set global osd_pool_default_size 2                               
sudo microceph.ceph config set mgr mgr_standby_modules false                                                                sudo microceph.ceph config set osd osd_crush_chooseleaf_type 0
```

## Crush Maps

The CRUSH algorithm computes storage locations in order to determine how to store and retrieve data. CRUSH allows Ceph clients to communicate with OSDs directly rather than through a centralized server or broker. By using an algorithmically-determined method of storing and retrieving data, Ceph avoids a single point of failure, a performance bottleneck, and a physical limit to its scalability.

<https://docs.ceph.com/en/quincy/rados/operations/crush-map/>

## Connect MicroCeph to MicroK8s

The rook-ceph addon first appeared with the 1.28 release, so we should select a MicroK8s deployment channel greater or equal to 1.28:

Rook is an open source cloud-native storage orchestrator, providing the platform, framework, and support for Ceph storage to natively integrate with cloud-native environments. Ceph is a distributed storage system that provides file, block and object storage and is deployed in large scale production clusters.

Ceph is a distributed storage system that provides file, block and object storage and is deployed in large scale production clusters.

Rook automates deployment and management of Ceph to provide self-managing, self-scaling, and self-healing storage services. The Rook operator does this by building on Kubernetes resources to deploy, configure, provision, scale, upgrade, and monitor Ceph.

Note: Before enabling the rook-ceph addon on a strictly confined MicroK8s, make sure the rbd kernel module is loaded with sudo modprobe rbd

Ceph RBD (RADOS Block Device) block storage stripes virtual disks over objects within a Ceph storage cluster, distributing data and workload ...

rbd is a utility for manipulating rados block device (RBD) images, used by the Linux rbd driver and the rbd storage driver for QEMU/KVM. RBD images are simple block devices that are striped over objects and stored in a RADOS object store. The size of the objects the image is striped over must be a power of two.

```bash
# The output message of enabling the addon, sudo microk8s enable rook-ceph, describes what the next steps should be to import a Ceph cluster:

sudo microk8s enable rook-ceph
sudo microk8s connect-external-ceph
```

Check status of rook operator

```bash
kubectl --namespace rook-ceph get pods -l "app=rook-ceph-operator"
```

Visit <https://rook.io/docs/rook/latest> for instructions on how to create and configure Rook clusters

Check Ceph Cluster status

```bash
kubectl --namespace rook-ceph-external get cephcluster
NAME                 DATADIRHOSTPATH   MONCOUNT   AGE     PHASE       MESSAGE                          HEALTH      EXTERNAL   FSID
rook-ceph-external   /var/lib/rook     3          2m46s   Connected   Cluster connected successfully   HEALTH_OK   true       c6d1ee89-e471-45af-86a7-bf5b54a1902f

```

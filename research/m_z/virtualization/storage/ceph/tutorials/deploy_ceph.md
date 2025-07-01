# **[Ceph: Step by step guide to deploy Ceph clusters](https://medium.com/@arslankhanali/ceph-step-by-step-guide-to-deploy-ceph-clusters-c62e4167a298)**

If you are just interested in deployment of Ceph. Jump to “Simple bash to deploy Ceph” section. If you are interested in how I set up everything according to my lab env, please continue :)
Here is the **[link](https://github.com/arslankhanali/Ceph-5-Playground-CNV)** to git repo

## What is Ceph ?

Ceph is an opensource project which is renowned for its distributed architecture, which comprises of several key components working together to provide a unified storage solution. At the heart of Ceph lies the RADOS (Reliable Autonomic Distributed Object Store) distributed storage system, which forms the foundation for its scalability and resilience. RADOS utilizes a cluster of storage nodes, each running Ceph OSD (Object Storage Daemon) software, to store data across the network in a fault-tolerant manner. This distributed approach ensures high availability and data durability by replicating data across multiple nodes and automatically recovering from failures.

## Object Storage in Ceph

Object storage, facilitated through RADOS Gateway, is a fundamental component of Ceph’s storage capabilities. Object storage in Ceph adopts a RESTful interface, allowing applications to interact with storage resources via HTTP APIs. Each object is stored as a binary blob, accompanied by metadata for efficient indexing and retrieval. This architecture enables seamless scalability, as objects are distributed across the Ceph cluster and can be accessed concurrently by multiple clients.

The Role of Object Storage in ML/AI Initiatives
In the realm of machine learning (ML) and artificial intelligence (AI), object storage plays a pivotal role in managing the vast amounts of unstructured data required for training and inference. ML/AI workflows often involve processing massive datasets comprising images, videos, sensor data, and text documents. Object storage in Ceph provides a cost-effective and scalable solution for storing these datasets, allowing organisations to efficiently manage petabytes of data without compromising performance or reliability.

From a technical standpoint, object storage in Ceph offers several advantages for ML/AI initiatives:

Scalability: Ceph’s distributed architecture allows organisations to seamlessly scale their storage infrastructure to accommodate growing datasets. As ML/AI workloads demand increasingly large volumes of data, object storage in Ceph can expand to meet these requirements without disruption.
Efficiency: The RESTful interface of Ceph’s object storage simplifies data access and manipulation, enabling developers to seamlessly integrate storage operations into ML/AI workflows. Additionally, Ceph’s support for metadata enables efficient indexing and querying of large datasets, improving overall performance.

Purpose of this article
We will look at how to deploy 2 Ceph clusters in my lab environment. This is a starting article in the Ceph series. In later articles we will:

Deploy rados gateway for object storage
Perform multi site replication
Use replication and erasure coding pools

## My setup

I have 7 VMs (RHEL 8) running on a hypervisor in my lab
One of the VMs is `Workstation machine` that will act as a jump host
CEPH-CLUSTER-1 will be setup on ceph-mon01, ceph-mon02 and ceph-mon03 VMs. Each have 20Gb of disks
CEPH-CLUSTER-2 will be setup on ceph-node01, ceph-node02 and ceph-node03 VMs. Each have 40Gb of disks
These VMs are not exposed publically so we will access Ceph dashboards and services through SSH tunnel

## Architecture

Look at the high level design below

![i1](https://miro.medium.com/v2/resize:fit:2776/format:webp/1*-bc7GvgpUAf-eyxU89UT8w.png)

Before we start
Remember you will have different environment with different IPs and hostname. So make changes accordingly.

Pre Req
You can ssh to workstation machine from your laptop
root user on workstation can access ceph-mon01 and ceph-node01
root user on ceph-mon01 can access ceph-mon02 and ceph-mon03
ceph-mon01 will be used to bootstrap cluster 1
root user on ceph-node01 can access ceph-node02 and ceph-node03
ceph-node01 will be used to bootstrap cluster 2

Easiest way is to create a ssh key pair on workstation and transfer both pubic and private keys to all hosts.

Enables repositories on VMs. If you are on RHEL, you will need to subscribe.

# To enables above repos

```bash
sudo dnf config-manager --set-enabled ansible-2-for-rhel-8-x86_64-rpms
sudo dnf config-manager --set-enabled ansible-2.9-for-rhel-8-x86_64-rpms
sudo dnf config-manager --set-enabled rhceph-5-tools-for-rhel-8-x86_64-rpms
sudo dnf config-manager --set-enabled rhel-8-for-x86_64-appstream-rpms
sudo dnf config-manager --set-enabled rhel-8-for-x86_64-baseos-rpmspos
```

## Setup SSH from Laptop to workstation

Purpose of this is to make sure all we can login from our laptop to workstation without being prompted for password. Makes life easier :)

Generate SSH key pair
Copy the .pub key to workstation
Login to workstation
Open 4 SSH tunnels that will route port 8000, 8888, 9000 and 9999 traffic from workstation to our laptop.

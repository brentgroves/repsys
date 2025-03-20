# **[Architecture](https://docs.ceph.com/en/reef/architecture/)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../a_status/detailed_status.md)**\
**[Back to Main](../../../../README.md)**

Ceph uniquely delivers object, block, and file storage in one unified system. Ceph is highly reliable, easy to manage, and free. The power of Ceph can transform your company’s IT infrastructure and your ability to manage vast amounts of data. Ceph delivers extraordinary scalability–thousands of clients accessing petabytes to exabytes of data. A Ceph Node leverages commodity hardware and intelligent daemons, and a Ceph Storage Cluster accommodates large numbers of nodes, which communicate with each other to replicate and redistribute data dynamically.

![a](https://docs.ceph.com/en/reef/_images/stack.png)

## The Ceph Storage Cluster

Ceph provides an infinitely scalable **[Ceph Storage Cluster](https://docs.ceph.com/en/reef/glossary/#term-Ceph-Storage-Cluster)** based upon RADOS, a reliable, distributed storage service that uses the intelligence in each of its nodes to secure the data it stores and to provide that data to clients. See Sage Weil’s **[“The RADOS Object Store”](https://ceph.io/en/news/blog/2009/the-rados-distributed-object-store/)** blog post for a brief explanation of RADOS and see **[RADOS - A Scalable, Reliable Storage Service for Petabyte-scale Storage Clusters](https://ceph.io/assets/pdfs/weil-rados-pdsw07.pdf)** for an exhaustive explanation of **[RADOS](https://docs.ceph.com/en/reef/glossary/#term-RADOS)**.

A Ceph Storage Cluster consists of multiple types of daemons:

- **[Ceph Monitor](https://docs.ceph.com/en/reef/glossary/#term-Ceph-Monitor)**
- **[Ceph Ceph Object Storage Daemon, OSD Daemon](https://docs.ceph.com/en/reef/glossary/#term-Ceph-OSD-Daemon)**
- **[Ceph Manager](https://docs.ceph.com/en/reef/glossary/#term-Ceph-Manager)**
- **[Ceph Metadata Server](https://docs.ceph.com/en/reef/glossary/#term-Ceph-Metadata-Server)**

Ceph Monitors maintain the master copy of the cluster map, which they provide to Ceph clients. The existence of multiple monitors in the Ceph cluster ensures availability if one of the monitor daemons or its host fails.

A Ceph OSD Daemon checks its own state and the state of other OSDs and reports back to monitors.

A Ceph Manager serves as an endpoint for monitoring, orchestration, and plug-in modules.

A Ceph Metadata Server (MDS) manages file metadata when CephFS is used to provide file services.

Storage cluster clients and Ceph OSD Daemons use the CRUSH algorithm to compute information about the location of data. Use of the CRUSH algoritm means that clients and OSDs are not bottlenecked by a central lookup table. Ceph’s high-level features include a native interface to the Ceph Storage Cluster via librados, and a number of service interfaces built on top of librados.

## Storing Data

The Ceph Storage Cluster receives data from Ceph Clients--whether it comes through a Ceph Block Device, Ceph Object Storage, the Ceph File System, or a custom implementation that you create by using librados. The data received by the Ceph Storage Cluster is stored as RADOS objects. Each object is stored on an Object Storage Device (this is also called an “OSD”). Ceph OSDs control read, write, and replication operations on storage drives. The default BlueStore back end stores objects in a monolithic, database-like fashion.

![osd](https://docs.ceph.com/en/reef/_images/ditaa-e01d23327b5f34ba68b18dbe5923c7617eeab3a2.png)

Ceph OSD Daemons store data as objects in a flat namespace. This means that objects are not stored in a hierarchy of directories. An object has an identifier, binary data, and metadata consisting of name/value pairs. Ceph Clients determine the semantics of the object data. For example, CephFS uses metadata to store file attributes such as the file owner, the created date, and the last modified date.

![o](https://docs.ceph.com/en/reef/_images/ditaa-b363b88681891164d307a947109a7d196e259dc8.png)

An object ID is unique across the entire cluster, not just the local filesystem.

## Scalability and High Availability

In traditional architectures, clients talk to a centralized component. This centralized component might be a gateway, a broker, an API, or a facade. A centralized component of this kind acts as a single point of entry to a complex subsystem. Architectures that rely upon such a centralized component have a single point of failure and incur limits to performance and scalability. If the centralized component goes down, the whole system becomes unavailable.

Facade is usually a simplified layer hiding complexities of the system. So an Aggregator API Or an Orchestrating API qualifies as API Facade.

Ceph eliminates this centralized component. This enables clients to interact with Ceph OSDs directly. Ceph OSDs create object replicas on other Ceph Nodes to ensure data safety and high availability. Ceph also uses a cluster of monitors to ensure high availability. To eliminate centralization, Ceph uses an algorithm called CRUSH.

## CRUSH Introduction

Ceph Clients and Ceph OSD Daemons both use the CRUSH algorithm to compute information about object location instead of relying upon a central lookup table. CRUSH provides a better data management mechanism than do older approaches, and CRUSH enables massive scale by distributing the work to all the OSD daemons in the cluster and all the clients that communicate with them. CRUSH uses intelligent data replication to ensure resiliency, which is better suited to hyper-scale storage. The following sections provide additional details on how CRUSH works. For an in-depth, academic discussion of CRUSH, see **[CRUSH - Controlled, Scalable, Decentralized Placement of Replicated Data](https://ceph.io/assets/pdfs/weil-crush-sc06.pdf)**.

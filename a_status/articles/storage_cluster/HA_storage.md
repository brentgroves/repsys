# HA Storage ported to Windows

Hi Team,

I wanted to share news of the Ceph storage driver for Windows. For those interested there will be a demo later this week.

Thanks,
Brent

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Prelim

- Before DOS/Windows we networked computers using Novell Netware and Banyan Vines.
- Novell acquired SUSE Linux Enterprise in 2004 to combine SUSE's Linux technology with Novell's networking.
- Ceph distributed storage system began in 2004 as a research project by Sage Weil, aiming to create a horizontally scalable, object-based file system for large-scale workloads.
- SUSE is a significant contributor to the Ceph open-source project, contributing advanced management and monitoring capabilities to the project.

## Current

Ceph, the leading open-source distributed storage system, has been ported to Windows, including RBD and CephFS.

**[SUSE Enterprise Storage Driver for Windows](https://www.suse.com/betaprogram/suse-enterprise-storage-windows-driver-beta/)**

Supported Windows versions:

- Windows Server 2022
- Windows Server 2019
- Works on Windows 10 (LTSC) and Windows 11 as well for development/testing purposes.

## **[Ceph Storage Cluster](https://docs.ceph.com/en/reef/architecture/)**

![i1](https://docs.ceph.com/en/reef/_images/stack.png)

## **[Ceph Public/Cluster Network](https://docs.ceph.com/en/latest/rados/configuration/network-config-ref/)**

![i2](https://ubuntucommunity.s3.us-east-2.amazonaws.com/original/3X/8/f/8fa40dee3c61703113c1f3fffd965a8ff762b0ff.png)

![i3](https://access.redhat.com/webassets/avalon/d/Red_Hat_Ceph_Storage-5-Configuration_Guide-en-US/images/8fb92a904c9c1e2bc110b3791fe8af75/110_Ceph_Configuration_updates_0720_01.png)

## **[Ceph features](https://ceph.io/en/discover/technology/)**

- **[high availability and fault tolerance](https://sysadmins.co.za/achieving-high-availability-with-haproxy-and-keepalived-building-a-redundant-load-balancer/)**
- **[Full Disk Encryption](https://ceph.io/en/news/blog/2023/ceph-encryption-performance/)**
- self-healing
- Configurable network interfaces for both public and internal traffic.
- **[Ceph’s RADOS Gateway, S3-compatible object storage service](https://docs.ceph.com/en/reef/radosgw/)**
  - great for giving tempory links.
  - ok if just one person is writing to files.
  - good support for backups.
  - not good for concurrent file access.
    - S3's nature: S3 is an object storage service, not a traditional filesystem. It offers strong read-after-write consistency, meaning a successful write will immediately be reflected in subsequent reads. However, it doesn't provide built-in object locking for concurrent writers.
- **[RBD block storage](https://docs.ceph.com/en/reef/rbd/#ceph-block-device)** for VM root file system.
- Mountable **[CephFS distributed filesystem](https://docs.ceph.com/en/squid/cephfs/)** to allow multiple clients to access the same data concurrently.

## Summary

- The **[MicroCloud (LXD, OVN, Ceph Clusters)](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/)** is the base. Structures MicroCloud configures the **[Ceph Cluster](https://canonical-microceph.readthedocs-hosted.com/)**.  It reduces the complexity of deploying and managing clusters.

![mc](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/_images/microcloud_basic_architecture.svg)

- You need a Linux administrator to monitor the storage cluster.
- **[comprehensive storage solution used by organizations worldwide](https://thenewstack.io/ceph-20-years-of-cutting-edge-storage-at-the-edge/#:~:text=Ceph:%2020%20Years%20of%20Cutting,of%20Use%20and%20Privacy%20Policy.)**
- Its one of the most thoroughly **[documented](https://docs.ceph.com/en/reef/start/)** peices of software I have ever seen.
- It has a dedicated **[foundation](https://ceph.io/en/foundation/)** made up commercial, government, and educational stakeholders.
- **[Ceph, I’ve never seen a data loss on properly managed clusters, even when there are major failures.](https://www.linkedin.com/posts/markus-wendland-clyso-ceph-abassador-kubernetes-opensource_ceph-20-years-of-cutting-edge-storage-at-activity-7239343394622234624-jMeX/)**

## references

- **[Ceph Architecture](https://docs.ceph.com/en/reef/architecture/)**
- **[Admin Guide](https://docs.ceph.com/en/latest/radosgw/admin/)**
- **[BlueStore](https://ceph.io/en/news/blog/2017/new-luminous-bluestore/)**
- **[20 years old](https://thenewstack.io/ceph-20-years-of-cutting-edge-storage-at-the-edge/#:~:text=Ceph:%2020%20Years%20of%20Cutting,of%20Use%20and%20Privacy%20Policy.)**
- **[Performance Tuning](https://ceph.io/en/news/blog/2022/rocksdb-tuning-deep-dive/)**
- **[S3 bucket life cycle](https://www.ibm.com/docs/en/storage-ceph/7.1.0?topic=gateway-bucket-lifecycle)**
- Ceph introduced **[BlueStore](https://ceph.io/en/news/blog/2017/new-luminous-bluestore/)**. This enables you to directly manage SSDs and HDDs without relying on conventional file systems. This innovation greatly enhanced Ceph’s performance and efficiency.
- **[HAProxy with KeepAliveD](https://sysadmins.co.za/achieving-high-availability-with-haproxy-and-keepalived-building-a-redundant-load-balancer/)**

## Team

- Kristian Smith: Global Directory IT
- Adrian Wise: System Admin, Technical Services Manager.
- Ramarao Guttikonda, Senior System Administrator
- John Biel: Manager, Network
- Kiran Ambati: Network Architect
- Aamir Ghaffar: IT Systems Architect
- Justin Langille, Network Technician
- Christian. Trujillo, IT Structures Manager
- Brent Hall, System Administrator Senior
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Hayley Rymer, IT Supervisor
- Kent Cook - IT Administrator
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport

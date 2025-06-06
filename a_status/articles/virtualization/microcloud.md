# **[Micro-Cloud](https://canonical.com/microcloud)**

**[Edge vs Cloud](https://enterprisersproject.com/article/2019/7/edge-computing-explained-plain-english#:~:text=Edge%20computing%20is%20the%20science,%2DCloud%20Portability%20for%20Dummies.%20%5D)**

“Put simply, edge computing is data analysis that takes place on a device in real-time,” says Nima Negahban, CTO of Kinetica. “Edge computing is about processing data locally, and cloud computing is about processing data in a data center or public cloud.”

**[What is a MicroCloud](https://canonical.com/microcloud)**

A MicroCloud is a lightweight, open-source cloud solution designed for edge computing and small-scale private clouds. It's essentially a cluster of machines that are automatically configured to function as a cloud environment. MicroCloud simplifies the process of deploying and managing a cloud, making it accessible for smaller deployments and use cases where a traditional cloud might be overkill.

Hyper-converged infrastructure (HCI) is a software-defined IT infrastructure that virtualizes all of the elements of conventional "hardware-defined" systems. HCI includes, at a minimum, virtualized computing (a hypervisor), software-defined storage, and virtualized networking (software-defined networking).[1][2] HCI typically runs on commercial off-the-shelf (COTS) servers.

## What is the size of a MicroCloud?

MicroClouds start with a single node, but at least 3 nodes are recommended for high availability.

They can easily extend in site size and scale from a single node to larger 50-node clusters.

## Best-of-breed open-source components

### LXD

LXD is a modern infrastructure tool that has everything you need to run your virtualised workloads. In addition to regular VMs, users can run their workloads using system containers that behave similarly but consume fewer resources while providing bare-metal performance.

LXD is image-based. It supports a wide range of Linux distributions, as well as Windows VMs, and has a good mix of cloud-like features.

## Ceph

Ceph has become a de facto standard for open-source storage solutions. It provides interfaces for several storage types (block, file and object) within a single cluster, eliminating the need for multiple storage solutions. It is scalable and reliable, making it the perfect solution for any cloud.

## OVN

OVN is a trusted open source software-defined networking solution. It provides virtual network abstractions, such as virtual L2 and L3 overlays, security groups, DHCP and other networking services. It was designed to support highly scalable and production-grade implementations.

Open Virtual Network (OVN) builds upon Open vSwitch (OVS) to provide a higher-level abstraction for virtual networks, offering features like virtual L2 and L3 overlays and security groups, while OVS handles the underlying packet forwarding.

## Key features

- Highly available cluster deploys in minutes.
- Automatic security updates and streamlined upgrades.
- Runs virtual machines, or system containers for higher density.
- Remote authentication, fine grained access control, projects and
- multi-user setup.
- Easily replicated at scale.
- Fully open source, commercial support available with Ubuntu Pro.

## Edge computing at a large scale

Industrial, telco, retail, banking – MicroClouds are the perfect edge computing solution for any industry:

- Scalable and low-latency HA cluster for critical applications.
- Lightweight to run on small servers or low-cost small devices.
- Low-touch, self-healing, few to no human interactions needed.

## Scalable cloud infrastructure

Do you need to keep sensitive workloads in a controlled environment, or are public cloud costs too unpredictable for your business?

MicroClouds are an efficient solution for your needs:

- Resource-efficient to lower costs.
- Simple to deploy and operate.
- Easy to scale as your needs grow.

**[Read about LXD's efficiency in this case study](https://ubuntu.com/engage/hypervisor-to-lxd-case-study?_gl=1*71vhvt*_gcl_au*MTI1MTU0NjkwNS4xNzQxMDk5MzI4)**

## Efficient dev environment

MicroCloud is lightweight enough that it can run on a developer laptop.
You can use it for:

Lightweight and constrained disposable testing environments.
Simulating or testing complex infrastructure processes.
Simulating how your workloads would run in production.
Safely experimenting with new technologies.

**[Deploy your own MicroCloud following this tutorial](https://canonical-microcloud.readthedocs-hosted.com/en/stable/microcloud/tutorial/get_started/)**

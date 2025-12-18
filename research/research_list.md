# Research List

**[Current Status](../development/status/weekly/current_status.md)**\
**[Back Main](../README.md)**

- **[Port Forwarding using IPTables](https://www.digitalocean.com/community/tutorials/how-to-forward-ports-through-a-linux-gateway-with-iptables)**
- **[go build system](https://www.codingexplorations.com/blog/mastering-gos-build-system-efficiency-through-caching-and-advanced-commands)**
- Research **[Namespace Natting](../research/m_z/virtualization/networking/namespaces/veths/veths_and_namespaces.md#start-here)**
- **[Understanding Open vSwitch: Part 1](https://medium.com/@ozcankasal/understanding-open-vswitch-part-1-fd75e32794e4)**
- **[Docker Multi-stage builds](./a_l/docker/multi_stage_builds.md)**\
- Research **[Bind9 for RFC 1918 network](../research/m_z/virtualization/networking/dns/dns_server.md)**
- Research Ceph storage **[Dynamic Cluster Management](../research/m_z/virtualization/storage/ceph/architecture.md#dynamic-cluster-management)** to optimize and trouble-shoot the MicroCloud HCI.
- Research **[Namespaces and CGroups](../research/m_z/virtualization/networking/namespaces/namespaces_cgroups.md)**
- Research **[Building a Linux container by hand using namespaces](../research/m_z/virtualization/networking/namespaces/building_containers/part1.md)**
- Research **[Linux Namespaces in Go](https://songrgg.github.io/programming/linux-namespace-part01-uts-pid/)**

## archive

- Research **[Writing a KVM hypervisor VMM in Python](../research/m_z/virtualization/hypervisor/kvm/writing_a_kvm_hypervisor_in_python/)**
- **[google-ai-overview-api](https://serpapi.com)**
- **[Canonical](./a_l/canonical/all_canonical.md)**\
A list of the products offered by Canonical.
- **[Cloud-init](./m_z/multipass/cloud-init.md)**\
The standard for customising cloud instances
Cloud images are operating system templates and every instance starts out as an identical clone of every other instance. It is the user data that gives every cloud instance its personality and cloud-init is the tool that applies user data to your instances automatically.
- **[Continuous Integration and Continuous Delivery(CI/CD)](./a_l/continuous_integration_and_delivery/continuous_integration_and_delivery.md)**\
  Semaphore lets you test and deploys code at the push of a button with hosted continuous integration and delivery.\
  After you push code to GitHub, it quickly runs your tests on a platform with first-class Docker support and 100+ tools preinstalled.
- **[Github Runners](./a_l/github/runners.md)**\
  Runners are the machines that execute jobs in a GitHub Actions workflow. For example, a runner can clone your repository locally, install testing software, and then run commands that evaluate your code.

- **[Graph Visualization](./a_l/graphviz/graphviz.md)**

Graph visualization is a way of representing structural information as diagrams of abstract graphs and networks. Automatic graph drawing has many important applications in software engineering, database and web design, networking, and in visual interfaces for many other domains.

- IAM
  - **[OAuth vs JWT](./a_l/iam/oauth_vs_jwt.md)**\
JWT defines a token format while OAuth deals in defining authorization protocols. JWT is simple and easy to learn from the initial stage while OAuth is complex. OAuth uses both client-side and server-side storage while JWT must use only client-side storage. JWT has limited scope and use cases.
  - **[Token Sharing Approaches](./a_l/iam/token_sharing_approaches.md)**

  ![](https://curity.io/images/resources/architect/api-security/token-sharing/mesh.svg)

  If your system is high in the API security maturity model you most probably use access tokens to authorize access to your endpoints. Access tokens that your API receives are tailored for the use with the given endpoint - they will have a concrete set of scopes and claim values. But as shown above, your API most probably will talk to different services which may or may not be part of the same domain or even company. This means that the API will have to share the token it received with the other services it needs to access. There are different ways in which such token can be shared:

- **[iproute2 Linux routing and traffic control](./m_z/virtualization/networking/routing/introduction_to_iproute2.md)** \
The 2.2 and above Linux kernels include a completely redesigned network subsystem. This new networking code brings Linux performance and a feature set with little competition in the general OS arena. In fact, the new routing, filtering, and classifying code is more featureful than the one provided by many dedicated routers and firewalls and traffic shaping products.

- **[JuJu](./a_l/juju/juju_list.md)**\
Juju is an open source orchestration engine for software operators that enables the deployment, integration and lifecycle management of applications at any scale, on any infrastructure using charms.

- **[Keycloak](./a_l/keycloak/keycloak.md)**
  - Keycloak is an open source software product to allow single sign-on with identity and access management aimed at modern applications and services.
  - Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own provider if you have users in other stores, such as a relational database.
  - Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is just a matter of configuring the Identity Provider through the admin console.
  - Through the account management console users can manage their own accounts. They can update the profile, change passwords, and setup two-factor authentication.

- **[Keystone](./a_l/keystone/keystone.md)**\
Keystone supports two configuration models for federated identity. The most common configuration is with keystone as a Service Provider (SP), using an external Identity Provider, such as a Keycloak or Google, as the identity source and authentication method. The second type of configuration is “Keystone to Keystone”, where two keystones are linked with one acting as the identity source.

- **[KVM](./a_l/juju/kvm_lxd_lxc.md)**\
Kernel-based Virtual Machine is a free and open-source virtualization module in the Linux kernel that allows the kernel to function as a hypervisor. It was merged into the mainline Linux kernel in version 2.6.20, which was released on February 5, 2007

- **[LXC](./a_l/juju/kvm_lxd_lxc.md)**\
LXC containers are often considered as something in the middle between a chroot and a full fledged virtual machine. The goal of LXC is to create an environment as close as possible to a standard Linux installation but without the need for a separate kernel.

- **[LXD](./a_l/lxd/lxd.md)**\
LXD ( [lɛks'di:] 🔈) is a modern, secure and powerful system container and virtual machine manager. It provides a unified experience for running and managing full Linux systems inside containers or virtual machines.

- Mattermost
  - **[Mattermost](./m_z/mattermost/mattermost.md)**\
  Mattermost is an open-source, self-hostable online chat service with file sharing, search, and integrations. It is designed as an internal chat for organisations and companies, and mostly markets itself as an open-source alternative to Slack and Microsoft Teams. Wikipedia

  - **[Deploy Mattermost to K8s](./m_z/mattermost/deploy_k8s.md)** \
  You can install and deploy a production-ready Mattermost system on a Kubernetes cluster using the Mattermost Kubernetes Operator in practically any environment with less IT overhead and more automation.

- **[Microstack](./m_z/microstack/microstack.md)**\
Install OpenStack anywhere in a few simple steps and let Kubernetes operators manage it for you. MicroStack (based on Sunbeam) is not yet another OpenStack on Kubernetes. It is a canonical OpenStack with native Kubernetes experience.

- **[Minio Object Storage](./m_z/minio/minio.md)**\
Object storage is accessed via a REST API call. Using POST, PUT, GET to an HTTP endpoint, you can create, read, update and delete (the famous CRUD operations) your blobs of data.\
Use of REST APIs means that, regardless of the operating system you are running on, your access to your object storage is the same.

- Redis
  - **[Distributed Locks](./m_z/redis/mutex/distributed_locks.md)**\
  This page describes a more canonical algorithm to implement distributed locks with Redis. We propose an algorithm, called **Redlock**, which implements a DLM which we believe to be safer than the vanilla single instance approach. We hope that the community will analyze it, provide feedback, and use it as a starting point for the implementations or more complex or alternative designs.

- **[Snap Confinement](./m_z/snap/confinement.md)**\
Strict Used by the majority of snaps. Strictly confined snaps run in complete isolation, up to a minimal access level that’s deemed always safe. Consequently, strictly confined snaps can not access files, network, processes or any other system resource without requesting specific access via an interface **[(see below)](https://snapcraft.io/docs/snap-confinement#interfaces)**.

- SQL Server
  - **[SQL Server Containers](./m_z/sql_server/sql_server_containers.md)**

    The quickstart in the previous section runs the free Developer edition of SQL Server from the Microsoft Artifact Registry. Most of the information still applies if you want to run production container images, such as Enterprise, Standard, or Web editions. However, there are a few differences that are outlined here.

    You can only use SQL Server in a production environment if you have a valid license. You can obtain a free SQL Server Express production license here. SQL Server Standard and Enterprise edition licenses are available through Microsoft Volume Licensing.
  - **[Import/Export](./m_z/sql_server/export_import.md)**
  
- **[Virtualization menu](./m_z/virtualization/virtualization_menu.md)**
All virtualization research.

- **[Zitadel](./m_z/zitadel/zitadel_article.md)**\
ZITADEL is an open source, cloud-native Identity and Access Management solution (IAM) that provides various security mechanisms to secure applications and services. It uses a range of different authorization strategies, including Role-Based Access Control (RBAC) and Delegated Access.

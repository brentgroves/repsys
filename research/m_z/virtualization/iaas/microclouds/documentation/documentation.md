# **[](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/)**

Deploy a scalable, low-touch cloud platform in minutes with MicroCloud.

MicroCloud creates a lightweight cluster of machines that operates as an open source private cloud. It combines LXD for virtualization, MicroCeph for distributed storage, and MicroOVN for networking—all automatically configured by the MicroCloud snap for reproducible, reliable deployments.

With MicroCloud, you can eliminate the complexity of manual setup and quickly benefit from high availability, automatic security updates, and the advanced features of its components such as self-healing clusters and fine-grained access control. Cluster members can run full virtual machines or lightweight system containers with bare-metal performance.

MicroCloud is designed for small-scale private clouds and hybrid cloud extensions. Its efficiency and simplicity also make it an excellent choice for edge computing, test labs, and other resource-constrained use cases.

![i1](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/_images/microcloud_basic_architecture.svg)

## About the integrated documentation sets

The three components of MicroCloud (**[LXD](https://documentation.ubuntu.com/microcloud/v2-edge/lxd)**, **[MicroCeph](https://documentation.ubuntu.com/microcloud/v2-edge/microceph)**, and **[MicroOVN](https://documentation.ubuntu.com/microcloud/v2-edge/microovn)**) each offer their own documentation sets, available at their respective standalone documentation sites.

For convenience, this site provides not only MicroCloud’s documentation but also an integrated view of all four documentation sets. You can easily switch between sets using the links in the site header, allowing you to explore all the related documentation without leaving this site.

Note

The components’ documentation sets are written for a general audience that might not be using MicroCloud. Thus, not all the information in these sets are relevant to MicroCloud users. For example, since MicroCloud automates the installation of its components, you can ignore the manual installation instructions in the components’ documentation.

Also, while each component’s documentation includes instructions for removing cluster members, you should not remove members from only one component. Use MicroCloud instead to remove cluster members (see How to remove a machine).

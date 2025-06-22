# **[Getting Started latest](https://documentation.ubuntu.com/microcloud/latest/microcloud/tutorial/get_started/)**

Get started with MicroCloud
MicroCloud is quick to set up. Once **[installed](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/install/#howto-install)**, you can start using MicroCloud in the same way as a regular LXD cluster.

This tutorial guides you through installing and initializing MicroCloud in a confined environment, then starting some instances to see what you can do with MicroCloud. It uses LXD virtual machines (VMs) for the MicroCloud cluster members, so you don’t need any extra hardware to follow the tutorial.

Tip

While VMs are used as cluster members for this tutorial, we recommend that you use physical machines in a production environment. You can use VMs as cluster members in testing or development environments. To do so, your host machine must have nested virtualization enabled. See the **[Ubuntu Server documentation](https://documentation.ubuntu.com/server/how-to/virtualisation/enable-nested-virtualisation/#check-if-nested-virtualisation-is-enabled)** on how to check if nested virtualization is enabled.

We also limit each machine in this tutorial to 2 GiB of RAM, which is less than the recommended hardware requirements. In the context of this tutorial, this amount of RAM is sufficient. However, in a production environment, make sure to use machines that fulfill the **[Hardware requirements](https://documentation.ubuntu.com/microcloud/latest/microcloud/reference/requirements/#reference-requirements-hardware)**.

# **[Build a MAAS and LXD environment in 30 minutes with Multipass on Ubuntu](https://maas.io/tutorials/build-a-maas-and-lxd-environment-in-30-minutes-with-multipass-on-ubuntu#1-overview)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../README.md)**

1. Overview
Time to try MAAS. We wanted to make it easier to go hands on with MAAS, so we created this tutorial to enable people to do that, right on their own PC or laptop. Below, we’ll explain a bit about how MAAS works and then dive straight into it.

Hang in there, because you’ll be up and running in no time, installing operating systems with ease and without breaking a sweat.

Installing MAAS itself is easy, but building an environment to play with it is more involved. MAAS works by detecting servers that attempt to boot via a network (called PXE booting). This means that MAAS needs to be on the same network as the servers.

Having MAAS on the same network as the servers can be problematic at home or the office, because MAAS also provides a DHCP server and it can (will) create issues if target servers and MAAS try to interact on your usual network.

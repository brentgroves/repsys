# **[Introduction to virtio-networking and vhost-net](https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-net)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Networking Menu](../networking_menu.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

In this post we will explain the vhost-net architecture described in the introduction, to make it clear how everything works together from a technical point of view. This is part of the series of blogs that introduces you to the realm of virtio-networking which brings together the world of virtualization and the world of networking.

This post is intended for architects and developers who are interested in understanding what happens under the hood of the vhost-net/virtio-net architecture described in the previous blog.

We'll start by describing how the different virtio spec standard components and shared memory regions are arranged in the hypervisor, how QEMU emulates a virtio network device and how the guest uses the open virtio specification to implement the virtualized driver for managing and communicating with that device.

After showing you the QEMU virtio architecture we will analyze the I/O bottlenecks and limitations and we will use the host’s kernel to overcome them, reaching the vhost-net architecture presented in the overview post (link).

Last, but not least, we will show how to connect the virtual machine to the external word, beyond the host it’s running on, using Open Virtual Switch (OVS), an open source virtual, SDN-capable, distributed switch.

By the end of this post, you’ll be able to understand how the vhost-net/virtio-net architecture works, the purpose of each of its components and how packets are sent and received.

# **[fan overlay network](https://wiki.ubuntu.com/FanNetworking)**

## **[lxd with fan](https://www.youtube.com/watch?v=5cwd0vZJ5bw)**

**[trevor lxd fan](https://www.youtube.com/watch?v=VhkxIY-jCjA&t=634s)**

**[lxd and ceph](https://www.youtube.com/watch?v=kVLGbvRU98A&t=948s)**

**[lxd cluster and ovn](https://www.youtube.com/watch?v=1M__Rm9iZb8)**
  This is very helpful, thank you! Don't forget to have openvswitch installed. Below are the config strings if you want to simply cut and paste them (and replace with your IPs).

  OVN_CTL_OPTS="--db-nb-addr=SERVER1 --db-nb-create-insecure-remote=yes --db-sb-addr=SERVER1 --db-sb-create-insecure-remote=yes --db-nb-cluster-local-addr=LOCAL --db-sb-cluster-local-addr=LOCAL --ovn-northd-nb-db=tcp:SERVER1:6641,tcp:SERVER2:6641,tcp:SERVER3:6641 --ovn-northd-sb-db=tcp:SERVER1:6642,tcp:SERVER2:6642,tcp:SERVER3:6642"

An alternative to using ovn.

Introduction
Containers enable tremendously dense virtualisation -- it is easy to run hundreds or even thousands of containers on a single host machine. Whether for whole machine containers (LXD) or process containers (Docker), it is easiest for these containers to be managed as separate networking entities, which means they need their own IP addresses. The proliferation of containers thus creates demand for additional network address space. Typically, the number of extra addresses needed is roughly constant across each container host.

A new solution to this problem of increased demand for IP address space is the fan. The fan is a mapping between a smaller network address space (typically a /16 network) and a larger one (typically a /8), which assigns subnets from the larger one to IP addresses on the smaller one, and enables automatic and simple tunnelling and routing between systems on the larger address space. Fan addresses are assigned as subnets on a virtual bridge on the host, which are mathematically related to the primary (or underlay) IP address behind which they are mapped. The fan system can be considered “address expansion,” as it simply multiplies the number of available IP addresses on the host, providing an extra 253 usable addresses for each host IP address on the /16.

This document describes the implementation of the fan on Ubuntu, beginning with the principles on which it’s based. Next up are outlines of some common use cases for the fan. The user-mode fan tools are then described, along with how to create a persistent configuration. Finally, detailed configuration instructions for using the fan with both LXC/LXD and Docker are presented.

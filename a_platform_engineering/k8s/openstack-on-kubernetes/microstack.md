# MicroStack

OpenStack is no doubt a wonderful and successful piece of software. It allows you to create your own cloud infrastructure, and thanks to its open-source nature, it’s free to use for everyone. But as with many giant software projects, all that power comes with a challenge: it is reasonably complex to install and configure. A number of OpenStack distributions do exist that intend to make engineers’ life a lot easier, but those also tend to be more complex than a non-experienced user would like them to be.

To solve this problem once and for all, Canonical created a simplified and easy-to-install distribution of OpenStack called MicroStack.

## References

<https://ubuntu.com/blog/k8s-native-microstack>

## Hypervisor

Of course, some parts of OpenStack are not a good fit for running inside a container. Services like nova-compute (that drives QEMU/KVM), ovn-chassis (that plugs into the network cards), ceph-osd (that needs access to physical hard drives) work better when run natively on bare metal. This is why those are distributed in a separate package to be installed on hypervisor/storage nodes.

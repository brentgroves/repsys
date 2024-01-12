# OpenStack

## NEXT

<https://www.youtube.com/watch?v=IseEhw-Dxrc>
START AT 11:11

## references

<https://www.youtube.com/watch?v=IseEhw-Dxrc>
<https://www.youtube.com/watch?v=NLlZwbFgGjU>
<https://github.com/openstack>

## learn openstack

Using a cloud provider you have limited understanding of how it all works. Does anyone actually know how all those services work behind the scenes in AWS, Azure, and Google Cloud?  There is some documentation but you can't spin up your very own version of those clouds using your own hardware.

With OpenStack you know exactly how it works because you are the one building it.

- started in 2010 by NASA and RackSpace.
- made up of several components, at least 9, that you can install separately.

- Horizon: dashboard
- Nuetron: Software defined network, subnets
- Nova: virtual machine instances powered by KVM
- Glance: deployment images for Nova
- Cinder: storage, supports nfs,iscsi, and ceph protocols.

## Conceptual Architecture

![](https://docs.openstack.org/install-guide/_images/openstack_kilo_conceptual_arch.png)

## Very Configurable

- like adding another ProxMox VE server to your cluster you could add another Nova instance if your dashboard experience becomes sluggish because of increased user access.  If you add another ProxMox VE server you get a server with all services but with OpenStack you increase the number of instances only to the services that needs increasing.
- better having separte components of OpenStack on separate servers.
- can install OpenStack on one server for development but since all the services our on one server expect to need about 32 GB of RAM.
- Runs best when you split up its components between servers.

## How to Install

There are many installation options.

- **[DevStack](https://docs.openstack.org/devstack/latest/)**

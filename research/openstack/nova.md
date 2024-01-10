# Nova

## references

<https://docs.openstack.org/nova/latest/>

## What is nova?

Nova is the OpenStack project that provides a way to provision compute instances (aka virtual servers). Nova supports creating virtual machines, baremetal servers (through the use of ironic), and has limited support for system containers. Nova runs as a set of daemons on top of existing Linux servers to provide that service.

It requires the following additional OpenStack services for basic function:

- **[Keystone](https://docs.openstack.org/keystone/latest/)**: This provides identity and authentication for all OpenStack services.
- **Glance**: This provides the compute image repository. All compute instances launch from glance images.
- **Neutron**: This is responsible for provisioning the virtual or physical networks that compute instances connect to on boot.
- **Placement**: This is responsible for tracking inventory of resources available in a cloud and assisting in choosing which provider of those resources will be used when creating a virtual machine.

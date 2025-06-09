# **[Single-node guide](https://canonical.com/microstack/docs/single-node-guided)**

## **[egress requirements](https://discourse.ubuntu.com/t/manage-a-proxied-environment/43946)**

This tutorial shows how to install OpenStack (based on project Sunbeam). It will deploy an OpenStack 2024.1 (Caracal) cloud.

Requirements
You will need a single machine whose requirements are:

- physical or virtual machine running Ubuntu 24.04 LTS
- a multi-core amd64 processor (ideally with 4+ cores)
- a minimum of 16 GiB of free memory
- 100 GiB of SSD storage available on the root disk
- two network interfaces
- primary: for access to the OpenStack control plane
- secondary: for remote access to cloud VMs

Caution: Any change in IP address of the local host will be detrimental to the deployment. A virtual host will generally have a more stable address.

Important: For environments constrained by a proxy server, the target machine must first be configured accordingly. See section Configure for the proxy at the OS level on the **[Manage a proxied environment page](https://canonical.com/microstack/docs/proxied-environment)** before proceeding.

## Control plane networking

The network associated with the primary network interface requires a range of approximately ten IP addresses that will be used for API service endpoints.

For the purposes of this tutorial, the following configuration is in place:

```yaml
CIDR: 192.168.1.0/24
Gateway: 192.168.1.1
Address range: 192.168.1.201-192.168.1.220
Interface name on machine: eno1
```

## External networking

The network associated with the secondary network interface requires a range of IP addresses that will be sufficient for allocating floating IP addresses to VMs. This will, in turn, allow them to be contacted by remote hosts.

For the purposes of this tutorial, the following configuration is in place:

```yaml
# Network component Value
CIDR: 192.168.1.0/24
Gateway: 192.168.1.1
Address range: 192.168.1.101-192.168.1.200
Interface name on machine: eno2
```

## Deploy the cloud

The cloud deployment process consists of several stages: installing a snap, preparing the cloud node machine, bootstrapping the cloud, and finally configuring the cloud.

Note: During the deployment process you will be asked to input information in order to configure your new cloud. These questions are explained in more detail on the Interactive configuration prompts page in the reference section.

## Install the openstack snap

Begin by installing the openstack snap:

```bash
sudo snap install openstack
2025-06-06T18:32:13Z INFO Waiting for automatic snapd restart...
2025-06-06T18:32:15Z INFO Waiting for automatic snapd restart...
openstack (2024.1/stable) 2024.1 from Canonical✓ installed
```

## Prepare the machine

As a prerequisite, Sunbeam needs a Juju controller deployed to LXD. --bootstrap option will set it up automatically, for a more detailed procedure refer to Bootstrap LXD based Juju controller on single node.

Sunbeam can generate a script to ensure that the machine has all of the required dependencies installed and is configured correctly for use in OpenStack - you can review this script using:

```bash
sunbeam prepare-node-script --bootstrap
```

or the script can be directly executed in this way:

```bash
sunbeam prepare-node-script --bootstrap | bash -x && newgrp snap_daemon
```

The script will ensure some software requirements are satisfied on the host. In particular, it will:

- install openssh-server if it is not found
- configure passwordless sudo for all commands for the current user (NOPASSWD:ALL)

## Bootstrap the cloud

Deploy the OpenStack cloud using the cluster bootstrap command:

```bash
sunbeam cluster bootstrap
```

You will first be prompted whether or not to enable network proxy usage. If ‘Yes’, several sub-questions will be asked.

```bash
Use proxy to access external network resources? [y/n] (y):
http_proxy ():
https_proxy ():
no_proxy ():
```

Note that proxy settings can also be supplied by using a manifest (see **[Deployment manifest](https://canonical.com/microstack/docs/manifest)**).

When prompted, enter the CIDR and the address range for the control plane networking. Here we use the values given earlier:

## did not work

```bash
Management network (192.168.1.0/24):
OpenStack APIs IP ranges (192.168.1.201-192.168.1.220): 192.168.1.201-192.168.1.220
```

## error

An unexpected error has occurred. Please see <https://canonical-openstack.readthedocs-hosted.com/en/latest/how-to/troubleshooting/inspecting-the-cluster/> for troubleshooting information.
Error: ['multiple subnets matching "192.168.1.0/24"']

## try 2

I removed all software and rebooted machine.
did not remove lxc/lxd and  network links:
 4: sunbeambr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:16:3e:f0:54:af brd ff:ff:ff:ff:ff:ff
    inet 10.167.240.1/24 scope global sunbeambr0
       valid_lft forever preferred_lft forever
6: veth635e2f26@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master sunbeambr0 state UP group default qlen 1000
    link/ether 8a:b1:ed:a2:4a:00 brd ff:ff:ff:ff:ff:ff link-netnsid 0

```bash
Management network (172.16.1.0/24):
An unexpected error has occurred. Please see https://canonical-openstack.readthedocs-hosted.com/en/latest/how-to/troubleshooting/inspecting-the-cluster/ for troubleshooting information.
Error: No local IP address found for CIDR 172.16.1.0/24

OpenStack APIs IP ranges (172.16.1.201-172.16.1.240): 172.16.1.201-172.16.1.220


```

Management network (192.168.2.0/24):
OpenStack APIs IP ranges (192.168.2.201-192.168.2.220): 192.168.2.201-192.168.2.220

## control plane

```yaml
CIDR: 192.168.1.0/24
Gateway: 192.168.1.1
Address range: 192.168.1.201-192.168.1.220
Interface name on machine: eno1
```

## Configure the cloud

Now configure the deployed cloud using the configure command:

```bash
sunbeam configure --openrc demo-openrc
```

## External networking (VM)

```yaml
# Network component Value
CIDR: 192.168.1.0/24
Gateway: 192.168.1.1
Address range: 192.168.1.101-192.168.1.200
Interface name on machine: eno2
```

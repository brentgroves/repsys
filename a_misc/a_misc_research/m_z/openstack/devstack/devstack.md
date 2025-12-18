# DevStack

DevStack is a series of extensible scripts used to quickly bring up a complete OpenStack environment based on the latest versions of everything from git master. It is used interactively as a development environment and as the basis for much of the OpenStack project’s functional testing.

The source is available at <https://opendev.org/openstack/devstack>.

## references

<https://docs.openstack.org/devstack/latest/>

<https://opendev.org/openstack/devstack>

## DevStack Install

![](https://docs.openstack.org/devstack/latest/_images/logo-blue.png)

## Warning

DevStack will make substantial changes to your system during installation. Only run DevStack on servers or virtual machines that are dedicated to this purpose.

## Quick Start

Install Linux
Start with a clean and minimal install of a Linux system. DevStack attempts to support the two latest LTS releases of Ubuntu, Rocky Linux 9 and openEuler.

If you do not have a preference, Ubuntu 22.04 (Jammy) is the most tested, and will probably go the smoothest.

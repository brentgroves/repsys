# **[Setting Up Virtual Machines with QEMU, KVM, and Virt-Manager on Debian/Ubuntu](https://linuxconfig.org/setting-up-virtual-machines-with-qemu-kvm-and-virt-manager-on-debian-ubuntu)**

**[Back to Research List](../../../../../research/research_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

Virtualization technology has become an indispensable tool in software development, testing, and deployment. It allows you to run multiple virtual machines (VMs) on a single physical machine, each with its own isolated operating system and resources. This tutorial focuses on setting up a virtualization environment on Debian or Ubuntu Linux using QEMU, KVM (Kernel-based Virtual Machine), and Virt-Manager.

In this tutorial you will learn:

How to update your Debian or Ubuntu system.
The process of installing QEMU, KVM, and Virt-Manager.
How to add your user to the necessary groups to manage VMs without root privileges.
Steps to verify the installation and manage virtual machines with Virt-Manager.

| Category    | Requirements, Conventions or Software Version Used                                                                                                                                                               |
|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| System      | Debian or Ubuntu Linux system                                                                                                                                                                                    |
| Software    | QEMU, KVM, Virt-Manager                                                                                                                                                                                          |
| Other       | Internet connection for software installation                                                                                                                                                                    |
| Conventions | # – requires given linux commands to be executed with root privileges either directly as a root user or by use of sudo command $ – requires given linux commands to be executed as a regular non-privileged user |

## Step-by-Step Guide to Virtualization with QEMU, KVM, and Virt-Manager

Before diving into the steps, it’s important to understand the roles of QEMU, KVM, and Virt-Manager. QEMU is an open-source machine emulator and virtualizer that allows you to run operating systems and software designed for a different architecture. KVM is a virtualization module in the Linux kernel that allows the kernel to function as a hypervisor. Lastly, Virt-Manager is a graphical interface for managing virtual machines through libvirt.

## Update Your System: 

Ensure that your Debian or Ubuntu system is up-to-date to avoid any compatibility issues during the installation of virtualization tools. Run the following commands in a terminal:

```bash
$ sudo apt update
$ sudo apt upgrade
```


This step updates the list of available packages and their versions and then installs the newest versions of the packages currently installed on your system.

## Install QEMU and Virt-Manager: 

Install QEMU, KVM, and Virt-Manager to set up your virtualization environment. These tools will allow you to create and manage virtual machines with ease. Execute the following command:

```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```

This command installs all necessary packages, including QEMU for emulation, KVM for hardware acceleration, libvirt daemon for managing VMs, libvirt clients for command-line interaction, bridge-utils for network bridging, and Virt-Manager for graphical management.

Add Your User to Necessary Groups: To manage virtual machines without root privileges, add your user to the ‘libvirt’ and ‘kvm’ groups by running:

```bash
$ sudo adduser $USER libvirt
$ sudo adduser $USER kvm
```


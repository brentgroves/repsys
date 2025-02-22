# **[How to install KVM on Ubuntu 20.04 LTS Headless Server](https://www.cyberciti.biz/faq/how-to-install-kvm-on-ubuntu-20-04-lts-headless-server/)**

## references

**[Ubuntu docs](https://manpages.ubuntu.com/manpages/trusty/man1/virt-install.1.html)**
**[virtual machine manager](https://ubuntu.com/server/docs/virtual-machine-manager)**
**[install kvm on headless server](https://www.cyberciti.biz/faq/how-to-install-kvm-on-ubuntu-20-04-lts-headless-server/)**

Kernel-based Virtual Machine (KVM) is a virtualization module for the Linux kernel that turns it into a hypervisor. How can I install KVM with bridged networking, set up a guest operating system as the back-end virtualization technology for non-graphic Ubuntu Linux 20.04 LTS server over ssh based session?

We can use KVM to run multiple operating systems such as MS-Windows server/desktop, *BSD family of operating systems, various Linux distros using virtual machines. Each virtual machine has its own private disk, graphics card, a network card, hardware devices, and more.

## Prerequisites to install KVM on Ubuntu 20.04 LTS headless server

I am assuming that:

The host Ubuntu server located in the remote data center and it is a headless box.
All commands in this tutorial typed over the ssh based session.
You need a vnc client to install the guest operating system. However, this is not required if you use Cloud images.
In this tutorial, you will learn how to install KVM software on Ubuntu 20.04 LTS server and use KVM to setup your first guest VM.

## Find out if CPU support Intel VT/AMD-V virtualization for KVM

Run any one of the following command:

```bash
$ lscpu
## or ##
sudo apt install cpu-checker
$ kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

By default, many system manufacturers disables an AMD or Intel hardware CPU virtualization technology in the BIOS for KVM. You need to reboot the system and turn it in the BIOS.

## Installing KVM on Ubuntu 20.04

Let us see how to install KVM on Ubuntu 20.04 LTS Linux server.

Step 1 – Install KVM on Ubuntu 20.04 LTS server
We need the following packages:

| Package name          | Short description                                                  | Installation target/type          |
|-----------------------|--------------------------------------------------------------------|-----------------------------------|
| qemu-kvm              | QEMU Full virtualization on x86 hardware                           | Headless server                   |
| libvirt-daemon-system | Libvirt daemon configuration files                                 | Headeless server                  |
| libvirt-clients       | Programs for the libvirt library                                   | Headless server                   |
| virtinst              | Programs to create and clone virtual machines                      | Headless server                   |
| libosinfo-bin         | Tools for querying the osinfo database                             | Headless server                   |
| libguestfs-tools      | Guest disk image management system and tools for Cloud images      | Headless server                   |
| cpu-checker           | tools to help evaluate certain CPU (or BIOS) features              | Headless or GUI server            |
| virt-manager          | desktop application for managing virtual machines                  | Graphically/GUI server            |
| ssh-askpass-gnome     | interactive X program to prompt users for a passphrase for ssh-add | Graphically/GUI for remote server |

Execute the following apt command/apt-get command to install packages for headless server:

```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients virtinst cpu-checker libguestfs-tools libosinfo-bin
```

Step 2 – Configure bridged networking on Ubuntu 20.04
By default, KVM installation creates “virbr0” bridge, and we can use the same for the outside world for communication. Let us find information about the “virbr0” bridge using the ip command:

```bash
ip link show master virbr0
bridge link show dev virbr0-nic
ip a s virbr0
6: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:51:46:ce brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
```

## install

```bash
sudo apt install virtinst
```

You can use the virt-install command to create virtual machines and install operating system on those virtual machines from the command line. virt-install can be used either interactively or as part of a script to automate the creation of virtual machines. If you are using an interactive graphical installation, you must have virt-viewer installed before you run virt-install. In addition, you can start an unattended installation of virtual machine operating systems using virt-install with kickstart files.

The virt-install utility uses a number of command-line options. However, most virt-install options are not required.
The main required options for virtual guest machine installations are:
--name
The name of the virtual machine.
--memory The amount of memory (RAM) to allocate to the guest, in MiB.
Guest storage
Use one of the following guest storage options:
--disk
The storage configuration details for the virtual machine. If you use the --disk none option, the virtual machine is created with no disk space.
--filesystem
The path to the file system for the virtual machine guest.

Installation method
Use one of the following installation methods:
--location
The location of the installation media.
--cdrom
The file or device used as a virtual CD-ROM device. It can be path to an ISO image, or a URL from which to fetch or access a minimal boot ISO image. However, it can not be a physical host CD-ROM or DVD-ROM device.
--pxe
Uses the PXE boot protocol to load the initial ramdisk and kernel for starting the guest installation process.
--import
Skips the OS installation process and builds a guest around an existing disk image. The device used for booting is the first device specified by the disk or filesystem option.
--boot
The post-install VM boot configuration. This option allows specifying a boot device order, permanently booting off kernel and initrd with optional kernel arguments and enabling a BIOS boot menu.
To see a complete list of options, enter the following command:

# virt-install --help

To see a complete list of attributes for an option, enter the following command:

# virt install --option=?

The virt-install man page also documents each command option, important variables, and examples.
Prior to running virt-install, you may also need to use qemu-img to configure storage options. For instructions on using qemu-img, see Chapter 14, Using qemu-img.

## 3.2.1. Installing a virtual machine from an ISO image

The following example installs a virtual machine from an ISO image:

```bash
ls ~/images
# virt-install \ 
  --name vlan_fun \ 
  --memory 2048 \ 
  --vcpus 2 \ 
  --disk size=8 \ 
  --cdrom ~/images/ubuntu-24.04.1-live-server-amd64.iso \ 
  --os-variant ubuntu24.04
```

The --cdrom /path/to/rhel7.iso option specifies that the virtual machine will be installed from the CD or DVD image at the specified location.

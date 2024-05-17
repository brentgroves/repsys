# KVM

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Kernel-based Virtual Machine is a free and open-source virtualization module in the Linux kernel that allows the kernel to function as a hypervisor. It was merged into the mainline Linux kernel in version 2.6.20, which was released on February 5, 2007

## **[LXC](https://linuxcontainers.org/)**

What's LXC?
LXC is a userspace interface for the Linux kernel containment features. Through a powerful API and simple tools, it lets Linux users easily create and manage system or application containers.

Features
Current LXC uses the following kernel features to contain processes:

- Kernel namespaces (ipc, uts, mount, pid, network and user)
- Apparmor and SELinux profiles
- Seccomp policies
- Chroots (using pivot_root)
- Kernel capabilities
- CGroups (control groups)

LXC containers are often considered as something in the middle between a chroot and a full fledged virtual machine. The goal of LXC is to create an environment as close as possible to a standard Linux installation but without the need for a separate kernel.

**[LXC](https://en.wikipedia.org/wiki/LXC)**

Linux Containers is an operating-system-level virtualization method for running multiple isolated Linux systems on a control host using a single Linux kernel.

![](https://www.google.com/search?q=lxc&sca_esv=3cf5305f7235dc23&sxsrf=ADLYWILpJFX7lpjRo24WLT6Xggfo430yEg:1715974949367&tbm=isch&source=iu&ictx=1&vet=1&fir=Hm4tK8wga_iVnM%252C6c0J6CBeF0bWPM%252C_%253BwHVTtkDd1wMFHM%252C8VgKCgQ9mQ9nYM%252C_%253BW8eVdY2Jem44VM%252CWMMzuSiXLo1sYM%252C_%253Bj7vy3NHwmKs1PM%252Ch5e8TMv4ild7dM%252C_%253BwgUChO6DRTBqMM%252CNT4dOhOeGP0iZM%252C_&usg=AI4_-kSJD70T71wVq9TCikdk-H72cKv_NQ&sa=X&ved=2ahUKEwizobPquJWGAxVPnokEHZF5DaoQ_h16BAhgEAE#imgrc=W8eVdY2Jem44VM)**

## **[LXD](https://www.techtarget.com/searchitoperations/definition/LXD-Linux-container-hypervisor)**

LXD (pronounced lex-dee) is the lightervisor, or lightweight container hypervisor. LXC (lex-see) is a program which creates and administers “containers” on a local system. It also provides an API to allow higher level managers, such as LXD, to administer containers.

LXD is an open source container management extension for Linux Containers (LXC). LXD both improves upon existing LXC features and provides new features and ...

Run system containers with LXD

Fast, dense, and secure container and VM management at any scale. LXD provides a unified user experience for managing system containers and virtual machines.

The LXD project is no longer part of the Linux Containers project but can now be found directly on Canonical's websites. Website: <https://ubuntu.com/lxd>

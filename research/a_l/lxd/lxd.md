# **[LXD](<https://documentation.ubuntu.com/lxd#:~:text=LXD%20(%20%5Bl%C9%9Bks'di%3A%5D,inside%20containers%20or%20virtual%20machines>.)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

LXD ( [lɛks'di:] 🔈) is a modern, secure and powerful system container and virtual machine manager. It provides a unified experience for running and managing full Linux systems inside containers or virtual machines.

## **[LXD vs. LXC](https://documentation.ubuntu.com/lxd/en/latest/explanation/lxd_lxc/)**

LXD and LXC are two distinct implementations of Linux containers.

LXC is a low-level user space interface for the Linux kernel containment features. It consists of tools (lxc-* commands), templates, and library and language bindings.

LXD is a more intuitive and user-friendly tool aimed at making it easy to work with Linux containers. It is an alternative to LXC’s tools and distribution template system, with the added features that come from being controllable over the network. Under the hood, LXD uses LXC to create and manage the containers.

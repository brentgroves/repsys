# **[How to use cloud-init](https://documentation.ubuntu.com/lxd/en/latest/cloud-init/)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## reference

- **[snapshot](https://discourse.ubuntu.com/t/multipass-snapshot-command/39755)**

**[cloud-init](https://cloud-init.io/)** is a tool for automatically initializing and customizing an instance of a Linux distribution.

By adding cloud-init configuration to your instance, you can instruct cloud-init to execute specific actions at the first start of an instance. Possible actions include, for example:

Updating and installing packages

Applying certain configurations

Adding users

Enabling services

Running commands or scripts

Automatically growing the file system of a VM to the size (quota) of the disk

See the **[Cloud-init documentation](https://cloudinit.readthedocs.io/en/latest/index.html#index)** for detailed information.


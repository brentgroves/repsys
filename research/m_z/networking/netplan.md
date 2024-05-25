# **[netplan](https://launchpad.net/netplan)**

**[Back to Research List](../../research_list.md)**\
**[Back to Networking Menu](./networking_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Declarative network configuration for various backends

netplan reads network configuration from /etc/netplan/*.yaml which are written by administrators, installers, cloud image instantiations, or other OS deployments. During early boot it then generates backend specific configuration files in /run to hand off control of devices to a particular networking daemon.

Currently supported backends are networkd, NetworkManager and OpenVSwitch.

There

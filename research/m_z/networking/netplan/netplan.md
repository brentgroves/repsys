# **[netplan](https://launchpad.net/netplan)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Networking Menu](../networking_menu.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## How does it work?

Netplan reads network configuration from /etc/netplan/*.yaml which are written by administrators, installers, cloud image instantiations, or other OS deployments. During early boot, Netplan generates backend specific configuration files in /run to hand off control of devices to a particular networking daemon.

![](https://assets.ubuntu.com/v1/a1a80854-netplan_design_overview.svg)

Netplan currently works with these supported renderers

NetworkManager
Systemd-networkd

## How do I use it?

Configuration
Without configuration, Netplan will not do anything. The simplest configuration snippet (to bring up things via DHCP on workstations) is as follows:

network:
  version: 2
  renderer: NetworkManager
This will make Netplan hand over control to NetworkManager, which will manage all devices in its default way (i.e. any ethernet device will come up with DHCP once carrier is detected).

When individual interface configurations are given, it will not let devices automatically come up using DHCP, but each interface needs to be specified in a file in /etc/netplan/ with its explicit YAML settings for the networkd or NetworkManager backend renderers.

## Commands

Netplan uses a set of subcommands to drive its behavior:

```
netplan generate: Use /etc/netplan to generate the required configuration for the renderers.
netplan apply: Apply all configuration for the renderers, restarting them as necessary.
netplan try: Apply configuration and wait for user confirmation; will roll back if network is broken or no confirmation is given.
```

Declarative network configuration for various backends

netplan reads network configuration from /etc/netplan/*.yaml which are written by administrators, installers, cloud image instantiations, or other OS deployments. During early boot it then generates backend specific configuration files in /run to hand off control of devices to a particular networking daemon.

Currently supported backends are networkd, NetworkManager and OpenVSwitch.

Both my Ubuntu 22.04 server and desktop configure the network interfaces with netplan.

```bash
# Networkd is running on ubuntu 22.04 server but not on Ubuntu 22.04 desktop
ssh brent@reports11
networkctl
IDX LINK            TYPE     OPERATIONAL SETUP     
  1 lo              loopback carrier     unmanaged
  2 enp0s31f6       ether    routable    configured
  9 vxlan.calico    vxlan    routable    unmanaged
 43 calid91e40e752c ether    degraded    unmanaged
 46 cali56b95e837c6 ether    degraded    unmanaged
 47 cali92441034b36 ether    degraded    unmanaged
 48 cali7b9b66e0016 ether    degraded    unmanaged
 49 cali715c7bde611 ether    degraded    unmanaged

cat /etc/netplan/00-installer-config.yaml 
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s31f6:
      addresses:
      - 10.1.0.110/22
      nameservers:
        addresses:
        - 10.1.2.69
        - 172.20.88.20
        search: []
      routes:
      - to: default
        via: 10.1.1.205
  version: 2

ssh brent@reports-alb
cat /etc/netplan/01-network-manager-all.yaml
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager  
```

# **[How to Bridge Two Network Interfaces in Linux Using Netplan](https://www.tecmint.com/netplan-bridge-network-interfaces/)**

## **[50-cloud-init](https://ubuntuforums.org/showthread.php?t=2492108)**

## Brent's summary

I updated /etc/netplan/50-cloud-init.yaml at it's changes persisted on reboot but if I start having network problems this is the first place I will check. I also only tested this on ubuntu 24.04.

## netplan

Netplan is a utility for easily configuring networking on a Linux system, typically used in Ubuntu. It allows users to configure network interfaces through a simple YAML file.

One common use case is creating a network bridge, which is useful for connecting two or more network interfaces to share a network segment, which is particularly useful in virtualized environments.

## Why Bridging Interfaces is Useful

Bridging network interfaces can be highly beneficial in various scenarios:

- When running virtual machines (VMs), you often need the VMs to communicate with the external network. A bridge allows VMs to appear as if they are physically connected to the same network as the host machine.
- It allows multiple network interfaces to share a single IP subnet, facilitating easier management and communication within the network.
- In complex network setups, bridges can simplify configurations and reduce the need for additional routing.

## Installing bridge-utils in Ubuntu

To bridge network interfaces, you need to install a bridge-utils package which is used to configure and manage network bridges in Linux-based systems.

```bash
sudo apt install bridge-utils
```

## Creating a Network Bridge Using Static IP

Similar to the DHCP configuration, you can also configure static IP addresses on the bridge in the same configuration file.

```bash
# create backup
cd ~
sudo cp /etc/netplan/50-cloud-init.yaml .
sudo vi /etc/netplan/50-cloud-init.yaml
```

## Modify the configuration to assign a static IP to the bridge ‘br0‘

I did not include renderer: networkd when I updated 50-cloud-init.yaml.

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
    enp2s0f1:
      dhcp4: no
  bridges:
    br0:
      dhcp4: no
      addresses: [192.168.122.100/24]
      routes:
        - to: 0.0.0.0/0
          via: 192.168.122.1  # Adjust according to your network configuration
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]  # DNS servers
      interfaces: [enp1s0, enp2s0f1]
```

The actual 50-cloud-init.yaml looked like this.

```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        eno1:
            addresses:
            - 10.1.0.125/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            routes:
            -   to: default
                via: 10.1.1.205
        eno2:
            dhcp4: no
        eno3:
            dhcp4: true
        eno4:
            dhcp4: true
        enp66s0f0:
            dhcp4: true
        enp66s0f1:
            dhcp4: true
        enp66s0f2:
            dhcp4: true
        enp66s0f3:
            dhcp4: true
    bridges:
        br0:
            dhcp4: no
            addresses:
            - 10.1.0.126/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno2]
        br1:
            dhcp4: no
            addresses:
            - 10.13.31.1/24
    version: 2
```

Apply the Configuration Changes: Once you’ve edited the configuration file, apply the changes to update your network settings.

```bash
sudo netplan try
$ sudo netplan apply
reboot
```

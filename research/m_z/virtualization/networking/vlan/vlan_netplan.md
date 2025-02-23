# **[How To Configure VLAN Tagging In Linux [A Step-by-Step Guide]](https://ostechnix.com/configure-vlan-tagging-in-linux/)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

- **[very good explanation of network namespaces and bridging to host](https://yuminlee2.medium.com/linux-networking-network-namespaces-cb6b00ad6ba4)**
- **[use python to run process from network namespace](https://medium.com/@minhaz217/network-namespace-setup-in-linux-using-python-1bc3d67c396)**
- **[persistent network namespaces](https://manpages.ubuntu.com/manpages/focal/en/man1/unshare.1.html)**
- **[extreme swtiches](https://emc.extremenetworks.com/content/oneview/docs/network/devices/docs/l_ov_cf_vlan.html#:~:text=Port%20VLAN%20ID's.-,VLAN%20ID%20(VID),(VIDs)%20and%20VLAN%20names.&text=A%20unique%20number%20between%201,reserved%20for%20the%20Default%20VLAN.)**

802.1Q VLANs are defined by VLAN IDs (VIDs) and VLAN names. A unique number between 1 and 4094 that identifies a particular VLAN. VID 1 is reserved for the Default VLAN. Although VID 1 is reserved as the default vid when linamar configures each switch the delete vid 1 and configure each port with their default which is vid 5.

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
      dhcp4: no
      addresses:
        - 192.168.1.40/24
      routes:
        - to: default
          via: 192.168.1.101
      nameservers:
          addresses: [8.8.8.8, 8.8.4.4]

  vlans:
    vlan10:
      id: 10
      link: ens18
      addresses: [192.168.10.2/24]
```

In the above configuration file, replace the network settings that matches to your own configuration.

ens18: Replace with the name of your physical network interface.
vlan10: Replace with a name for your VLAN.
id: 10: Replace with your desired VLAN ID.
link: ens18: Specify the physical interface to associate the VLAN with.
addresses: Set the IP address and subnet mask for the VLAN.
You can also define multiple VLANs as shown in the following configuration. Just make sure you have used an unique name and IP address for each VLAN.

![mvlan](https://ostechnix.com/wp-content/uploads/2023/11/Configure-VLAN-Tagging-using-Netplan-in-Linux-1024x555.png)

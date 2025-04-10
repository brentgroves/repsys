# 3 VLAN

Configured edge switch port 28,29,31 with vlans: 50,220, and 1220

- all networked access to all machines ceased.

```bash
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: false
      addresses:
      - 10.188.50.201/24    
      routes:
      - to: default
        via: 10.188.50.254
      nameservers:
        addresses:
        - 10.225.50.203
        - 10.224.50.203
```

## 1. Change edge switch back to vlans 50 and 220 only

still no network access.

## 2. try 1 configure VLAN50 only

This config is in r620_203_try_1.yaml.

## 3. try 2 configure VLAN 50 and 220

AI Overview: in netplan is it ok to assign 2 vlans to 1 network interface

Yes, it is generally okay to assign two VLANs to one network interface in Netplan, especially when configured as a trunk port. This allows for multiple VLANs to share the same physical link, improving efficiency and flexibility.

Trunking:
When you configure a physical interface as a trunk, it can carry traffic for multiple VLANs. This is different from an access port, which typically carries traffic for only one VLAN.
Netplan Configuration:
In Netplan, you can configure the physical interface to be a trunk and then assign VLANs to that interface. You'll specify the VLAN IDs and potentially the VLANs' IP addresses and subnets.
Example:
You could have a physical interface like enp0s3 and assign VLANs vlan10 and vlan20 to it, with each VLAN having its own IP address and subnet.
Advantages:
This approach avoids using separate physical interfaces for each VLAN, which can save resources and simplify configuration.
Inter-VLAN Routing:
If you want VLANs to communicate with each other, you'll need to implement inter-VLAN routing, which can be done using a router, a Layer 3 switch, or by configuring the network interface to act as a router.

This config is in r620_203_try_2.yaml.

- added no routes or nameservers on vlan220.

This worked. I could ssh into both 10.188.50.203 and 10.188.220.203

## try 3: configure VLANs 50,220, 1220

- Add vlan1220 section to the r620_203_try_2.yaml file making  r620_203_try_3.yaml.
- added no routes or nameservers on vlan1220.

### result

- I could ssh into both 10.188.50.203 and 10.188.220.203
- I could not ssh into 10.187.220.203 from my laptop.
I don't have a route to 10.187.220.203 from my laptop so I won't be able to ssh into it.

- ssh into 10.188.50.203 and `nmap -v -sn 10.187.220.0/24 | more`.
I could see no hosts on the 10.187.22.0/24 network except my own. I might need a route for responses from other hosts.

## try 4: configure VLAN 1220 only

Configured port 30 as untagged 1220 and configured only ip address 10.187.220.203 with a default route of 10.187.220.254.

- this did not work.  Maybe it would work if I did a fresh off-lin install of the OS.

## try 5: configure VLAN 1220 only

The port is still configured with 50, 220, and 1220 but the netplan yaml will only configure vlan 1220 and the default route will be 10.187.220.254.

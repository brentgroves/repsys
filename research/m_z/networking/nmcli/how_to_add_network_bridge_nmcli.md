# **[How to add network bridge with nmcli (NetworkManager) on Linux](https://www.cyberciti.biz/faq/how-to-add-network-bridge-with-nmcli-networkmanager-on-linux/)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Networking Menu](../networking_menu.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

**Note:** This assumes
Iam using Debian Linux 12/11/10/9 on the desktop. I would like to create network bridge with NetworkManager. But, I am unable to find the option to add br0. How can I create or add network bridge with nmcli for NetworkManager on Linux?

A bridge is nothing but a device which joins two local networks into one network. It works at the data link layer, i.e., layer 2 of the OSI model. Network bridge often used with virtualization and other software. Disabling NetworkManager for a simple bridge especially on Linux Laptop/desktop doesn’t make any sense. The nmcli tool can create Persistent bridge configuration without editing any files. This page shows how to create a bridge interface using the Network Manager command line tool called nmcli.

## How to create/add network bridge with nmcli

The procedure to add a bridge interface on Linux is as follows when you want to use Network Manager:

```bash
# Open the Terminal app
# Get info about the current connection:
nmcli con show
# Add a new bridge:
nmcli con add type bridge ifname br0
# Create a slave interface:
nmcli con add type bridge-slave ifname eno1 master br0
# Turn on br0:
nmcli con up br0
```

Get current network config
You can view connection from the Network Manager GUI in settings:

![](https://www.cyberciti.biz/media/new/faq/2018/01/Getting-Network-Info-on-Linux.jpg)

Another option is to type the following command:

```bash
ssh brent@reports-alb
nmcli con show
nmcli connection show --active
NAME                UUID                                  TYPE      DEVICE          
Wired connection 1  c031620b-0f27-3dea-9352-8b45b7a8b2ea  ethernet  enp0s25         
mpqemubr0           a89655e1-3df3-4eb0-b640-2b7f00ce2789  bridge    mpqemubr0       
br-860dc0d9b54b     390335bd-c36c-4bd3-b188-90aab3bbebbb  bridge    br-860dc0d9b54b 
br-924b3db7b366     1439fb5a-1611-4682-b90b-2e944bf36900  bridge    br-924b3db7b366 
br-b543cc541f49     c06fe11e-e0fd-4d3b-950e-b2b0c16a3b1a  bridge    br-b543cc541f49 
br-ef440bd353e1     fc87473a-82ab-48ed-9f67-61bafbf0b2eb  bridge    br-ef440bd353e1 
docker0             79954717-f033-4c83-96df-636f6dcef469  bridge    docker0         
tap-d951e26a898     8c208343-21f8-4fc2-9f2c-6856138b63f7  tun       tap-d951e26a898 
```

![](https://www.cyberciti.biz/media/new/faq/2018/01/View-the-connections-with-nmcli.jpg)

I have a “Wired connection 1” which uses the eno1 Ethernet interface. My system has a VPN interface too. I am going to setup a bridge interface named br0 and add, (or enslave) an interface to eno1.

How to create a bridge, named br0

```bash
sudo nmcli con add ifname br0 type bridge con-name br0
sudo nmcli con add type bridge-slave ifname eno1 master br0
nmcli connection show
```

![](https://www.cyberciti.biz/media/new/faq/2018/01/Create-bridge-interface-using-nmcli-on-Linux.jpg)

You can disable STP too:

```bash
sudo nmcli con modify br0 bridge.stp no
nmcli con show
nmcli -f bridge con show br0
```

The last command shows the bridge settings including disabled STP:

```yaml
bridge.mac-address:                     --
bridge.stp:                             no
bridge.priority:                        32768
bridge.forward-delay:                   15
bridge.hello-time:                      2
bridge.max-age:                         20
bridge.ageing-time:                     300
bridge.multicast-snooping:              yes
```

## How to turn on bridge interface

You must turn off “Wired connection 1” and turn on br0:

```bash
sudo nmcli con down "Wired connection 1"
sudo nmcli con up br0
nmcli con show
```

Use ip command (or ifconfig command) to view the IP settings:

```bash
ip a s
ip a s br0
```

![](https://www.cyberciti.biz/media/new/faq/2018/01/Build-a-network-bridge-with-nmcli-on-Linux.jpg)

## Optional: How to use br0 with KVM

Now you can connect VMs (virtual machine) created with KVM/VirtualBox/VMware workstation to a network directly without using NAT. Create a file named br0.xml for KVM using vi command or cat command:

cat /tmp/br0.xml

Append the following code:

```xml
<network>
  <name>br0</name>
  <forward mode="bridge"/>
  <bridge name="br0" />
</network>
```

Run virsh command as follows:

```bash
virsh net-define /tmp/br0.xml
virsh net-start br0
virsh net-autostart br0
virsh net-list --all
Sample outputs:

 Name                 State      Autostart     Persistent
----------------------------------------------------------
 br0                  active     yes           yes
 default              inactive   no            yes
```

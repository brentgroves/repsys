# **[How to use bridged networking with libvirt and KVM](https://linuxconfig.org/how-to-use-bridged-networking-with-libvirt-and-kvm)**

**[Back to Research List](../../../../../research/research_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

![cn](https://linuxconfig.org/wp-content/uploads/2021/03/00-how_to_use_bridged_networking_with_libvirt_and_kvm.avif)

AI Overview
Learn more
To access the host network interface in QEMU, you need to configure a "bridged" network setting, which essentially connects the virtual machine's network card directly to your host machine's physical network interface by creating a bridge between them, allowing the guest to access the host's network directly; this is usually achieved by using the -netdev bridge option with the appropriate bridge name in your QEMU command line. 

Libvirt is a free and open source software which provides API to manage various aspects of virtual machines. On Linux it is commonly used in conjunction with KVM and Qemu. Among other things, libvirt is used to create and manage virtual networks. The default network created when libvirt is used is called “default” and uses NAT (Network Address Translation) and packet forwarding to connect the emulated systems with the “outside” world (both the host system and the internet). In this tutorial we will see how to create a different setup using Bridged networking.

## In this tutorial you will learn:

- How to create a virtual bridge
- How to add a physical interface to a bridge
- How to make the bridge configuration persistent
- How to modify firmware rules to allow traffic to the virtual machine
- How to create a new virtual network and use it in a virtual machine

## Software requirements and conventions used

| Category    | Requirements, Conventions or Software Version Used                                                                                                                                                               |
|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| System      | Distribution independent                                                                                                                                                                                         |
| Software    | libvirt, iproute, brctl                                                                                                                                                                                          |
| Other       | Administrative privileges to create and manipulate the bridge interface                                                                                                                                          |
| Conventions | # – requires given linux-commands to be executed with root privileges either directly as a root user or by use of sudo command $ – requires given linux-commands to be executed as a regular non-privileged user |

## he “default” network
When libvirt is in use and the libvirtd daemon is running, a default network is created. We can verify that this network exists by using the virsh utility, which on the majority of Linux distribution usually comes with the libvirt-client package. To invoke the utility so that it displays all the available virtual networks, we should include the net-list subcommand:

```bash
sudo virsh net-list --all
 Name      State    Autostart   Persistent
--------------------------------------------
 default   active   yes         yes

```

In the example above we used the --all option to make sure also the inactive networks are included in the result, which should normally correspond to the one displayed below:

```bash
Name      State    Autostart   Persistent
--------------------------------------------
 default   active   yes         yes
```

To obtain detailed information about the network, and eventually modify it, we can invoke virsh with the edit subcommand instead, providing the network name as argument:

```bash
sudo virsh net-edit default
Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny
  3. /usr/bin/code
  4. /bin/ed

Choose 1-4 [1]: 
```

A temporary file containing the xml network definition will be opened in our favorite text editor. In this case the result is the following:

```xml
<network>
  <name>default</name>
  <uuid>168f6909-715c-4333-a34b-f74584d26328</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:48:3f:0c'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

As we can see, the default network is based on the use of the virbr0 virtual bridge, and uses NAT based connectivity to connect the virtual machines which are part of the network to the outside world. We can verify that the bridge exists using the ip command:

```bash
ip link show type bridge
5: lxdbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 00:16:3e:a6:6d:bf brd ff:ff:ff:ff:ff:ff
7: lxcbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:16:3e:00:00:00 brd ff:ff:ff:ff:ff:ff
9: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 42:86:f0:20:a4:84 brd ff:ff:ff:ff:ff:ff
18: virbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:eb:f6:cd brd ff:ff:ff:ff:ff:ff
```

In our case the command above returns the following output:

```bash
5: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:48:3f:0c brd ff:ff:ff:ff:ff:ff
```

To show the interfaces which are part of the bridge, we can use the ip command and query only for interfaces which have the virbr0 bridge as master:

```bash
ip link show master virbr0
20: vnet1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master virbr0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether fe:54:00:66:d7:b9 brd ff:ff:ff:ff:ff:ff
```

The result of running the command is:

```bash
6: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:48:3f:0c brd ff:ff:ff:ff:ff:ff
```

As we can see, there is only one interface currently attached to the bridge, virbr0-nic. The virbr0-nic interface is a virtual ethernet interface: it is created and added to the bridge automatically, and its purpose is just to provide a stable MAC address (52:54:00:48:3f:0c in this case) for the bridge.

In my case I see that link/ether fe:54:00:66:d7:b9 is showing on the vm and the bridge.

Other virtual interfaces will be added to the bridge when we create and launch virtual machines. For the sake of this tutorial I created and launched a Debian (Buster) virtual machine; if we re-launch the command we used above to display the bridge slave interfaces, we can see a new one was added, vnet0:

```bash
$ ip link show master virbr0
6: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:54:00:48:3f:0c brd ff:ff:ff:ff:ff:ff
7: vnet0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master virbr0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether fe:54:00:e2:fe:7b brd ff:ff:ff:ff:ff:ff
```

In my case I only see 1 interface and that is to the running vm.

```bash
ip link show master virbr0
20: vnet1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master virbr0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether fe:54:00:66:d7:b9 brd ff:ff:ff:ff:ff:ff
```

## IMPORTANT

No physical interfaces should ever be added to the virbr0 bridge, since it uses NAT to provide connectivity.


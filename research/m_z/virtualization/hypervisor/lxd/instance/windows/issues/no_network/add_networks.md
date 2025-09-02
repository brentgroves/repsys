# **[]()**

how to add networking to windows vm in lxd

AI Overview
To add networking to a Windows VM in LXD, you can use the default internal network, attach an existing managed network, or configure a bridged NIC that connects to a host bridge or physical interface using the lxc config device add command. After adding the device, you may need to configure the Windows guest's network settings (e.g., using cloud-init for static IP, or by allowing it to get an IP from DHCP) to connect to the network.
Method 1: Using the Default Internal Network
During LXD initialization, a default internal network (lxdbr0) is created, connecting virtual machines to the host's physical network via NAT.
If you don't specify any network device when creating the VM, it will automatically be connected to this default bridge.
Devices on the physical network cannot initiate inbound connections to VMs on this NATed network.
This **[video](https://www.youtube.com/watch?v=vYK1aLSDVIw&t=1349)** explains how to configure networking for LXD virtual machines on Ubuntu:

Method 2: **[Attaching an Existing Managed Network](https://www.youtube.com/watch?v=d7o_SVSOCkE&t=355)**
If you have created a managed network, you can attach it to your instance using lxc network attach or by configuring the network device via the LXD UI or with lxc config device add.
This allows LXD to have complete information about the network configuration.
You can watch this video to see how to add a network to your LXD instance and configure it:

Method 3: Connecting to a Host Bridge or Physical Interface

1. Identify your target interface:
Use ip addr or ifconfig on the LXD host to find the name of the physical interface or existing Linux bridge you want to connect to.
2. Add the NIC device:
Use the lxc config device add command:
For a host bridge: lxc config device add <instance_name> eth0 nic nictype=bridged parent=<bridge_name> (e.g., parent=br0).
For a direct physical interface: lxc config device add <instance_name> eth0 nic nictype=macvlan.
3. Restart the instance:
lxc restart <instance_name>.
4. Configure the guest OS:
Inside the Windows VM, you may need to enable automatic IP address configuration (DHCP) or provide static IP details.
Important Considerations
Cloud-init:
.
For virtual machines, you may need to use cloud-init to configure network settings, especially when using routed NICs.
Device Naming:
.
When adding a network device, it's good practice to specify a device name (e.g., eth0) to ensure compatibility with image-provided drivers.
Network Type (nictype):
.
You can choose between bridged, macvlan, or other NIC types based on your network setup.

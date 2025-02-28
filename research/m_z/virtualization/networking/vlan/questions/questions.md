# Linamar Network Questions

## Can we access both vlan from vm and give vm network reachable IP

### multipass docs

<https://canonical.com/multipass/docs/configure-static-ips>

### AI Overview

Learn more
To make a Multipass VM network accessible, you need to configure the network settings to use a "bridged" network mode, which essentially connects the VM directly to your host machine's physical network, allowing external access by using the VM's assigned IP address; this is typically done when launching the VM with the --network flag and specifying the desired network interface on your host machine.
Key steps:
Launch with bridged network: When creating a new Multipass VM, use the --network option with the name of your host network interface to enable bridged networking:
Code

    multipass launch --name myvm --network enp0s3  
Replace enp0s3 with the actual name of your network interface on your host machine.
Check VM IP address: Once the VM is running, use multipass exec myvm ip addr show to find the assigned IP address.
Access the VM: You can now access the VM from other devices on your network using its IP address.

### problem

<https://askubuntu.com/questions/1425752/how-to-bridge-local-lan-using-multipass>

1

Looking for some assistance in trying to get the network bridging to work (consistently/more than once) when creating VMs with Multipass. I have tried so many things with the documentation I've found, yet nothing seems to work, or have any level of consistency.

My driver is lxd I am using network manager I initially used launch --network=en0, which is my physical ethernet adapter, and this worked the first time. I was prompted to create a bridge the first time I did this, and any VM I launched would show two IPs, one for the 10.x.x.x Multipass network and the other 192.168.1.x for my local LAN and everything was great.

After one reboot of my Ubuntu server, none of that works anymore and even when attempting to launch a VM with --network= I get a single 10.x.x.x address on the VM and is not accessible from my LAN.

From top r620, 10.188.50.203, apply r620_203.yaml netplan configuration with bridge.

## Can Multipass VM access both 50 and 220

Yes.

```bash
ssh brent@10.188.50.201
multipass shell luminous-louvar
sudo apt update
ping 10.188.220.50
PING 10.188.220.50 (10.188.220.50) 56(84) bytes of data.
64 bytes from 10.188.220.50: icmp_seq=1 ttl=127 time=1.08 ms
64 bytes from 10.188.220.50: icmp_seq=2 ttl=127 time=0.698 ms

ping 10.188.50.79
PING 10.188.50.79 (10.188.50.79) 56(84) bytes of data.
64 bytes from 10.188.50.79: icmp_seq=1 ttl=127 time=1.08 ms
64 bytes from 10.188.50.79: icmp_seq=2 ttl=127 time=0.690 ms
exit

ssh brent@10.41.219.209

```

### how does multipass vm access the internet

A Multipass virtual machine accesses the internet by leveraging the host machine's network connection, essentially "sharing" the host's internet access; meaning the VM uses the same network interface and IP configuration as the host machine to reach the internet, with the underlying hypervisor managing the traffic between the VM and the host network.

Setup k8sgw2,50.201, using the r620_201.yaml then install multipass.

```bash
multipass list
Name                    State             IPv4             Image
luminous-louvar         Running           10.41.219.209    Ubuntu 24.04 LTS
ip route show table all
default via 10.188.50.254 dev eno1 proto static 
10.41.219.0/24 dev mpqemubr0 proto kernel scope link src 10.41.219.1 
10.188.50.0/24 dev eno1 proto kernel scope link src 10.188.50.201 
10.188.220.0/24 dev vlan220 proto kernel scope link src 10.188.220.201 

ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
...
11: mpqemubr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 52:54:00:de:88:9b brd ff:ff:ff:ff:ff:ff
    inet 10.41.219.1/24 brd 10.41.219.255 scope global mpqemubr0
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fede:889b/64 scope link 
       valid_lft forever preferred_lft forever
12: tap-1370c02f459: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master mpqemubr0 state UP group default qlen 1000
    link/ether 2e:cd:43:31:e6:bc brd ff:ff:ff:ff:ff:ff
    inet6 fe80::2ccd:43ff:fe31:e6bc/64 scope link 
       valid_lft forever preferred_lft forever

```

## How to collect data from moxa server

configure a trunk port in albion for 50 and 70 vlans and make 50 the default for untagged traffic. Listen on 70 IP and send data to 10.188.50.202 or Azure SQL db.

## Can I see 10.187.50.0/24 from Avilla

change address of laptop to 10.187.220.230/24.
No, if 10.187.220.51, can connect to 10.187.73.0/24, there must be a host route setup from Avilla to Albion.

```bash
ip route show table all
...
nmap -v -sn 10.187.220.0/24
no hosts
```

## Are there any IP network routes from 10.188 to 10.187 or vise-versa?

Yes. The following routes exist.

10.187.40.0/24 to 10.188.40.0/24
10.188.40.0/24 to 10.187.40.0/24

```bash
ssh brent@10.188.40.230
nmap -v -sn 10.188.73.0/24
no hosts
If Mach2 is able to communicate with the honda vlan there my be a host route instead of network route.

traceroute 10.187.40.123
Note: no gateway entry.
1 10.188.40.251 // Jared said this is a fortigate ip
2 10.187.249.11 // Goes to the AOS transport circuit.
3 10.187.40.123 // host

AOS transport circuit
10.x.10.11
10.y.10.11

traceroute 10.188.50.202
1 10.188.40.251 // ?
2 10.188.50.202

ssh brent@10.187.40.123
traceroute 10.188.50.202
_gateway (10.187.40.254)
10.188.249.1
10.188.50.202
```

## Can I see honda vlan 70 from 220 address

No. There is not a network route from 10.188.220.0/24 to 10.187.73.0/24

Is the Avilla 73 vlan cofigured with access to the 220 vlan?
Is this a routing rule that has been created on the Avilla FW 10.188.255.11?

src: 10.188.220.230
dest: 10.188.73.0/24
result: did not work.

maybe the route is a host only route such as:
src: 10.188.220.50
dst: 10.188.73.0/24

## What Avilla VLAN has access to Albion Kobe VLAN

Look at core IP router:

to (Alvilla): 10.188.40.0/24
via: 10.187.40.0/24

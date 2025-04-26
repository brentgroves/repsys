# Port Forwarding from research21 to k8sgw2

## cleanup

- **[delete rules](./delete_rules.md)**
- **[delete namespace](./delete_namespace.md)**

## Plan

Use **[Port forward using iptables](../port_forward_using_iptables.md)** as an example to port forward traffic from 10.187.40.123 to 10.187.220.50.

1. verify we can connect to 10.188.50.202.

## we are using iptables-nft

```bash
# iptables is actually iptables-nft
update-alternatives --display iptables
iptables - auto mode
  link best version is /usr/sbin/iptables-nft
  link currently points to /usr/sbin/iptables-nft
  link iptables is /usr/sbin/iptables
  slave iptables-restore is /usr/sbin/iptables-restore
  slave iptables-save is /usr/sbin/iptables-save
/usr/sbin/iptables-legacy - priority 10
  slave iptables-restore: /usr/sbin/iptables-legacy-restore
  slave iptables-save: /usr/sbin/iptables-legacy-save
/usr/sbin/iptables-nft - priority 20
  slave iptables-restore: /usr/sbin/iptables-nft-restore
  slave iptables-save: /usr/sbin/iptables-nft-save
sudo tcpdump -i enp0s25 'dst 8.8.8.8 and src 10.187.40.123'

```

## enable packet routing

To enable packet routing on a Linux system, you need to configure the kernel to forward packets destined for other networks. This typically involves enabling IP forwarding and setting up routing tables with appropriate routes

Temporarily Enable IP Forwarding:

```bash
cat /proc/sys/net/ipv4/ip_forward
0

# (temporarily enables forwarding)
echo 1 > /proc/sys/net/ipv4/ip_forward
# or
sudo sysctl -w net.ipv4.ip_forward=1 

# verify
cat /proc/sys/net/ipv4/ip_forward
1

```

## AI Overview: how to sysctl to make routing permanent

Make it persistent (recommended):

Edit the /etc/sysctl.conf file and add or modify the line net.ipv4.ip_forward=1
Apply the changes with sudo sysctl -p

```bash
sudo sed -i 's/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p
The -p option, followed by a filename (e.g., /etc/sysctl.conf), instructs sysctl to read and apply the kernel parameter settings defined in a file.
```

Then run the same command, but replace the -p flag with--system:

```bash
# --system
              # Load settings from all system configuration files. See the SYSTEM FILE PRECEDENCE section below.
sudo sysctl --system
. . .
* Applying /usr/lib/sysctl.d/50-pid-max.conf ...
kernel.pid_max = 4194304
* Applying /etc/sysctl.d/99-cloudimg-ipv6.conf ...
net.ipv6.conf.all.use_tempaddr = 0
net.ipv6.conf.default.use_tempaddr = 0
* Applying /etc/sysctl.d/99-sysctl.conf ...
net.ipv4.ip_forward = 1
* Applying /usr/lib/sysctl.d/protect-links.conf ...
fs.protected_fifos = 1
fs.protected_hardlinks = 1
fs.protected_regular = 2
fs.protected_symlinks = 1
* Applying /etc/sysctl.conf ...
net.ipv4.ip_forward = 1
```

## Make default FORWARD rule DROP

Now that we're forwarding packets, we want to make sure that we're not just forwarding them willy-nilly around the network. If we check the current rules in the FORWARD chain (in the default "filter" table):

```bash
oot@isdev:/home/brent/src/pki# iptables -L FORWARD
Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

# Each chain is a list of rules which can match a set of packets. Each rule specifies what to do with a packet that matches. This is called a `target', which may be a jump to a user-defined chain in the same table.

```

We see that the default is ACCEPT, so we'll change that to DROP:

<!-- I left it as accept for this experiment. -->
```bash

iptables -P FORWARD DROP
# iptables -P FORWARD ACCEPT
# iptables -L FORWARD
Chain FORWARD (policy DROP)
target     prot opt source               destination
#
```

OK, now we want to make some changes to the nat iptable so that we have routing. Let's see what we have first:

```bash
# From isdev in Albion using vlan 40
iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
```

## enable masquerading

So, firstly, we'll enable masquerading from the 10.188.50.0/24 network onto our main ethernet interface enp0s25:

In iptables, **[masquerading](../../../masquerading/masquerading.md)**, a form of SNAT (Source Network Address Translation), allows multiple internal network devices to share a single external IP address, effectively hiding their private IPs behind the router's public IP.

```bash
# from isdev at albion office on vlan 40 through enx803f5d090eb3
ip a              
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s25: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 18:03:73:1f:84:a4 brd ff:ff:ff:ff:ff:ff
    inet 10.187.40.123/24 brd 10.187.40.255 scope global dynamic noprefixroute enp0s25
       valid_lft 51365sec preferred_lft 51365sec
    inet6 fe80::6fd5:28c2:e3ca:d7fd/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

# nat: This table is consulted when a packet that creates a new connection is encountered. It consists of three built-ins: PREROUTING (for altering packets as soon as they come in), OUTPUT (for altering locally-generated packets before routing), and POSTROUTING (for altering packets as they are about to go out).
```

## start here

The idea is to apply the same rules as we did to forward packets to namespaces to forward packets to a web service on a different host.

```bash
iptables -t nat -A POSTROUTING -s 10.188.50.0/24 -o enp0s25 -j MASQUERADE

# -t nat: Specifies the NAT table. 
# -A POSTROUTING: Appends a rule to the POSTROUTING chain. 
# -o eth0: Specifies the outgoing interface (e.g., eth0). 
# -j MASQUERADE: Sets the target to MASQUERADE. 
# -m is for matching module name and not string. By using a particular module you get certain options to match. See the cpu module example above. With the -m tcp the module tcp is loaded. The tcp module allows certain options: --dport, --sport, --tcp-flags, --syn, --tcp-option to use in iptables rules
 # -S shows you how to type in the table rule
iptables -t nat -S
iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  192.168.0.0/24       anywhere     

# verify
# list rules by specification
# Purpose: The -S option is used to show the current iptables rules in a format that is easy to read and understand, and that can be used to recreate the rules if needed.
# iptables-legacy -t nat -S only microk8s uses these older tables.

sudo iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A POSTROUTING -s 192.168.0.0/24 -o enp0s25 -j MASQUERADE


# from default namespace
sudo tcpdump -i enp0s25 'dst 8.8.8.8 and src 10.187.40.123'

# This produces no output because src has been changed from 192.168.0.2 to 10.187.40.123
sudo tcpdump -i enp0s25 'dst 8.8.8.8 and src 192.168.0.2'


# from netns1
ip netns exec netns1 /bin/bash
ping 8.8.8.8
```

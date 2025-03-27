# **[Fun with network namespaces](https://www.gilesthomas.com/2021/03/fun-with-network-namespaces)**

**[Research List](../../../../../research_list.md)**\
**[Detailed Status](../../../../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../../../../a_status/current_tasks.md)**\

**[Main](../../../../../../README.md)**

Linux has some amazing kernel features to enable containerization. Tools like Docker are built on top of them, and at PythonAnywhere we have built our own virtualization system using them.

One part of these systems that I've not spent much time poking into is network namespaces. Namespaces are a general abstraction that allows you to separate out system resources; for example, if a process is in a mount namespace, then it has its own set of mounted disks that is separate from those seen by the other processes on a machine -- or if it's in a process namespace, then it has its own cordoned-off set of processes visible to it (so, say, ps auxwf will just show the ones in its namespace).

As you might expect from that, if you put a process into a network namespace, it will have its own restricted view of what the networking environment looks like -- it won't see the machine's main network interface,

This provides certain advantages when it comes to security, but one that I thought was interesting is that because two processes inside different namespaces would have different networking environments, they could both bind to the same port -- and then could be accessed from outside via port forwarding.

To put that in more concrete terms: my goal was to be able to start up two Flask servers on the same machine, both bound to port 8080 inside their own namespace. I wanted to be able to access one of them from outside by hitting port 6000 on the machine, and the other by hitting port 6001.

Here is a run through how I got that working; it's a lightly-edited set of my "lab notes".

Creating a network namespace and looking inside
The first thing to try is just creating a network namespace, called netns1:

```bash
sudo ip netns add netns1
```

Now, you can "go into" the created namespace by using ip netns exec namespace-name, so we can run Bash there and then use ip a to see what network interfaces we have available:

```bash
sudo ip netns exec netns1 /bin/bash
ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
# exit
```

(I'll put the ip netns exec command at the start of all code blocks below if the block in question needs to be run inside the namespace, even when it's not necessary, so that it's reasonably clear which commands are to be run inside and which are not.)

So, we have a new namespace, and when we're inside it, there's only one interface available, a basic loopback interface. We can compare that with what we see with the same command outside:

```bash
# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:d6:01:7e:06:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.173/24 brd 10.0.0.255 scope global dynamic ens5
       valid_lft 2802sec preferred_lft 2802sec
    inet6 fe80::8d6:1ff:fe7e:65b/64 scope link
       valid_lft forever preferred_lft forever
```

There we can see the actual network card attached to the machine, which has the name ens5.

## Getting the loopback interface working

You might have noticed that the details shown for the loopback interface inside the namespace were much shorter, too -- no IPv4 or IPv6 addresses, for example. That's because the interface is down by default. Let's see if we can fix that:

```bash
ip netns exec netns1 /bin/bash
ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
ping 127.0.0.1
ping: connect: Network is unreachable
ip link set dev lo up
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.019 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.027 ms
^C
--- 127.0.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1022ms
rtt min/avg/max/mdev = 0.019/0.023/0.027/0.004 ms

```

So, we could not ping the loopback when it was down (unsurprisingly) but once we used the ip link set dev lo up command, it showed up as configured and was pingable.

Now we have a working loopback interface, but the external network still is down:

```bash
ip netns exec netns1 /bin/bash
ping 8.8.8.8
ping: connect: Network is unreachable
```

Again, that makes sense. There's no non-loopback interface, so there's no way to send packets to anywhere but the loopback network.

Virtual network interfaces: connecting the namespace
What we need is some kind of non-loopback network interface inside the namespace. However, we can't just put the external interface ens5 inside there; an interface can only be in one namespace at a time, so if we put that one in there, the external machine would lose networking.

What we need to do is create a virtual network interface. These are created in pairs, and are essentially connected to each other. This command:

```bash
ip link add veth0 type veth peer name veth1
```

Creates interfaces called veth0 and veth1. Anything sent to veth0 will appear on veth1, and vice versa. It's as if they were two separate ethernet cards, connected to the same hub (but not to anything else). Having run that command (outside the network namespace) we can list all of our available interfaces:

```bash
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:d6:01:7e:06:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.173/24 brd 10.0.0.255 scope global dynamic ens5
       valid_lft 2375sec preferred_lft 2375sec
    inet6 fe80::8d6:1ff:fe7e:65b/64 scope link
       valid_lft forever preferred_lft forever
5: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether ce:d5:74:80:65:08 brd ff:ff:ff:ff:ff:ff
6: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 22:55:4e:34:ce:ba brd ff:ff:ff:ff:ff:ff
```

You can see that they're both there, and are currently down. I read the veth1@veth0 notation as meaning "virtual interface veth1, which is connected to the virtual interface veth0".

We can now move one of them -- veth1 -- into the network namespace netns1, which means that we have the interface outside connected to the one inside:

```bash
ip link set veth1 netns netns1
```

Now, from outside, we see this:

```bash
# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:d6:01:7e:06:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.173/24 brd 10.0.0.255 scope global dynamic ens5
       valid_lft 2368sec preferred_lft 2368sec
    inet6 fe80::8d6:1ff:fe7e:65b/64 scope link
       valid_lft forever preferred_lft forever
6: veth0@if5: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 22:55:4e:34:ce:ba brd ff:ff:ff:ff:ff:ff link-netns netns1
```

veth1 has disappeared (and veth0 is now @if5, which is interesting -- not sure why, though it seems to make some kind of sense given that veth1 is now inside another namespace). But anyway, inside, we can see our moved interface:

```bash
root@giles-devweb1:~# ip netns exec netns1 /bin/bash
root@giles-devweb1:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
5: veth1@if6: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether ce:d5:74:80:65:08 brd ff:ff:ff:ff:ff:ff link-netnsid 0
```

At this point we have a network interface outside the namespace, which is connected to an interface inside. However, in order to actually use them, we'll need to bring the interfaces up and set up routing. The first step is to bring the outside one up; we'll give it the IP address 192.168.0.1 on the 192.168.0.0/24 subnet (that is, the network covering all addresses from 192.168.0.0 to 192.168.0.255)

## start here

```bash
# ip addr add 192.168.0.1/24 dev veth0
# ip link set dev veth0 up
# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:d6:01:7e:06:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.173/24 brd 10.0.0.255 scope global dynamic ens5
       valid_lft 3567sec preferred_lft 3567sec
    inet6 fe80::8d6:1ff:fe7e:65b/64 scope link
       valid_lft forever preferred_lft forever
6: veth0@if5: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state LOWERLAYERDOWN group default qlen 1000
    link/ether 22:55:4e:34:ce:ba brd ff:ff:ff:ff:ff:ff link-netns netns1
    inet 192.168.0.1/24 scope global veth0
       valid_lft forever preferred_lft forever
```

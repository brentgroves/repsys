# How to send an ARP request

## references

<https://networkengineering.stackexchange.com/questions/19947/how-to-send-an-arp-request-manually>

## **[arping](https://github.com/ThomasHabets/arping)**

The arping utility sends ARP and/or ICMP requests to the specified host and displays the replies. The host may be specified by its hostname, its IP address, or ...

arping [-AbDfhqUV] [-c count] [-w deadline] [-i interval] [-s source] [-I interface] {destination}

Arping is a util to find out if a specific IP address on the LAN is 'taken'
and what MAC address owns it. Sure, you *could* just use 'ping' to find out if
it's taken and even if the computer blocks ping (and everything else) you still
get an entry in your ARP cache. But what if you aren't on a routable net? Or
the host blocks ping (all ICMP even)? Then you're screwed. Or you use arping.

Command 'arping' not found, but can be installed with:
sudo apt install iputils-arping  # version 3:20211215-1, or
sudo apt install arping          # version 2.22-1

Introduction
------------

Arping is a util to find out if a specific IP address on the LAN is 'taken'
and what MAC address owns it. Sure, you *could* just use 'ping' to find out if
it's taken and even if the computer blocks ping (and everything else) you still
get an entry in your ARP cache. But what if you aren't on a routable net? Or
the host blocks ping (all ICMP even)? Then you're screwed. Or you use arping.

Why it's not stupid
-------------------

Say you have a block of N real IANA-assigned IP-addresses. You want to debug
the net and you don't know which IP addresses are taken. You can't ping anyone
before you take the IP, and you can't pick an IP before you know which are
already taken. Catch 22. But with arping you can 'ping' the IP and if you get
no response, the IP is available.

Example uses
------------

If some box is dumping non-IP (like IPX) garbage and you don't know which box
it is, you can ping by MAC to get the IP and fix the problem.

If you are on someone else's net and want to 'borrow' a real IP address instead
of using one of those 10.x.x.x-addresses the DHCP hands out you probably want
to know which ones are taken, or people will get mad (a friend of mine got a
call on his cellphone about 15 seconds after he accidentally 'stole' an IP,
oops).

## question posed

I recently sniffed with Tcpdump a packet "ARP, Request who-has 192.168.2.3 tell 192.168.2.2, length 28".

I would like to reproduce this message, and to send an ARP request from my laptop to any IP I would decide. How can I do this ?

I would be interested as well in forcing refreshing the whole ARP table. I know that deleting the table will renew it but only laptop this operation is really slow and it can take up to 1/2/5 minutes to rebuild the complete ARP table. Is there a way to force rebuilding the table, by sending a broadcasted ARP request ?

## answer

First of all lets have a look at why we actually need ARP.
Computers on the same subnet communicate directly with each other using a layer 2 MAC address.

So if you try to contact a computers IP-address your computer calculates if the computer is on the same network.

If the computer is on the same network your computer checks if its arp table already contains the MAC address of the target host. If the table does not contain the MAC address your computer needs to obtain it.

This is done via ARP-requests (who has 192.168.2.2, send MAC address to 192.168.2.2 from your example output).

## So how can you issue ARP-requests on your own?

By using what we know from above we can make your computer do so:

delete your ARP table (sudo arp -ad on Mac OS X)
contact other computers on your local network (eg ping 192.168.2.2).

The underlying network stack will check if it knows the MAC address (which it does not) and issue an ARP-request.

There is no need to have a complete arp table already before you actually need it when communicating with other hosts, but if you explicitly want to have it you could ping all hosts in your network:

```bash
for i in {1..254}; do ping -c 1 192.168.2.$i > /dev/null &; done
```

This command

- pings every host in your network (192.168.2.{1..254})
- once (-c 1)
- and outputs the results to /dev/null
- You should have all active hosts on your network in your arp table afterwards.

## Using tools

You could also use **[arping](https://github.com/ThomasHabets/arping)** to issue ARP-requests for IP-addresses from your command line.

If your need is to reproduce the same (getting same packet again), capture the packet into a file using tcpdump (at the receiving end) and replay the captured packets using tcpreplay tool (at the sending end).

While capturing packet(s) using tcpdump, use the "-w " option to save packet(s) into a file. The captured packet(s) in the file can be replayed using tcpreply.

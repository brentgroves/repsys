# **[arping](https://github.com/ThomasHabets/arping)**

The arping utility sends ARP and/or ICMP requests to the specified host and displays the replies. The host may be specified by its hostname, its IP address, or ...

Arping is a util to find out if a specific IP address on the LAN is 'taken'
and what MAC address owns it. Sure, you *could* just use 'ping' to find out if
it's taken and even if the computer blocks ping (and everything else) you still
get an entry in your ARP cache. But what if you aren't on a routable net? Or
the host blocks ping (all ICMP even)? Then you're screwed. Or you use arping.

## install

Command 'arping' not found, but can be installed with:
sudo apt install iputils-arping  # version 3:20211215-1, or
sudo apt install arping          # version 2.22-1

## usage

```bash
arping [-AbDfhqUV] [-c count] [-w deadline] [-i interval] [-s source] [-I interface] {destination}

OPTIONS
       -A
           The same as -U, but ARP REPLY packets used instead of ARP REQUEST.

       -b
           Send only MAC level broadcasts. Normally arping starts from sending broadcast, and
           switch to unicast after reply received.

       -c count
           Stop after sending count ARP REQUEST packets. With deadline option, instead wait for
           count ARP REPLY packets, or until the timeout expires.

       -D
           Duplicate address detection mode (DAD). See RFC2131, 4.4.1. Returns 0, if DAD
           succeeded i.e. no replies are received.

       -f
           Finish after the first reply confirming that target is alive.

       -I interface
           Name of network device where to send ARP REQUEST packets.

       -h
           Print help page and exit.

       -q
           Quiet output. Nothing is displayed.

       -s source
           IP source address to use in ARP packets. If this option is absent, source address is:

               • In DAD mode (with option -D) set to 0.0.0.0.

               • In Unsolicited ARP mode (with options -U or -A) set to destination.

               • Otherwise, it is calculated from routing tables.

       -U
           Unsolicited ARP mode to update neighbours' ARP caches. No replies are expected.

       -V
           Print version of the program and exit.

       -w deadline
           Specify a timeout, in seconds, before arping exits regardless of how many packets have
           been sent or received. In this case arping does not stop after count packet are sent,
           it waits either for deadline expire or until count probes are answered.

       -i interval
           Specify an interval, in seconds, between packets.

```

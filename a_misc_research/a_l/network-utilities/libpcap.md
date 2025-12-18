# **[pcap](http://yuba.stanford.edu/~casado/pcap/section1.html)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

- Download libpcap source from <www.tcpdump.org> here
- Download libpcap for win32 from <www.winpcap.org>
- Check out a better pcap tutorial **[here](http://www.tcpdump.org/pcap.htm)**

## Front matter

This is a slightly modified and extended version of my older pcap tutorial. Revisiting this work five years later, I am necessarily dumber (age and beer) yet hopefully somewhat more knowledgeable. Contact information has changed, please send your hate-mail to casado at cs.stanford.edu.

## Contents

Intro (You are already here)
Capturing our First Packet
Writing a Basic Packet Capturing Engine
Analyzing packets..... (in progress)

## Who this is for

This tutorial assumes a cursory knowledge in networks; what a packet is, Ethernet vs. IP vs. TCP vs. UDP etc. If these concepts are foreign I highly suggest you invest in a good (e.g. probably can't find at Best Buy) networking book. My favorites are:

- Computer Networking : A Top-Down Approach Featuring the Internet (3rd Edition) by James F. Kurose, Keith W. Ross
- UNIX Network Programming by W. Richard Stevens
- The Protocols (TCP/IP Illustrated, Volume 1) by W. Richard Stevens

Intro: Finally, you've made it (either by reading, skimming or skipping) to the start of the tutorial. We'll start at the verryyy begining and define a few thing before getting into the nity-grity -- howver if you are eager to get moving, scroll to the bottom of this page, cut, paste, compile and enjoy. For the rest of you, the following two definition may give you a clue about what we are doing, what the tools we will be using.

Packet Capture Roughly means, to grab a copy of packets off of the wire before they are processed by the operating system. Why would one want to do this? Well, its cool. More practically, packet capture is widely used in network security tools to analyze raw traffic for detecting malicious behaviour (scans and attacks), sniffing, fingerprinting and many other (often devious) uses.
libpcap "provides implementation-independent access to the underlying packet capture facility provided by the operating system" (Stevens, UNP page. 707). So pretty much, libpcap is the library we are going to use to grab packets right as they come off of the network card.
Getting Started Well there is an awful lot to cover.. so lets just get familiar with libpcap. All the examples in this tutorial assume that you are sitting on an Ethernet. If this is not the case, then the basics are still relevant, but the code presented later on involving decoding the Ethernet header obviously isn't :-( *sorry*. Allright... crack your knuckles *crunch* and lets get ready to code our FIRST LIBPCAP PROGRAM :). Go ahead and copy the following program into your favorite editor (which should be vim if you have any sense :-) save, and compile with...

```bash
%>gcc ldev.c -lpcap
```

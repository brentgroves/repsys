# **[autonomous system](https://www.cloudflare.com/learning/network-layer/what-is-an-autonomous-system/)**

## What is an autonomous system?

The Internet is a network of networks*, and autonomous systems are the big networks that make up the Internet. More specifically, an autonomous system (AS) is a large network or group of networks that has a unified routing policy. Every computer or device that connects to the Internet is connected to an AS.

![](https://cf-assets.www.cloudflare.com/slt3lc6tev37/2VQ6NpacA6xXz9B8iAE7re/e06c5e47d5138d05b27c208a59373a30/autonomous-system-diagram.svg)

Imagine an AS as being like a town's post office. Mail goes from post office to post office until it reaches the right town, and that town's post office will then deliver the mail within that town. Similarly, data packets cross the Internet by hopping from AS to AS until they reach the AS that contains their destination Internet Protocol (IP) address. Routers within that AS send the packet to the IP address.

Every AS controls a specific set of IP addresses, just as every town's post office is responsible for delivering mail to all the addresses within that town. The range of IP addresses that a given AS has control over is called their "IP address space."

Most ASes connect to several other ASes. If an AS connects to only one other AS and shares the same routing policy, it may instead be considered a subnetwork of the first AS.

Typically, each AS is operated by a single large organization, such as an Internet service provider (ISP), a large enterprise technology company, a university, or a government agency.

## What is an AS routing policy?

An AS routing policy is a list of the IP address space that the AS controls, plus a list of the other ASes to which it connects. This information is necessary for routing packets to the correct networks. ASes announce this information to the Internet using the Border Gateway Protocol (BGP).

## What is IP address space?

A specified group or range of IP addresses is called "IP address space." Each AS controls a certain amount of IP address space. (A group of IP addresses can also be called an IP address "block".)

Imagine if all the phone numbers in the world were listed in order, and each telephone company was assigned a range: Phone Co. A controlled numbers 000-0000 through 599-9999, and Phone Co. B controlled numbers 600-0000 through 999-9999. If Alice calls Michelle at 555-2424, her call will be routed to Michelle via Phone Co. A. If she calls Jenny at 867-5309, her call will be routed to Jenny by Phone Co. B.

This is sort of how IP address space works. Suppose Acme Co. operates an AS and controls an IP address range that includes the address 192.0.2.253. If a computer sends a packet to 192.0.2.253, the packet will eventually reach the AS controlled by Acme Co. If that first computer is also sending packets to 198.51.100.255, the packets go to a different AS (although they may pass through Acme Co.'s AS on the way).

## What are IP address prefixes?

When networking engineers communicate which IP addresses are controlled by which ASes, they do so by talking about the IP address "prefixes" owned by each AS. An IP address prefix is a range of IP addresses. Because of the way IP addresses are written, IP address prefixes are expressed in this fashion: 192.0.2.0/24. This represents IP addresses 192.0.2.0 through 192.0.2.255, not 192.0.2.0 through 192.0.2.24.

## What is an autonomous system number (ASN)?

Each AS is assigned an official number, or autonomous system number (ASN), similar to how every business has a business license with an unique, official number. But unlike businesses, external parties often refer to ASes by their number alone.

AS numbers, or ASNs, are unique 16 bit numbers between 1 and 65534 or 32 bit numbers between 131072 and 4294967294. They are presented in this format: AS(number). For instance, Cloudflare's ASN is AS13335. According to some estimates, there are over 90,000 ASNs in use worldwide.

ASNs are only required for external communications with inter-network routers (see "What is BGP?" below). Internal routers and computers within an AS may not need to know that AS's number, since they are only communicating with devices within that AS.

An AS has to meet certain qualifications before the governing bodies that assign ASNs will give it a number. It must have a distinct routing policy, be of a certain size, and have more than one connection to other ASes. There is a limited amount of ASNs available, and if they were given out too freely, the supply would run out and routing would become much more complex.

## What is BGP?

ASes announce their routing policy to other ASes and routers via the Border Gateway Protocol (BGP). BGP is the protocol for routing data packets between ASes. Without this routing information, operating the Internet on a large scale would quickly become impractical: data packets would get lost or take too long to reach their destinations.

Each AS uses BGP to announce which IP addresses they are responsible for and which other ASes they connect to. BGP routers take all this information from ASes around the world and put it into databases called routing tables to determine the fastest paths from AS to AS. When packets arrive, BGP routers refer to their routing tables to determine which AS the packet should go to next.

With so many ASes in the world, BGP routers are constantly updating their routing tables. As networks go offline, new networks come online, and ASes expand or contract their IP address space, all of this information has to be announced via BGP so that BGP routers can adjust their routing tables.

## Why is BGP routing necessary? Isn't IP used for routing?

IP, or the Internet Protocol, is indeed used for routing in that it specifies which destination each packet is going to. BGP is responsible for directing packets on the fastest route to their destination. Without BGP, IP packets would bounce around the Internet randomly from AS to AS, like a driver trying to reach their destination by guessing which roads to take.

## How do autonomous systems connect with each other?

ASes connect with each other and exchange network traffic (data packets) through a process called peering. One way ASes peer with each other is by connecting at physical locations called Internet Exchange Points (IXPs). An IXP is a large local area network (LAN) with lots of routers, switches, and cable connections.

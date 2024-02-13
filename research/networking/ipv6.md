# IPv6

![](https://cdn.ttgtmedia.com/rms/onlineimages/whatis-ipv6_address-h.png)

## references

<https://www.techtarget.com/iotagenda/definition/IPv6-address#:~:text=In%20precise%20terms%2C%20an%20IPv6,groups%20are%20separated%20by%20colons.&text=An%20IPv6%20address%20is%20split,network%20and%20a%20node%20component>.

## IPv6 address

An IPv6 address is a 128-bit alphanumeric value that identifies an endpoint device in an Internet Protocol Version 6 (IPv6) network. IPv6 is the successor to a previous addressing infrastructure, IPv4, which had limitations IPv6 was designed to overcome. Notably, IPv6 has drastically increased address space compared to IPv4.

The Internet Protocol (IP) is a method in which data is sent to different computers over the internet. Each network interface, or computer, on the internet will have at least one IP address that is used to uniquely identify that computer. Every device that connects to the internet is assigned an IP address. Which is why there was a concern with the number of IP addresses in IPv4, and why the Internet Engineering Task Force (IETF) defined the new IPv6 standard.

Operating systems (OSes) like Windows 10, macOS and Ubuntu support IPv6. Currently, the use of address types is mixed. Devices in use now will either use IPv6 or IPv4. Domain name systems (DNSes) have supported IPv6 since 2008.

It has been a concern for some time that the IPv4 addressing scheme was running out of potential addresses. The IPv6 format was created to enable the trillions of new IP addresses to connect an ever-greater number of computing devices and the rapidly expanding numbers of items with embedded connectivity, thanks to the internet of things (IoT). The number of potential IPv6 addresses has been calculated to be over 340 undecillion (or 340 trillion trillion trillion). According to Computer History Museum docent Dick Guertin, that number allows an IPv6 address for each atom on the surface of the planet, with enough left over for more than 100 more similar planets.

## Format of an IPv6 address

In precise terms, an IPv6 address is 128 bits long and is arranged in eight groups, each of which is 16 bits. Each group is expressed as four hexadecimal digits and the groups are separated by colons.

An example of a full IPv6 address could be:

FE80:CD00:0000:0CDE:1257:0000:211E:729C

An IPv6 address is split into two parts: a network and a node component. The network component is the first 64 bits of the address and is used for routing. The node component is the later 64 bits and is used to identify the address of the interface. It is derived from the physical, or MAC address, using the 64-bit extended unique identifier (EUI-64) format defined by the Institute of Electrical and Electronics Engineers (IEEE).

A MAC address (media access control address) is a 12-digit hexadecimal number assigned to each device connected to the network.

![](https://cdn.ttgtmedia.com/rms/onlineimages/osi_model-f.png)

## Types of MAC addresses

There are three types of MAC addresses:

- **Unicast MAC address**. A unicast address is attached to a specific NIC on the local network. Therefore, this address is only used when a frame is sent from a single transmitting device to a single destination device.
- **Multicast MAC address**. A source device can transmit a data frame to multiple devices by using a Multicast A multicast group IP address is assigned to devices belonging to the multicast group.
- **Broadcast MAC address**. This address represents every device on a given network. The purpose of a broadcast domain is to enable a source device to send data to every device on the network by using the broadcast address as the destination's MAC address.

![](https://cdn.ttgtmedia.com/rms/onlineimages/networking-mac_vs_ip_address.png)

The network node can be split even further into a block of 48 bits and a block of 16 bits. The upper 48-bit section is used for global network addresses. The lower 16-bit section is controlled by network administrators and is used for subnets on an internal network.

Further, the example address can be shortened, as the addressing scheme allows the omission of any leading zero, as well as any sequences consisting of only zeros. The shortened version would look like:

FE80:CD00:0:CDE:1257:0:211E:729C

The specific layout of an IPv6 address may vary somewhat, depending on its format. Three basic parts that make up the address are the routing prefix, the subnet ID and the interface ID.

![](https://cdn.ttgtmedia.com/rms/onlineimages/whatis-ipv6_address-h.png)

Both the routing prefix and the subnet ID represent two main levels in which the address is constructed -- either global or site-specific. The routing prefix is the number of bits that can be subdivided -- typically, decided by Internet Registries and Internet Service Providers (ISPs). If you were to look at an IPv6 address, the leftmost set of numbers -- the first 48 bits -- is called the site prefix. The subnet ID is the next 16 bits. The subnet ID lays out site topology. The last 64-bits are called the interface ID, which can be automatically or manually configured.

## Types of IPv6 addresses

There are different types and formats of IPv6 addresses, of which, it's notable to mention that there are no broadcast addresses in IPv6. Some examples of IPv6 formats include:

- **Global unicast**. These addresses are routable on the internet and start with "2001:" as the prefix group. Global unicast addresses are the equivalent of IPv4 public addresses.
- **Unicast address**: Used to identify the interface of an individual node.
- **Anycast address**: Used to identify a group of interfaces on different nodes.
- **Multicast address**: An address used to define Multicast Multicasts are used to send a single packet to multiple destinations at one time.
- **Link local addresses**: One of the two internal address types that are not routed on the internet. Link local addresses are used inside an internal network, are self-assigned and start with "fe80:" as the prefix group.
- **Unique local addresses**: This is the other type of internal address that is not routed on the internet. Unique local addresses are equivalent to the IPv4 addresses 10.0.0.0/8, 172.16.0.0/12 and 192.168.0.0/16.

## Advantages and disadvantages of IPv6 addresses

IPv6 addresses can bring a variety of benefits, including:

- More efficient routing with smaller routing tables and aggregation of prefixes.
- Simplified packet processing due to more streamlined packet headers.

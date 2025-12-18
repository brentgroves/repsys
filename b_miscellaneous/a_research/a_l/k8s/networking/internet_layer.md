# Internet or Network Layer (Layer 3)

## references

The following is out of a fantastic book called **["The TCP/IP Guide"](http://www.tcpipguide.com/index.htm)** , ISBN 1-59327-047-X. I would recommend this book, its fantastic.

## Internet Layer

The Internet layer, also known as the network layer or IP layer, accepts and delivers packets for the network. This layer includes the powerful Internet Protocol (IP), the Address Resolution Protocol (ARP), and the Internet Control Message Protocol (ICMP).

IP Protocol
The IP protocol and its associated routing protocols are possibly the most significant of the entire TCP/IP suite. IP is responsible for the following:

IP addressing – The IP addressing conventions are part of the IP protocol. Designing an IPv4 Addressing Scheme introduces IPv4 addressing and IPv6 Addressing Overview introduces IPv6 addressing.

Host-to-host communications – IP determines the path a packet must take, based on the receiving system's IP address.

Packet formatting – IP assembles packets into units that are known as datagrams. Datagrams are fully described in Internet Layer: Where Packets Are Prepared for Delivery.

Fragmentation – If a packet is too large for transmission over the network media, IP on the sending system breaks the packet into smaller fragments. IP on the receiving system then reconstructs the fragments into the original packet.

Oracle Solaris supports both IPv4 and IPv6 addressing formats, which are described in this book. To avoid confusion when addressing the Internet Protocol, one of the following conventions is used:

When the term “IP” is used in a description, the description applies to both IPv4 and IPv6.

When the term “IPv4” is used in a description, the description applies only to IPv4.

When the term “IPv6” is used in a description, the description applies only to IPv6.

ARP Protocol
The Address Resolution Protocol (ARP) conceptually exists between the data-link and Internet layers. ARP assists IP in directing datagrams to the appropriate receiving system by mapping Ethernet addresses (48 bits long) to known IP addresses (32 bits long).

ICMP Protocol
The Internet Control Message Protocol (ICMP) detects and reports network error conditions. ICMP reports on the following:

Dropped packets – Packets that arrive too fast to be processed

Connectivity failure – A destination system cannot be reached

Redirection – Redirecting a sending system to use another router

**Packet** This term is consided by many to correctly refer to a message sent by protocols operating at the network layer of the OSI Reference Model. So you will commonly see people refer to [i/IP Packets[/i]. However, this termin is commonly also used to refer generically to any type of message, as i menitoned earlier.
**Datagram** This term is basically synonymous with packet and is also used to refer to network layer technologie. It is also often used to refer to a message that is sent at a higher level of the OSI Reference Model (more often than packet is).
**Frame** This term is most commonly associated with messages that travel at low levels of the OSI Reference Model. In particular, it is most commonly seen used in reference to data link layer messages. It is occasionally also used to refer to physical layer messages, when message formatting is performed by a layer 1 technology. A frame gets its name from the fact that it is created by taking higher-level packets or datagrams and "framing" them with additional header information needed at the lower level.
Cell Frames and packets, in general, can be of variable length, depending on their contents; in contrast, a cell is most often a message that is fixed in size. For example, the fixed-length, 53-byte messages sent in ATM are called cells. Like frames, cells are usually used by technologies operating at the lower layers of the OSI Model.
Protocol Data Unit (PDU) and Service Data Unit (SDU) These are the forumal terms used in the OSI Reference Model to describe protocol messages. A PDU at layer N is a message sent between protocols at layer N. It consists of layer N header information and an encapsulated message from layer N+1, which is called both the layer N SDU and the layer N+1 PDU. After you stop scratching your head, see the "Data Encapsulation, Protocol Data Units (PDU's), and Service Data Units (SDUs)" section in Chapter 5 for a discussion of this.

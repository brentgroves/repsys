# **[Ethernet Frame Format](https://www.geeksforgeeks.org/ethernet-frame-format/)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

The basic frame format which is required for all MAC implementation is defined in IEEE 802.3 standard. Though several optional formats are being used to extend the protocol’s basic capability. Ethernet frame starts with the Preamble and SFD, both work at the physical layer. The ethernet header contains both the Source and Destination MAC address, after which the payload of the frame is present. The last field is CRC which is used to detect the error. Now, let’s study each field of basic frame format.

Ethernet (IEEE 802.3) Frame Format
![i1](https://media.geeksforgeeks.org/wp-content/uploads/IEEE-802.3-Ethernet-Frame-Format.png)

Ethernet II Frame Format
![i2](https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Ethernet_Type_II_Frame_format.svg/700px-Ethernet_Type_II_Frame_format.svg.png
)

VLAN (IEEE 802.1Q) Frame Format

![i3](https://download.huawei.com/mdl/image/download?uuid=b644d61f3dfa4e289c19f436361c5abc)

## What About VLANs?

One thing to note is that **[VLAN](https://www.cbtnuggets.com/blog/technology/networking/what-is-a-vlan-and-how-they-work)** tagging is often added to the ethernet frame if the network is broken up into subnetworks. This identifies which sub-LAN the frame should be routed to.

1. PREAMBLE: Ethernet frame starts with a 7-Bytes Preamble. This is a pattern of alternative 0’s and 1’s which indicates starting of the frame and allow sender and receiver to establish bit synchronization. Initially, PRE (Preamble) was introduced to allow for the loss of a few bits due to signal delays. But today’s high-speed Ethernet doesn’t need a Preamble to protect the frame bits. PRE (Preamble) indicates the receiver that frame is coming and allow the receiver to lock onto the data stream before the actual frame begins.
2. Start of frame delimiter (SFD): This is a 1-Byte field that is always set to 10101011. SFD indicates that upcoming bits are starting the frame, which is the destination address. Sometimes SFD is considered part of PRE, this is the reason Preamble is described as 8 Bytes in many places. The SFD warns station or stations that this is the last chance for synchronization.
3. Destination Address: This is a 6-Byte field that contains the MAC address of the machine for which data is destined.
4. Source Address: This is a 6-Byte field that contains the MAC address of the source machine. As Source Address is always an individual address (Unicast), the least significant bit of the first byte is always 0.
5. Length: Length is a 2-Byte field, which indicates the length of the entire Ethernet frame. This 16-bit field can hold a length value between 0 to 65535, but length cannot be larger than 1500 Bytes because of some own limitations of Ethernet.
6. Data: This is the place where actual data is inserted, also known as Payload . Both **[IP header](https://www.geeksforgeeks.org/introduction-and-ipv4-datagram-header/)** and data will be inserted here if Internet Protocol is used over Ethernet. The maximum data present may be as long as 1500 Bytes. In case data length is less than minimum length i.e. 46 bytes, then padding 0’s is added to meet the minimum possible length.
7. Cyclic Redundancy Check (CRC): CRC is 4 Byte field. This field contains a 32-bits hash code of data, which is generated over the Destination Address, Source Address, Length, and Data field. If the checksum computed by destination is not the same as sent checksum value, data received is corrupted.
8. VLAN Tagging: The Ethernet frame can also include a VLAN (Virtual Local Area Network) tag, which is a 4-byte field inserted after the source address and before the EtherType field. This tag allows network administrators to logically separate a physical network into multiple virtual networks, each with its own VLAN ID.

# L2, L3, and L4 protocols?

Layer 2 (L2), Layer 3 (L3), and Layer 4 (L4) are three distinct layers in the OSI (Open Systems Interconnection) model, which is a conceptual framework used to understand and standardize how different networking protocols work. Each layer serves specific functions in data communication, and they have different characteristics and responsibilities:

## references

<https://www.quora.com/What-are-the-differences-between-the-L2-L3-and-L4-protocols>

## What are the differences between the L2, L3, and L4 protocols?

![](https://cf-assets.www.cloudflare.com/slt3lc6tev37/6ZH2Etm3LlFHTgmkjLmkxp/59ff240fb3ebdc7794ffaa6e1d69b7c2/osi_model_7_layers.png)

## Layer 2 (L2) - Data Link Layer

Scope: L2 operates at the data link layer, focusing on local network communication within the same physical network segment (e.g., a local area network, or LAN).
Responsibilities:Frame creation and addressing: L2 is responsible for creating data frames and adding physical addresses (e.g., MAC addresses) to them.Data framing and error detection: It breaks data into frames and performs basic error detection through methods like CRC (Cyclic Redundancy Check).Switching and local network forwarding: L2 devices (like Ethernet switches) use MAC addresses for forwarding frames within a local network.
Protocols: Common L2 protocols include Ethernet (IEEE 802.3), Wi-Fi (IEEE 802.11), and PPP (Point-to-Point Protocol).

## Layer 3 (L3) - Network Layer

Scope: L3 operates at the network layer and is responsible for routing data between different networks or subnets.
Responsibilities:Logical addressing: L3 assigns logical addresses (e.g., IP addresses) to devices and routers to identify them on a broader network.Routing: L3 routers examine IP headers to determine the best path to forward packets between networks based on routing tables.Subnetting and segmentation: L3 enables network segmentation through subnet masks.
Protocols: Key L3 protocols include Internet Protocol (IP), Internet Control Message Protocol (ICMP), and Internet Group Management Protocol (IGMP).

## VLANs Work on Layer 2

A VLAN works at the Data Link Layer or Layer 2. In a nutshell, VLANs virtually isolate networks and create discrete broadcast domains. If you're comfortable with the concept of a LAN (Local Area Network), VLANs should be easy enough to conceptualize. If not, Jeremy Cioara has got you covered with this VLAN design and implementation course.

A "regular" LAN is a way of physically grouping devices. A VLAN is a way of grouping devices into one or more logically isolated networks. It is important to note that you can have multiple VLANs on the same switch. Conversely, you can have a single VLAN span multiple switches.

Before VLANs, the only way of isolating networks would be to have two complete sets of equipment (i.e., router, switch, and nodes) to set up a proper LAN. With a VLAN, instead of having one switch for each LAN, you can now use a single switch to create multiple logical networks.

Pro Tip: To route traffic between VLANs, you need a Layer 3 routing device. This is a common stumbling point for beginners. Just because two VLANs are on the same switch doesn't mean they can communicate.

## Layer 3 routing device

A Layer 3 switch combines the functionality of a switch and a router. It acts as a switch to connect devices that are on the same subnet or virtual LAN at lightning speed. It can support routing protocols, inspect incoming packets, and may even make routing decisions supporting source and destination addresses.

## Subnets Work on Layer 3

A subnet works at the IP layer or Layer 3 of the OSI Model. Subnets enable you to create smaller networks inside a larger overall network.

A standard IPv4 address is typically broken up into a Network ID and Host ID. If we take a class B IP of 172.16.1.10 the first two segments are the Network ID (172.16) and the other two are the Host ID (1.10). When a request is made for information on the internet, it will first be delivered to the network and then to the host using the host ID.

These numbers will be unique on each network. When creating a Subnet, you use part of the Host ID to identify the subnet the host is located in. Using the same example, the 1 in 172.16.1.10 would identify the subnet.

## Use Cases for Subnets

Because you are limited to only a certain amount of IP address on each subnet, splitting into multiple subnets will allow you to control the amount on division. This gives you more control over how to handle network growth as it happens.

This will also improve your network speed by reducing the number of hosts on that subnet. This way, when a request comes in, you can reduce the number of hosts on the subnet and increase speeds in the process.

Probably the most important reason to look into multiple subnets is security. By breaking your network up into multiple subnets, you can better monitor the flow of traffic, allowing you to identify threats with a much faster response time.

However, because this is at Layer 3, anybody who has direct access to the switch you're connected to will be able to see the flow of traffic. This means you'll need to take some precautions at the Layer 2 level.

## Layer 4 (L4) - Transport Layer

Scope: L4 operates at the transport layer and manages end-to-end communication between devices across networks.
Responsibilities:End-to-end communication: L4 is responsible for establishing, maintaining, and terminating connections between devices.Segmentation and reassembly: It divides data into smaller segments for efficient transmission and reassembles them at the receiving end.Error detection and correction: L4 protocols like TCP (Transmission Control Protocol) provide error detection and recovery mechanisms.Port and session management: L4 uses port numbers to distinguish different services running on a device (e.g., HTTP on port 80, FTP on port 21).
Protocols: Prominent L4 protocols include TCP (connection-oriented) and UDP (connectionless).

## OSI Networking Differences

- **Layer Focus**: L2: Local network communication, data frames, and MAC addressing.L3: Inter-network communication, logical addressing (IP), and routing.L4: End-to-end communication, data segmentation, error handling, and port-based addressing.
- **Addressing**: L2: Uses MAC addresses for physical device identification within the local network.L3: Uses IP addresses for logical device identification, allowing routing between networks.L4: Utilizes port numbers to distinguish different services on a device.
- **Communication** Scope:L2: Local network (e.g., LAN) communication.L3: Inter-network (e.g., internet) communication.L4: End-to-end communication across networks.
- **Error Handling**:L2: Basic error detection (CRC), but limited error correction capabilities.L3: No error handling, but relies on L4 for error detection (e.g., ICMP for error reporting).L4: Provides error detection and correction (e.g., TCP's acknowledgment and retransmission mechanisms).

![](https://cf-assets.www.cloudflare.com/slt3lc6tev37/6ZH2Etm3LlFHTgmkjLmkxp/59ff240fb3ebdc7794ffaa6e1d69b7c2/osi_model_7_layers.png)

## K8s mappings to OSI Model


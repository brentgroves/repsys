# Trunk

What is trunk and what is trunking in networking?
A network trunk is a communications line or link designed to carry multiple signals simultaneously to provide network access between two points. Trunks typically connect switching centers in a communications system. The signals can convey any type of communications data.

## references

<https://www.techtarget.com/searchnetworking/definition/trunk>

## Trunking and VLAN configuration

![](https://cf-assets.www.cloudflare.com/slt3lc6tev37/6ZH2Etm3LlFHTgmkjLmkxp/59ff240fb3ebdc7794ffaa6e1d69b7c2/osi_model_7_layers.png)

Trunking is a key architectural component of VLANs. In VLANS, a physical network is virtualized to create several logical networks that are independent broadcast domains. The main physical communications link is the trunk; switches connected to the trunk provide the branches out to support many client devices.

![](https://cdn.ttgtmedia.com/rms/onlineImages/VLAN_samplenet.jpg)
)

VLANs were an improvement over shared network hubs. A VLAN groups client devices that frequently communicate with one another. On busy networks, this reduces broadcast traffic congestion. It also segments data as it goes through the switches. Trunk links pass packets of data from each of the VLANs. This connects switches together so that each port can be independently configured to a dedicated VLAN.

## Trunk ports vs. access ports

An Ethernet interface can be configured as an access port or a trunk port by switching the port's mode setting:

## Access port

In the switch port mode access setting, a port provides a dedicated link to servers, routers or terminals within a single VLAN. Access ports convey only the data traffic that matches the access value of its pre-assigned VLAN. When configured as an access port, the switch connects to a network host. The host presumes the arriving data frames to be part of that VLAN. A common use case for access ports is to connect a personal computer or peripheral device to a switch.

## Trunk ports

In switch port mode trunk setting, a port will concurrently carry traffic between several VLAN switches on the same physical link. A trunk port adds special identifying tags to isolate traffic on the different switches. IEEE (Institute of Electrical and Electronics Engineers) open standard 802.1Q describes the vendor-agnostic encapsulation protocol for VLAN tagging. A tag gets placed on Ethernet frames as they pass between switches. This ensures each frame is routed to its intended VLAN at the other end of the trunked link. A trunk port is commonly used for connecting two switches, connecting switches to servers and routers, and connecting hypervisors to switches.

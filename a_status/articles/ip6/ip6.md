# IPv6

Hi team,

With the additional zero-trust security measure of not allowing access to the server VLAN without a network configuration request is it time to embrace IPv6?

Brent
Structures - Information Systems

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.dev>.

## AI Overview

IPv6 is the newer internet protocol that addresses the limitations of IPv4 by offering a vastly larger address space $2^{128}$ vs. $2^{32}$ and built-in security and efficiency features like no NAT and better routing. IPv4 uses a 32-bit address in dotted-decimal notation (e.g., \(192.168.1.1\)) and is nearing exhaustion, while IPv6 uses a 128-bit address in hexadecimal notation (e.g., \(2001:0db8::1\)). The primary advantage of IPv6 is the immense number of available addresses, which is crucial for the growth of the internet, IoT devices, and mobile networks.

## Firewall Policy

### Before change

All users had access to all sites server VLAN.

### After change

No users have access to all sites server VLAN.

### Results

- Any user needing access to any site's servers must have an unchanging reserved IP address.
- Less unreserved IP addresses needed.
- More reserved IP addresses needed.

## Change Option

Use IPv6 addresses for bigger isolated block ranges for reserved IP addresses.

## **[Difference Between IPv4 and IPv6](https://www.geeksforgeeks.org/computer-networks/differences-between-ipv4-and-ipv6/)**

## Drawbacks of IPv4

- **Limited Addresses:** IPv4’s 32-bit space cannot meet the growing demand for internet-connected devices.
- **Complex Setup:** Requires manual configuration or DHCP, which can be error-prone.
- **Inefficient Routing:** Larger, complex headers slow down data processing.
- **Weak Security:** No built-in security; extra measures are needed.
- **Poor QoS Support:** Limited ability to prioritize traffic, affecting video/voice quality.
- **Packet Fragmentation:** Routers may split packets, causing inefficiency and possible data loss.
- **Broadcast Overhead:** Uses broadcasting, which increases unnecessary traffic and reduces performance.
Benefits of IPv6 over IPv4

The recent Version of IP IPv6 has a greater advantage over IPv4. Here are some of the mentioned benefits:

- **Larger Address Space:** IPv6 uses 128-bit addresses (vs. 32-bit in IPv4), allowing many more devices to connect.
- **Improved Security:** IPv6 has built-in features like data authentication and encryption, making connections safer..
- **Simpler Header:** IPv6 has a streamlined header, improving speed and reducing processing cost.
Better QoS Support: IPv6 provides stronger Quality of Service, improving video, audio, and website performance.
- **Mobile-Friendly:** IPv6 offers better, faster, and more secure support for mobile connections.

## Switching From IPV4 to IPV6 : To switch from IPv4 to IPv6, there are several strategies

- **Dual Stacking:** Devices can use both IPv4 and IPv6 at the same time. This way, they can talk to networks and devices using either version.
- **Tunneling:** This method allows IPv6 users to send data through an IPv4 network to reach other IPv6 users. Think of it as creating a "tunnel" for IPv6 traffic through the older IPv4 system.
- **Network Address Translation (NAT):** NAT helps devices using different versions of IP addresses (IPv4 and IPv6) to communicate with each other by translating the addresses so they understand each other.

The below table shows the difference between the IPV4 and IPV6 addressing:

| Feature              | IPv4                                                   | IPv6                                                           |
|----------------------|--------------------------------------------------------|----------------------------------------------------------------|
| Address Length       | 32-bit address                                         | 128-bit address                                                |
| Address Format       | Decimal format (e.g., 192.168.0.1)                     | Hexadecimal format (e.g., 2001:0db8::1)                        |
| Configuration        | Manual and DHCP configuration                          | Auto-configuration and renumbering supported                   |
| Connection Integrity | End-to-end integrity is unachievable                   | End-to-end integrity is achievable                             |
| Security             | No built-in security; external tools like IPSec needed | IPSec is built-in for encryption and authentication            |
| Fragmentation        | Performed by sender and routers                        | Performed only by the sender                                   |
| Flow Identification  | Not available                                          | Uses Flow Label field in header for packet flow identification |
| Checksum Field       | Present                                                | Not present                                                    |
| Transmission Scheme  | Supports broadcast                                     | Uses multicast and anycast; no broadcast                       |
| Header Size          | Variable: 20–60 bytes                                  | Fixed: 40 bytes                                                |
| Conversion           | Can be converted to IPv6                               | Not all IPv6 addresses can be converted to IPv4                |
| Field Structure      | 4 fields separated by dots (.)                         | 8 fields separated by colons (:)                               |
| Address Classes      | Has address classes (A, B, C, D, E)                    | No concept of address classes                                  |
| VLSM Support         | Supports Variable Length Subnet Mask (VLSM)            | Does not support VLSM                                          |
| Example              | 66.94.29.13                                            | 2001:0000:3238:DFE1:0063:0000:0000:FEFB                        |

## Corporate - IT

- Christian Smith: Global Directory IT
- Adrian Wise: System Admin, Technical Services Manager.
- Brent Hall, System Administrator Senior
- John Biel: Manager, Network
- Kiran Ambati: Network Architect
- Ramarao Guttikonda, Senior System Administrator
- Justin Langille, Network Technician
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician

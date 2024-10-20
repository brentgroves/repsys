# **[Tun/Tap device](https://vtun.sourceforge.net/tun/faq.html)**

**[Back to Research List](../../research_list.md)**\
**[Back to Networking Menu](./networking_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://vtun.info/>

1.1 What is the TUN ?
 The TUN is Virtual Point-to-Point network device.
 TUN driver was designed as low level kernel support for
 IP tunneling. It provides to userland application
 two interfaces:

- /dev/tunX - character device;
- tunX - virtual Point-to-Point interface.

 Userland application can write IP frame to /dev/tunX
 and kernel will receive this frame from tunX interface.
 In the same time every frame that kernel writes to tunX
 interface can be read by userland application from /dev/tunX
 device.

 1.2 What is the TAP ?
 The TAP is a Virtual Ethernet network device.
 TAP driver was designed as low level kernel support for
 Ethernet tunneling. It provides to userland application
 two interfaces:

- /dev/tapX - character device;
- tapX - virtual Ethernet interface.

 Userland application can write Ethernet frame to /dev/tapX
 and kernel will receive this frame from tapX interface.
 In the same time every frame that kernel writes to tapX
 interface can be read by userland application from /dev/tapX
 device.

 1.3 What platforms are supported by TUN/TAP driver ?
 Currently driver has been written for 3 Unices:
    Linux kernels 2.2.x, 2.4.x
    FreeBSD 3.x, 4.x, 5.x
    Solaris 2.6, 7.0, 8.0

1.4 What is TUN/TAP driver used for?
 As mentioned above, main purpose of TUN/TAP driver is tunneling.
 It used by VTun (<http://vtun.info>).

1.5 How does Virtual network device actually work ?
 Virtual network device can be viewed as a simple Point-to-Point or
 Ethernet device, which instead of receiving packets from a physical
 media, receives them from user space program and instead of sending
 packets via physical media sends them to the user space program.

 Let's say that you configured IPX on the tap0, then whenever
 kernel sends any IPX packet to tap0, it is passed to the application
 (VTun for example). Application encrypts, compresses and sends it to
 the other side over TCP or UDP. Application on other side decompress
 and decrypts them and write packet to the TAP device, kernel handles
 the packet like it came from real physical device.

 1.6 What is the difference between TUN driver and TAP driver?
 TUN works with IP frames. TAP works with Ethernet frames.

1.7 What is the difference between BPF and TUN/TAP driver?
 BFP is a advanced packet filter. It can be attached to existing
 network interface. It does not provide virtual network interface.
 TUN/TAP driver does provide virtual network interface and it is possible
 to attach BPF to this interface.

1.8 Does TAP driver support kernel Ethernet bridging?
 Yes. Linux and FreeBSD drivers support Ethernet bridging.

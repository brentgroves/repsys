# Network **[Tap device](https://blog.cloudflare.com/virtual-networking-101-understanding-tap)**

A tap device is a virtual network interface that looks like an ethernet network card. Instead of having real wires plugged into it, it exposes a nice handy file descriptor to an application willing to send/receive packets. Historically tap devices were mostly used to implement VPN clients. The machine would route traffic towards a tap interface, and a VPN client application would pick them up and process accordingly. For example this is what our Cloudflare WARP Linux client does. Here's how it looks on my laptop:

## references

<https://blog.cloudflare.com/virtual-networking-101-understanding-tap>

```bash
ip link list
...
18: CloudflareWARP: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc mq state UNKNOWN mode DEFAULT group default qlen 500
 link/none

$ ip tuntap list
CloudflareWARP: tun multi_queue
```

More recently tap devices started to be used by virtual machines to enable networking. The VMM (like Qemu, Firecracker, or gVisor) would open the application side of a tap and pass all the packets to the guest VM. The tap network interface would be left for the host kernel to deal with. Typically, a host would behave like a router and firewall, forward or NAT all the packets. This design is somewhat surprising - it's almost reversing the original use case for tap. In the VPN days tap was a traffic destination. With a VM behind, tap looks like a traffic source.

A Linux tap device is a mean creature. It looks trivial — a virtual network interface, with a file descriptor behind it. However, it's surprisingly hard to get it to perform well. The Linux networking stack is optimized for packets handled by a physical network card, not a userspace application. However, over the years the Linux tap interface grew in features and nowadays, it's possible to get good performance out of it. Later I'll explain how to use the Linux tap API in a modern way.

## To tun or to tap?

The interface is called "the universal tun/tap" in the kernel. The "tun" variant, accessible via the IFF_TUN flag, looks like a point-to-point link. There are no L2 Ethernet headers. Since most modern networks are Ethernet, this is a bit less intuitive to set up for a novice user. Most importantly, projects like Firecracker and gVisor do expect L2 headers.

"Tap", with the IFF_TAP flag, is the one which has Ethernet headers, and has been getting all the attention lately. If you are like me and always forget which one is which, you can use this  AI-generated rhyme (check out WorkersAI/LLama) to help to remember:

```rhyme
Tap is like a switch,
Ethernet headers it'll hitch.
Tun is like a tunnel,
VPN connections it'll funnel.
Ethernet headers it won't hold,
Tap uses, tun does not, we're told.
```

## Network **[Tap](https://www.instructables.com/Make-a-Passive-Network-Tap/)**

Make a Passive Network Tap
Step 1: Parts. You will need: ...
Step 2: Tools. You will need a wire stripper and a screw driver.
Step 3: Strip Wire. Cut 5 inches of cat 5 cable, and pull out the 8 strands of wire.
Step 4: Wire the First Jack. ...
Step 5: Wire the Second Jack. ...
Step 6: Third Jack. ...
Step 7: Close It Up.

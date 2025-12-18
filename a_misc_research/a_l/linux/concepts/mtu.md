# **[MTU](https://www.cloudflare.com/learning/network-layer/what-is-mtu/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[large mtu](https://www.reddit.com/r/networking/comments/k0x15y/does_a_large_mtu_size_make_a_difference/)**

## What is MTU?

In networking, maximum transmission unit (MTU) is a measurement representing the largest data packet that a network-connected device will accept. Imagine it as being like a height limit for freeway underpasses or tunnels: Cars and trucks that exceed the height limit cannot fit through, just as packets that exceed the MTU of a network cannot pass through that network.

However, unlike cars and trucks, data packets that exceed MTU are broken up into smaller pieces so that they can fit through. This process is called fragmentation. Fragmented packets are reassembled once they reach their destination.

MTU is measured in bytes — a "byte" is equal to 8 bits of information, meaning 8 ones and zeroes. 1,500 bytes is the maximum MTU size.

The maximum transmission unit (MTU) size is the largest packet or frame size that can be sent in a packet- or frame-based network, measured in octets (eight-bit bytes). The standard MTU size for Ethernet networks is 1,500 bytes, but the maximum possible size is 8,896 bytes. However, several factors can limit the actual MTU size used in practice, such as virtual private networks (VPNs) and network tunnels. These can impose their own maximum MTU size restrictions due to encapsulation and encryption overhead.

## Does a large MTU size make a difference?

While setting up a few internal apps, an MTU size of 1500 is recommended. Can someone explain what this means in terms of connectivity and what effect it has on TCP/UDP please? (if any correlation)

Often times you will encounter MTU set to 9000 inside a network for links that support it. By allowing larger frames, you're essentially reducing the amount of throughput that you lose to overhead. With the typical default of 1500, you're losing 14 bytes to the Ethernet header, 20 for the IP header, and another 20 for the TCP header. (TCP and IP headers can be up to 60 bytes depending on inclusion of options.) 54/1500 means you're losing 3.6% of your theoretical maximum throughput just to overhead; setting MTU to 9000 reduces that loss to just .6%.

You could compare it to the maximum attachment size permitted by e-mail--usually your e-mail provider won't let you send an attachment over a certain size (usually around 20-25MB). This is because your e-mail probably has to pass between one or more SMTP relays to get to its destination, and they tend to limit attachment sizes; my understanding is that every relay has to have received the entire attachment before it can begin forwarding it on to the next relay, and they don't want to have to buffer huge messages that they're just forwarding on to someone else. In effect, your upper bound on attachment size is limited by what you can reasonably assume will make it all the way from source to destination, so in a sense the maximum everywhere is 25MB because the maximum everywhere is 25MB. (Obviously an SMTP server will just reject a message with an attachment too large, while packets that are too large still get forwarded, they just get fragmented, but it's a similar concept.)

## answer 2

The reduced header overhead is not unimportant, but the real benefit is in reduced computational work per byte sent. For every packet, the sender and receiver have to do all kinds of work to calculate header checksums, update various pointers etc. By running at a larger MTU, the CPU has to spend less time on processing these headers, and this in turn makes it possible to achieve higher speeds. About a decade ago, it was a near necessity to use Jumbo frames to reliably get above 1Gb/s.

These days, the actual packet size on the wire doesn't matter quite as much because the NIC often takes in 64kB packets, and does all the header mangling itself to turn those into packets that are sized to the actual network MTU. This is called **TCP offloading**.

Politely disagreeing here - we're running all our routed interfaces, including our pulbic IP connectivity and international L2 links at an MTU of 9000.

Especially in the research and education space, most networks support an MTU of 9000 just fine. We use it for routed traffic from across all of Europe.

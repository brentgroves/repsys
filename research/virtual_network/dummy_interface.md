# Dummy Interface

When you work on Network Namespaces (which is a feature Linux Kernel provides), you usually create bunch of virtual ethernet ports called as veth interfaces. The veth interface itself is a separate LK virtual network driver which offers this specific functionality. But sometimes besides veth you can also configure an optional interface called “dummy” interface. The dummy interface, just like veth (and other such virtual interfaces) is provided by LK via the driver drivers/net/dummy.c.

The interesting aspect of dummy interface is that it serves as an alter ego of the loop-back localhost (as mentioned in the tldp.org article link below). Which means you can set any valid IP and this can serve as alternate local host ip other than 127.0.0.1. So to learn more, kindly watch my complete video series on this fascinating network interface called Dummy Interface.

## references

<https://tldp.org/LDP/nag/node72.html>

## The Dummy Interface

The dummy interface is really a little exotic, but rather useful nevertheless. Its main benefit is with standalone hosts, and machines whose only IP network connection is a dial-up link. In fact, the latter are standalone hosts most of the time, too.
The dilemma with standalone hosts is that they only have a single network device active, the loopback device, which is usually assigned the address 127.0.0.1. On some occasions, however, you need to send data to the `official' IP address of the local host. For instance, consider the laptop vlite, that has been disconnected from any network for the duration of this example. An application on vlite may now want to send some data to another application on the same host. Looking up vlite in /etc/hosts yields an IP-address of 191.72.1.65, so the application tries to send to this address. As the loopback interface is currently the only active interface on the machine, the kernel has no idea that this address actually refers to itself! As a consequence, the kernel discards the datagram, and returns an error to the application.

This is where the dummy device steps in. It solves the dilemma by simply serving as the alter ego of the loopback interface. In the case of vlite, you would simply give it the address 191.72.1.65 and add a host route pointing to it. Every datagram for 191.72.1.65 would then be delivered locally. The proper invocation is:

           # ifconfig dummy vlite
           # route add vlite

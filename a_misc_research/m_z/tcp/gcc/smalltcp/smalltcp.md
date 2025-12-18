# **[smoltcp](https://github.com/m-labs/smoltcp)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

## reference

- **[Using Linux Raw Sockets](https://squidarth.com/networking/systems/rc/2018/05/28/using-raw-sockets.html)**

In an effort to learn how TCP/IP works, I decided to start playing around with a low-level TCP/IP library, **[smoltcp](https://github.com/m-labs/smoltcp)**. Some of the examples (particularly, the clone of tcpdump) require using raw sockets, which need to be run as the root user. Running network programs as root is pretty dangerous, and is something that one should probably never do.

In this post, I’ll be discussing how to use raw sockets without having to run the whole program as root. And while the library I’m working with is written in Rust, I’ll be using examples written in C.

## Why does it mean to access a raw socket?

Sockets are the means by which programs on Linux way talk to the internet. The socket system call creates a file descriptor that can be written to and read from. The connect system call can then be used to connect the socket to some remote address. After that, writing to the socket sends data to that remote address, while reading from the socket file descriptor reads data sent from the remote address.

There are two main types of sockets, stream sockets, and datagram sockets. I won’t get into the details of these now, but streaming sockets are used for applications that use TCP, while datagram sockets are for applications that use UDP. These are both transport-level protocols that follow the network-level IP protocol.

If you are interested in writing your own implementations of one of these protocols, or need to use a different transport-layer protocol, you’ll need to use raw sockets. Raw sockets operate at the network OSI level, which means that transport-level headers such as TCP or UDP headers will not be automatically decoded. If you are implementing a a transport-level protocol, you’ll have to write code to decode and encode the transport-level headers in your application.

## Raw Sockets and Security

An important thing worth noting about this is that there is important security-related information stored in TCP and UDP headers:

![i1](https://squidarth.com/assets/TCP_Protocol_Diagram.png)

For instance, the destination port is stored in the TCP headers. This means that packets read from raw sockets don’t have any notion of “port”.

To step back a little bit, an application using TCP or UDP must, when opening up a STREAM or DGRAM socket, declare a port to receive data on. When the application reads data from that socket, they will only see data that was sent to that particular port.

Now, with raw sockets, because network-level IP packets do not have a notion of “port”, all packets coming in over the server’s network device can be read. Applications that open raw sockets have to do the work of filtering out packets that are not relevant themselves, by parsing the TCP headers. The security implications of this are pretty serious–it means that applications with a raw socket open can read any inbound network packets, including those headed to other applications running on the system, which may or may not be run as the same unix user as the application with the raw socket open.

To prevent this from happening, Linux requires that any program that accesses raw sockets be run as root. Actually running network programs as root is dangerous, especially for a sufficiently complicated program, like a TCP implementation.

In this post I’ll cover a couple different strategies for circumventing this.

## Attempting to read from a raw socket

To see what happens when we read data from sockets, let’s use this C program that simply sniffs packets entering the system and prints out some information about the packet as an example:

Compiling this program with:

```bash
gcc raw_sock.c
```

And then running it with:

```bash
./a.out
Failed to create socket: Operation not permitted
```

yields the following error:

`Failed to create socket: Operation not permitted`

## Options

The most basic thing that you can do to run the program is to run the program as root:

```bash
sudo ./a.out
New Packet:
Packet Size (bytes): 40
Source Address: 10.0.2.2
Destination Address: 10.0.2.15
Identification 2541

New Packet:
...
```

This is very clearly not ideal. With root access, programs can do some serious damage to the system, and with a sufficiently complicated network program, the chances of something going wrong and pretty high.

## The solution: Linux Capabilities

Thankfully, programs don’t have to be run with full root access in order to be able to use raw sockets. Linux has a feature called capabilities. Linux capabilities allow some features previously limited to processes running as root (with sudo) to be used by processes that are unprivileged. The very handy CAP_NET_RAW capability can be used to open raw sockets.

Capabilities are applied on a per-file basis with the setcap command. This example applies the CAP_NET_RAW and CAP_NET_ADMIN capabilities to the a.out binary. Once these capabilities have been set on the file, non-root users will be able to run these programs.

```bash
sudo setcap cap_net_admin,cap_net_raw=eip a.out
```

You can verify that the capabilities were added by running:

```bash
sudo getcap a.out
a.out = cap_net_admin,cap_net_raw+eip
```

Setting capabilities on executables allows you to run these programs without having to run the risk of these being run as root.

See these two great blog posts for more details on Linux capabilities in this context.

- **[Sniffing with Wireshark as a Non-Root User](http://packetlife.net/blog/2010/mar/19/sniffing-wireshark-non-root-user/)**
- **[File Capabilities in Linux](http://www.andy-pearce.com/blog/posts/2013/Mar/file-capabilities-in-linux/)**

## Future Investigation

Being able to provide programs with access to raw sockets without providing full root access is key to being able to run programs like Wireshark safely on our computers.

Hope you found this interesting/helpful! Next up I’ll be covering the Linux socket API in more detail.

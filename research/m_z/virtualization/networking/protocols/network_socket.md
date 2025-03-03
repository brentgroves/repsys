# **[Network socket](https://en.wikipedia.org/wiki/Network_socket)**

**[Back to Research List](../../research_list.md)**\
**[Back to Networking Menu](./networking_menu.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

A network socket is a software structure within a network node of a computer network that serves as an endpoint for sending and receiving data across the network. The structure and properties of a socket are defined by an application programming interface (API) for the networking architecture. Sockets are created only during the lifetime of a process of an application running in the node.

Because of the standardization of the TCP/IP protocols in the development of the Internet, the term network socket is most commonly used in the context of the Internet protocol suite, and is therefore often also referred to as Internet socket. In this context, a socket is externally identified to other hosts by its socket address, which is the triad of transport protocol, IP address, and port number.

The term socket is also used for the software endpoint of node-internal inter-process communication (IPC), which often uses the same API as a network socket.

Use
The use of the term socket in software is analogous to the function of an electrical female connector, a device in hardware for communication between nodes interconnected with an electrical cable. Similarly, the term port is used for external physical endpoints at a node or device.

The application programming interface (API) for the network protocol stack creates a handle for each socket created by an application, commonly referred to as a socket descriptor. In Unix-like operating systems, this descriptor is a type of file descriptor. It is stored by the application process for use with every read and write operation on the communication channel.

At the time of creation with the API, a network socket is bound to the combination of a type of network protocol to be used for transmissions, a network address of the host, and a port number. Ports are numbered resources that represent another type of software structure of the node. They are used as service types, and, once created by a process, serve as an externally (from the network) addressable location component, so that other hosts may establish connections.

Network sockets may be dedicated for persistent connections for communication between two nodes, or they may participate in connectionless and multicast communications.

In practice, due to the proliferation of the TCP/IP protocols in use on the Internet, the term network socket usually refers to use with the Internet Protocol (IP). It is therefore often also called Internet socket.

## Socket addresses

An application can communicate with a remote process by exchanging data with TCP/IP by knowing the combination of protocol type, IP address, and port number. This combination is often known as a socket address. It is the network-facing access handle to the network socket. The remote process establishes a network socket in its own instance of the protocol stack and uses the networking API to connect to the application, presenting its own socket address for use by the application.

## Implementation

A protocol stack, usually provided by the operating system (rather than as a separate library, for instance), is a set of services that allows processes to communicate over a network using the protocols that the stack implements. The operating system forwards the payload of incoming IP packets to the corresponding application by extracting the socket address information from the IP and transport protocol headers and stripping the headers from the application data.

The application programming interface (API) that programs use to communicate with the protocol stack, using network sockets, is called a socket API. Development of application programs that utilize this API is called socket programming or network programming. Internet socket APIs are usually based on the Berkeley sockets standard. In the Berkeley sockets standard, sockets are a form of file descriptor, due to the Unix philosophy that "everything is a file", and the analogies between sockets and files. Both have functions to read, write, open, and close. In practice, the differences strain the analogy, and different interfaces (send and receive) are used on a socket. In inter-process communication, each end generally has its own socket.

In the standard Internet protocols TCP and UDP, a socket address is the combination of an IP address and a port number, much like one end of a telephone connection is the combination of a phone number and a particular extension. Sockets need not have a source address, for example, for only sending data, but if a program binds a socket to a source address, the socket can be used to receive data sent to that address. Based on this address, Internet sockets deliver incoming data packets to the appropriate application process.

Socket often refers specifically to an internet socket or TCP socket. An internet socket is minimally characterized by the following:

local socket address, consisting of the local IP address and (for TCP and UDP, but not IP) a port number
protocol: A transport protocol, e.g., TCP, UDP, raw IP. This means that (local or remote) endpoints with TCP port 53 and UDP port 53 are distinct sockets, while IP does not have ports.
A socket that has been connected to another socket, e.g., during the establishment of a TCP connection, also has a remote socket

Definition
The distinctions between a socket (internal representation), socket descriptor (abstract identifier), and socket address (public address) are subtle, and these are not always distinguished in everyday usage. Further, specific definitions of a socket differ between authors. In IETF Request for Comments, Internet Standards, in many textbooks, as well as in this article, the term socket refers to an entity that is uniquely identified by the socket number. In other textbooks,[1] the term socket refers to a local socket address, i.e. a "combination of an IP address and a port number". In the original definition of socket given in RFC 147,[2] as it was related to the ARPA network in 1971, "the socket is specified as a 32-bit number with even sockets identifying receiving sockets and odd sockets identifying sending sockets." Today, however, socket communications are bidirectional.

Within the operating system and the application that created a socket, a socket is referred to by a unique integer value called a socket descriptor.

Tools
On Unix-like operating systems and Microsoft Windows, the command-line tools netstat or ss[3] are used to list established sockets and related information.

Example
This example, modeled according to the Berkeley socket interface, sends the string "Hello, world!" via TCP to port 80 of the host with address 203.0.113.0. It illustrates the creation of a socket (getSocket), connecting it to the remote host, sending the string, and finally closing the socket:

```c
Socket mysocket = getSocket(type = "TCP")
connect(mysocket, address = "203.0.113.0", port = "80")
send(mysocket, "Hello, world!")
close(mysocket)
```

## Types

Several types of Internet socket are available:

## Datagram sockets

Connectionless sockets, which use User Datagram Protocol (UDP).[4] Each packet sent or received on a datagram socket is individually addressed and routed. Order and reliability are not guaranteed with datagram sockets, so multiple packets sent from one machine or process to another may arrive in any order or might not arrive at all. Special configuration may be required to send broadcasts on a datagram socket.[5] In order to receive broadcast packets, a datagram socket should not be bound to a specific address, though in some implementations, broadcast packets may also be received when a datagram socket is bound to a specific address.[6]

## Stream sockets

Connection-oriented sockets, which use Transmission Control Protocol (TCP), Stream Control Transmission Protocol (SCTP) or Datagram Congestion Control Protocol (DCCP). A stream socket provides a sequenced and unique flow of error-free data without record boundaries, with well-defined mechanisms for creating and destroying connections and reporting errors. A stream socket transmits data reliably, in order, and with out-of-band capabilities. On the Internet, stream sockets are typically implemented using TCP so that applications can run across any networks using TCP/IP protocol.

## Raw sockets

Allow direct sending and receiving of IP packets without any protocol-specific transport layer formatting. With other types of sockets, the payload is automatically encapsulated according to the chosen transport layer protocol (e.g. TCP, UDP), and the socket user is unaware of the existence of protocol headers that are broadcast with the payload. When reading from a raw socket, the headers are usually included. When transmitting packets from a raw socket, the automatic addition of a header is optional.
Most socket application programming interfaces (APIs), for example, those based on Berkeley sockets, support raw sockets. Windows XP was released in 2001 with raw socket support implemented in the Winsock interface, but three years later, Microsoft limited Winsock's raw socket support because of security concerns.[7]
Raw sockets are used in security-related applications like Nmap. One use case for raw sockets is the implementation of new transport-layer protocols in user space.[8] Raw sockets are typically available in network equipment, and used for routing protocols such as the Internet Group Management Protocol (IGMP) and Open Shortest Path First (OSPF), and in the Internet Control Message Protocol (ICMP) used, among other things, by the ping utility.[9]

Other socket types are implemented over other transport protocols, such as Systems Network Architecture[10] and Unix domain sockets for internal inter-process communication.

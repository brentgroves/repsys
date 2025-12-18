# Service outage or Firewall blocked domain

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

Issue: How to determine if there is a service outage or FW blocked domain espicially useful for non-http services such as databases.

One Solution: One way is to use telnet to connect to an internet service network socket.

## Details

When connecting to an internet service we first make a connection using a transport protocol such as TCP or UDP.  Once this connection is established the application protocol sessions are started.

If we can use telnet to connect to the interet services network socket we know it's listening and the FW is not blocking the socket address.

Example: How to test Plex ODBC connection.

```bash
# From system outside of Linamar's network
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
Connected to test.odbc.plex.com.
Escape character is '^]'.
# From Structures Avilla Kubernetes system.
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
```

This test shows that the Plex ODBC service is available but may be blocked by a Linamar Firewall policy.

## What is a **[Network socket](https://en.wikipedia.org/wiki/Network_socket)**?

A network socket is a software structure within a network node of a computer network that serves as an endpoint for sending and receiving data across the network.

Because of the standardization of the TCP/IP protocols in the development of the Internet, the term network socket is most commonly used in the context of the Internet protocol suite, and is therefore often also referred to as Internet socket. In this context, a socket is externally identified to other hosts by its socket address, which is the triad of **transport protocol, IP address, and port number**.

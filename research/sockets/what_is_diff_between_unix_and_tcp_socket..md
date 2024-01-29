# What is the difference between Unix sockets and TCP/IP sockets

A **[UNIX socket](https://en.wikipedia.org/wiki/Unix_domain_socket)**, AKA Unix Domain Socket, is an inter-process communication mechanism that allows bidirectional data exchange between processes running on the same machine.

**[IP sockets](https://en.wikipedia.org/wiki/Internet_socket)** (especially TCP/IP sockets) are a mechanism allowing communication between processes over the network. In some cases, you can use TCP/IP sockets to talk with processes running on the same computer (by using the loopback interface).

UNIX domain sockets know that they’re executing on the same system, so they can avoid some checks and operations (like routing); which makes them faster and lighter than IP sockets. So if you plan to communicate with processes on the same host, this is a better option than IP sockets.

Edit: As per Nils Toedtmann's comment: UNIX domain sockets are subject to file system permissions, while TCP sockets can be controlled only on the packet filter level.

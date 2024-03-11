# **[http connect](https://http.dev/http-connection)**

Managing HTTP connections is an important process in HTTP. The type of HTTP connection impacts performance, stability, and the general operation of web-based applications and websites. Connection types and options are areas that have been updated between versions of HTTP, either to increase performance or improve robustness.

## Connection scope

HTTP connections made between a client and a server are not created in an end-to-end manner. Rather, they are made on a hop-by-hop basis, which means that the first HTTP connection is opened between the client and the first intermediary, or proxy, between it and the server. A new HTTP connection is created between each intermediary and finally, there is a new one between the final intermediary node and the server.

This is important because intermediate nodes can use their own parameters for specifying HTTP connection types, and a single end-to-end trip can consist of different ones. This can affect both performance and stability.

## Connection types

In HTTP/1.1, TCP is used to provide short-lived HTTP connections, persistent HTTP connections, and pipelining. Prior to HTTP/1.0, many HTTP connections were required to download resources on a single webpage. All of these were short-lived HTTP connections, each to transfer exactly one resource, even if each resource was just a single image as part of a larger multimedia webpage. HTTP connections were not made in parallel, which meant that each one had to be closed before the subsequent one was established.

## Persistent connection

To reduce the number of HTTP connections required, the persistent HTTP connection type was introduced in HTTP/1.0. It cut back on overhead because several HTTP requests can be made over a single HTTP connection, without incurring the additional bandwidth required for dropping and reestablishing new ones. It is not difficult to recognize that on a page with many images, each originally requiring a separate HTTP connection, that the persistent HTTP connection was a time and bandwidth saver. In the former model, network latency was amplified primarily because of the additional handshakes, which needed at least one full network round trip each.

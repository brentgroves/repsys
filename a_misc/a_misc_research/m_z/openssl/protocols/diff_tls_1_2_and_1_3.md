# **[TLS 1.2 vs TLS 1.3: What are the Main Differences?](https://www.a10networks.com/glossary/key-differences-between-tls-1-2-and-tls-1-3/#:~:text=As%20with%20SSL%2C%20TLS%20relies,%E2%80%9D%20(0%2DRTT).)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

## How do Secure Sockets Layer (SSL) and Transport Layer Security (TLS) Differ?

Like its successor Transport Layer Security (TLS), Secure Sockets Layer (SSL) is a cryptographic protocol that extends HTTP to authenticate internet connections and enable encryption and SSL decryption for data communication over a network. In fact, TLS is a direct evolution of SSL and introduced to address security vulnerabilities in the earlier protocol. The differences between the two are relatively minor, such as the stronger encryption algorithms and ability to work on different ports offered by TLS. The terms are used somewhat interchangeably, and the same certificates can be used with both TLS and SSL. Still, all releases of SSL have been deprecated, and most modern browsers no longer support the protocol.

## TLS 1.2 vs TLS 1.3: What are the Main Differences?

TLS 1.3 offers several improvements over earlier versions, most notably a faster TLS handshake and simpler, more secure cipher suites. Zero Round-Trip Time (0-RTT) key exchanges further streamline the TLS handshake. Together, these changes provide better performance and stronger security.

![i1](https://www.a10networks.com/wp-content/uploads/differences-between-tls-1.2-and-tls-1.3-full-handshake.png)

TLS 1.3 is faster than its predecessors

## A Faster TLS Handshake

TLS encryption and SSL decryption require CPU time and add latency to network communications, somewhat degrading performance. Under TLS 1.2, the initial handshake was carried out in clear text, meaning that even it needed to be encrypted and decrypted. Given that a typical handshake involved 5 – 7 packets exchanged between the client and server, this added considerable overhead to the connection. Under version 1.3, server certificate encryption was adopted by default, making it possible for a TLS handshake to be performed with 0 – 3 packets, reducing or eliminating this overhead and allowing faster, more responsive connections.

## Simpler, Stronger Cipher Suites

In addition to reducing the number of packets to be exchanged during the TLS handshake, version 1.3 has also shrunk the size of the cipher suites used for encryption. In TLS 1.2 and earlier versions, the use of ciphers with cryptographic weaknesses had posed potential security vulnerabilities. TLS 1.3 includes support only for algorithms that currently have no known vulnerabilities, including any that do not support Perfect Forward Secrecy (PFS). The update has also removed the ability to perform “renegotiation,” in which a client and server that already have a TLS connection can negotiate new parameters and generate new keys, a function that can increase risk.

## Zero Round-Trip Time (0-RTT)

As with SSL, TLS relies on key exchanges to establish a secure session. In earlier versions, keys could be exchanged during the handshake using one of two mechanisms: a static RSA key, or a Diffie-Hellman key. In TLS 1.3, RSA has been removed, along with all static (non-PFS) key exchanges, while retaining ephemeral Diffie-Hellman keys. In addition to eliminating the security risk posed by a static key, which can compromise security if accessed illicitly, relying exclusively on the Diffie-Hellman family allows the client to send the requisite randoms and inputs needed for key generation during its “hello.” By eliminating an entire round-trip on the handshake, this saves time and improves overall site performance. In addition, when accessing a site that has been visited previously, a client can send data on the first message to the server by leveraging pre-shared keys (PSK) from the prior session—thus “zero round-trip time” (0-RTT).

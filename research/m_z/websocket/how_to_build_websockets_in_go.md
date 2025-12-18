# Websockets

## references

<https://yalantis.com/blog/how-to-build-websockets-in-go/>

## How to implement instant messaging with WebSockets in Go

Sending a message and getting an instant response without refreshing the page is something we take for granted. But in the past, enabling real-time functionality was a real challenge for developers. The developer community has come a long way from HTTP long polling and AJAX and has finally found a solution for building truly real-time apps.

This solution comes in the form of WebSockets, which make it possible to open an interactive session between a user’s browser and a server. WebSockets allow a browser to send messages to a server and receive event-driven responses without having to poll the server for a reply.

For now, WebSockets are the number one solution for building real-time applications: online games, instant messengers, tracking apps, and so on. This guide explains how WebSockets operate and shows how we can build WebSocket applications in the Go programming language. We also compare the most popular WebSocket libraries so you can choose the best one for your needs.

## Network sockets vs WebSockets

To discover how to get started with WebSockets in the GO, let’s begin by drawing the line between network sockets and WebSockets.

## Network socket

A network socket, or simply a socket, serves as an internal endpoint for exchanging data between applications running on the same computer or on different computers on the same network.

Sockets are a key part of Unix and Windows-based operating systems, and they make it easier for developers to create network-enabled software. Instead of constructing network connections from scratch, app developers can include sockets in their programs. Since network sockets are used for several network protocols (HTTP, FTP, etc.), multiple sockets can be used simultaneously.

Sockets are created and used with a set of function calls defined by a socket’s application programming interface (API).

There are several types of network sockets:

**Datagram sockets (SOCK_DGRAM)**, also known as connectionless sockets, use the User Datagram Protocol (UDP). Datagram sockets support a bidirectional flow of messages and preserve record boundaries.

**Stream sockets (SOCK_STREAM)**, also known as connection-oriented sockets, use the Transmission Control Protocol (TCP), Stream Control Transmission Protocol (SCTP), or Datagram Congestion Control Protocol (DCCP). These sockets provide a bidirectional, reliable, sequenced, and unduplicated flow of data with no record boundaries.

**Raw sockets (or raw IP sockets)** are typically available in routers and other networking equipment. These sockets are normally datagram-oriented, although their exact characteristics depend on the interface provided by the protocol. Raw sockets are not used by most applications. They’re provided to support the development of new communication protocols and to provide access to more esoteric facilities of existing protocols.

**Socket communication**
Each network socket is identified by the address, which is a triad of a transport protocol, IP address, and port number.

There are two major protocols for communicating between hosts: TCP and UDP. Let’s see how your app can connect to TCP and UDP sockets.

## Connecting to a TCP socket

To establish a TCP connection, a Go client uses the DialTCP function in the net package. DialTCP returns a TCPConn object. When a connection is established, the client and server begin exchanging data: the client sends a request to the server through a TCPConn object, the server parses the request and sends a response, and the TCPConn object receives the response from the server.

![alt](https://wp-uploads.yalantis.com/wp-content/uploads/2020/11/19102421/tcp-socket-1.webp)

This connection remains valid until the client or server closes it. The functions for creating a connection are as follows:

Client side:

```golang
 // init
   tcpAddr, err := net.ResolveTCPAddr(resolver, serverAddr)
   if err != nil {
        // handle error
   }
   conn, err := net.DialTCP(network, nil, tcpAddr)
   if err != nil {
           // handle error
   }
   // send message
    _, err = conn.Write({message})
   if err != nil {
        // handle error
   }
   // receive message
   var buf [{buffSize}]byte
   _, err := conn.Read(buf[0:])
   if err != nil {
        // handle error
   }
```

Server side:

```golang
// init
   tcpAddr, err := net.ResolveTCPAddr(resolver, serverAddr)
       if err != nil {
           // handle error
       }
   
       listener, err := net.ListenTCP("tcp", tcpAddr)
    if err != nil {
        // handle error
    }
    
    // listen for an incoming connection
    conn, err := listener.Accept()
    if err != nil {
        // handle error
    }
    
    // send message
    if _, err := conn.Write({message}); err != nil {
        // handle error
    }    
    // receive message
    buf := make([]byte, 512)
    n, err := conn.Read(buf[0:])
    if err != nil {
        // handle error
    }

```

## Connecting to a UDP socket

In contrast to a TCP socket, with a UDP socket, the client just sends a datagram to the server. There’s no Accept function, since the server doesn’t need to accept a connection and just waits for datagrams to arrive.

![alt](https://wp-uploads.yalantis.com/wp-content/uploads/2020/11/19102534/udp-socket-1.webp)

Other TCP functions have UDP counterparts; just replace TCP with UDP in the functions above.

Client side:

```golang
// init
    raddr, err := net.ResolveUDPAddr("udp", address)
    if err != nil {
        // handle error
    }
       
    conn, err := net.DialUDP("udp", nil, raddr)
    if err != nil {
        // handle error
    }
        ....... 
    // send message
    buffer := make([]byte, maxBufferSize)
    n, addr, err := conn.ReadFrom(buffer)
    if err != nil {
        // handle error
    }
         .......            
    // receive message
    buffer := make([]byte, maxBufferSize)
    n, err = conn.WriteTo(buffer[:n], addr)
    if err != nil {
        // handle error
    }
```

Server side:

```golang
    // init
    udpAddr, err := net.ResolveUDPAddr(resolver, serverAddr)
    if err != nil {
        // handle error
    }
    
    conn, err := net.ListenUDP("udp", udpAddr)
    if err != nil {
        // handle error
    }
        .......
    // send message
    buffer := make([]byte, maxBufferSize)
    n, addr, err := conn.ReadFromUDP(buffer)
    if err != nil {
        // handle error
    }
         .......
    // receive message
    buffer := make([]byte, maxBufferSize)
    n, err = conn.WriteToUDP(buffer[:n], addr)
    if err != nil {
        // handle error
    }

```

## What WebSockets are

The WebSocket communication package provides a full-duplex communication channel over a single TCP connection. That means that both the client and the server can simultaneously send data whenever they need without any request.

WebSockets are a good solution for services that require continuous data exchange – for instance, instant messengers, online games, and real-time trading systems. You can find complete information about the WebSocket protocol in the Internet Engineering Task Force (IETF) RFC 6455 specification.

WebSocket connections are requested by browsers and are responded to by servers, after which a connection is established. This process is often called a handshake. The special kind of header in WebSockets requires only one handshake between a browser and server for establishing a connection that will remain active throughout its lifetime.

The WebSocket protocol uses port 80 for an unsecure connection and port 443 for a secure connection. The WebSocket specification determines which uniform resource identifier schemes are required for the ws (WebSocket) and wss (WebSocket Secure) protocols.

WebSockets solve many of the headaches of developing real-time web applications and have several benefits over traditional HTTP:

- The lightweight header reduces data transmission overhead.
- Only one TCP connection is required for a single web client.
- WebSocket servers can push data to web clients.

![](https://wp-uploads.yalantis.com/wp-content/uploads/2020/11/19102644/how-websockets-work-1.webp)

The WebSocket protocol is relatively simple to implement. It uses the HTTP protocol for the initial handshake. After a successful handshake, a connection is established and the WebSocket essentially uses raw TCP to read/write data.

This is what the client request looks like:

```TCP
  GET /chat HTTP/1.1
    Host: server.example.com
    Upgrade: websocket
    Connection: Upgrade
    Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
    Sec-WebSocket-Protocol: chat, superchat
    Sec-WebSocket-Version: 13
    Origin: http://example.com
```

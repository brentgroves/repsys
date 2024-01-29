# Understanding Unix Domain Sockets in Golang

## references

<https://dev.to/douglasmakey/understanding-unix-domain-sockets-in-golang-32n8>

![](https://res.cloudinary.com/practicaldev/image/fetch/s--TVZ7CRzP--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://www.kungfudev.com/img/unix-domain-sockets-by-julia-evans.png)

## Unix Domain Sockets in Golang

In Golang, a socket is a communication endpoint that allows a program to send and receive data over a network. There are two main types of sockets in Golang: Unix domain sockets (AF_UNIX) and network sockets (AF_INET|AF_INET6). This blog post will explore some differences between these two types of sockets.

Unix domain sockets, a.k.a., local sockets, are used for communication between processes on the same machine. They use a file-based interface and can be accessed using the file system path, just like regular files. In some cases, Unix domain sockets are faster and more efficient than network sockets as they do not require the overhead of network protocols and communication. They are commonly used for interprocess communication (IPC) and communication between services on the same machine. The data is transmitted between processes using the file system as the communication channel.

The file system provides a reliable and efficient mechanism for transmitting data between processes. Only the kernel is involved in the communication between processes. The processes communicate by reading and writing to the same socket file, which is managed by the kernel. The kernel is responsible for handling the communication details, such as synchronization, buffering and error handling, and ensures that the data is delivered reliably and in the correct order.

This is different from network sockets, where the communication involves the kernel, the network stack, and the network hardware. The processes use network protocols, such as TCP/UDP, in network sockets to establish connections and transfer data over the network. The kernel and the network stack handle the communication details, such as routing, addressing, and error correction. The network hardware handles the physical transmission of the data over the network.

In Golang, Unix domain sockets are created using the net.Dial "client" or net.Listen "server" functions, with the unix network type. For example, the following code creates a Unix domain socket and listens for incoming connections:

```golang
// Create a Unix domain socket and listen for incoming connections.
socket, err := net.Listen("unix", "/tmp/mysocket.sock")
if err != nil {
    panic(err)
}
```

Let's look at an example of how to use Unix domain sockets in Golang. The following code creates a simple echo server using a Unix domain socket:

```golang
package main
import (...)

func main() {
    // Create a Unix domain socket and listen for incoming connections.
    socket, err := net.Listen("unix", "/tmp/echo.sock")
    if err != nil {
        log.Fatal(err)
    }

    // Cleanup the sockfile.
    c := make(chan os.Signal, 1)
    signal.Notify(c, os.Interrupt, syscall.SIGTERM)
    go func() {
        <-c
        os.Remove("/tmp/echo.sock")
        os.Exit(1)
    }()

    for {
        // Accept an incoming connection.
        conn, err := socket.Accept()
        if err != nil {
            log.Fatal(err)
        }

        // Handle the connection in a separate goroutine.
        go func(conn net.Conn) {
            defer conn.Close()
            // Create a buffer for incoming data.
            buf := make([]byte, 4096)

            // Read data from the connection.
            n, err := conn.Read(buf)
            if err != nil {
                log.Fatal(err)
            }

            // Echo the data back to the connection.
            _, err = conn.Write(buf[:n])
            if err != nil {
                log.Fatal(err)
            }
        }(conn)
    }
}
```

Let's test the above echo server using netcat, you can use the -U option to specify the socket file. This allows you to connect to the socket and send and receive data through it.

The **[Netcat](https://phoenixnap.com/kb/nc-command#:~:text=The%20Netcat%20(%20nc%20)%20command%20is,%2C%20ncat%20%2C%20and%20others)** ( nc ) command is a command-line utility for reading and writing data between two computer networks. The communication happens using either TCP or UDP. The command differs depending on the system ( netcat , nc , ncat , and others)

```bash
$ echo "I'm a Kungfu Dev" | nc -U /tmp/echo.sock
I'm a Kungfu Dev
```

Network sockets, on the other hand, are used for communication between processes on different machines. They use network protocols, such as TCP and UDP. Network sockets are more versatile than Unix domain sockets, as they can be used to communicate with processes on any machine that is connected to the network. They are commonly used for client-server communication, such as web servers and client applications.

In Golang, network sockets are created using the net.Dial or net.Listen functions, with a network type such as TCP or UDP. For example, the following code creates a TCP socket and listens for incoming connections:

```golang
// Create a TCP socket and listen for incoming connections.
socket, err := net.Listen("tcp", ":8000")
if err != nil {
    panic(err)
}

```

Basic Profiling from a client perspective
Client pprof for network socket

```bash
Type: cpu
...
(pprof) list main.main
...
ROUTINE ======================== main.main in /Users/douglasmakey/go/src/github.com/douglasmakey/go-sockets-uds-network-pprof/server_echo_network_socket/client/main.go
         0      530ms (flat, cum) 70.67% of Total 
         .          .     16: 
         .          .     17:   pprof.StartCPUProfile(f) 
         .          .     18:   defer pprof.StopCPUProfile() 
         .          .     19: 
         .          .     20:   for i := 0; i < 10000; i++ { 
         .      390ms     21:          conn, err := net.Dial("tcp", "localhost:3000") 
         .          .     22:          if err != nil { 
         .          .     23:                  log.Fatal(err) 
         .          .     24:          } 
         .          .     25: 
         .          .     26:          msg := "Hello" 
         .       40ms     27:          if _, err := conn.Write([]byte(msg)); err != nil { 
         .          .     28:                  log.Fatal(err) 
         .          .     29:          } 
         .          .     30: 
         .          .     31:          b := make([]byte, len(msg)) 
         .      100ms     32:          if _, err := conn.Read(b); err != nil { 
         .          .     33:                  log.Fatal(err) 
         .          .     34:          } 
         .          .     35:   } 
         .          .     36:}
```

Client pprof for unix socket

```bash
Type: cpu
...
(pprof) list main.main
...
ROUTINE ======================== main.main in /Users/douglasmakey/go/src/github.com/douglasmakey/go-sockets-uds-network-pprof/server_echo_unix_domain_socket/client/main.go
         0      210ms (flat, cum) 80.77% of Total 
         .          .     16: 
         .          .     17:   pprof.StartCPUProfile(f) 
         .          .     18:   defer pprof.StopCPUProfile() 
         .          .     19: 
         .          .     20:   for i := 0; i < 10000; i++ { 
         .      130ms     21:          conn, err := net.Dial("unix", "/tmp/echo.sock") 
         .          .     22:          if err != nil { 
         .          .     23:                  log.Fatal(err) 
         .          .     24:          } 
         .          .     25: 
         .          .     26:          msg := "Hello" 
         .       40ms     27:          if _, err := conn.Write([]byte(msg)); err != nil { 
         .          .     28:                  log.Fatal(err) 
         .          .     29:          } 
         .          .     30: 
         .          .     31:          b := make([]byte, len(msg)) 
         .       40ms     32:          if _, err := conn.Read(b); err != nil { 
         .          .     33:                  log.Fatal(err) 
         .          .     34:          } 
         .          .     35:   } 
         .          .     36:}
```

Things to notice in these basic profiles are:

Open an unix socket is significantly faster than a network socket.
Reading from unix socket is significantly faster than reading from a network socket.
Github Repo

NEXT: <https://dev.to/douglasmakey/understanding-unix-domain-sockets-in-golang-32n8>

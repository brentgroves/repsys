# Sockets

## **[Client/Server Communication via Sockets](https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_Languages/Java_Java_Java_-_Object-Oriented_Programming_(Morelli_and_Walde)/15%3A_Sockets_and_Networking/15.06%3A_Client_Server_Communication_via_Sockets)**

As we said earlier, many networking applications are based on the client/ server model. According to this model, a task is viewed as a service that can be requested by clients and handled by servers. In this section, we develop a simple client/server framework based on a socket connection between the client and the server.

A socket is a simple communication channel through which two programs communicate over a network. A socket supports two-way communication between a client and a server, using a well-established protocol. The protocol simply prescribes rules and behavior that both the server and client must follow in order to establish two-way communication.

According to this protocol, a server program creates a socket at a certain port and waits until a client requests a connection. A port is a particular address or entry point on the host computer, which typically has hundreds of potential ports. It is usually represented as a simple integer value. For example, the standard port for an HTTP (Web) server is 80. Once the connection is established, the server creates input and output streams to the socket and begins sending messages to and receiving messages from the client. Either the client or the server can close the connection, but it’s usually done by the client.

To help clarify this protocol, think of some service performed by a human using a telephone connection. The “server” waits for the phone to ring. When it rings, the server picks it up and begins communicating with the client. A socket, combined with input and output streams, is something like a two-way phone connection.

From the client’s side, the protocol goes as follows: The client creates a socket and attempts to make a connection to the server. The client has to know the server’s URL and the port at which the service exists. Once a connection has been established, the client creates input and output streams to the socket and begins exchanging messages with the server. The client can close the connection when the service is completed.

Think again of the telephone analogy. A human client picks up the phone and dials the number of a particular service. This is analogous to the client program creating a socket and making a connection to a server. Once the service agent answers the phone, two-way communication between the client and the server can begin.

Figure [fig-clientserverpict] provides a view of the client/server connection. Note that a socket has two channels. Once a connection has been established between a client and a server, a single two-way channel exists between them. The client’s output stream is connected to the server’s input stream. The server’s output stream is connected to the client’s input stream.

## The Server Protocol

Let’s now see how a client/server application would be coded in Java. The template in Figure [fig-serverpro] shows the code that is necessary on the server side. The first step the server takes is to create a ServerSocket. The first argument to the ServerSocket() method is the port at which the service will reside. The second argument specifies the number of clients that can be backlogged, waiting on the server, before a client will be refused service. If more than one client at a time should request service, Java would establish and manage a waiting list, turning away clients when the list is full.

The next step is to wait for a client request. The accept() method will block until a connection is established. The Java system is responsible for waking the server when a client request is received.

```java
Socket socket;    // Reference to the socket
ServerSocket port;// The port where the server will listen
try {
    port = new ServerSocket(10001, 5); // Create a port
    socket = port.accept();  // Wait for client to call

 // Communicate with the client

    socket.close();
} catch (IOException e) {
    e.printStackTrace();
}
```

Once a connection is established, the server can begin communicating with the client. As we have suggested, a socket connection is like a two-way telephone conversation. Both the client and server can “talk” back and forth to each other. The details of this step are not shown here. As we will see, the two-way conversation is managed by connecting both an input and an output stream to the socket.

Once the conversation between client and server is finished—once the server has delivered the requested service—the server can close the connection by calling close(). Thus, there are four steps involved on the server side:

1. Create a ServerSocket and establish a port number.
2. Listen for and accept a connection from a client.
3. Converse with the client.
4. Close the socket.

What distinguishes the server from the client is that the server establishes the port and accepts the connection.

## The Client Protocol

The client protocol (Fig. [fig-clientpro]) is just as easy to implement. Indeed, on the client side there are only three steps involved. The first step is to request a connection to the server. This is done in the Socket() constructor by supplying the server’s URL and port number. Once the connection is established, the client can carry out two-way communication with the server. This step is not shown here. Finally, when the client is finished, it can simply close() the connection. Thus, from the client side, the protocol involves just three steps:

1. Open a socket connection to the server, given its address.
2. Converse with the server.
3. Close the connection.

What distinguishes the client from the server is that the client initiates the two-way connection by requesting the service.

```java
Socket connection;     // Reference to the socket
try {                  // Request a connection
  connection = new Socket("java.cs.trincoll.edu", 10001);

   // Carry on a two-way communication

    connection.close();   // Close the socket
} catch (IOException e ) {
    e.printStackTrace();
}

```

## A Two-Way Stream Connection

Now that we have seen how to establish a socket connection between a client and server, let’s look at the actual two-way communication that takes place. Because this part of the process will be exactly the same for both client and server, we develop a single set of methods, writeToSocket() and readFromSocket(), that may be called by either.

The writeToSocket() method takes two parameters, the and a String, which will be sent to the process on the other end of the socket:

```java
protected void writeToSocket(Socket sock, String str) 
                             throws IOException {
    oStream = sock.getOutputStream();
    for (int k = 0; k < str.length(); k++)
        oStream.write(str.charAt(k));
}// writeToSocket()
```

If writeToSocket() is called by the server, then the string will be sent to the client. If it is called by the client, the string will be sent to the server.

The method is declared protected because we will define it in a superclass so that it can be inherited and used by both the client and server classes. Note also that the method declares that it throws an IOException. Because there’s no way to fix an IOException, we’ll just let this exception be handled elsewhere, rather than handling it within the method.

The method is declared protected because we will define it in a superclass so that it can be inherited and used by both the client and server classes. Note also that the method declares that it throws an IOException. Because there’s no way to fix an IOException, we’ll just let this exception be handled elsewhere, rather than handling it within the method.

In order to write to a socket we need only get the socket’s OutputStream and then write to it. For this example, oStream is an instance variable of the client/server superclass. We use the Socket.getOutputStream() method to get a reference to the socket’s output stream. Note that we are not creating a new output stream here. We are just getting a reference to an existing stream, which was created when the socket connection was accepted. Note also that we do not close the output stream before exiting the method. This is important. If you close the stream, you will lose the ability to communicate through the socket.

Given the reference to the socket’s output stream, we simply write each character of the string using the OutputStream.write() method. This method writes a single byte. Therefore, the input stream on the other side of the socket must read bytes and convert them back into characters.

The readFromSocket() method takes a Socket parameter and returns a String:

```java
protected String readFromSocket(Socket sock) 
                                throws IOException {
    iStream = sock.getInputStream();
    String str="";
    char c;
    while (  ( c = (char) iStream.read() ) != '\n')
        str = str + c + "";
    return str;
}
```

It uses the Socket.getInputStream() method to obtain a reference to the socket’s input stream, which has already been created. So here again it is important that you don’t close the stream in this method. A socket’s input and output streams will be closed automatically when the socket connection itself is closed.

The InputStream.read() method reads a single byte at a time from the input stream until an end-of-line character is received. For this particular application, the client and server will both read and write one line of characters at a time. Note the use of the cast operator (char) in the read() statement. Because bytes are being read, they must be converted to char before they can be compared to the end-of-line character or concatenated to the String. When the read loop encounters an end-of-line character, it terminates and returns the String that was input.

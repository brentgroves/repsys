# **[Socket Programming](https://docs.python.org/3/howto/sockets.html)**

## Abstract

Sockets are used nearly everywhere, but are one of the most severely misunderstood technologies around. This is a 10,000 foot overview of sockets. It’s not really a tutorial - you’ll still have work to do in getting things operational. It doesn’t cover the fine points (and there are a lot of them), but I hope it will give you enough background to begin using them decently.

## Sockets

I’m only going to talk about INET (i.e. IPv4) sockets, but they account for at least 99% of the sockets in use. And I’ll only talk about STREAM (i.e. TCP) sockets - unless you really know what you’re doing (in which case this HOWTO isn’t for you!), you’ll get better behavior and performance from a STREAM socket than anything else. I will try to clear up the mystery of what a socket is, as well as some hints on how to work with blocking and non-blocking sockets. But I’ll start by talking about blocking sockets. You’ll need to know how they work before dealing with non-blocking sockets.

Part of the trouble with understanding these things is that “socket” can mean a number of subtly different things, depending on context. So first, let’s make a distinction between a “client” socket - an endpoint of a conversation, and a “server” socket, which is more like a switchboard operator. The client application (your browser, for example) uses “client” sockets exclusively; the web server it’s talking to uses both “server” sockets and “client” sockets.

## History

Of the various forms of IPC, sockets are by far the most popular. On any given platform, there are likely to be other forms of IPC that are faster, but for cross-platform communication, sockets are about the only game in town.

They were invented in Berkeley as part of the BSD flavor of Unix. They spread like wildfire with the internet. With good reason — the combination of sockets with INET makes talking to arbitrary machines around the world unbelievably easy (at least compared to other schemes).

A Unix domain socket (UDS) or IPC socket (inter-process communication) is a data communications endpoint for exchanging data between processes executing on the same host operating system. It is also referred to by its address family AF_UNIX.

Creating a Socket
Roughly speaking, when you clicked on the link that brought you to this page, your browser did something like the following:

## create an INET, STREAMing socket

```python
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# now connect to the web server on port 80 - the normal http port
s.connect(("www.python.org", 80))
```

When the connect completes, the socket s can be used to send in a request for the text of the page. The same socket will read the reply, and then be destroyed. That’s right, destroyed. Client sockets are normally only used for one exchange (or a small set of sequential exchanges).

What happens in the web server is a bit more complex. First, the web server creates a “server socket”:

```python
# create an INET, STREAMing socket
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# bind the socket to a public host, and a well-known port
serversocket.bind((socket.gethostname(), 80))
# become a server socket
serversocket.listen(5)
```

A couple things to notice: we used socket.gethostname() so that the socket would be visible to the outside world. If we had used s.bind(('localhost', 80)) or s.bind(('127.0.0.1', 80)) we would still have a “server” socket, but one that was only visible within the same machine. s.bind(('', 80)) specifies that the socket is reachable by any address the machine happens to have.

A second thing to note: low number ports are usually reserved for “well known” services (HTTP, SNMP etc). If you’re playing around, use a nice high number (4 digits).

Finally, the argument to listen tells the socket library that we want it to queue up as many as 5 connect requests (the normal max) before refusing outside connections. If the rest of the code is written properly, that should be plenty.

Now that we have a “server” socket, listening on port 80, we can enter the mainloop of the web server:

```python
while True:
    # accept connections from outside
    (clientsocket, address) = serversocket.accept()
    # now do something with the clientsocket
    # in this case, we'll pretend this is a threaded server
    ct = client_thread(clientsocket)
    ct.run()
```

There’s actually 3 general ways in which this loop could work - dispatching a thread to handle clientsocket, create a new process to handle clientsocket, or restructure this app to use non-blocking sockets, and multiplex between our “server” socket and any active clientsockets using select. More about that later. The important thing to understand now is this: this is all a “server” socket does. It doesn’t send any data. It doesn’t receive any data. It just produces “client” sockets. Each clientsocket is created in response to some other “client” socket doing a connect() to the host and port we’re bound to. As soon as we’ve created that clientsocket, we go back to listening for more connections. The two “clients” are free to chat it up - they are using some dynamically allocated port which will be recycled when the conversation ends.

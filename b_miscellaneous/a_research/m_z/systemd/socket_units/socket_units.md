# **[The End of the Road: systemd’s “Socket” Units](https://www.linux.com/training-tutorials/end-road-systemds-socket-units/)**

**[Current Tasks](../../../../a_status/current_tasks.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## AI Overview

Socket-Based SSH Activation: Old Linux Dogs vs. New Systemd ...
Systemd socket activation allows services to be started only when a client connects to a specific socket, reducing resource consumption when the service is idle. This is achieved by configuring a socket unit (.socket file) that listens on a socket, and a service unit (.service file) that is activated when the socket receives a connection.

## Here's a breakdown of how it works

1. Define a Socket Unit:
.
Create a unit file with a ".socket" extension, specifying the socket's address (IP, port, or file system path) and other configuration parameters like Accept=yes (allowing the service to accept the connection).

2. Define a Service Unit:
.
Create a unit file with a ".service" extension. This file defines the service to be started when the socket receives a connection. You can use the Service= directive in the socket unit to specify the service to be activated.

3. Systemd's Role:
.
When the socket unit receives a connection, systemd starts the associated service, passing the socket file descriptor to the service.

4. Service Handles the Connection:
.
The service then takes over handling the connection, processing requests and responses.

## Example

Let's say you have a simple web server that you want to activate only on demand.
Socket Unit (e.g., webserver.socket):

```bash
[Unit]
Description=Activates the webserver service on demand

[Socket]
ListenStream=0.0.0.0:8080
Accept=yes

[Install]
WantedBy=sockets.target
```

Service Unit (e.g., webserver.service):
Code

```bash
[Unit]
Description=Simple Web Server
Wants=webserver.socket

[Service]
ExecStart=/usr/bin/simple_web_server.py
Restart=on-failure
```

## Explanation

The webserver.socket unit listens on port 8080.
When a client connects to port 8080, systemd starts the webserver.service.
The simple_web_server.py script handles the connection and serves web pages.

## Benefits of Socket Activation

- Resource Efficiency: Services are only started when needed, reducing resource consumption, especially on systems with limited resources like VPSs or containers.
- Improved Scalability: Services can be easily scaled up and down based on demand.
- Security: You can restrict access to services by only allowing connections on specific sockets.

## Key Concepts

sd_listen_fds():
A systemd library function that provides file descriptors to the service, allowing it to accept connections from the socket.
LISTEN_FDS:
An environment variable that tells the service the number of sockets it has received.
socket activation:
A general term for a system where services are started on demand based on incoming connections.

## tutorial start

Sockets are used so that two different processes can share data or for shuttling information from one machine to another over the network. They are extremely useful and the basis of things like FTP, real-time network chat systems, secure shells, and so on.

For the fly-by programmer, sockets can be somewhat hard to get right, but by using systemd’s socket units, you can make systemd do the heavy lifting.

Besides making sockets simpler to set up, systemd dumps whatever comes in through the socket to STDIN. This means you don’t have to bother with complicated socket management in you script; just pick up the data from STDIN and use it from there.

The other advantage is that systemd will make sure your socket is active only as long as necessary, waking it up when data is incoming, and closing it down again when it is done. This saves resources, as the server associated on the receiving side will be closed most of the time and will only be activated if a systemd socket unit detects activity on its port.

To see how all this works, first you’ll see how easy it is to send some strings of text over a systemd activated socket. Later, we’ll look at how to send a whole binary file. Finally, we will pick up the systemd-based surveillance system we have been developing over the past several installments and learn how to send the images it captures to your laptop.

DISCLAIMER: What you’ll see here are over-simplified examples created for teaching purposes only. Although they all work, there is no error-handling or security built into any of them. I don’t recommend you use them in a real-world scenario.

## Sending Texts

Socket units are stupidly simple, or rather, they usually are. Although there are dozens of socket-specific directives you can use to fine tune your units, you will rarely use more than two. In this case, you do exactly that and use only a listening directive and the Accept directive:

```bash
# echo.socket

[Unit]
Description = Echo server

[Socket]
ListenStream = 4444
Accept = yes

[Install]
WantedBy = sockets.target
```

That is what a basic socket file looks like. It has a [Socket] section where you specify what it has to listen for. Apart from streams, it can listen for datagrams, sequential packages, and so on. On the other side of the “=" is where to listen from. You could specify a full IP address, file system socket, or something else. A single number, like you can see above, means a port. This socket unit will be listening on the local machine to port 4444.

The other socket-specific directive is Accept. Accept by default is set to false, as this is used mostly for AF_UNIX sockets. Not to get into too much detail, but AF_UNIX sockets are sockets where the processes sharing the information reside on the same machine.

As you want to send information from one machine to another, you will be using an AF_INET, and for that the best thing to do is have Accept set to true or yes.

The service itself is also pretty basic:

```bash
# <echo@.service>

[Unit]
Description=Echo server service

[Service]
ExecStart=/path/to/socketthing.py
StandardInput=socket
```

In most cases, the service will have the same name the socket unit, except with an @ and the service suffix. As your socket unit was echo.socket, your service will be <echo@.service>.

The service “Type" is “simple", which is already the default, so there is no need to include it. "ExecStart” points to the socketthing.py script you will see in a minute, and the "StandardInput" for said script comes from the socket set up by echo.socket.

The socketthing.py script is just three lines long:

```bash
# !/usr/bin/python
import sys
sys.stdout.write(sys.stdin.readline().strip().upper() + 'rn')
```

What this does is read a line of text in from STDIN, which, as you saw, comes in via the socket. Then it strips all the spaces from the beginning and the end, and puts it into uppercase (sys.stdin.readline().strip().upper()). Finally it sends it back across the socket to the terminal of the sending computer (sys.stdout.write([...])). This means a user will connect to your receiving machine’s socket, type in a string, and will see it echoed back in CAPITAL LETTERS.

Start the socket unit with:

`sudo systemctl start echo.socket`

And echo.socket will automatically call <echo@.service> (which in turn runs socketthing.py) each time someone tries to push a string to the server through port 4444.

To do that, on the sending computer, you can use a program like socat:

```bash
$ socat - TCP:server_IP_address:4444
hello computer
HELLO COMPUTER
```

The socat utility is a relay for bidirectional data transfers between two independent data channels.

There are many different types of channels socat can connect, including:

Although good for illustrating how to get started, this example is pretty pointless. Let’s do something a bit more useful and send over a whole file…

## Transferring Files

For a systemd, there is no difference between sending a stream of text to a stream of binary data. In fact, to all practical effects the socket file is the same…

```bash
# filetrans.socket
[Unit] 
Description=File transfer server 

[Socket] 
ListenStream=4444 
Accept=yes 

[Install] 
WantedBy=sockets.target
```

… As is the service unit:

```bash
# <filetrans@.service>

[Unit]
Description=File transfer server service

[Service]
ExecStart=/path/to/socketfilething.py
StandardInput=socket
```

All you need to do is change the name and description of the services and have the “new” <filetrans@.service> point to a script that will handle the reception of the file.

In this case, the script, socketfilething.py, will handle PDFs coming from the sending computer:

```bash
# !/usr/bin/python
import sys

output_file = open ("/path/to/store/test.pdf", "wb")
output_file.write(sys.stdin.buffer.read())
output_file.close()
```

You use sys.stdin.buffer.read() to read in a stream of binary data from STDIN, and, as you have opened test.pdf in write binary mode ("wb"), you can just write the stream passed down from the socket directly into the file.

To try this our, from the sending end of things, you can send a PDF file over the wire again using socat:

`cat some.pdf | socat - TCP:192.168.1.111:4444`

On the receiving end, a copy of some.pdf (called test.pdf) will pop up in the directory of your choice.

You can probably see where we are going with this and how we can use it in our systemd-powered surveillance system.

Surveillance Sockets
Again, on the receiving side, there is virtually no difference to either the socket unit:

```bash
# surveillance.socket #

[Unit]
Description=Surveillance server

[Socket]
ListenStream=4444
Accept=yes

[Install]
WantedBy=sockets.target
```

… Or the service unit:

```bash
# <surveillance@.service> #

[Unit]
Description=Surveillance server service

[Service]
ExecStart=/path/to/surveillancething.py
StandardInput=socket
```

Save for a change of name, description and the have it point to another script you will call surveillancething.py:

```bash
# !/usr/bin/python
import sys
from time import strftime

fn = strftime("%Y_%m_%d_%H_%M_%S")+".jpg"

output_file = open ("/path/to/store/" + fn, "wb")
output_file.write(sys.stdin.buffer.read())
output_file.close()
```

This new script is very similar to the prior one you used to send a PDF. The only difference is that, as the surveying machine sends an image every time it detects changes, you want to give each image you receive a unique name, preferably with a time stamp, hence the fn = strftime("%Y_%m_%d_%H_%M_%S")+".jpg" line.

On the surveying side, you only need to change the `picmonitor.sh` file so that it sends the new image over the socket:

```bash
# !/bin/bash
fn=`date|tr [:punct:][:space:] _`.jpg
cp /home/[user name]/monitor/monitor.jpg /home/[user name]/monitor/$fn
cat /home/[user name]/monitor/$fn | socat - TCP:192.168.1.111:4444
```

Start surveillance.socket on the server and **[picchanged.timer](https://www.linux.com/blog/intro-to-linux/2018/8/systemd-timers-two-use-cases-0)** on the surveying machine, and you will start to receive images from your spying webcam.

## Conclusion

And that’s it! Over the past few months, we have covered everything you need to know to get started writing systemd units. We have gone from the most basic service units, all the way through device event-activated services, timers, and more.

In case you missed anything, here’s an index to all the other systemd topics we have covered:

Basic Services: Writing Systemd Services for Fun and Profit
More Advanced Services: Beyond Starting and Stopping
Device-aware services: Reacting to Change
Paths: Monitoring Files and Directories
Timers 1: Setting Up a Timer
Timers 2: Timers: Three Use Cases

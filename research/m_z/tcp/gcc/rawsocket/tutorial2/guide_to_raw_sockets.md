# **[A Guide to Using Raw Sockets](https://www.opensourceforu.com/2015/03/a-guide-to-using-raw-sockets/)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

In this tutorial, let us take a look at how raw sockets can be used to receive data packets and send those packets to specific user applications, bypassing the normal TCP/IP protocols.

If you have no knowledge of the Linux kernel, yet are interested in the contents of network packets, raw sockets are the answer. Raw sockets are used to receive raw packets. This means packets received at the Ethernet layer will directly pass to the raw socket. Stating it precisely, a raw socket bypasses the normal TCP/IP processing and sends the packets to the specific user application (see Figure 1).

![f1](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-11-1-350x108.jpg)

## A raw socket vs other sockets

Other sockets like stream sockets and data gram sockets receive data from the transport layer that contains no headers but only the payload. This means that there is no information about the source IP address and MAC address. If applications running on the same machine or on different machines are communicating, then they are only exchanging data.

The purpose of a raw socket is absolutely different. A raw socket allows an application to directly access lower level protocols, which means a raw socket receives un-extracted packets (see Figure 2). There is no need to provide the port and IP address to a raw socket, unlike in the case of stream and datagram sockets.

![f2](https://www.opensourceforu.com/wp-content/uploads/2015/09/Figure-24.jpg)

## Network packets and packet sniffers

When an application sends data into the network, it is processed by various network layers. Before sending data, it is wrapped in various headers of the network layer. The wrapped form of data, which contains all the information like the source and destination address, is called a network packet (see Figure 3). According to Ethernet protocols, there are various types of network packets like Internet Protocol packets, Xerox PUP packets, Ethernet Loopback packets, etc. In Linux, we can see all protocols in the if_ether.h header file (see Figure 4).

![f3](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-3-Generic-Network-Packet-Representation-590x30.png)

![f4](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-4-Network-Packet-for-IP-Protocol-590x35.png)

When we connect to the Internet, we receive network packets, and our machine extracts all network layer headers and sends data to a particular application. For example, when we type <www.google.com> in our browser, we receive packets sent from Google, and our machine extracts all the headers of the network layer and gives the data to our browser.

By default, a machine receives those packets that have the same destination address as that of the machine, and this mode is called the non-promiscuous mode. But if we want to receive all the packets, we have to switch into the promiscuous mode. We can go into the promiscuous mode with the help of ioctls.

If we are interested in the contents or the structure of the headers of different network layers, we can access these with the help of a packet sniffer. There are various packet sniffers available for Linux, like Wireshark. There is a command line sniffer called tcpdump, which is also a very good packet sniffer. And if we want to make our own packet sniffer, it can easily be done if we know the basics of C and networking.

## A packet sniffer with a raw socket

To develop a packet sniffer, you first have to open a raw socket. Only processes with an effective user ID of 0 or the CAP_NET_RAW capability are allowed to open raw sockets. So, during the execution of the program, you have to be the root user.

## Opening a raw socket

To open a socket, you have to know three things  the socket family, socket type and protocol. For a raw socket, the socket family is AF_PACKET, the socket type is SOCK_RAW and for the protocol, see the if_ether.h header file. To receive all packets, the macro is **[ETH_P_ALL](https://www.mutekh.org/doc/netinet_ether_h_header_reference.html)** and to receive IP packets, the macro is ETH_P_IP for the protocol field.

```c
#define ETH_P_ALL  0x0003    
This macro is declared in netinet/ether.h source file, line 69.
```

```c
int sock_r;
sock_r=socket(AF_PACKET,SOCK_RAW,htons(ETH_P_ALL));
if(sock_r<0)
{
printf(error in socket\n);
return -1;
}
```

## Reception of the network packet

After successfully opening a raw socket, its time to receive network packets, for which you need to use the recvfrom api. We can also use the recv api. But recvfrom provides additional information.

```c
unsigned char *buffer = (unsigned char*) malloc(65536); //to receive data
memset(buffer,0,65536);
struct sockaddr saddr;
int saddr_len = sizeof (saddr);

//Receive a network packet and copy in to buffer
buflen=recvfrom(sock_r,buffer,65536,0,&saddr,(socklen_t *)&saddr_len);
if(buflen<0)
{
printf(error in reading recvfrom function\n);
return -1;
}
```

In saddr, the underlying protocol provides the source address of the packet.

## Extracting the Ethernet header

Now that we have the network packets in our buffer, we will get information about the Ethernet header. The Ethernet header contains the physical address of the source and destination, or the MAC address and protocol of the receiving packet. The if_ether.h header contains the structure of the Ethernet header (see Figure 5).

![f5](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-5-Structure-of-Ethernet-header.png)

Now, we can easily access these fields:

```c
struct ethhdr *eth = (struct ethhdr*)(buffer);
printf(\nEthernet Header\n);
printf(\t|-Source Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n,eth->h_source[0],eth->h_source[1],eth->h_source[2],eth->h_source[3],eth->h_source[4],eth->h_source[5]);
printf(\t|-Destination Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n,eth->h_dest[0],eth->h_dest[1],eth->h_dest[2],eth->h_dest[3],eth->h_dest[4],eth->h_dest[5]);
printf(\t|-Protocol : %d\n,eth->h_proto);
```

h_proto gives information about the next layer. If you get 0x800 (ETH_P_IP), it means that the next header is the IP header. Later, we will consider the next header as the IP header.

Note 1: The physical address is 6 bytes.

Note 2: We can also direct the output to a file for better understanding.

```c
fprintf(log_txt,\t|-Source Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n,eth->h_source[0],eth->h_source[1],eth->h_source[2],eth->h_source[3],eth->h_source[4],eth->h_source[5]);
```

Use fflush to avoid the input-output buffer problem when writing into a file.

## Extracting the IP header

The IP layer gives various pieces of information like the source and destination IP address, the transport layer protocol, etc. The structure of the IP header is defined in the ip.h header file (see Figure 6).

![f6](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-6-Structure-of-IP-Header.png)

Now, to get this information, you need to increment your buffer pointer by the size of the Ethernet header because the IP header comes after the Ethernet header:

```c
unsigned short iphdrlen;
struct iphdr *ip = (struct iphdr*)(buffer + sizeof(struct ethhdr));
memset(&source, 0, sizeof(source));
source.sin_addr.s_addr = ip->saddr;
memset(&dest, 0, sizeof(dest));
dest.sin_addr.s_addr = ip->daddr;
 
fprintf(log_txt, \t|-Version : %d\n,(unsigned int)ip->version);
 
fprintf(log_txt , \t|-Internet Header Length : %d DWORDS or %d Bytes\n,(unsigned int)ip->ihl,((unsigned int)(ip->ihl))*4);
 
fprintf(log_txt , \t|-Type Of Service : %d\n,(unsigned int)ip->tos);
 
fprintf(log_txt , \t|-Total Length : %d Bytes\n,ntohs(ip->tot_len));
 
fprintf(log_txt , \t|-Identification : %d\n,ntohs(ip->id));
 
fprintf(log_txt , \t|-Time To Live : %d\n,(unsigned int)ip->ttl);
 
fprintf(log_txt , \t|-Protocol : %d\n,(unsigned int)ip->protocol);
 
fprintf(log_txt , \t|-Header Checksum : %d\n,ntohs(ip->check));
 
fprintf(log_txt , \t|-Source IP : %s\n, inet_ntoa(source.sin_addr));
 
fprintf(log_txt , \t|-Destination IP : %s\n,inet_ntoa(dest.sin_addr));
```

![f7](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-7-Structure-of-TCP-Header-350x502.png)
tcp header
![f8](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-8-Structure-of-UDP-Header.png)
udp header

## The transport layer header

There are various transport layer protocols. Since the underlying header was the IP header, we have various IP or Internet protocols. You can see these protocols in the /etc/protocls file. The TCP and UDP protocol structures are defined in tcp.h and udp.h respectively. These structures provide the port number of the source and destination. With the help of the port number, the system gives data to a particular application (see Figures 7 and 8).
The size of the IP header varies from 20 bytes to 60 bytes. We can calculate this from the IP header field or IHL. IHL means Internet Header Length (IHL), which is the number of 32-bit words in the header. So we have to multiply the IHL by 4 to get the size of the header in bytes:

```c
struct iphdr *ip = (struct iphdr *)( buffer + sizeof(struct ethhdr) );
/* getting actual size of IP header*/
iphdrlen = ip->ihl*4;
/* getting pointer to udp header*/
struct tcphdr *udp=(struct udphdr*)(buffer + iphdrlen + sizeof(struct ethhdr));
```

We now have the pointer to the UDP header. So lets check some of its fields.

Note: If your machine is little endian, you have to use `ntohs` because the network uses the big endian scheme.

```c
fprintf(log_txt , \t|-Source Port : %d\n , ntohs(udp->source));
fprintf(log_txt , \t|-Destination Port : %d\n , ntohs(udp->dest));
fprintf(log_txt , \t|-UDP Length : %d\n , ntohs(udp->len));
fprintf(log_txt , \t|-UDP Checksum : %d\n , ntohs(udp->check));
```

Similarly, we can access the TCP header field.

## Extracting data

After the transport layer header, there is data payload remaining. For this, we will move the pointer to the data, and then print.

```c
unsigned char * data = (buffer + iphdrlen + sizeof(struct ethhdr) + sizeof(struct udphdr));
```

Now, lets print data, and for better representation, let us print 16 bytes in a line.

```c
int remaining_data = buflen - (iphdrlen + sizeof(struct ethhdr) + sizeof(struct udphdr));

for(i=0;i<remaining_data;i++)
{
if(i!=0 && i%16==0)
fprintf(log_txt,\n);
fprintf(log_txt, %.2X ,data[i]);
}
```

When you receive a packet, it will look like whats shown is Figures 9 and 10.

![f9](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-9-UDP-Packet.png)
udp packet

![f10](https://www.opensourceforu.com/wp-content/uploads/2015/03/Figure-10-TCP-Packet.png)
tcp packet

## Sending packets with a raw socket

To send a packet, we first have to know the source and destination IP addresses as well as the MAC address. Use your friends MAC & IP address as the destination IP and MAC address. There are two ways to find out your IP address and MAC address:

Enter ifconfig and get the IP and MAC for a particular interface.

Enter ioctl and get the IP and MAC.
The second way is more efficient and will make your program machine-independent, which means you should not enter ifconfig in each machine.

## **[ioctl](https://github.com/jerome-pouiller/ioctl)** command line tool

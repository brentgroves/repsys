# tcpdump

## references

<https://opensource.com/article/18/10/introduction-tcpdump>

## An introduction to using tcpdump at the Linux command line

This flexible, powerful command-line tool helps ease the pain of troubleshooting network issues.

Tcpdump is a command line utility that allows you to capture and analyze network traffic going through your system. It is often used to help troubleshoot network issues, as well as a security tool.

A powerful and versatile tool that includes many options and filters, tcpdump can be used in a variety of cases. Since it's a command line tool, it is ideal to run in remote servers or devices for which a GUI is not available, to collect data that can be analyzed later. It can also be launched in the background or as a scheduled job using tools like cron.

## Installation on Linux

Tcpdump is included with several Linux distributions, so chances are, you already have it installed. Check whether tcpdump is installed on your system with the following command:

```bash
which tcpdump
/bin/tcpdump
```

Tcpdump requires libpcap, which is a library for network packet capture. If it's not installed, it will be automatically added as a dependency.

You're ready to start capturing some packets.

## Capturing packets with tcpdump

To capture packets for troubleshooting or analysis, tcpdump requires elevated permissions, so in the following examples most commands are prefixed with sudo.

To begin, use the command tcpdump --list-interfaces (or -D for short) to see which interfaces are available for capture:

```bash
sudo tcpdump -D
1.eth0
2.virbr0
3.eth1
4.any (Pseudo-device that captures on all interfaces)
5.lo [Loopback]

# reports-alb
sudo tcpdump -D
1.enp0s25 [Up, Running, Connected]
2.docker0 [Up, Running, Connected]
3.vethf7ce1ad [Up, Running, Connected]
4.any (Pseudo-device that captures on all interfaces) [Up, Running]
5.lo [Up, Running, Loopback]
6.mpqemubr0 [Up, Disconnected]
7.br-ef440bd353e1 [Up, Disconnected]
8.br-860dc0d9b54b [Up, Disconnected]
9.br-924b3db7b366 [Up, Disconnected]
10.br-b543cc541f49 [Up, Disconnected]
11.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
12.nflog (Linux netfilter log (NFLOG) interface) [none]
13.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
14.dbus-system (D-Bus system bus) [none]
15.dbus-session (D-Bus session bus) [none]

# reports11

sudo tcpdump -D
[sudo] password for brent: 
1.enp0s31f6 [Up, Running, Connected]
2.cali715c7bde611 [Up, Running, Connected]
3.calib7941b2f74d [Up, Running, Connected]
4.vxlan.calico [Up, Running, Connected]
5.cali56b95e837c6 [Up, Running, Connected]
6.cali7b9b66e0016 [Up, Running, Connected]
7.cali92441034b36 [Up, Running, Connected]
8.any (Pseudo-device that captures on all interfaces) [Up, Running]
9.lo [Up, Running, Loopback]
10.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
11.nflog (Linux netfilter log (NFLOG) interface) [none]
12.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
13.dbus-system (D-Bus system bus) [none]
14.dbus-session (D-Bus session bus) [none]

# reports13
sudo tcpdump -D
[sudo] password for brent: 
1.eno1 [Up, Running, Connected]
2.cali87d0e87cee8 [Up, Running, Connected]
3.vxlan.calico [Up, Running, Connected]
4.calib6e99f7c0f0 [Up, Running, Connected]
5.cali273c23168a9 [Up, Running, Connected]
6.calie61a2eec846 [Up, Running, Connected]
7.cali171f4d0822a [Up, Running, Connected]
8.cali049a4ac6276 [Up, Running, Connected]
9.cali9673087a9d3 [Up, Running, Connected]
10.any (Pseudo-device that captures on all interfaces) [Up, Running]
11.lo [Up, Running, Loopback]
12.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
13.nflog (Linux netfilter log (NFLOG) interface) [none]
14.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
15.dbus-system (D-Bus system bus) [none]
16.dbus-session (D-Bus session bus) [none]

```

In the example above, you can see all the interfaces available in my machine. The special interface any allows capturing in any active interface.

Let's use it to start capturing some packets. Capture all packets in any interface by running this command:

```bash
sudo tcpdump --interface any
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on any, link-type LINUX_SLL (Linux cooked), capture size 262144 bytes
09:56:18.293641 IP rhel75.localdomain.ssh > 192.168.64.1.56322: Flags [P.], seq 3770820720:3770820916, ack 3503648727, win 309, options [nop,nop,TS val 76577898 ecr 510770929], length 196
09:56:18.293794 IP 192.168.64.1.56322 > rhel75.localdomain.ssh: Flags [.], ack 196, win 391, options [nop,nop,TS val 510771017 ecr 76577898], length 0
09:56:18.295058 IP rhel75.59883 > gateway.domain: 2486+ PTR? 1.64.168.192.in-addr.arpa. (43)
09:56:18.310225 IP gateway.domain > rhel75.59883: 2486 NXDomain* 0/1/0 (102)
09:56:18.312482 IP rhel75.49685 > gateway.domain: 34242+ PTR? 28.64.168.192.in-addr.arpa. (44)
09:56:18.322425 IP gateway.domain > rhel75.49685: 34242 NXDomain* 0/1/0 (103)
09:56:18.323164 IP rhel75.56631 > gateway.domain: 29904+ PTR? 1.122.168.192.in-addr.arpa. (44)
09:56:18.323342 IP rhel75.localdomain.ssh > 192.168.64.1.56322: Flags [P.], seq 196:584, ack 1, win 309, options [nop,nop,TS val 76577928 ecr 510771017], length 388
09:56:18.323563 IP 192.168.64.1.56322 > rhel75.localdomain.ssh: Flags [.], ack 584, win 411, options [nop,nop,TS val 510771047 ecr 76577928], length 0
09:56:18.335569 IP gateway.domain > rhel75.56631: 29904 NXDomain* 0/1/0 (103)
09:56:18.336429 IP rhel75.44007 > gateway.domain: 61677+ PTR? 98.122.168.192.in-addr.arpa. (45)
09:56:18.336655 IP gateway.domain > rhel75.44007: 61677* 1/0/0 PTR rhel75. (65)
09:56:18.337177 IP rhel75.localdomain.ssh > 192.168.64.1.56322: Flags [P.], seq 584:1644, ack 1, win 309, options [nop,nop,TS val 76577942 ecr 510771047], length 1060

---- SKIPPING LONG OUTPUT -----

09:56:19.342939 IP 192.168.64.1.56322 > rhel75.localdomain.ssh: Flags [.], ack 1752016, win 1444, options [nop,nop,TS val 510772067 ecr 76578948], length 0
^C
9003 packets captured
9010 packets received by filter
7 packets dropped by kernel

```

Tcpdump continues to capture packets until it receives an interrupt signal. You can interrupt capturing by pressing Ctrl+C. As you can see in this example, tcpdump captured more than 9,000 packets. In this case, since I am connected to this server using ssh, tcpdump captured all these packets. To limit the number of packets captured and stop tcpdump, use the -c (for count) option:

```bash
sudo tcpdump -i any -c 5
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
13:20:43.299413 enp0s25 B   ARP, Request who-has BUSCHE-ENG-1-PC.BUSCHE-CNC.com tell WES008064C4E766.busche, length 46
13:20:43.346775 lo    In  IP localhost.56041 > localhost.domain: 12140+ [1au] PTR? 180.0.1.10.in-addr.arpa. (52)
13:20:43.347341 enp0s25 Out IP reports-alb.busche-cnc.com.60009 > ALB-AD01.BUSCHE-CNC.COM.domain: 35394+ [1au] PTR? 180.0.1.10.in-addr.arpa. (52)
13:20:43.348135 enp0s25 In  IP ALB-AD01.BUSCHE-CNC.COM.domain > reports-alb.busche-cnc.com.60009: 35394* 1/0/1 PTR BUSCHE-ENG-1-PC.BUSCHE-CNC.com. (96)
13:20:43.348428 lo    In  IP localhost.domain > localhost.56041: 12140 1/0/1 PTR BUSCHE-ENG-1-PC.BUSCHE-CNC.com. (96)
5 packets captured
40 packets received by filter
0 packets dropped by kernel
```

In this case, tcpdump stopped capturing automatically after capturing five packets. This is useful in different scenarios—for instance, if you're troubleshooting connectivity and capturing a few initial packets is enough. This is even more useful when we apply filters to capture specific packets (shown below).

By default, tcpdump resolves IP addresses and ports into names, as shown in the previous example. When troubleshooting network issues, it is often easier to use the IP addresses and port numbers; disable name resolution by using the option -n and port resolution with -nn:

```bash
sudo tcpdump -i any -c5 -nn
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
13:24:11.595727 enp0s25 B   IP 10.1.2.157.137 > 10.1.3.255.137: UDP, length 50
13:24:11.696906 enp0s25 B   ARP, Request who-has 10.1.2.14 tell 10.1.1.205, length 46
13:24:11.805898 econsole
13:24:12.075820 enp0s25 B   ARP, Request who-has 10.1.0.180 tell 10.1.0.150, length 46
5 packets captured
5 packets received by filter
0 packets dropped by kernel
```

As shown above, the capture output now displays the IP addresses and port numbers. This also prevents tcpdump from issuing DNS lookups, which helps to lower network traffic while troubleshooting network issues.

Now that you're able to capture network packets, let's explore what this output means.

Understanding the output format
Tcpdump is capable of capturing and decoding many different protocols, such as TCP, UDP, ICMP, and many more. While we can't cover all of them here, to help you get started, let's explore the TCP packet. You can find more details about the different protocol formats in tcpdump's manual pages. A typical TCP packet captured by tcpdump looks like this:

08:41:13.729687 IP 192.168.64.28.22 > 192.168.64.1.41916: Flags [P.], seq 196:568, ack 1, win 309, options [nop,nop,TS val 117964079 ecr 816509256], length 372

The fields may vary depending on the type of packet being sent, but this is the general format.

The first field, 08:41:13.729687, represents the timestamp of the received packet as per the local clock.

Next, IP represents the network layer protocol—in this case, IPv4. For IPv6 packets, the value is IP6.

The next field, 192.168.64.28.22, is the source IP address and port. This is followed by the destination IP address and port, represented by 192.168.64.1.41916.

After the source and destination, you can find the TCP Flags Flags [P.]. Typical values for this field include:

| Value | Flag Type | Description       |
|-------|-----------|-------------------|
| S     | SYN       | Connection Start  |
| F     | FIN       | Connection Finish |
| P     | PUSH      | Data push         |
| R     | RST       | Connection reset  |
| .     | ACK       | Acknowledgment    |

This field can also be a combination of these values, such as [S.] for a SYN-ACK packet.

Next is the sequence number of the data contained in the packet. For the first packet captured, this is an absolute number. Subsequent packets use a relative number to make it easier to follow. In this example, the sequence is seq 196:568, which means this packet contains bytes 196 to 568 of this flow.

This is followed by the Ack Number: ack 1. In this case, it is 1 since this is the side sending data. For the side receiving data, this field represents the next expected byte (data) on this flow. For example, the Ack number for the next packet in this flow would be 568.

The next field is the window size win 309, which represents the number of bytes available in the receiving buffer, followed by TCP options such as the MSS (Maximum Segment Size) or Window Scale. For details about TCP protocol options, consult Transmission Control Protocol (TCP) Parameters.

Finally, we have the packet length, length 372, which represents the length, in bytes, of the payload data. The length is the difference between the last and first bytes in the sequence number.

Now let's learn how to filter packets to narrow down results and make it easier to troubleshoot specific issues.

Filtering packets
As mentioned above, tcpdump can capture too many packets, some of which are not even related to the issue you're troubleshooting. For example, if you're troubleshooting a connectivity issue with a web server you're not interested in the SSH traffic, so removing the SSH packets from the output makes it easier to work on the real issue.

One of tcpdump's most powerful features is its ability to filter the captured packets using a variety of parameters, such as source and destination IP addresses, ports, protocols, etc. Let's look at some of the most common ones.

## Protocol

To filter packets based on protocol, specifying the protocol in the command line. For example, capture ICMP packets only by using this command:

```bash
sudo tcpdump -i any -c5 icmp
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
13:46:52.547988 enp0s25 Out IP reports-alb.busche-cnc.com > reports1.busche-cnc.com: ICMP echo request, id 2, seq 1, length 64
13:46:53.557933 enp0s25 Out IP reports-alb.busche-cnc.com > reports1.busche-cnc.com: ICMP echo request, id 2, seq 2, length 64
13:46:53.558268 enp0s25 In  IP reports13 > reports-alb.busche-cnc.com: ICMP redirect reports1.busche-cnc.com to host reports1.busche-cnc.com, length 92
13:46:54.581971 enp0s25 Out IP reports-alb.busche-cnc.com > reports1.busche-cnc.com: ICMP echo request, id 2, seq 3, length 64
13:46:54.582213 enp0s25 In  IP reports13 > reports-alb.busche-cnc.com: ICMP redirect reports1.busche-cnc.com to host reports1.busche-cnc.com, length 92
5 packets captured
5 packets received by filter
0 packets dropped by kernel

# In a different terminal, try to ping another machine:
ping reports1.busche-cnc.com

% Back in the tcpdump capture, notice that tcpdump captures and displays only the ICMP-related packets. In this case, tcpdump is not displaying name resolution packets that were generated when resolving the name reports1.busche-cnc.com:

```

## Host

Limit capture to only packets related to a specific host by using the host filter:

```bash
sudo tcpdump -i any -c5 -nn host 10.1.0.112
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
13:53:37.998474 enp0s25 B   ARP, Request who-has 10.1.0.8 tell 10.1.0.112, length 46
13:53:39.001040 enp0s25 B   ARP, Request who-has 10.1.0.8 tell 10.1.0.112, length 46
13:53:39.030239 enp0s25 In  IP 10.1.0.112 > 10.1.0.113: ICMP redirect 10.1.0.8 to host 10.1.0.8, length 92
13:53:40.024984 enp0s25 B   ARP, Request who-has 10.1.0.8 tell 10.1.0.112, length 46
13:53:40.054284 enp0s25 In  IP 10.1.0.112 > 10.1.0.113: ICMP redirect 10.1.0.8 to host 10.1.0.8, length 92
5 packets captured
5 packets received by filter
0 packets dropped by kernel
```

## Port

To filter packets based on the desired service or port, use the port filter. For example, capture packets related to a web (HTTP) service by using this command:

```bash
ssh reports13
sudo tcpdump -i any -c5 -nn port 80
# from reports-alb terminal
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
curl -v -H 'apikey: hello_world' http://$PROXY_IP/echo
# output from tcpdump on reports13
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:08:42.539544 eno1  In  IP 10.1.0.113.53152 > 10.1.0.8.80: Flags [S], seq 1062607367, win 64240, options [mss 1460,sackOK,TS val 1407715691 ecr 0,nop,wscale 7], length 0
19:08:42.539689 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.53152: Flags [S.], seq 575134565, ack 1062607368, win 64308, options [mss 1410,sackOK,TS val 924638 ecr 1407715691,nop,wscale 7], length 0
19:08:42.539910 eno1  In  IP 10.1.0.113.53152 > 10.1.0.8.80: Flags [.], ack 1, win 502, options [nop,nop,TS val 1407715691 ecr 924638], length 0
19:08:42.540071 eno1  In  IP 10.1.0.113.53152 > 10.1.0.8.80: Flags [P.], seq 1:98, ack 1, win 502, options [nop,nop,TS val 1407715691 ecr 924638], length 97: HTTP: GET /echo HTTP/1.1
19:08:42.540130 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.53152: Flags [.], ack 98, win 502, options [nop,nop,TS val 924638 ecr 1407715691], length 0
5 packets captured
12 packets received by filter
0 packets dropped by kernel

# 
ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 98:90:96:c3:f4:83 brd ff:ff:ff:ff:ff:ff
    altname enp0s25
4: cali87d0e87cee8@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-be042aea-d3c4-50d5-2817-9b5dc0d0f583
7: vxlan.calico: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN mode DEFAULT group default 
    link/ether 66:eb:2f:b2:c5:e7 brd ff:ff:ff:ff:ff:ff
8: calib6e99f7c0f0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-b563bde9-ff57-0b44-6fb1-cc00b9740d6b
28: cali273c23168a9@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-2257b9ef-d87d-6fff-80b5-fab218898133
29: calie61a2eec846@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-2f61d90e-9981-904c-ff68-224c416d2f33
31: cali171f4d0822a@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-874aa017-970a-9651-1f39-2e47c044584e
33: cali049a4ac6276@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-b67b509f-2b0b-8890-52df-ab3e968ede48
34: cali9673087a9d3@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether ee:ee:ee:ee:ee:ee brd ff:ff:ff:ff:ff:ff link-netns cni-691960fb-20ef-51e9-6b04-c0783fc21902

```

Source IP/hostname
You can also filter packets based on the source or destination IP Address or hostname. For example, to capture packets from host 192.168.122.98:

```bash
# from reports13
sudo tcpdump -i any -c5 -nn src 10.1.0.8
# or
sudo tcpdump -i any -c5 -nn src reports1.busche-cnc.com

# from reports-alb
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
curl -v -H 'apikey: hello_world' http://$PROXY_IP/echo
# output on reports13
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:21:10.705354 eno1  Out ARP, Reply 10.1.0.8 is-at 98:90:96:c3:f4:83, length 46
19:21:18.086604 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.38910: Flags [S.], seq 1351503601, ack 1862760056, win 64308, options [mss 1410,sackOK,TS val 1680185 ecr 1408471238,nop,wscale 7], length 0
19:21:18.087078 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.38910: Flags [.], ack 98, win 502, options [nop,nop,TS val 1680185 ecr 1408471239], length 0
19:21:18.090527 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.38910: Flags [P.], seq 1:630, ack 98, win 502, options [nop,nop,TS val 1680189 ecr 1408471239], length 629: HTTP: HTTP/1.1 200 OK
19:21:18.091393 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.38910: Flags [F.], seq 630, ack 99, win 502, options [nop,nop,TS val 1680190 ecr 1408471243], length 0
5 packets captured
7 packets received by filter
0 packets dropped by kernel

```

Notice that tcpdumps captured packets with source IP address 192.168.122.98 for multiple services such as name resolution (port 53) and HTTP (port 80). The response packets are not displayed since their source IP is different.

Conversely, you can use the dst filter to filter by destination IP/hostname:

```bash
sudo tcpdump -i any -c5 -nn dst reports-alb
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:31:05.409453 eno1  Out IP 10.1.0.112.22 > 10.1.0.113.54980: Flags [P.], seq 1038455467:1038455543, ack 72787904, win 501, options [nop,nop,TS val 1791966791 ecr 539409855], length 76
19:31:05.411344 eno1  Out IP 10.1.0.112.22 > 10.1.0.113.54980: Flags [P.], seq 76:280, ack 1, win 501, options [nop,nop,TS val 1791966793 ecr 539409855], length 204
19:31:05.489483 eno1  Out IP 10.1.0.112.22 > 10.1.0.113.54980: Flags [P.], seq 280:668, ack 1, win 501, options [nop,nop,TS val 1791966871 ecr 539409888], length 388
19:31:05.597770 eno1  Out IP 10.1.0.112.22 > 10.1.0.113.54980: Flags [P.], seq 668:872, ack 1, win 501, options [nop,nop,TS val 1791966979 ecr 539410007], length 204
19:31:05.701532 eno1  Out IP 10.1.0.112.22 > 10.1.0.113.54980: Flags [P.], seq 872:1076, ack 1, win 501, options [nop,nop,TS val 1791967083 ecr 539410075], length 204
5 packets captured
5 packets received by filter
0 packets dropped by kernel

```

Complex expressions
You can also combine filters by using the logical operators and and or to create more complex expressions. For example, to filter packets from source IP address 192.168.122.98 and service HTTP only, use this command:

```bash
# from reports13
# sudo tcpdump -i any -c5 -nn src 10.1.0.8 and port 80
sudo tcpdump -i any -c5 -nn dst reports-alb and port 80
# from reports-alb
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
curl -v -H 'apikey: hello_world' http://$PROXY_IP/echo
# output on reports13
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:38:32.817363 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.39876: Flags [S.], seq 1746092061, ack 3164218779, win 64308, options [mss 1410,sackOK,TS val 2714916 ecr 1409505967,nop,wscale 7], length 0
19:38:32.817878 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.39876: Flags [.], ack 98, win 502, options [nop,nop,TS val 2714916 ecr 1409505968], length 0
19:38:32.819661 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.39876: Flags [P.], seq 1:629, ack 98, win 502, options [nop,nop,TS val 2714918 ecr 1409505968], length 628: HTTP: HTTP/1.1 200 OK
19:38:32.820735 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.39876: Flags [F.], seq 629, ack 99, win 502, options [nop,nop,TS val 2714919 ecr 1409505970], length 0


```

You can create more complex expressions by grouping filter with parentheses. In this case, enclose the entire filter expression with quotation marks to prevent the shell from confusing them with shell expressions:

```bash
sudo tcpdump -i any -c5 -nn "port 80 and (src 192.168.122.98 or src 54.204.39.132)"
```

## Checking packet content

In the previous examples, we're checking only the packets' headers for information such as source, destinations, ports, etc. Sometimes this is all we need to troubleshoot network connectivity issues. Sometimes, however, we need to inspect the content of the packet to ensure that the message we're sending contains what we need or that we received the expected response. To see the packet content, tcpdump provides two additional flags: -X to print content in hex, and ASCII or -A to print the content in ASCII.

For example, inspect the HTTP content of a web request like this:

```bash
# from reports13
sudo tcpdump -i any -c10 -nn -A port 80
# from reports-alb
curl -v -H 'apikey: hello_world' http://$PROXY_IP/echo
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
# output on reports13
tcpdump: data link type LINUX_SLL2
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:42:55.393629 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [S], seq 738157153, win 64240, options [mss 1460,sackOK,TS val 1409768543 ecr 0,nop,wscale 7], length 0
E..<.Z@.@.p.
..q
......P+.ba...................
T.\_........
19:42:55.393821 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.59642: Flags [S.], seq 597094301, ack 738157154, win 64308, options [mss 1410,sackOK,TS val 2977492 ecr 1409768543,nop,wscale 7], length 0
E..<..@.?.'B
...
..q.P..#...+.bb...4...........
.-n.T.\_....
19:42:55.394124 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [.], ack 1, win 502, options [nop,nop,TS val 1409768544 ecr 2977492], length 0
E..4.[@.@.p.
..q
......P+.bb#..............
T.\`.-n.
19:42:55.394236 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [P.], seq 1:98, ack 1, win 502, options [nop,nop,TS val 1409768544 ecr 2977492], length 97: HTTP: GET /echo HTTP/1.1
E....\@.@.p.
..q
......P+.bb#........e.....
T.\`.-n.GET /echo HTTP/1.1
Host: 10.1.0.8
User-Agent: curl/7.81.0
Accept: */*
apikey: hello_world


19:42:55.394288 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.59642: Flags [.], ack 98, win 502, options [nop,nop,TS val 2977493 ecr 1409768544], length 0
E..4..@.?.f\
...
..q.P..#...+.b............
.-n.T.\`
19:42:55.396178 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.59642: Flags [P.], seq 1:629, ack 98, win 502, options [nop,nop,TS val 2977495 ecr 1409768544], length 628: HTTP: HTTP/1.1 200 OK
E.....@.?.c.
...
..q.P..#...+.b............
.-n.T.\`HTTP/1.1 200 OK
Content-Type: text/plain; charset=utf-8
Connection: keep-alive
X-RateLimit-Remaining-Minute: 4
X-RateLimit-Limit-Minute: 5
RateLimit-Remaining: 4
RateLimit-Reset: 47
RateLimit-Limit: 5
X-Cache-Key: bf9ad6963d82d689c472470e83911459acf0c2aa2767ee7633e71354abe03c09
Date: Wed, 07 Feb 2024 19:38:13 GMT
X-Cache-Status: Hit
Content-Length: 136
X-Kong-Upstream-Latency: 0
X-Kong-Proxy-Latency: 1
Via: kong/3.5.0
X-Kong-Request-Id: be90f276dbe38f1a9f7e8678692d4636

Welcome, you are connected to node reports12.
Running on Pod echo-74c66b778-k8pzn.
In namespace default.
With IP address 10.1.102.213.


19:42:55.396417 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [.], ack 629, win 501, options [nop,nop,TS val 1409768546 ecr 2977495], length 0
E..4.]@.@.p.
..q
......P+.b.#........).....
T.\b.-n.
19:42:55.397009 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [F.], seq 98, ack 629, win 501, options [nop,nop,TS val 1409768547 ecr 2977495], length 0
E..4.^@.@.p.
..q
......P+.b.#........'.....
T.\c.-n.
19:42:55.397178 eno1  Out IP 10.1.0.8.80 > 10.1.0.113.59642: Flags [F.], seq 629, ack 99, win 502, options [nop,nop,TS val 2977495 ecr 1409768547], length 0
E..4..@.?.fZ
...
..q.P..#...+.b............
.-n.T.\c
19:42:55.397404 eno1  In  IP 10.1.0.113.59642 > 10.1.0.8.80: Flags [.], ack 630, win 501, options [nop,nop,TS val 1409768547 ecr 2977495], length 0
E..4._@.@.p.
..q
......P+.b.#........&.....
T.\c.-n.
10 packets captured
12 packets received by filter
0 packets dropped by kernel

```

## Saving captures to a file

Another useful feature provided by tcpdump is the ability to save the capture to a file so you can analyze the results later. This allows you to capture packets in batch mode overnight, for example, and verify the results in the morning. It also helps when there are too many packets to analyze since real-time capture can occur too fast.

To save packets to a file instead of displaying them on screen, use the option -w (for write):

```bash
$ sudo tcpdump -i any -c10 -nn -w webserver.pcap port 80
[sudo] password for ricardo:
tcpdump: listening on any, link-type LINUX_SLL (Linux cooked), capture size 262144 bytes
10 packets captured
10 packets received by filter
0 packets dropped by kernel
```

This command saves the output in a file named webserver.pcap. The .pcap extension stands for "packet capture" and is the convention for this file format.

As shown in this example, nothing gets displayed on-screen, and the capture finishes after capturing 10 packets, as per the option -c10. If you want some feedback to ensure packets are being captured, use the option -v.

Tcpdump creates a file in binary format so you cannot simply open it with a text editor. To read the contents of the file, execute tcpdump with the -r (for read) option:

```bash
tcpdump -nn -r webserver.pcap
reading from file webserver.pcap, link-type LINUX_SLL (Linux cooked)
13:36:57.679494 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [S], seq 3709732619, win 29200, options [mss 1460,sackOK,TS val 135708029 ecr 0,nop,wscale 7], length 0
13:36:57.718932 IP 54.204.39.132.80 > 192.168.122.98.39378: Flags [S.], seq 1999298316, ack 3709732620, win 28960, options [mss 1460,sackOK,TS val 526052949 ecr 135708029,nop,wscale 9], length 0
13:36:57.719005 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [.], ack 1, win 229, options [nop,nop,TS val 135708068 ecr 526052949], length 0
13:36:57.719186 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [P.], seq 1:113, ack 1, win 229, options [nop,nop,TS val 135708068 ecr 526052949], length 112: HTTP: GET / HTTP/1.1
13:36:57.756979 IP 54.204.39.132.80 > 192.168.122.98.39378: Flags [.], ack 113, win 57, options [nop,nop,TS val 526052959 ecr 135708068], length 0
13:36:57.760122 IP 54.204.39.132.80 > 192.168.122.98.39378: Flags [P.], seq 1:643, ack 113, win 57, options [nop,nop,TS val 526052959 ecr 135708068], length 642: HTTP: HTTP/1.1 302 Found
13:36:57.760182 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [.], ack 643, win 239, options [nop,nop,TS val 135708109 ecr 526052959], length 0
13:36:57.977602 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [F.], seq 113, ack 643, win 239, options [nop,nop,TS val 135708327 ecr 526052959], length 0
13:36:58.022089 IP 54.204.39.132.80 > 192.168.122.98.39378: Flags [F.], seq 643, ack 114, win 57, options [nop,nop,TS val 526053025 ecr 135708327], length 0
13:36:58.022132 IP 192.168.122.98.39378 > 54.204.39.132.80: Flags [.], ack 644, win 239, options [nop,nop,TS val 135708371 ecr 526053025], length 0

```

Since you're no longer capturing the packets directly from the network interface, sudo is not required to read the file.

You can also use any of the filters we've discussed to filter the content from the file, just as you would with real-time data. For example, inspect the packets in the capture file from source IP address 54.204.39.132 by executing this command:

```bash
tcpdump -nn -r webserver.pcap src 54.204.39.132
```

## What's next?

These basic features of tcpdump will help you get started with this powerful and versatile tool. To learn more, consult the **[tcpdump website](http://www.tcpdump.org/#)** and man pages.

The tcpdump command line interface provides great flexibility for capturing and analyzing network traffic. If you need a graphical tool to understand more complex flows, look at **[Wireshark](https://www.wireshark.org/)**.

One benefit of Wireshark is that it can read .pcap files captured by tcpdump. You can use tcpdump to capture packets in a remote machine that does not have a GUI and analyze the result file with Wireshark, but that is a topic for another day.

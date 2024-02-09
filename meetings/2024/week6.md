# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear you must perform better than your neighbor.  I say help your neighbor and especially help the ones that are struggling. Do not worry about your own status.  Do not promote yourself instead think of others and help them in their work.

Report System IT Admin, Hardware, or Software Topics of Interest

This markdown file is located at: ~/src/repsys/meetings/2024/week6.md
It can be viewed from <https://markdownlivepreview.com/> or by logging into devcon2(10.1.0.120) as bcieslik,bcook,sjackson,cstangland,rdecker,bhall,jdavis,or kyoung with password k8sAdmin1! and opening week45.md from visual studio code and pressing shift-ctrl-v.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in these meetings!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin something about Plex or other machines if you want :-)
- Brad something about Fruitport casters or other machines if you want :-)
- Sam something about Mach2 or Kep ServerEx or Fruitport caster code if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent H. something about Azure tenant migration, or anything you want :-)
- Brent G. Microsoft Data Analytics team, Network connectivity trouble-shooting

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

## Last Meeting Summary

Talked to Aamir Ghaffar and Vishal Kumar Medavarapu

- Send email of PowerBI paginated (rdx) report to Vishal

## WebFocus Report

- Short running reports
- Periodic reports

## On-Premise Sql Server

- Periodic reports
- Export result dataset from ETL pipeline to Lanimar data warehouse
- Export DDL for Tables and create a service request.

## Postgres and MySQL

- Live archivable reports such as current shift and TB
- Long running reports such as mean time between failure

## **[Azure Sql Server](https://learn.microsoft.com/en-us/azure/azure-sql/database/features-comparison?view=azuresql) for ETL

- Azure Sql Server for Teams Report requestor and Power BI app access to dynamic archivable reports.

## Create Microsoft Team

```bash
Name: Data Analytics
Owner: Brent Groves
Members:
Jake Kunkel
Sam Jackson
Dan Martin
Brendan Cieslik
Brad D. Cook
Kevin Young
Apps: Power BI
Channels:
General
Financial
```

Need **[paginated report](https://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-faq)** license.

## Power BI license

e-3 need e-5 license to publish Power BI paginated report
Just send it to someone with an e-5 license

This article answers frequently asked questions about paginated reports. These reports are highly formatted, print-ready output optimized for printing or PDF generation. They're called "paginated" because they're formatted to fit well on multiple pages. Paginated reports are based on the RDL report technology in SQL Server Reporting Services.

This article answers many common questions people have about paginated reports in Power BI, and about Power BI Report Builder, the standalone tool for authoring paginated reports. You don't need a Premium Per User (PPU) license or a Power BI Pro license to publish paginated reports to My Workspace. You do need a **[PPU](https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-per-user-faq)** or **[Power BI Pro license](https://learn.microsoft.com/en-us/power-bi/fundamentals/service-self-service-signup-for-power-bi)** and write access to publish to other workspaces. Users with free, Pro, and PPU licenses can view the content. To learn more about licensing, see Licensing the Power BI service for users in your organization

## Scan your LAN for available IP

<https://nmap.org/book/port-scanning-tutorial.html>
<https://www.techrepublic.com/article/how-to-scan-for-ip-addresses-on-your-network-with-linux/>

```bash
sudo snap install nmap
sudo apt-get install nmap -y

# Once the installation completes, you are ready to scan your LAN with nmap. To find out what addresses are in use, issue the command:

nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22
nmap 172.20.88.115
<https://172.20.88.115-118>

# Note: You will need to alter the IP address scheme to match yours.

# The output of the command (Figure B), will show you each address found on your LAN.

sudo nmap -vv -sS -O -n 172.20.88.0/22
```

While this simple command is often all that is needed, advanced users often go much further. In Example 4.3, the scan is modified with four options. -p0- asks Nmap to scan every possible TCP port, -v asks Nmap to be verbose about it, -A enables aggressive tests such as remote OS detection, service/version detection, and the Nmap Scripting Engine (NSE). Finally, -T4 enables a more aggressive timing policy to speed up the scan.

nmap p0- -v -A -T4 172.20.88.115

## Network connectivity issues

Complex expressions
You can also combine filters by using the logical operators and and or to create more complex expressions. For example, to filter packets from source IP address 192.168.122.98 and service HTTP only, use this command:

```bash
# from reports13
# Protocol filter
# sudo tcpdump -i any -c5 icmp
# Host filter
# sudo tcpdump -i any -c5 -nn host 10.1.0.112
# port filter
# sudo tcpdump -i any -c5 -nn port 80
# Source IP/hostname
# sudo tcpdump -i any -c5 -nn src 10.1.0.8 and port 80
# sudo tcpdump -i any -c5 -nn dst reports-alb and port 80
# Complex expression
# sudo tcpdump -i any -c5 -nn "port 80 and (src reports-alb or dst reports1.busche-cnc.com)"
# Checking packet content
# sudo tcpdump -i any -c10 -nn -A port 80

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

## Why **[OpenStack](https://microstack.run/)**

We have K8s clusters spanning 3 dell Optiplexes in both Avilla and Albion. So, if one machine breaks the cluster continues to run the report system on the other two.  We also have K8s clusters on various virtual machines on Nutanix and WMware vSphere hypervisors. If one of those virtual machines go down K8s maybe able to run the software on the other nodes but we have not tested this.  If we create an OpenStack cluster on three or more bare Dell R620s we can ensure the report system stays running even if one or more nodes goes down.

How OpenStack differs from other hypervisors is its API.  It is made to be automated and controlled by clients through it's API.

## service mesh vs. API gateway

Here are the key things to know about service mesh vs. API gateway:

- Service mesh acts as a centralized infrastructure layer for efficient microservices communication, simplifying tasks like service discovery and load balancing.
- API gateways, on the other hand, serves as the entry point for external clients to access microservices, managing functions like request routing and authentication.

## Introduction to Linux interfaces for **[virtual networking](https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking)**

Linux has virtual networking capabilities that are used VMs and containers, as well as cloud environments. A list of interfaces can be obtained using the command ip link help.

```bash
ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s25: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 18:03:73:1f:84:a4 brd ff:ff:ff:ff:ff:ff
3: br-ef440bd353e1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:93:30:4c:99 brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:41:39:29:a3 brd ff:ff:ff:ff:ff:ff
5: br-860dc0d9b54b: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:df:51:6d:49 brd ff:ff:ff:ff:ff:ff
6: br-924b3db7b366: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:cf:f7:6f:b4 brd ff:ff:ff:ff:ff:ff
7: br-b543cc541f49: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:91:90:d3:0d brd ff:ff:ff:ff:ff:ff
```

For other interfaces like tunnel, please see **[An introduction to Linux virtual interfaces: Tunnels](https://developers.redhat.com/blog/2019/05/17/an-introduction-to-linux-virtual-interfaces-tunnels/)**

## Bridge

A Linux bridge behaves like a network switch. It forwards packets between interfaces that are connected to it. It's usually used for forwarding packets on routers, on gateways, or between VMs and network namespaces on a host. It also supports STP, VLAN filter, and multicast snooping.

![](https://developers.redhat.com/blog/wp-content/uploads/2018/10/bridge.png)

Use a bridge when you want to establish communication channels between VMs, containers, and your hosts.

### Here's how to create a bridge

```bash
# ip link add br0 type bridge
# ip link set eth0 master br0
# ip link set tap1 master br0
# ip link set tap2 master br0
# ip link set veth1 master br0
```

This creates a bridge device named br0 and sets two TAP devices (tap1, tap2), a VETH device (veth1), and a physical device (eth0) as its slaves, as shown in the diagram above.

## How to find the **[mac address](https://unix.stackexchange.com/questions/120153/resolving-mac-address-from-ip-address-in-linux)** to remote ip

## kubernetes Load balancer

I don't know how it works but it does not seem to use iproute2 utilities to add a second IP to the network interface.

### **[Multiple IP Address](https://netplan.readthedocs.io/en/stable/examples/#how-to-use-multiple-addresses-on-a-single-interface)** per NIC

From **[article](https://askubuntu.com/questions/1432883/how-to-create-sub-interface)** with many examples **[here](https://netplan.readthedocs.io/en/stable/examples/#how-to-use-multiple-addresses-on-a-single-interface)**:

At this fundamental level, aliases are supported by the Linux kernel. However, I believe the ability to create aliases for interfaces comes from older network configuration tools like ifconfig and route

Second, the iproute2 package and its utilities are the modern approach to network configuration. It allows assigning multiple addresses to an interface without the need for aliases.

Third, netplan, it is yet another new approach to configuring networks and interfaces, via yaml files.

Specific to your question, you will wind up defining different routes per IP address on your interface. Netplan DOES provide labeling of interfaces but I don't believe this is necessary for you to achieve your goals. (From the documentation)

```yaml
ethernets:
enp3s0:
  addresses:
    - 10.100.1.37/24
    - 10.100.1.38/24:
        label: "enp3s0:0"
    - 10.100.1.39/24:
        label: "enp3s0:some-label"
```

A **[SOCKs5 proxy server](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** creates a Transmission Control Protocol (TCP) connection to another server behind the firewall on the client’s behalf, then exchanges network packets between the client and the actual server. The SOCKS proxy server doesn’t interpret the network traffic between client and server in any way; it is often used because clients are behind a firewall and are not permitted to establish TCP connections to outside servers unless they do it through the SOCKS proxy server. Therefore, a SOCKS proxy relays a user’s TCP and User Datagram Protocol (UDP) session over a firewall.

SOCKS is a layer 5 protocol, and it doesn’t care about anything below that layer in the Open Systems Interconnection (OSI) model — meaning you can’t use it to tunnel protocols operating below layer 5. This includes ping, Address Resolution Protocol (ARP), etc. From a security perspective, it won’t allow attackers to perform scans using tools such as Nmap if they are scanning based on half-open connections because it works at layer 5.

![](https://www.imperva.com/learn/wp-content/uploads/sites/13/2020/02/OSI-vs.-TCPIP-models.jpg.webp)

Since SOCKS sits at layer 5, between SSL (layer 7) and TCP/UDP (layer 4), it can handle several request types, including HTTP, HTTPS, POP3, SMTP, and FTP. As a result, SOCKS can be used for email, web browsing, peer-to-peer sharing, file transfers, and more.

Other proxies built for specific protocols at layer 7, such as an HTTP proxy that is used to interpret and forward HTTP or HTTPS traffic between client and server, are often referred to as application proxies.

There are only two versions: SOCKS4 and SOCKs5. The main differences between SOCKs5 and SOCKS4 are:

- SOCKS4 doesn’t support authentication, while SOCKs5 supports a variety of authentication methods; and
- SOCKS4 doesn’t support UDP proxies, while SOCKs5 does.

## What is Azure Bastion?

I do not believe Azure Bastion is a **[SOCKs5 proxy server](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** which we could use to create a secure TCP connection to our API Gateway. Instead, it is only usable to create a secure RDP/SSH connection to an on-premise server.

Is our Bastion host configured to provide SSH tunneling (Dynamic Port Forwarding) from an Azure Public IP to a VM or computer within our company's network, remote port forwarding, taking care of TLS termination?

![](https://learn.microsoft.com/en-us/azure/bastion/media/connect-ip-address/ip-address.png)

<https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm#managingsessions>

## **[Azure Bastion Native Client Support](https://codyburkard.com/blog/bastionabuse/)**

Instead of logging in through the Azure Portal, Azure Bastion now allows users to connect using their native RDP or SSH clients.

If so I believe Bastion can be setup to route traffic to our K8s-hosted API gateway which has its own routing, throttling, TLS termination, and IAM authentication and authorization scheme.

If TLS termination is done by our Bastion host then we will probably need to pay for a Public IP and a TLS certificate. Once this is done I believe we will be able to access our data warehouse reporting UI and micro-services from a Microsoft Teams reporting app.

Azure Bastion is a fully managed PaaS service that you provision to securely connect to virtual machines via a private IP address. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal, or via the native SSH or RDP client already installed on your local computer. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network for which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

The following diagram shows connections to virtual machines via a Bastion deployment that uses a Basic or Standard SKU.

![](https://learn.microsoft.com/en-us/azure/bastion/media/bastion-overview/architecture.png)

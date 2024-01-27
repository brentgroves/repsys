# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear to be better than your neighbor.  I say help your neighbor and especially help the ones that are struggling. Do not worry about your own status.  Do not promote yourself instead think of others and help them in their work.

Report System IT Admin, Hardware, or Software Topics of Interest

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

**Last meeting summary**,

Mach2 rebranded to Automation and Orchestration.
Brent H. discussed his understanding of Mach2 and Mobex Azure requirements.
Kevin talked about Plex IAM and discussed Mach2.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin something about Plex.
- Brad something about Fruitport casters or other machines if you want :-)
- Sam something about Mach2 or Kep ServerEx or Fruitport caster code if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent H. something about Azure tenant migration, or anything you want :-)
- Brent G. Report System API Gateway, Azure Bastion

## **[API Gateways](https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/)**

An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented.


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

### Resolving MAC Address from IP Address in Linux

There are at least 3 methods above to create a virtual network on a linux host but the Kubernetes load-balancer we use does not seem to use any of them.  So I'm thinking it attaches itself to the network driver like a network interfaces and uses the arp protocol to respond to IP to mac requests. And also assigns a random Mac address for itself to use.

If you just want to find out the MAC address of a given IP address you can use the command arp to look it up, once you've pinged the system 1 time.

```bash
# Find mac address of reports1 load-balancer ip
# ping from reports-alb
ping -c1 10.1.0.8 
PING 10.1.0.8 (10.1.0.8) 56(84) bytes of data.
From 10.1.0.112 icmp_seq=1 Destination Host Unreachable

--- 10.1.0.8 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
```

Now look up in the ARP table:

```bash
# Find mac address of reports1 load-balancer 
$ arp -a
reports13 (10.1.0.112) at 98:90:96:c3:f4:83 [ether] on enp0s25
? (10.1.0.32) at cc:70:ed:1b:4f:c0 [ether] on enp0s25
Super-PLT-7.BUSCHE-CNC.com (10.1.0.170) at 4c:91:7a:64:0f:ad [ether] on enp0s25
reports1.busche-cnc.com (10.1.0.8) at 98:90:96:c3:f4:83 [ether] on enp0s25
```
## Key Authentication

Authentication is the process of verifying that a requester has permissions to access a resource. API gateway authentication authenticates the flow of data to and from your upstream services.

Kong Gateway has a library of plugins that support the most widely used methods of API gateway **[authentication](https://docs.konghq.com/hub/#authentication)**.

Common authentication methods include:

- Key Authentication
- Basic Authentication
- OAuth 2.0 Authentication (Kong for free) <https://docs.konghq.com/hub/kong-inc/oauth2/>
- LDAP Authentication Advanced
- OpenID Connect

Test that the API is secure by sending a request using curl -i $PROXY_IP/echo. Observe that a HTTP 401 is returned with this message:

```bash
curl -i $PROXY_IP/echo
HTTP/1.1 401 Unauthorized
Date: Fri, 05 Jan 2024 17:48:36 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
WWW-Authenticate: Key realm="kong"
Content-Length: 96
X-Kong-Response-Latency: 1
Server: kong/3.5.0
X-Kong-Request-Id: 2e0dbd1ac29f85282b68067dc25f032e

{
  "message":"No API key found in request",
  "request_id":"2e0dbd1ac29f85282b68067dc25f032e"
}% 
```

## test http connection with API key

curl -H 'apikey: hello_world' $PROXY_IP/echo
Welcome, you are connected to node reports52.
Running on Pod echo-74c66b778-j2n45.
In namespace default.
With IP address 10.1.184.161.

## Rate limiting

## Test the rate-limiting plugin

To test the rate-limiting plugin, rapidly send six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -H 'apikey: hello_world' -sv $PROXY_IP/echo 2>&1 | grep "< HTTP"; done
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 429 Too Many Requests
```

This shows that the rate limiting plugin is preventing the request from reaching the upstream service.

## Test the proxy-cache plugin

To test the proxy-cache plugin, send another six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep -E "(Status|< HTTP)"; done
< HTTP/1.1 200 OK
< X-Cache-Status: Miss
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 429 Too Many Requests

```

The first request results in X-Cache-Status: Miss. This means that the request is sent to the upstream service. The next four responses return X-Cache-Status: Hit which indicates that the request was served from a cache.

The X-Cache-Status header can return the following cache results:

| STATE   | DESCRIPTION                                                                                                                                        |
|---------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| Miss    | The request could be satisfied in cache, but an entry for the resource was not found in cache, and the request was proxied upstream.               |
| Hit     | The request was satisfied and served from the cache.                                                                                               |
| Refresh | The resource was found in cache, but could not satisfy the request, due to Cache-Control behaviors or reaching its hard-coded cache_ttl threshold. |
| Bypass  | The request could not be satisfied from cache based on plugin configuration.                                                                       |

The final thing to note is that when a HTTP 429 request is returned by the rate-limit plugin, you do not see a X-Cache-Status header. This is because rate-limiting executes before proxy-cache. For more information, see **[plugin priority](https://docs.konghq.com/gateway/latest/plugin-development/custom-logic/#kong-plugins)**.

## service mesh vs. API gateway

Here are the key things to know about service mesh vs. API gateway:

- Service mesh acts as a centralized infrastructure layer for efficient microservices communication, simplifying tasks like service discovery and load balancing.
- API gateways, on the other hand, serves as the entry point for external clients to access microservices, managing functions like request routing and authentication.

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

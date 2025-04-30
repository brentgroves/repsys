# **[Linux Gateway using iptables](https://superuser.com/questions/1286555/iptables-port-forwarding-with-internal-snat#:~:text=1%20Answer,%2D%2Dto%2Dsource%20192.168.2.5)**

**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../../README.md)**

In networking, a **packet** is the basic unit of data transmitted over a network, typically at the network layer (Layer 3 of the OSI model). A **frame**, on the other hand, encapsulates a packet and other information for transmission across a specific network technology at the data link layer (Layer 2 of the OSI model). Think of **it like putting a letter (the packet) into an envelope (the frame)** for mailing.

![iptfc1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*OIoNQkH4RTSm-eY2lUMBcQ.jpeg)**

| Tables↓/Chains→               | PREROUTING | INPUT | FORWARD | OUTPUT | POSTROUTING |
|-------------------------------|------------|-------|---------|--------|-------------|
| (routing decision)            |            |       |         | ✓      |             |
| raw                           | ✓          |       |         | ✓      |             |
| (connection tracking enabled) | ✓          |       |         | ✓      |             |
| mangle                        | ✓          | ✓     | ✓       | ✓      | ✓           |
| nat (DNAT)                    | ✓          |       |         | ✓      |             |
| (routing decision)            | ✓          |       |         | ✓      |             |
| filter                        |            | ✓     | ✓       | ✓      |             |
| security                      |            | ✓     | ✓       | ✓      |             |
| nat (SNAT)                    |            | ✓     |         |        | ✓           |

- Incoming packets destined for the local system: PREROUTING -> INPUT
- Incoming packets destined to another host: PREROUTING -> FORWARD -> POSTROUTING
- Locally generated packets: OUTPUT -> POSTROUTING

![ipt](https://stuffphilwrites.com/wp-content/uploads/2024/05/FW-IDS-iptables-Flowchart-v2024-05-22-768x978.png)**

## **[Architecture](https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture)**

## **[summary](https://superuser.com/questions/1286555/iptables-port-forwarding-with-internal-snat#:~:text=1%20Answer,%2D%2Dto%2Dsource%20192.168.2.5)**

## rules

- allow forwarding *to* destination ip:port
- allow forwarding *from* destination ip:port
- nat packets identified by arrival at external IP / port to have
*destination* internal ip:port
- nat packets identified by arrival at internal IP / port to have
*source* internal network IP of gateway machine

```bash
# Gateway = 1.2.3.4/192.168.2.5, internal server = 192.168.2.10
iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

# allow inbound and outbound forwarding
# iptables -A FORWARD -p tcp -d 192.168.2.10 --dport 54321 -j ACCEPT
iptables -A FORWARD -p tcp -d 10.188.50.202 --dport 8080 -j ACCEPT
# iptables -A FORWARD -p tcp -s 192.168.2.10 --sport 54321 -j ACCEPT
iptables -A FORWARD -p tcp -s 10.188.50.202 --sport 8080 -j ACCEPT

iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A FORWARD -s 10.188.50.202/32 -p tcp -m tcp --sport 8080 -j ACCEPT
-A FORWARD -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j ACCEPT

# iptables -t nat -S
# route packets arriving at external IP/port to LAN machine
# iptables -A PREROUTING -t nat -p tcp -d 1.2.3.4 --dport 12345 -j DNAT --to-destination 192.168.2.10:54321
iptables -A PREROUTING -t nat -p tcp -d 10.187.40.123 --dport 8080 -j DNAT --to-destination 10.188.50.202:8080

# Gateway = 1.2.3.4/192.168.2.5, internal server = 192.168.2.10
# rewrite packets going to LAN machine (identified by address/port)
# to originate from gateway's internal address
# iptables -A POSTROUTING -t nat -p tcp -d 192.168.2.10 --dport 54321 -j SNAT --to-source 192.168.2.5
iptables -A POSTROUTING -t nat -p tcp -d 10.188.50.202 --dport 8080 -j SNAT --to-source 10.187.40.123

iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A PREROUTING -d 10.187.40.123/32 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
-A POSTROUTING -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j SNAT --to-source 10.187.40.123

```

## request and response flow

1. client requests 10.187.40.123:8080
2. gateway changes destination to 10.188.50.202:8080
3. gateway changes source from client to gateway's ip 10.187.40.123.
4. gateway keeps track of network request's original source IP for reversal of response.
5. Service host completes request and responds to the gateway's IP.
6. gateway recognizes the response as being from the client machine and changes the destination from the gateway's IP to the client's IP.

## Running a server with port-forwarding

So, with that set up, we should be able to run a server on 10.188.50.202:8080. Using this Python code in the file server.py

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello from Flask!\n'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
```

Start the server.

```bash
ssh brent@10.188.50.202
# namespace has no dns so add dependancies in default namespace
mkdir -p ~/src/python/veths_and_namespaces
cd ~/src/python/veths_and_namespaces
uv init
Initialized project `veths-and-namespaces-md`
uv add flask
uv add flask
Using CPython 3.13.3
Creating virtual environment at: .venv
⠇ veths-and-namespaces==0.1.0                                                                                                                                                           error: Failed to fetch: `https://pypi.org/simple/flask/`
  Caused by: Request failed after 3 retries
  Caused by: error sending request for url (https://pypi.org/simple/flask/)
  Caused by: operation timed out
uv run server.py
...then we run it:

From another terminal start tcpdump

```bash
sudo tcpdump -i enp0s25 'src 10.187.40.18 and dst 10.187.40.123'
```

Start the server.

```bash


## Configure NAT (Destination Network Address Translation)

Use the DNAT option to rewrite the destination IP and port of incoming packets.
Example:

```bash
# iptables -t nat -A PREROUTING -p tcp -i <incoming_interface> --dport <external_port> -j DNAT --to-destination <internal_IP>:<internal_port>
iptables -t nat -A PREROUTING -p tcp -i enp0s25 --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
```

Replace <incoming_interface> with the interface where external traffic enters (e.g., ppp0), <external_port> with the port to forward, <internal_IP> with the internal server's IP address, and <internal_port> with the port on the internal server.

```bash
iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A PREROUTING -i enp0s25 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
```

## Configure NAT (Source Network Address Translation)

<https://superuser.com/questions/1286555/iptables-port-forwarding-with-internal-snat#:~:text=1%20Answer,%2D%2Dto%2Dsource%20192.168.2.5>

If the internal server is behind a different IP, you'll need to rewrite the source IP of packets from the internal server back to the gateway's IP.
Example:

```bash
# iptables -t nat -A POSTROUTING -o <outgoing_interface> -s <internal_IP> --sport <internal_port> -j SNAT --to-source <gateway_IP>
iptables -t nat -A POSTROUTING -o enp0s25 -s 10.188.50.202 --sport 8080 -j SNAT --to-source 10.187.40.123

# route packets arriving at external IP/port to LAN machine
iptables -A PREROUTING -t nat -p tcp -d 1.2.3.4 --dport 12345 -j DNAT --to-destination 192.168.2.10:54321
# rewrite packets going to LAN machine (identified by address/port)
# to originate from gateway's internal address
iptables -A POSTROUTING -t nat -p tcp -d 192.168.2.10 --dport 54321 -j SNAT --to-source 192.168.2.5

```

Replace <outgoing_interface> with the interface where traffic leaves the gateway (e.g., eth0), <internal_IP> with the internal server's IP, <internal_port> with the port on the internal server, and <gateway_IP> with the gateway's IP address.

```bash

To set up a gateway using iptables, you'll need to enable IP forwarding, configure masquerading (for NAT), and create forwarding rules. You'll also need to configure the client devices to use the gateway.
Here's a breakdown of the process:

1. Enable IP Forwarding:
Open the /proc/sys/net/ipv4/ip_forward file and set it to 1: echo 1 > /proc/sys/net/ipv4/ip_forward.
To make this change persistent, add net.ipv4.ip_forward=1 to /etc/sysctl.conf.
2. Configure Masquerading (NAT):
Masquerading is used to rewrite the source address of outgoing packets, allowing the gateway to act as a translator.
Use the following command, where eth1 is the external interface:

```bash
# configure iptables
# iptables -t nat -A POSTROUTING -s 10.0.3.0/24 -d 10.2.0.2/32 -j MASQUERADE

iptables -t nat -A PREROUTING -s 10.187.40.18/31 -d 10.188.40.202/32 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.187.40.18/31 -d 10.188.40.202/32 -j MASQUERADE

```

3. Configure Forwarding Rules:
Allow traffic from the internal interface (e.g., eth0) to the external interface (e.g., eth1): iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT.
Allow returning traffic from the external interface to the internal interface: iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate RELATED, ESTABLISHED -j ACCEPT.
Drop all other traffic that shouldn't be forwarded: iptables -A FORWARD -j DROP.
4. Configure Client Devices:
Set the default gateway on the client devices to the IP address of the gateway server.
You can also use the ip route add default via <gateway_ip> dev <interface> command on Linux.
For Windows, you can configure the gateway IP address in the TCP/IPv4 settings

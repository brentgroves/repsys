# **[Mastering Istio Rate Limiting for Efficient Traffic Management](https://medium.com/@ishujeetpanjeta/mastering-istio-rate-limiting-for-efficient-traffic-management-ff5acbcde7b3)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## **[SYN flood attack](https://www.cloudflare.com/learning/ddos/syn-flood-ddos-attack/)**

A SYN flood exploits a vulnerability in the TCP/IP handshake in an attempt to disrupt a web service.

## What is a SYN flood attack?

A SYN flood (half-open attack) is a type of denial-of-service (DDoS) attack which aims to make a server unavailable to legitimate traffic by consuming all available server resources. By repeatedly sending initial connection request (SYN) packets, the attacker is able to overwhelm all available ports on a targeted server machine, causing the targeted device to respond to legitimate traffic sluggishly or not at all.

## How does a SYN flood attack work?

SYN flood attacks work by exploiting the handshake process of a TCP connection. Under normal conditions, TCP connection exhibits three distinct processes in order to make a connection.

- First, the client sends a SYN packet to the server in order to initiate the connection.
- The server then responds to that initial packet with a SYN/ACK packet, in order to acknowledge the communication.
- Finally, the client returns an ACK packet to acknowledge the receipt of the packet from the server. After completing this sequence of packet sending and receiving, the TCP connection is open and able to send and receive data.

![SYN](https://www.cloudflare.com/img/learning/ddos/syn-flood-ddos-attack/syn-flood-attack-ddos-attack-diagram-1.png)

To create **[denial-of-service](), an attacker exploits the fact that after an initial SYN packet has been received, the server will respond back with one or more SYN/ACK packets and wait for the final step in the handshake. Here’s how it works:

1. The attacker sends a high volume of SYN packets to the targeted server, often with spoofed IP addresses.
2. The server then responds to each one of the connection requests and leaves an open port ready to receive the response.
3. While the server waits for the final ACK packet, which never arrives, the attacker continues to send more SYN packets. The arrival of each new SYN packet causes the server to temporarily maintain a new open port connection for a certain length of time, and once all the available ports have been utilized the server is unable to function normally.

![dos](https://www.cloudflare.com/img/learning/ddos/syn-flood-ddos-attack/syn-flood-attack-ddos-attack-diagram-2.png)

In networking, when a server is leaving a connection open but the machine on the other side of the connection is not, the connection is considered half-open. In this type of DDoS attack, the targeted server is continuously leaving open connections and waiting for each connection to timeout before the ports become available again. The result is that this type of attack can be considered a “half-open attack”.

## **[Rate Limiting: Protecting Your Server 101](https://konghq.com/blog/engineering/kong-gateway-rate-limiting)**

Let's take a step back and go over the concept of rate limiting for those who aren't familiar.

Rate limiting is remarkably effective and ridiculously simple. It's also regularly forgotten. Rate limiting is a defensive measure you can use to prevent your server or application from being paralyzed. By restricting the number of similar requests that can hit your server within a window of time, you ensure your server won't be overwhelmed and debilitated.

You're not only guarding against malicious requests. Yes, you want to shut down a bot that's trying to discover login credentials with a brute force attack. You want to stop scrapers from slurping up your content. You want to safeguard your server from DDOS attacks.

But it's also vital to limit non-malicious requests. Sometimes, it's somebody else's buggy code that hits your API endpoint 10 times a second rather than one time every 10 minutes. Or, perhaps only your premium users get unlimited API requests, while your free-tier users only get a hundred requests an hour.

## Mastering Istio Rate Limiting for Efficient Traffic Management

Istio, the powerful open-source service mesh, offers a plethora of features to enhance microservices architecture. One crucial capability is rate limiting, which allows you to control and manage the traffic flowing through your services dynamically. In this article, we’ll delve into Istio’s rate limiting capabilities and guide you through the process of setting up both global and local rate limits.

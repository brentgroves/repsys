# **[What is Azure Relay?](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it#:~:text=Azure%20Relay%20is%20a%20service%20that%20allows,of%20the%20Relay%20features%20that%20existed%20earlier.)**

The Azure Relay service enables you to securely expose services that run in your corporate network to the public cloud. You can do so without opening a port on your firewall, or making intrusive changes to your corporate network infrastructure.

The relay service supports the following scenarios between on-premises services and applications running in the cloud or in another on-premises environment.

- Traditional one-way, request/response, and peer-to-peer communication
- Event distribution at internet-scope to enable publish/subscribe scenarios
- Bi-directional and unbuffered socket communication across network boundaries

Azure Relay differs from network-level integration technologies such as VPN. An Azure relay can be scoped to a single application endpoint on a single machine. The VPN technology is far more intrusive, as it relies on altering the network environment.

## Basic flow

In the relayed data transfer pattern, the basic steps involved are:

1. An on-premises service connects to the relay service through an outbound port.
2. It creates a bi-directional socket for communication tied to a particular address.
3. The client can then communicate with the on-premises service by sending traffic to the relay service targeting that address.
4. The relay service then relays data to the on-premises service through the bi-directional socket dedicated to the client. The client doesn't need a direct connection to the on-premises service. It doesn't need to know the location of the service. And, the on-premises service doesn't need any inbound ports open on the firewall.

Features
Azure Relay has two features:

Hybrid Connections - Uses the open standard web sockets enabling multi-platform scenarios.
WCF Relays - Uses Windows Communication Foundation (WCF) to enable remote procedure calls. WCF Relay is the legacy relay offering that many customers already use with their WCF programming models.

Understanding WebSockets with Socket.io | TO THE NEW BlogWebSockets are a communication protocol that allows for a full-duplex, persistent, two-way communication channel between a web browser and a server.

## Hybrid Connections

The Hybrid Connections feature in Azure Relay is a secure, and open-protocol evolution of the Relay features that existed earlier. You can use it on any platform and in any language. Hybrid Connections feature in Azure Relay is based on HTTP and WebSockets protocols. It allows you to send requests and receive responses over web sockets or HTTP(S). This feature is compatible with WebSocket API in common web browsers.

For details on the Hybrid Connection protocol, see Hybrid Connections protocol guide. You can use Hybrid Connections with any web sockets library for any runtime/language.

## Required Ports for the gateway to function

The gateway communicates on the following outbound ports: TCP 443, 433, 5671, 5672, and from 9350 through 9354. The gateway doesn't require inbound ports.

For guidance on how to set up your on-premises firewall and/or proxy using fully qualified domain names (FQDNs) instead of using IP addresses that are subject to change, follow the steps in **[Azure WCF Relay DNS Support](https://techcommunity.microsoft.com/t5/messaging-on-azure/azure-wcf-relay-dns-support/ba-p/370775)**.

Alternatively, you allow the IP addresses for your data region in your firewall. Use the JSON files listed below, which are updated weekly.

**Inbound traffic** originates from outside the network, while outbound traffic originates inside the network. Therefore, inbound firewall rules protect the network from unwanted incoming traffic from the internet or other networks -- in particular, disallowed connections, malware and DDoS attacks. Outbound firewall rules control outgoing traffic, that is, requests to resources outside of the network. For example, a connection request to an email service or the Informa TechTarget website might be allowed, but connection requests to unapproved or dangerous websites are stopped.

Public Cloud
US Gov
Germany
China

Or, you can get the list of required ports by performing the network ports test periodically in the gateway app.

The gateway communicates with Azure Relay by using FQDNs. If you force the gateway to communicate via HTTPS, it will strictly use FQDNs only and won't communicate by using IP addresses.

The following list describes FQDNs used by the gateway. These endpoints are required for the gateway to function.

| Public Cloud Domain names                                                                                  | Outbound ports    | Description                                                                                                                                                                                           |
|------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| *.download.microsoft.com                                                                                   | 443               | Used to download the installer. The gateway app also uses this domain to check the version and gateway region.                                                                                        |
| *.powerbi.com                                                                                              | 443               | Used to identify the relevant Power BI cluster.                                                                                                                                                       |
| *.analysis.windows.net                                                                                     | 443               | Used to identify the relevant Power BI cluster.                                                                                                                                                       |
| *.login.windows.net, login.live.com, aadcdn.msauth.net, login.microsoftonline.com,*.microsoftonline-p.com | 443               | Used to authenticate the gateway app for Microsoft Entra ID and OAuth2. Note that additional URLs could be required as part of the Microsoft Entra ID sign in process that can be unique to a tenant. |
| *.servicebus.windows.net                                                                                   | 5671-5672         | Used for Advanced Message Queuing Protocol (AMQP).                                                                                                                                                    |
| *.servicebus.windows.net                                                                                   | 443 and 9350-9354 | Listens on Azure Relay over TCP. Port 443 is required to get Azure Access Control tokens.                                                                                                             |
| *.msftncsi.com                                                                                             | 80                | Used to test internet connectivity if the Power BI service can't reach the gateway.                                                                                                                   |
| *.dc.services.visualstudio.com                                                                             | 443               | Used by AppInsights to collect telemetry.                                                                                                                                                             |
| ecs.office.com                                                                                             | 443               | Used for ECS configuration to enable Mashup features.                                                                                                                                                 |
| gatewayadminportal.azure.com                                                                               | 443               | Used for gateway management in the portal.                                                                                                                                                            |

# **[](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it)**

## What is Azure Relay?

12/17/2024
The Azure Relay service enables you to securely expose services that run in your corporate network to the public cloud. You can do so without opening a port on your firewall, or making intrusive changes to your corporate network infrastructure.

The relay service supports the following scenarios between on-premises services and applications running in the cloud or in another on-premises environment.

- Traditional one-way, request/response, and peer-to-peer communication
- Event distribution at internet-scope to enable publish/subscribe scenarios
- Bi-directional and unbuffered socket communication across network boundaries

Azure Relay differs from network-level integration technologies such as VPN. An Azure relay can be scoped to a single application endpoint on a single machine. The VPN technology is far more intrusive, as it relies on altering the network environment.

## Basic flow

In the relayed data transfer pattern, the basic steps involved are:

- An on-premises service connects to the relay service through an outbound port.
- It creates a bi-directional socket for communication tied to a particular address.
- The client can then communicate with the on-premises service by sending traffic to the relay service targeting that address.
- The relay service then relays data to the on-premises service through the bi-directional socket dedicated to the client. The client doesn't need a direct connection to the on-premises service. It doesn't need to know the location of the service. And, the on-premises service doesn't need any inbound ports open on the firewall.

## Features

Azure Relay has two features:

- Hybrid Connections - Uses the open standard web sockets enabling multi-platform scenarios.
- WCF Relays - Uses Windows Communication Foundation (WCF) to enable remote procedure calls. WCF Relay is the legacy relay offering that many customers already use with their WCF programming models.

##

Hybrid Connections
The Hybrid Connections feature in Azure Relay is a secure, and open-protocol evolution of the Relay features that existed earlier. You can use it on any platform and in any language. Hybrid Connections feature in Azure Relay is based on HTTP and WebSockets protocols. It allows you to send requests and receive responses over web sockets or HTTP(S). This feature is compatible with WebSocket API in common web browsers.

For details on the Hybrid Connection protocol, see Hybrid Connections protocol guide. You can use Hybrid Connections with any web sockets library for any runtime/language.

 Note

Hybrid Connections of Azure Relay replaces the old Hybrid Connections feature of BizTalk Services. The Hybrid Connections feature in BizTalk Services was built on the Azure Service Bus WCF Relay. The Hybrid Connections capability in Azure Relay complements the pre-existing WCF Relay feature. These two service capabilities (WCF Relay and Hybrid Connections) exist side-by-side in the Azure Relay service. They share a common gateway, but are otherwise different implementations.

To get started with using Hybrid Connections in Azure Relay, see the following quick starts:

Hybrid Connections - .NET WebSockets
Hybrid Connections - Node WebSockets
Hybrid Connections - .NET HTTP
Hybrid Connections - Node HTTP
Hybrid Connections - Java HTTP
For more samples, see Azure Relay - Hybrid Connections samples on GitHub.

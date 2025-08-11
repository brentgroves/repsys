# **[Architecture: Processing of incoming relay requests](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it#architecture-processing-of-incoming-relay-requests)**

The following diagram shows you how incoming relay requests are handled by the Azure Relay service when both sending and receiving clients are outside a corporate network.

![i1](https://learn.microsoft.com/en-us/azure/azure-relay/media/relay-what-is-it/process-flow.svg)

- Listening client sends a listening request to the Azure Relay service. The Azure load balancer routes the request to one of the gateway nodes.
- The Azure Relay service creates a relay in the gateway store.
- Sending client sends a request to connect to the listening service.
- The gateway that receives the request looks up for the relay in the gateway store.
- The gateway forwards the connection request to the right gateway mentioned in the gateway store.
- The gateway sends a request to the listening client for it to create a temporary channel to the gateway node that's closest to the sending client.
- The listening client creates a temporary channel to the gateway that's closest to the sending client. Now that the connection is established between clients via a gateway, the clients can exchange messages with each other.
- The gateway forwards any messages from the listening client to the sending client.
- The gateway forwards any messages from the sending client to the listening client.

## Next steps

Follow one or more of the following quick starts, or see Azure Relay samples on GitHub.

Hybrid Connections
Hybrid Connections - .NET WebSockets
Hybrid Connections - Node WebSockets
Hybrid Connections - .NET HTTP
Hybrid Connections - Node HTTP

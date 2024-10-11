# **[Core concepts, architecture and lifecycle](https://grpc.io/docs/what-is-grpc/core-concepts/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

An introduction to key gRPC concepts, with an overview of gRPC architecture and RPC life cycle.

Not familiar with gRPC? First read **[Introduction to gRPC](https://grpc.io/docs/what-is-grpc/introduction/)**. For language-specific details, see the quick start, tutorial, and reference documentation for your language of choice.

## does grpc listen for http requests

Yes, gRPC uses HTTP/2 for transport and can listen for HTTP requests:
gRPC uses HTTP/2: gRPC APIs always use HTTP/2, which is a common web protocol that supports long-lived, real-time communication streams. gRPC takes advantage of HTTP/2's advanced features, such as binary format encapsulation, multiplexing, and PING-based keepalives.
gRPC can use HTTP/1.1: gRPC can also use HTTP/1.1 through the application/grpc-web wire format.
gRPC can listen for HTTP requests on the same port: You can use a third-party framework like cmux to multiplex connections based on their payload and run both gRPC and HTTP servers on the same TCP port.

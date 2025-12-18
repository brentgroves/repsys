# **[gRPC Web Basics](https://grpc.io/docs/platforms/web/basics/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Basics tutorial

A basic tutorial introduction to gRPC-web.

This tutorial provides a basic introduction on how to use gRPC-Web from browsers.

By walking through this example you’ll learn how to:

- Define a service in a .proto file.
- Generate client code using the protocol buffer compiler.
- Use the gRPC-Web API to write a simple client for your service.

It assumes a passing familiarity with **[protocol buffers](https://protobuf.dev/overview)**.

## Why use gRPC and gRPC-Web?

With gRPC you can define your service once in a .proto file and implement clients and servers in any of gRPC’s supported languages, which in turn can be run in environments ranging from servers inside a large data center to your own tablet - all the complexity of communication between different languages and environments is handled for you by gRPC. You also get all the advantages of working with protocol buffers, including efficient serialization, a simple IDL, and easy interface updating. gRPC-Web lets you access gRPC services built in this manner from browsers using an idiomatic API.

## Define the Service

The first step when creating a gRPC service is to define the service methods and their request and response message types using protocol buffers. In this example, we define our EchoService in a file called echo.proto. For more information about protocol buffers and proto3 syntax, please see the **[protobuf documentation](https://protobuf.dev/)**.

```protobuf
message EchoRequest {
  string message = 1;
}

message EchoResponse {
  string message = 1;
}

service EchoService {
  rpc Echo(EchoRequest) returns (EchoResponse);
}
```

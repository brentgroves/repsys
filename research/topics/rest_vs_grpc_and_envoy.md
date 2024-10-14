# **[Rest vs gRPC and Envoy](https://nordicapis.com/7-api-testing-tools-that-support-grpc/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## references

- **[gRPC routing](https://gateway-api.sigs.k8s.io/guides/grpc-routing/)**

Istio supports proxying any TCP traffic. This includes HTTP, HTTPS, gRPC, as well as raw TCP protocols. In order to provide additional capabilities, such as routing and rich metrics, the protocol must be determined. This can be done automatically or explicitly specified.

- **[Istio](https://istio.io/latest/blog/2021/proxyless-grpc/)**

- **[gRPC on K8s with Istio](https://itnext.io/effectively-communicate-between-microservices-k8s-and-istio-proxy-edition-1fd33561d67a)**

Istio Envoy sidecar helps gRPC client to use all instances of the gRPC server effectively.

- **[gRPC docker and k8s example](https://github.com/adavarski/gRPC-go-k8s-example)**

- **[gRPC](../../volumes/go/tutorials/grpc/go-grpc-react-example/go_grpc_server_with_envoy.md)**

- **[gRPC](https://medium.com/teads-engineering/dynamic-cache-replication-using-grpc-streaming-629adfbbcb32)**

## **[gRPC vs REST](<https://www.imaginarycloud.com/blog/grpc-vs-rest>**

## summary

gRPC gives you HTTP 2 feature support such as streaming and an IDL language enabling you to generate client code in any language using the protoc compiler. Would like to try gRPC for it's client generation ability and HTTP2 streaming support.

### HTTP 1.1 vs HTTP 2

REST APIs follow a request-response model of communication that is typically built on HTTP 1.1. Unfortunately, this implies that if a microservice receives multiple requests from multiple clients, the model has to handle each request at a time, which consequently slows the entire system. However, REST APIs can also be built on HTTP 2, but the request-response model of communication remains the same, which forbids REST APIs to make the most out of the HTTP 2 advantages, such as streaming communication and bidirectional support.

gRPC does not face a similar obstacle. It is built on HTTP 2 and instead follows a client-response communication model. These conditions support bidirectional communication and streaming communication due to gRPC's ability to receive multiple requests from several clients and handle those requests simultaneously by constantly streaming information. Plus, gRPC can also handle "unary" interactions like the ones built on HTTP 1.1.

‍In sum, gRPC is able to handle unary interactions and different types of streaming:

- **Unary:** when the client sends a single request and receives a single response.
‍
- **Server-streaming:** when the server responds with a stream of messages to a client's request. Once all the data is sent, the server additionally delivers a status message to complete the process.
‍
- **Client-streaming:** when the client sends a stream of messages and in turn receives a single response message from the server.
‍
- **Bidirectional-streaming:** the two streams (client and server) are independent, meaning that they both can transmit messages in any order. The client is the one who initiates and ends the bidirectional streaming.

## Browser Support

This aspect is probably one of the main REST API advantages over gRPC. On the one hand, REST is fully supported by all browsers. On the other hand, gRPC is still quite limited when it comes to browser support. Unfortunately, it requires gRPC-web and a proxy layer to perform conversions between HTTP 1.1 and HTTP 2. Therefore, gRPC ends up being mainly used for internal/private systems (API programs within a particular organisation’s backend data and application functionality).

![envoy](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*mAkZWyRD9gKyBEOaqEFm-A.png)

## Payload Data Structure

As previously mentioned, gRPC uses Protocol Buffer by default to serialize payload data. This solution is lighter since it enables a highly compressed format and reduces the messages' size. Further, Protobuf (or Protocol Buffer) is binary; thus, it serializes and deserializes structured data in order to communicate and transmit it. In other words, the strongly typed messages can be automatically converted from Protobuf to the client and server's programming language.

‍In contrast, REST mainly relies on JSON or XML formats to send and receive data. In fact, even though it does not mandate any structure, JSON is the most popular format due to its flexibility and ability to send dynamic data without necessarily following a strict structure.  Another significant benefit of using JSON is its human-readability level, which Protobuf cannot compete with yet.

Nonetheless, JSON is not as light-weight or fast when it comes to data transmission. The reason for that lies in the fact that when using REST, JSON (or other formats) must be serialised and turned into the programming language used on both the client and server sides. This adds an extra step to the process of transmitting data which can consequently damage performance and open a possibility for errors.

## Code Generation Features

Unlike gRPC, REST API does not provide in-built code generation features, meaning that developers must use a third-party tool like Swagger or Postman to produce code for API requests.

In contrast, gRPC has native code generation features due to its protoc compiler, which is compatible with several programming languages. This is particularly beneficial for microservices systems that integrate various services developed in different languages and platforms. All in all, the built-in code generator also facilitates creating SDK (Software Development Kit).

## Envoy Proxy's versatility and feature set make it suitable for a wide range of use cases in modern application architectures

- **Microservices Communication:** Envoy can be deployed as a sidecar proxy alongside each service instance, handling inter-service communication securely and efficiently. It provides features like service discovery, load balancing, and fault tolerance, making it easier to manage the complex communication patterns in microservices architectures.
- **API Gateway:** Envoy can act as an API gateway, a single entry point for external clients to access multiple backend services. It can handle tasks such as request routing, authentication, rate limiting, and protocol translation, simplifying the management of public-facing APIs.
- **Ingress and Egress Control:** Envoy can be used as an ingress proxy, controlling and securing traffic entering a cluster from external sources. It can also serve as an egress proxy, managing and monitoring traffic, leaving the cluster to external services, enabling fine-grained control over outbound requests.
- **Canary Releases and Traffic Splitting:** Envoy's traffic management capabilities allow for the controlled rollout of new service versions through canary releases. It can also split traffic between different service versions, enabling gradual rollouts and reducing the risk of deployments.
- **Security and Access Control:** Envoy can enforce security policies at the network level, such as authentication and authorization. It supports features like TLS encryption, JSON Web Token (JWT) validation, and role-based access control (RBAC), enhancing the security of inter-service communication.
- **Hybrid and Multi-Cloud Deployments:** Envoy's platform-agnostic nature makes it suitable for hybrid and multi-cloud deployments. It can bridge services across different cloud providers or between on-premises and cloud environments, facilitating seamless communication and migration strategies.

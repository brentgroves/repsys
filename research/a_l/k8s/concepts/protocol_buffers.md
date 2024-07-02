# **[Protocol buffers](https://en.wikipedia.org/wiki/Protocol_Buffers)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Protocol buffers are Google’s language-neutral, platform-neutral, extensible mechanism for serializing structured data. Just like xml but smaller in size. It is useful in developing programs to communicate with each other over a wire or for storing data. The method involves an **[interface description language](https://en.wikipedia.org/wiki/Interface_description_language)** that describes the structure of some data and a program that generates source code from that description for generating or parsing a stream of bytes that represents the structured data.

Google developed Protocol Buffers for internal use and provided a code generator for multiple languages under an open-source license.

The design goals for Protocol Buffers emphasized simplicity and performance. In particular, it was designed to be smaller and faster than XML.[3]

Protocol Buffers is widely used at Google for storing and interchanging all kinds of structured information. The method serves as a basis for a custom remote procedure call (RPC) system that is used for nearly all inter-machine communication at Google.[4]

Protocol Buffers is similar to the Apache Thrift, Ion, and Microsoft Bond protocols, offering a concrete RPC protocol stack to use for defined services called gRPC.[5]

**[gRPC](https://en.wikipedia.org/wiki/GRPC)** (gRPC Remote Procedure Calls[2]) is a cross-platform open source high performance remote procedure call (RPC) framework. gRPC was initially created by Google, which used a single general-purpose RPC infrastructure called Stubby to connect the large number of microservices running within and across its data centers from about 2001.[3] In March 2015, Google decided to build the next version of Stubby and make it open source. The result was gRPC, which is now used in many organizations aside from Google for use cases from microservices to the "last mile" of computing (mobile, web, and Internet of Things). It uses HTTP/2 for transport, Protocol Buffers as the interface description language, and provides features such as authentication, bidirectional streaming and flow control, blocking or nonblocking bindings, and cancellation and timeouts. It generates cross-platform client and server bindings for many languages. Most common usage scenarios include connecting services in a microservices style architecture, or connecting mobile device clients to backend services.[4]

gRPC's use of HTTP/2 has been considered complex. It makes it impossible to implement a gRPC client in the browser, instead requiring a proxy.[5]

Data structure schemas (called messages) and services are described in a proto definition file (.proto) and compiled with protoc. This compilation generates code that can be invoked by a sender or recipient of these data structures. For example, example.pb.cc and example.pb.h are generated from example.proto. They define C++ classes for each message and service in example.proto.

Canonically, messages are serialized into a binary wire format which is compact, forward- and backward-compatible, but not self-describing (that is, there is no way to tell the names, meaning, or full datatypes of fields without an external specification). There is no defined way to include or refer to such an external specification (schema) within a Protocol Buffers file. The officially supported implementation includes an ASCII serialization format,[6] but this format—though self-describing—loses the forward- and backward-compatibility behavior, and is thus not a good choice for applications other than human editing and debugging.[7]

Though the primary purpose of Protocol Buffers is to facilitate network communication, its simplicity and speed make Protocol Buffers an alternative to data-centric C++ classes and structs, especially where interoperability with other languages or systems might be needed in the future.

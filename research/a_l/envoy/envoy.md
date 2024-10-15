# **[What is Envoy](https://www.envoyproxy.io/docs/envoy/latest/intro/what_is_envoy)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Envoy is an L7 proxy and communication bus designed for large modern service oriented architectures. The project was born out of the belief that:

The network should be transparent to applications. When network and application problems do occur it should be easy to determine the source of the problem.

In practice, achieving the previously stated goal is incredibly difficult. Envoy attempts to do so by providing the following high level features:

**Out of process architecture:** Envoy is a self contained process that is designed to run alongside every application server. All of the Envoys form a transparent communication mesh in which each application sends and receives messages to and from localhost and is unaware of the network topology. The out of process architecture has two substantial benefits over the traditional library approach to service to service communication:

- Envoy works with any application language. A single Envoy deployment can form a mesh between Java, C++, Go, PHP, Python, etc. It is becoming increasingly common for service oriented architectures to use multiple application frameworks and languages. Envoy transparently bridges the gap.

- As anyone that has worked with a large service oriented architecture knows, deploying library upgrades can be incredibly painful. Envoy can be deployed and upgraded quickly across an entire infrastructure transparently.

- **L3/L4 filter architecture:** At its core, Envoy is an L3/L4 network proxy. A pluggable filter chain mechanism allows filters to be written to perform different TCP/UDP proxy tasks and inserted into the main server. Filters have already been written to support various tasks such as raw TCP proxy, UDP proxy, HTTP proxy, TLS client certificate authentication, Redis, MongoDB, Postgres, etc.

- **HTTP L7 filter architecture:** HTTP is such a critical component of modern application architectures that Envoy supports an additional HTTP L7 filter layer. HTTP filters can be plugged into the HTTP connection management subsystem that perform different tasks such as buffering, rate limiting, routing/forwarding, sniffing Amazon’s DynamoDB, etc.

- **First class HTTP/2 support:** When operating in HTTP mode, Envoy supports both HTTP/1.1 and HTTP/2. Envoy can operate as a transparent **HTTP/1.1 to HTTP/2** proxy in both directions. This means that any combination of HTTP/1.1 and HTTP/2 clients and target servers can be bridged. The recommended service to service configuration uses HTTP/2 between all Envoys to create a mesh of persistent connections that requests and responses can be multiplexed over.

- **HTTP/3 support (currently in alpha):** As of 1.19.0, Envoy now supports HTTP/3 upstream and downstream, and translating between any combination of HTTP/1.1, HTTP/2 and HTTP/3 in either direction.

- **HTTP L7 routing:** When operating in HTTP mode, Envoy supports a routing subsystem that is capable of routing and redirecting requests based on path, authority, content type, runtime values, etc. This functionality is most useful when using Envoy as a front/edge proxy but is also leveraged when building a service to service mesh.

- **gRPC support:** gRPC is an RPC framework from Google that uses HTTP/2 or above as the underlying multiplexed transport. Envoy supports all of the HTTP/2 features required to be used as the routing and load balancing substrate for gRPC requests and responses. The two systems are very complementary.

- **Service discovery and dynamic configuration:** Envoy optionally consumes a layered set of dynamic configuration APIs for centralized management. The layers provide an Envoy with dynamic updates about: hosts within a backend cluster, the backend clusters themselves, HTTP routing, listening sockets, and cryptographic material. For a simpler deployment, backend host discovery can be done through DNS resolution (or even skipped entirely), with the further layers replaced by static config files.

- **Health checking:** The recommended way of building an Envoy mesh is to treat service discovery as an eventually consistent process. Envoy includes a health checking subsystem which can optionally perform active health checking of upstream service clusters. Envoy then uses the union of service discovery and health checking information to determine healthy load balancing targets. Envoy also supports passive health checking via an outlier detection subsystem.

- **Advanced load balancing:** Load balancing among different components in a distributed system is a complex problem. Because Envoy is a self contained proxy instead of a library, it is able to implement advanced load balancing techniques in a single place and have them be accessible to any application. Currently Envoy includes support for **automatic retries**, **circuit breaking**, **global rate limiting** via an external rate limiting service, **request shadowing**, and **outlier detection**. Future support is planned for **request racing**.

**Front/edge proxy support:** There is substantial benefit in using the same software at the edge (observability, management, identical service discovery and load balancing algorithms, etc.). Envoy has a feature set that makes it well suited as an edge proxy for most modern web application use cases. This includes **TLS termination**, **HTTP/1.1 HTTP/2 and HTTP/3 support**, as well as **HTTP L7 routing**.

**Best in class observability:** As stated above, **the primary goal of Envoy is to make the network transparent**. However, problems occur both at the network level and at the application level. Envoy includes robust statistics support for all subsystems. statsd (and compatible providers) is the currently supported statistics sink, though plugging in a different one would not be difficult. Statistics are also viewable via the administration port. Envoy also supports distributed tracing via thirdparty providers.

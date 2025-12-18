# **[How Do I Choose? API Gateway vs. Ingress Controller vs. Service Mesh](https://www.f5.com/company/blog/nginx/how-do-i-choose-api-gateway-vs-ingress-controller-vs-service-mesh)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

https://thenewstack.io/api-gateway-ingress-controller-or-service-mesh-when-to-use-what-and-why/

https://www.linkedin.com/pulse/comparison-api-gateway-kubernetes-ingress-service-mesh-mahadevan

## **[Security](https://www.linkedin.com/pulse/comparison-api-gateway-kubernetes-ingress-service-mesh-mahadevan)**

An API Gateway provides security features, such as authentication, authorization, encryption, and SSL termination, to your microservices. An API Gateway can integrate with various authentication and authorization mechanisms, such as OAuth, JWT, and LDAP, to verify the identity of the clients and enforce access control policies. An API Gateway also enables you to encrypt sensitive data in transit, such as credit card numbers or personal information, using SSL or TLS encryption.

Kubernetes Ingress provides basic security features, such as SSL termination, to your services. Kubernetes Ingress supports SSL termination at the ingress controller, allowing you to secure the communication between clients and the ingress controller using SSL or TLS encryption. Kubernetes Ingress does not provide advanced security features, such as authentication and authorization, so you need to use other components, such as Kubernetes RBAC or network policies, to enforce access control policies.

Service Mesh provides security features, such as mTLS encryption, to your microservices. Service Mesh enables you to encrypt communication between service instances using mTLS encryption, which provides mutual authentication and confidentiality between the service instances. Service Mesh also provides fine-grained security policies, such as certificate validation and peer identity verification, to secure communication within the mesh. Service Mesh does not provide advanced security features, such as authentication and authorization, so you need to use other components, such as Kubernetes RBAC or network policies, to enforce access control policies.

An API Gateway is a dedicated server that acts as the single entry point for all incoming requests from clients to your microservices. The purpose of an API Gateway is to provide a centralized entry point for clients to access your microservices, abstracting the underlying microservices from the clients and protecting them from the clients' direct requests.

The primary function of the API gateway is to always route inbound requests to the correct down-stream services, optionally perform protocol translation (i.e., translation between web protocols, such as HTTP and WebSocket, and web-unfriendly protocols that are used internally, such as AMQP and Thrift binary RPC) and sometimes compose requests. In some rare instances, they are used as part of a Backend for Frontend (BFF), thus enabling support for clients with different form factors (e.g., browser, mobile device). All requests from clients first go through the API gateway, which then routes requests to the appropriate microservice. The API gateway will often handle a request by invoking multiple microservices and aggregating the results.

Kubernetes Ingress is a collection of rules that allow inbound connections to reach the cluster services. The purpose of Kubernetes Ingress is to provide a way to route traffic from the internet to your services running in a Kubernetes cluster, so you can expose your services to the outside world.

A Service Mesh is a configurable infrastructure layer for microservices application that makes communication between service instances flexible, reliable, and fast. The purpose of a Service Mesh is to **provide advanced traffic management features**, such as load balancing, service discovery, request routing, rate limiting, and failure recovery, to your microservices, enabling you to handle the growing complexity of microservices communication and improve the reliability and performance of your microservices.


## **[NGINX Gate Fabric](https://blog.nginx.org/blog/5-things-to-know-about-nginx-gateway-fabric)**


How Is NGINX Gateway Fabric Different from NGINX Ingress Controller?
F5 NGINX Ingress Controller implements the **Ingress API** specification to deliver core functionality, using custom annotations, CRDs, and NGINX Ingress resources for expanded capabilities. NGINX Gateway Fabric conforms to the Gateway API specification, simplifies implementation, and aligns better with the organizational roles that deal with service networking configurations.

The following table compares the key high‑level features of the standard Ingress API, NGINX Ingress Controller with CRDs, and Gateway API to illustrate their capabilities.

| Feature                              | Standard Ingress API | NGINX Ingress Controller with CRDs | Gateway API   |
|--------------------------------------|----------------------|------------------------------------|---------------|
| API specification                    | Ingress API          | Ingress API + CRDs                 | Gateway API   |
| Multi-user management                | ❌                    | ✅                                  | ✅             |
| Layer 7 protocols (HTTP/HTTPS, gRPC) | ✅                    | ✅                                  | ✅             |
| Layer 7 load balancing               | ✅                    | ✅                                  | Custom policy |
| Request routing                      | ✅                    | ✅                                  | ✅             |
| Request header manipulation          | Limited              | ✅                                  | ✅             |
| Response header manipulation         | Limited              | ✅                                  | ✅             |
| Layer 4 protocols (TLS, TCP, UDP)    | ❌                    | ✅                                  | ✅             |
| Layer 4 load balancing               | ❌                    | ✅                                  | Custom policy |
| Allow/deny lists                     | ❌                    | ✅                                  | Custom policy |
| Certificate validation               | ❌                    | ✅                                  | Custom policy |
| Authentication (OIDC)                | ❌                    | ✅                                  | Custom policy |
| Rate limiting                        | ❌                    | ✅                                  | Custom policy |

In just about every webinar about Ingress controllers and service meshes that we’ve delivered over the course of 2021, we’ve heard some variation of the questions “How is this tool different from an API gateway?” or “Do I need both an API gateway and an Ingress controller (or service mesh) in Kubernetes?”

The confusion is totally understandable for two reasons:

- Ingress controllers and service meshes can fulfill many API gateway use cases.
- Some vendors position their API gateway tool as an alternative to using an Ingress controller or service mesh – or they roll all three capabilities into one tool.

In this blog we tackle how these tools differ and which to use for Kubernetes‑specific API gateway use cases. For a deeper dive, including demos, watch the webinar API Gateway Use Cases for Kubernetes.

## Definitions

At their cores, API gateways, Ingress controllers, and service meshes are each a type of proxy, designed to get traffic into and around your environments.

**[proxy server](./proxy_servers.md)**

## What Is an API Gateway?

An API gateway routes API requests from a client to the appropriate services. But a big misunderstanding about this simple definition is the idea that an API gateway is a unique piece of technology. It’s not. Rather, “API gateway” describes a set of use cases that can be implemented via different types of proxies – most commonly an ADC or load balancer and reverse proxy, and increasingly an Ingress controller or service mesh.

There isn’t a lot of agreement in the industry about what capabilities are “must haves” for a tool to serve as an API gateway. We typically see customers requiring the following abilities (grouped by use case):




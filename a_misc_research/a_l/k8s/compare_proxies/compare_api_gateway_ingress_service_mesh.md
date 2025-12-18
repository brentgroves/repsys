# **[Comparison : API Gateway, Kubernetes Ingress and Service Mesh](https://www.linkedin.com/pulse/comparison-api-gateway-kubernetes-ingress-service-mesh-mahadevan/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Summary

This article does not talk about k8s API gateway specifically.

The comparison between API Gateway, Kubernetes Ingress, and Service Mesh.

This is only a high level comparison of the 'published' features and not from a personal practical experience of using all of them, well some hotch-botch use with all of them though.

## Introduction

An API Gateway is a dedicated server that acts as the single entry point for all incoming requests from clients to your microservices. The purpose of an API Gateway is to provide a centralized entry point for clients to access your microservices, abstracting the underlying microservices from the clients and protecting them from the clients' direct requests.

The primary function of the API gateway is to always route inbound requests to the correct down-stream services, optionally perform protocol translation (i.e., translation between web protocols, such as HTTP and WebSocket, and web-unfriendly protocols that are used internally, such as AMQP and Thrift binary RPC) and sometimes compose requests. In some rare instances, they are used as part of a Backend for Frontend (BFF), thus enabling support for clients with different form factors (e.g., browser, mobile device). All requests from clients first go through the API gateway, which then routes requests to the appropriate microservice. The API gateway will often handle a request by invoking multiple microservices and aggregating the results.

**Kubernetes Ingress** is a collection of rules that allow inbound connections to reach the cluster services. The purpose of Kubernetes Ingress is to provide a way to route traffic from the internet to your services running in a Kubernetes cluster, so you can expose your services to the outside world.

A **Service Mesh** is a configurable infrastructure layer for microservices application that makes communication between service instances flexible, reliable, and fast. The purpose of a Service Mesh is to provide advanced traffic management features, such as load balancing, service discovery, request routing, rate limiting, and failure recovery, to your microservices, enabling you to handle the growing complexity of microservices communication and improve the reliability and performance of your microservices.

## Scalability

An API Gateway is typically horizontally scalable, which means you can add more instances of the API Gateway to handle increasing traffic. You can also load balance incoming requests across multiple API Gateway instances. The scalability of an API Gateway depends on the specific implementation, but it usually provides a centralized entry point to manage access to microservices.

Kubernetes Ingress can be horizontally scalable by adding more ingress controllers, which are the components responsible for routing incoming requests to the services. The scalability of Kubernetes Ingress depends on the specific ingress controller implementation, but it provides a way to route traffic within a cluster.

Service Mesh is horizontally scalable by adding more proxies, which are the components responsible for forwarding requests between service instances. The scalability of a Service Mesh depends on the specific implementation, but it provides a highly scalable and flexible way to manage traffic within microservices. Service Mesh also enables you to control the traffic flow between services, allowing you to implement sophisticated traffic management strategies. Most of my friends think of either Istio and or Linkerd (and some, those people are in SRE field, with raised eyebrows for operational trouble).

**Site reliability engineering (SRE)** is a set of principles and practices that applies aspects of software engineering to IT infrastructure and operations.

## Routing

An **API Gateway** provides URL-based routing for incoming requests and transforms requests for compatibility with microservices. You can configure the API Gateway to route incoming requests to different microservices based on the URL path, query parameters, headers, or payload of the requests. An API Gateway also enables you to apply various request transformations, such as header manipulation, request data mapping, and payload compression, to incoming requests.

**Kubernetes Ingress** provides path-based routing within a cluster, using ingress rules to control traffic. You can configure the ingress rules to route incoming requests to different services based on the URL path of the requests. Kubernetes Ingress does not provide request transformation capabilities, so you need to use other components, such as ConfigMap or annotation, to manipulate the incoming requests.

**Service Mesh** provides advanced routing capabilities, such as load balancing, traffic shaping, and circuit breaking, to your microservices. Service Mesh enables you to control the traffic flow between services, allowing you to implement sophisticated traffic management strategies, such as canary releases, blue-green deployments, and A/B testing. Service Mesh also enables you to enforce policies, such as rate limiting and circuit breaking, to protect your services from overloading or failure.

## Security

An **API Gateway** provides security features, such as authentication, authorization, encryption, and SSL termination, to your microservices. An API Gateway can integrate with various authentication and authorization mechanisms, such as OAuth, JWT, and LDAP, to verify the identity of the clients and enforce access control policies. An API Gateway also enables you to encrypt sensitive data in transit, such as credit card numbers or personal information, using SSL or TLS encryption.

Kubernetes Ingress provides basic security features, such as SSL termination, to your services. Kubernetes Ingress supports SSL termination at the ingress controller, allowing you to secure the communication between clients and the ingress controller using SSL or TLS encryption. Kubernetes Ingress does not provide advanced security features, such as authentication and authorization, so you need to use other components, such as Kubernetes RBAC or network policies, to enforce access control policies.

Service Mesh provides security features, such as mTLS encryption, to your microservices. Service Mesh enables you to encrypt communication between service instances using mTLS encryption, which provides mutual authentication and confidentiality between the service instances. Service Mesh also provides fine-grained security policies, such as certificate validation and peer identity verification, to secure communication within the mesh. Service Mesh does not provide advanced security features, such as authentication and authorization, so you need to use other components, such as Kubernetes RBAC or network policies, to enforce access control policies.

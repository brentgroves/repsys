# **[What is Istio?](https://istio.io/latest/docs/overview/what-is-istio/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – with few or no service code changes. It gives you:

- Secure service-to-service communication in a cluster with mutual TLS encryption, strong identity-based authentication and authorization
- Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic
- Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection
- A pluggable policy layer and configuration API supporting access controls, rate limits and quotas
- Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress

Istio is designed for extensibility and can handle a diverse range of deployment needs. Istio’s control plane runs on Kubernetes, and you can add applications deployed in that cluster to your mesh, extend the mesh to other clusters, or even connect VMs or other endpoints running outside of Kubernetes.

A large ecosystem of contributors, partners, integrations, and distributors extend and leverage Istio for a wide variety of scenarios. You can install Istio yourself, or a large number of vendors have products that integrate Istio and manage it for you.

## How it works

Istio uses a proxy to intercept all your network traffic, allowing a broad set of application-aware features based on configuration you set.

The control plane takes your desired configuration, and its view of the services, and dynamically programs the proxy servers, updating them as the rules or the environment changes.

The data plane is the communication between services. Without a service mesh, the network doesn’t understand the traffic being sent over, and can’t make any decisions based on what type of traffic it is, or who it is from or to.

Istio supports two data plane modes:

- sidecar mode, which deploys an Envoy proxy along with each pod that you start in your cluster, or running alongside services running on VMs.
- ambient mode, which uses a per-node Layer 4 proxy, and optionally a per-namespace Envoy proxy for Layer 7 features.

## Why choose Istio?

Istio pioneered the concept of a sidecar-based service mesh when it launched in 2017. Out of the gate, the project included the features that would come to define a service mesh, including standards-based mutual TLS for zero-trust networking, smart traffic routing, and observability through metrics, logs and tracing.

Since then, the project has driven advances in the mesh space including multi-cluster & multi-network topologies, extensibility via WebAssembly, the development of the Kubernetes Gateway API, and moving the mesh infrastructure away from application developers with ambient mode.

Here are a few reasons we think you should use Istio as your service mesh.

## Simple and powerful
Kubernetes has hundreds of features and dozens of APIs, but you can get started with it with just one command. We’ve built Istio to be the same way. Progressive disclosure means you can use a small set of APIs, and only turn the more powerful knobs if you have the need. Other “simple” service meshes spent years catching up to the feature set Istio had on day 1.

It is better to have a feature and not need it, than to need it and not have it!

## The Envoy proxy
From the beginning, Istio has been powered by the Envoy proxy, a high performance service proxy initially built by Lyft. Istio was the first project to adopt Envoy, and the Istio team were the first external committers. Envoy would go on to become the load balancer that powers Google Cloud as well as the proxy for almost every other service mesh platform.

Istio inherits all the power and flexibility of Envoy, including world-class extensibility using WebAssembly that was developed in Envoy by the Istio team.

## Community
Istio is a true community project. In 2023, there were 10 companies who made over 1,000 contributions each to Istio, with no single company exceeding 25%. (See the numbers here).

No other service mesh project has the breadth of support from the industry as Istio.

## Packages

We make stable binary releases available to everyone, with every release, and commit to continue doing so. We publish free and regular security patches for our latest release and a number of prior releases. Many of our vendors will support older versions, but we believe that engaging a vendor should not be a requirement to be safe in a stable open source project.

## Alternatives considered

A good design document includes a section on alternatives that were considered, and ultimately rejected.

## Why not “use eBPF”?

We do - where it’s appropriate! Istio can be configured to **[use eBPF to route traffic from pods to proxies](https://istio.io/latest/blog/2022/merbridge/)**. This shows a small performance increase over using iptables.

Why not use it for everything? No-one does, because no-one actually can.

eBPF is a virtual machine that runs inside the Linux kernel. It was designed for functions guaranteed to complete in a limited compute envelope to avoid destabilizing kernel behavior, such as those that perform simple L3 traffic routing or application observability. It was not designed for long running or complex functions like those found in Envoy: that’s why operating systems have user space! eBPF maintainers have theorized that it could eventually be extended to support running a program as complex as Envoy, but this is a science project and unlikely to have real world practicality.

Other meshes that claim to “use eBPF” actually use a per-node Envoy proxy, or other user space tools, for much of their functionality.


## Why not use a per-node proxy?

Envoy is not inherently multi-tenant. As a result, we have major security and stability concerns with commingling complex processing rules for L7 traffic from multiple unconstrained tenants in a shared instance. Since Kubernetes, by default can schedule a pod from any namespace onto any node, the node is not an appropriate tenancy boundary. Budgeting and cost attribution are also major issues, as L7 processing costs a lot more than L4.

In ambient mode, we strictly limit our ztunnel proxy to L4 processing - just like the Linux kernel. This reduces the vulnerability surface area significantly, and allows us to safely operate a shared component. Traffic is then forwarded off to Envoy proxies that operate per-namespace, such that no Envoy proxy is ever multi-tenant.


**Multi-tenancy** is a software architecture that allows multiple users or groups of users, called tenants, to share a single instance of a software application. In a multi-tenant environment, tenants are isolated from each other, but they share the same underlying computing resources, such as servers, CPU, and memory. 
Here are some benefits of multi-tenancy:
Scalability: Multi-tenant systems can easily accommodate seasonal spikes in demand or adjust usage based on customer needs.
Cost savings: Companies can reduce costs by sharing resources instead of investing in separate systems for each tenant.

## I have a CNI. Why do I need Istio?

**Container Network Interface**\
A framework that uses libraries and specifications to configure networking resources for Linux containers. CNI is a standard used by Kubernetes to configure cluster networking. It's used to add, connect, and disconnect containers to networks. 

Today, some CNI plugins are starting to offer service mesh-like functionality as an add-on that sits on top of their own CNI implementation. For example, they may implement their own encryption schemes for traffic between nodes or pods, workload identity, or support some amount of transport-level policy by redirecting traffic to a L7 proxy. These service mesh addons are non-standard, and as such can only work on top of the CNI that ships them. They also offer varying feature sets. For example, solutions built on top of Wireguard cannot be made FIPS-compliant.

For this reason, Istio has implemented its zero-trust tunnel (ztunnel) component, which transparently and efficiently provides this functionality using proven, industry-standard encryption protocols. Learn more about ztunnel.

Istio is designed to be a service mesh that provides a consistent, highly secure, efficient, and standards-compliant service mesh implementation providing a powerful set of L7 policies, platform-agnostic workload identity, using industry-proven mTLS protocols - in any environment, with any CNI, or even across clusters with different CNIs.
# **[What Is Istio Service Mesh?](https://tetrate.io/what-is-istio-service-mesh/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[sidecar proxy](https://iximiuz.com/en/posts/service-proxy-pod-sidecar-oh-my/)**

## What Is Istio Service Mesh?

Service mesh is a new form of architecture for software applications. This includes internal applications used to run a business, such as analytics reporting or dashboards, and public-facing applications that deliver functionality to customers, such as a ride-sharing app on your phone.

Part of the reason service mesh is becoming popular is because it supports and extends other important trends in application design and delivery: containerizing software to make it more reliable and more flexible; using Kubernetes to manage the containers; and microservices architecture, which splits an application into small, containerized components (services). Service mesh sits on top of these pre-existing approaches and extends them to help make software easier to develop, easier to deliver, more reliable, and more secure.

The service mesh is made up of a network, or “mesh,” of communications between software services. While software services are, of course, different from each other, each service is attached to a fixed piece of software, called a sidecar proxy. When a service wants to send a message to another service, or to the control plane that’s part of the service mesh, the message goes through the proxy software. The proxy authenticates messages, authorizes them, and encrypts/decrypts them using TLS, among other functions. We go into more depth on this below.

Core development of service mesh software took place at Google, IBM, and Lyft, to solve problems that are hard to manage in any other way at the scale that Google (and a few other companies) run at. The service approach was quickly adopted by other leading, tech-forward companies, such as Twitter. As companies move to the cloud, and take on larger and more complex software projects – or want to develop smaller projects faster, with greater consistency – they are increasingly turning to the service mesh architectural pattern to help.

## Why Istio Service Mesh?

Istio is the first and most widely used open source project to make service mesh accessible to a wider audience. There are alternatives, which we will discuss in a later blog post. While the different approaches have most of their features and functionality in common, this page only discusses Istio service mesh.

Istio service mesh serves as a networking layer, automating and securing communications between applications. Istio service mesh is independent of any specific programming language. Istio is used by architects and engineers building cloud-native applications or following microservice architecture approaches.

Istio service mesh provides a control plane to define and implement the way microservices communicate with each other. **Istio is based on a foundation layer of lightweight network proxy instances derived from the Envoy proxy.** Envoy is responsible for all service interaction in Kubernetes or virtual machines (VMs). One outstanding feature of the Istio service mesh is that services do not know they are working alongside Envoy instances or using a sidecar proxy.

Using Istio service mesh, platform teams can address needs for traffic management, service security, and application monitoring. Istio service mesh enables developers to develop business logic for loosely coupled microservices without worrying about communication logic and security. Istio is designed to run in various environments like on-premises, multi-cloud, Kubernetes containers, and virtual machines (VMs), so Istio helps platform teams manage and monitor all the service traffic across clusters and data centers.

## Features of Istio Service Mesh

Istio provides numerous features that make software development and delivery faster, easier, and more secure. Istio offers authentication, authorization, load balancing, circuit breaker, time outs, retries, and deployment strategies, service discovery, and observability. Following is a brief description of key capabilities that you can expect Istio + Envoy software to provide:

### Security

Istio helps application teams to achieve zero trust security with the ability to define and implement authentication, authorization, and access control policies. All your data communicated among the services, in and outside of the cluster or data center, will be encrypted based on mTLS protocols provided by Istio resources. You can also ensure authentication of apps from internal and external users using JSON Web Tokens (JWT) provided by Istio.

### Service Discovery

One of the primary needs of an application running in a production environment is to be highly available. This requires one to scale up the number of service instances with increasing load and scale down when needed to save costs. Istio’s service discovery capability keeps track of all the available nodes ready to pick up new tasks. In case of node unavailability, service discovery removes a node from the list of available nodes and stops sending new requests to the node.

### Traffic Management

Using Envoy proxies, Istio provides flexibility to finely control the traffic among the available services. Istio provides features like load balancing, health checks, and deployment strategies. Istio allows load balancing based on algorithms that include round robin, random selection, weighted algorithms, etc. Istio performs constant health checks of service instances to ensure they are available before routing the traffic request. And based on the deployment type used in the configuration, Istio drives traffic to new nodes in a weighted pattern.

### High Availability (HA) Systems (Resilience)

Istio removes the need for coding circuit breakers within an application. Istio helps platform architects to define mechanisms such as timeouts to a service, number of retries to be made and planned automatic failover of high availability (HA) systems, without the application knowing about them.

### Istio - Observability

Istio keeps track of network requests and traces each call across multiple services. Istio provides the telemetry (such as latency, saturation, traffic health, and errors) that helps SREs to understand service behavior and troubleshoot, maintain, and optimize their applications.

### Istio - Network Controls (Advanced Deployment)

Istio provides visibility and fine-grained network controls for traditional and modern workloads, including containers and virtual machines. Istio helps to achieve canary and blue-green deployment by providing the capability to route specific user groups to newly deployed applications.

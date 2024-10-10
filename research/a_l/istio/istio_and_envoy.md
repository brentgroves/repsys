# **[Istio & Envoy: How they work together](https://istio.io/latest/docs/examples/microservices-istio/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The idea of load balancing and proxies has been around for a while. In fact, the technology dates back to the 1990s, when hardware-based devices distributed the network traffic to back-end servers. As the world of technology evolved, however, so did the load balancer and the proxy, migrating eventually to software-based platforms.

Software-based load balancers, such as Kubernetes Ingress and NGINX, are now ubiquitous. Beyond that, however, there exists a whole new world of microservices and distributed architectures that bring unique and interesting challenges.

New players like Envoy and Istio have emerged to address many of these challenges, providing new ways to manipulate and secure traffic patterns.

Let’s start with Envoy. What is it, and how does it fit into today's architecture? To quote their official site, “Envoy is an L7 proxy and communication bus designed for large modern service-oriented architectures.” It can also act as an L3/L4 proxy, an advanced load balancer, an edge proxy, and much more—as we will soon see.

Envoy was created in 2016 by Lyft and has had 72 major releases since then. It’s open-source, a CNCF graduate, popular, capable, and very well-maintained.

Next, we’ll introduce Istio. Istio was created in 2017 as a collaboration between IBM, Google, and Lyft. It Implements a whole new approach to communication between distributed applications. Istio is an example of what’s known as a “service mesh.'—that is to say, a dedicated infrastructure layer that runs alongside applications, interconnecting them. Service meshes give us greater control of network communications because they provide observability, traceability, and security. Furthermore, they do so without requiring that these communication-enhancing features are explicitly built into the applications themselves..In this article, we’ll look at Envoy as a core building block for Istio service mesh. Along the way, we’ll assess the features it brings to Istio, and highlight some drawbacks.

## Envoy: concepts and features
Before we plunge into a discussion of Envoy’s role in Istio Service Mesh, let’s cover some basic Envoy concepts and terminology:

- **host:** a logical entity that participates in network communication
- **downstream:** a process or an application that communicates with an Envoy proxy
- **upstream:** a destination host to which Envoy establishes communication
- **mesh:** an assembly of hosts that have logical groupings and provide a consistent networking space
- **runtime configuration:** a dynamic configuration deployed to every participating Envoy proxy within a mesh that contains details about traffic processing rules, Envoy runtime configuration, enabled features, and other attributes
- **ingress and egress:** logical network objects that intercept and process traffic heading towards (ingress) and from (egress) your applications

Understanding these definitions is essential to grasping the life of a network packet as it passes through a proxy. All of these definitions are also equally applicable to Istio.

Now, let’s take a look at a diagram (inspired by an original document from Envoy) that will give us a practical example of how these pieces work together.

![isen](https://www.kubecost.com/images/kubernetes-devops-tools/envoy-mesh-topology.png)

The life of a request inside an Envoy mesh topology

Here we see an advanced use case, with Envoy acting as both the edge proxy (with possible TLS termination, AAA, request limiting, etc) and as a mesh for internal communication. This is what happens when an external source connects to a service:

- any external requests heading into a cluster first land on the edge proxies
- the edge proxy forwards these requests to the respective service, based on discovery and predefined routing rules
- the service receives it via an ingress listener and processes the request
- responses are sent via an egress listener (either edge or service-related)
- if more internal communication occurs between services (e.g. frontend to backend) then the pattern repeats itself

It is important to note that the same topology would also be applicable to Istio service mesh, since Istio is using Envoy at its core (albeit an extended version).

## Istio data plane: Envoy’s playing field

In our example “life of a request” above, we looked a little closer at how Envoy Proxies interact with different types of requests. We also mentioned that Istio uses Envoy at its core. Let’s expand on this and see exactly how it's being used inside the Istio service mesh.

Istio has two logically separate planes that together form a mesh:

- **the data plane:** built on top of Envoy, it’s solely responsible for all data passing through the mesh
- **the control plane:** implemented monolithically, it’s responsible for tasks such as mesh configuration (including Envoy’s runtime configuration, traffic routing rules, etc), populating the service catalog by connecting to the respective service discovery mechanism, providing certificate management, and setting up secure communications

Now, to further understand Envoy’s placement in the data plane, let’s take a look at an architecture diagram from Istio’s official documentation. For simplicity, it uses only a single control deployment model.

![istio](https://www.kubecost.com/images/kubernetes-devops-tools/istio-architecture.png)

Envoy is deployed into a Kubernetes cluster using a sidecar pattern, which means that every Istio-enabled application (or namespace, deployment, or pod) gets injected with a container running an Envoy proxy, with the necessary configuration bootstrapped into it. This process is overseen by the control plane (and its Pilot component) and abstracts Envoy’s configuration into a more high-level Istio concept. Usage of the sidecar pattern also eliminates the need to re-architect any existing infrastructure and provides a flexible way of rolling out the service mesh gradually.

Envoy provides many useful features for Istio, which can be grouped into the following rough categories:

- **traffic control and network resiliency:** load balancing, traffic throttling, rate limiting, fault injection, failover, and retry mechanisms
- **security and authentication:** the policy-enforcement point for authentication policies that define the rules of request and peer authentication
- **observability:** rich telemetry data for mesh communications, including metrics, traces, and access/audit logging
- **extensibility:** enables additional Envoy filters, **[WASM](https://istio.io/latest/docs/reference/config/proxy_extensions/wasm-plugin/)** plugins, and allows Istio to be integrated into almost any environment

To be thorough, let’s take a closer look at these categories and explore how Envoy enables each functionality for Istio.

## Traffic control and network resiliency with Envoy

As discussed, Istio is built on top of an extended version of Envoy and provides many abstractions to simplify the configuration of a proxy. These abstractions are translated from Istio CRDs via Istio’s control plane component, called Pilot, and into **[xDS](https://www.envoyproxy.io/docs/envoy/latest/api-docs/xds_protocol)** API calls to Envoy.

### side note: xDS REST and gRPC protocol

Envoy discovers its various dynamic resources via the filesystem or by querying one or more management servers. Collectively, these discovery services and their corresponding APIs are referred to as xDS. Resources are requested via subscriptions, by specifying a filesystem path to watch, initiating gRPC streams, or polling a REST-JSON URL. The latter two methods involve sending requests with a DiscoveryRequest proto payload. Resources are delivered in a DiscoveryResponse proto payload in all methods. We discuss each type of subscription below.

When talking about broad groups such as “traffic control” or “network resiliency,” there are almost too many areas to cover. For the sake of brevity, we’ll focus on one of the more common examples.

Imagine that you have a set of services inside a service mesh: an entrypoint publicly exposed behind a DNS name and services communicating via REST. We want to ensure that our services not only do not get fatigued (by balancing the load), but also that we quickly cut connections to any services that may be unresponsive.

In terms of Istio abstractions, the following resources would be used to set up our example:

- **VirtualService:** used for routing requests and built on top of Envoy’s HTTP connection manager
- **DestinationRule:** defines what happens to the traffic once it lands on an actual destination service. This is built on top of Envoy’s load balancer and circuit breaker functionality.
- **Gateway:** an alternative to a Kubernetes’ Ingress. Manages incoming and outgoing traffic from the mesh and is implemented by Envoy’s edge proxy awareness
- **ServiceEntry:** used for adding entries to Istio’s service registry and useful in cases where there is a need to control how traffic behaves outside of the mesh

To demonstrate this more practically, we will now look at a Kubernetes manifest that describes the gateway deployment along with a “life of a request” diagram.

The manifest below does the following:

- **exposes demo-svc** as demo.example.com via (ingress) Gateway on port 443(HTTPS)
- **matches two routes** (set in VirtualService), ‘/api’ and ‘/health’, before sending traffic to demo-svc:8080
- **balances traffic between pods** on the least connections algorithm once the traffic reaches the service (set in DestinationRule)
- **provides a custom timeout and retry mechanism** is described for demo-svc in VirtualService, thus making sure that we protect it from unwanted load
- **controls the connection to the external dependency** via ServiceEntry and DestinationRule, and sets up mutual TLS authentication

```yaml

---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
 name: demo-gateway
spec:
 selector:
   istio: ingressgateway
 servers:
 - port:
     number: 443
     name: https
     protocol: HTTPS
   hosts:
   - demo.example.com
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
 name: demo-service
spec:
 hosts:
 - "demo.example.com"
 gateways:
 - demo-gateway
 http:
 - match:
   - uri:
       prefix: /api
   - uri:
       prefix: /health
   route:
   - destination:
       port:
         number: 8080
       host: demo-svc
   timeout: 10s
   retries:
     attempts: 3
     perTryTimeout: 2s

---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
 name: demo-svc-dr
spec:
 host: demo-svc
 trafficPolicy:
   loadBalancer:
     simple: RANDOM
---
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
 name: external-svc-entry
spec:
 hosts:
 - external.service.com
 ports:
 - number: 443
   name: https
   protocol: HTTPS
 location: MESH_EXTERNAL
 resolution: DNS
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
 name: external-svc-dr
spec:
 host: external.service.com
 trafficPolicy:
   tls:
     mode: MUTUAL
     clientCertificate: /etc/certs/myclientcert.pem
     privateKey: /etc/certs/client_private_key.pem
     caCertificates: /etc/certs/rootcacerts.pem
```

This is a lot to process and visualize. Hopefully our “life of a request” diagram below will add further clarity.

This diagram is a bit of a hybrid, since it shows Istio abstractions alongside Kubernetes objects, but the aim is to highlight which definitions are responsible for traffic movement.

![lor](https://www.kubecost.com/images/kubernetes-devops-tools/istio-service-life-request.png)**

In short, requests enter the mesh via a Gateway, which has awareness of the host and route matching, described in the VirtualService. The requests then land on a demo-svc and are load-balanced by the “least-active-connection” method (described in the DestinationRule). If connections to external services are needed, they are established with mTLS authentication.

As we can see from the manifests and diagram, by instructing Envoy proxies in how they should behave via Istio resources, we are now in full control of the traffic.



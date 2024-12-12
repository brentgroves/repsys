# **[A Hands-On Guide to Kubernetes Endpoints & EndpointSlices](https://medium.com/@muppedaanvesh/a-hands-on-guide-to-kubernetes-endpoints-endpointslices-%EF%B8%8F-1375dfc9075c)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

![ep](https://miro.medium.com/v2/resize:fit:720/format:webp/1*6qbSvRldvpgPIExIq8fiGw.png)

In the world of Kubernetes, efficient service discovery and routing are essential for managing complex containerized applications. Kubernetes Endpoints and Endpoint Slices play a critical role in this process, linking services to the pods that handle the actual workload. This blog post aims to provide a comprehensive understanding of these concepts, their importance, how they work, and best practices for using them.

![eps](https://miro.medium.com/v2/resize:fit:720/format:webp/1*kAMuf7ryG81KEFWzQFwVDw.gif)

Animated Kubernetes Endpoints & EndpointSlices by Anvesh Muppeda

## What are Kubernetes Endpoints?

Kubernetes Endpoints are API objects that define a list of IP addresses and ports. These addresses correspond to the pods that are dynamically assigned to a service. Essentially, **an Endpoint in Kubernetes is a bridge connecting a service to the pods that fulfill the service’s requests.**

When a service is created, Kubernetes automatically creates an associated Endpoint object. The Endpoint object maintains the IP addresses and port numbers of the pods that match the service’s selector criteria.

## How Kubernetes Endpoints Work

To understand how Kubernetes Endpoints work, let’s break down the process:

- **Service Creation:** When you create a service in Kubernetes, you define a selector that matches a set of pods. This selector determines which pods the service will route traffic to.
- **Endpoint Creation:** Kubernetes automatically creates an Endpoint object associated with the service. This object contains the IP addresses and ports of the pods that match the selector.
- **Updating Endpoints:** As pods are added or removed, or their statuses change, Kubernetes continuously updates the Endpoint object to reflect the current set of matching pods. This ensures that the service always routes traffic to the appropriate pods.

## Anatomy of an Endpoint Object

Let’s take a look at a sample Endpoint object:

```yaml
apiVersion: v1
kind: Endpoints
metadata:
  name: my-service
subsets:
  - addresses:
      - ip: 10.0.0.1
      - ip: 10.0.0.2
    ports:
      - port: 80
```

In this example:

The addresses field lists the IP addresses of the pods that match the service selector.
The ports field lists the ports on which the pods are listening.

## The Role of Endpoints in Service Discovery

Service discovery in Kubernetes relies heavily on Endpoints. When a service receives a request, it uses the information in the associated Endpoint object to route the request to one of the available pods. This mechanism ensures that traffic is evenly distributed among healthy pods.

## DNS and Endpoints

Kubernetes services are accessible via DNS. For example, if you have a service named my-service in the default namespace, it can be resolved with the DNS name my-service.default.svc.cluster.local. When this DNS name is resolved, it points to the IP addresses listed in the corresponding Endpoint object.

## What are Endpoint Slices?

Endpoint Slices are a more scalable and efficient way to manage endpoints in Kubernetes. Introduced in Kubernetes 1.16, Endpoint Slices provide a way to distribute the network endpoints across multiple resources, reducing the load on the Kubernetes API server and improving the performance of large clusters.

An Endpoint Slice represents a subset of the endpoints that make up a service. Instead of having a single large Endpoint object for a service, multiple smaller Endpoint Slice objects are created, each representing a portion of the endpoints.

By default, the control plane creates and manages EndpointSlices to have no more than 100 endpoints each. You can configure this with the --max-endpoints-per-slice **[kube-controller-manager](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/)** flag, up to a maximum of 1000.

EndpointSlices can act as the source of truth for **[kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)** when it comes to how to route internal traffic.

## Address types

EndpointSlices support three address types:

- IPv4
- IPv6
- FQDN (Fully Qualified Domain Name)

Each EndpointSlice object represents a specific IP address type. If you have a Service that is available via IPv4 and IPv6, there will be at least two EndpointSlice objects (one for IPv4, and one for IPv6).

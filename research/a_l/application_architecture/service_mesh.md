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

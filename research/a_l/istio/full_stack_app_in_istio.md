# **[Running a Full Stack App in Istio Service Mesh — Part 1](https://istio.io/latest/docs/examples/microservices-istio/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The world is going cloud-native. A lot of workloads in many companies are already migrating from VMs and running in Kubernetes. But the future of microservice networking is through service mesh, with the most popular open source implementation of the same being Istio.

Istio simplifies observability, traffic management, security, and policy with the leading service mesh. You can explore independently about the need of service mesh and what critical problems it is solving.

In this blog, we will take a simplified full stack app and make it up and running inside a Istio service mesh. We will expose it via Ingress gateway and visualize live traffic through the Kiali Service Graph Dashboard.

In further blogs, we will build upon this example to inspect further Istio features like Security, Observability and Traffic Routing.

Architecture
The following drawing showcases what we are trying to achieve through this blog.


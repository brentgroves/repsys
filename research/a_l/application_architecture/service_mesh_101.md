# **[Service Mesh 101: Everything You Need to Know](https://www.infracloud.io/blogs/service-mesh-101/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[video](https://www.infracloud.io/cloud-native-talks/request-level-authentication-istio-keycloak/)**

When building software, code can be structured as a single large program (monolith) or multiple smaller programs (microservices). While it is true that many organizations are migrating from monolith to microservices to leverage the flexibility and scalability microservices offer, it gets difficult to manage them as their number grows. Challenges arise in tracking, latency control, optimizing load between replicas of a service, service-to-service communication security, and maintaining resilience. All these features can be encoded with the service giving an opportunity for vulnerabilities & mixing of business logic with management logic.

Implementing a reliable service discovery mechanism and maintaining an up-to-date service registry becomes difficult. **[Adopting Kubernetes](https://www.infracloud.io/kubernetes-consulting-partner/)** resolves some deployment issues, but runtime issues persist due to tight coupling with the application. Testing new features and making changes while maintaining infrastructure security becomes challenging.

Service mesh fills this gap and helps build a secure infrastructure with the optimized usage of the service by adding reliability, observability, and security features across all services uniformly without any application code change. In this blog post, we will understand the concept of the service mesh, its components, its functionality, and how it can be helpful in Kubernetes and beyond.

## What is a service mesh?

Service mesh is an infrastructure layer deployed alongside an application, which means all the network complexities are handled outside the application code. It operates independently from the application and provides capabilities to optimize networking and enable service-to-service communication. By configuring and managing network behavior and traffic flow through policies, the service mesh enhances the application’s networking capabilities.

## Why is a service mesh needed?

There are multiple reasons why an organization would wish to implement a service mesh. We can start with the **API endpoint discovery** feature of service mesh that helps in identifying the backend service based on the client’s request and preventing the exposure of the API to unauthorized access. Another reason is that an **outbound proxy** can only protect the cluster or VMs from the outside. However, once a request enters the infrastructure, all communication becomes insecure, and the request gains access to all the services. This leaves it vulnerable to potential threats.

**[Service mesh](https://glossary.cncf.io/service-mesh/)** fills this gap and routes all the inter-service communication through proxies. It allows **[platform engineers](../application_architecture/platform_engineer.md)** to rate limit, trace, access control, etc. the service request which helps in keeping the infrastructure secure. Though very frequently used with Kubernetes and microservices, service mesh can be used outside of microservices and containers on virtual or bare metal servers. Let us understand the architecture of service mesh to know how we can modernize existing services.

## Service mesh architecture

Service mesh is designed on the basis of the **[Software Defined Network (SDN)](../../m_z/virtualization/networking/sdn.md)** architecture. It has two major components, i.e. control plane and the data plane. With one or more control planes that act as the brain of the service mesh, multiple data planes can be configured to process the traffic flow using the policy specified by the control plane.

![sm](https://www.infracloud.io/assets/img/blog/demystifying-service-mesh/service-mesh-architecture.png)

# **[Service Mesh 101: Everything You Need to Know](https://aws.amazon.com/what-is/service-mesh/#:~:text=A%20service%20mesh%20is%20a,with%20multiple%20service%20management%20systems.)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[video](https://www.infracloud.io/cloud-native-talks/request-level-authentication-istio-keycloak/)**

## What is a service mesh?

A service mesh is a software layer that handles all communication between services in applications. This layer is composed of containerized microservices. As applications scale and the number of microservices increases, it becomes challenging to monitor the performance of the services. To manage connections between services, a service mesh provides new features like monitoring, logging, tracing, and traffic control. It’s independent of each service’s code, which allows it to work across network boundaries and with multiple service management systems.

## Why do you need a service mesh?

In modern application architecture, you can build applications as a collection of small, independently deployable microservices. Different teams may build individual microservices and choose their coding languages and tools. However, the microservices must communicate for the application code to work correctly.

Application performance depends on the speed and resiliency of communication between services. Developers must monitor and optimize the application across services, but it’s hard to gain visibility due to the system's distributed nature. As applications scale, it becomes even more complex to manage communications.

There are two main drivers to service mesh adoption, which we detail next.

## Service-level observability

As more workloads and services are deployed, developers find it challenging to understand how everything works together. For example, service teams want to know what their downstream and upstream dependencies are. They want greater visibility into how services and workloads communicate at the application layer.

## Service-level control

Administrators want to control which services talk to one another and what actions they perform. They want fine-grained control and governance over the behavior, policies, and interactions of services within a microservices architecture. Enforcing security policies is essential for regulatory compliance.

## What are the benefits of a service mesh?

A service mesh provides a centralized, dedicated infrastructure layer that handles the intricacies of service-to-service communication within a distributed application. Next, we give several service mesh benefits.

## Service discovery

Service meshes provide automated service discovery, which reduces the operational load of managing service endpoints. They use a service registry to dynamically discover and keep track of all services within the mesh. Services can find and communicate with each other seamlessly, regardless of their location or underlying infrastructure. You can quickly scale by deploying new services as required.

## Load balancing

Service meshes use various algorithms—such as round-robin, least connections, or weighted load balancing—to distribute requests across multiple service instances intelligently. Load balancing improves resource utilization and ensures high availability and scalability. You can optimize performance and prevent network communication bottlenecks.

## Traffic management

Service meshes offer advanced traffic management features, which provide fine-grained control over request routing and traffic behavior. Here are a few examples.

## Traffic splitting

You can divide incoming traffic between different service versions or configurations. The mesh directs some traffic to the updated version, which allows for a controlled and gradual rollout of changes. This provides a smooth transition and minimizes the impact of changes.

## Request mirroring

You can duplicate traffic to a test or monitoring service for analysis without impacting the primary request flow. When you mirror requests, you gain insights into how the service handles particular requests without affecting the production traffic.

# **[Basic Guide to Kubernetes Service Discovery](https://dev.to/nomzykush/basic-guide-to-kubernetes-service-discovery-dmd?signin=true)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## Introduction

In today's fast-paced world, the rise of distributed systems has revolutionized the way we build and manage applications. As these systems grow increasingly complex, ensuring seamless communication among services has become paramount. Enter the world of service discovery – the unsung hero of distributed architectures.

Imagine a bustling city, teeming with countless businesses and services. In such a metropolis, knowing how to locate and connect with each establishment would be a monumental task. Service discovery solves this very challenge in the realm of distributed systems. It enables services to effortlessly find and communicate with one another, without relying on manual intervention or grappling with the ever-changing landscape.

Picture this: you have the opportunity to harness the power of Kubernetes, a cutting-edge container orchestration platform that takes service discovery to new heights. By leveraging Kubernetes, you can unlock the full potential of service discovery, streamlining application deployment, and management in ways you never thought possible.

In this article, we will embark on a journey through the fundamentals of Kubernetes service discovery. We will demystify the inner workings of service discovery in Kubernetes, explore its various methods, and delve into the advantages it offers. We will equip you with best practices to implement service discovery effectively, and highlight common pitfalls to avoid along the way. By the time you reach the end, you will be armed with the knowledge and insights needed to confidently deploy and manage applications in a distributed system.

## Kubernetes Service Discovery Basics

In Kubernetes, a service is a grouping of pods that provides a stable IP address and DNS name for easy communication. It abstracts the physical location or IP address of pods, allowing other applications or services to interact with them within the cluster. Services can also expose pods to the internet or other pods in the same cluster.

Kubernetes provides five types of services:

ClusterIP provides an internal IP address for clients within the cluster to send requests. When a Service is created in Kubernetes, a stable IP address is automatically generated, which can be accessed by nodes within the cluster. To call the Service, clients can use the cluster IP address and the TCP port specified in the Service manifest's port field. The request is then forwarded to one of the member Pods on the TCP port specified in the targetPort field.

Here’s an example of YAML configuration for a ClusterIP service:

```yaml

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

![cip](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Focuhufq5lyby1lefjrrx.png)

NodePort enables clients to send requests to a Kubernetes Service using the IP address of any node and a specified nodePort value. Kubernetes automatically assigns a nodePort value to each Service, which can be used to access the Service from any node's IP address. External clients can reach the Service by using the external IP address of a node and the TCP port specified by nodePort.

Here’s a sample YAML configuration for a NodePort service:

```yaml
apiVersion: v1
kind: Service
metadata:

  name: my-service
spec:
  type: NodePort
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30080
```

![np](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fw2pgsz3fpr1n6kpm5cz3.png)

LoadBalancer facilitates client access to a Service by providing a network load balancer IP address for receiving requests.

Example YAML configuration for a LoadBalancer service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - protocol: TCP
 targetPort: 8080
```

![lb](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fmeatcthh3wuhqx45u0ds.png)

**ExternalName** enables internal clients to utilize a Service's DNS name as an alias for an external DNS name, effectively providing an internal alias for the external DNS name.

Example YAML configuration for an ExternalName service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ExternalName
  externalName: external-service.example.com
```

![en](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fo9hp903lb5u5ieal9n06.jpg)

A Notable usecase for Kubernetes Service Discovery
Imagine you're part of a team working on a cutting-edge e-commerce platform that handles thousands of requests per second. This platform comprises various microservices, each responsible for a specific functionality. One of the challenges you face is ensuring seamless communication between these microservices in a dynamic and scalable environment.

Service discovery comes to the rescue! Let's consider a scenario where a customer places an order on the platform. The ordering service needs to communicate with the inventory service to check product availability, the payment service to process payment, and the shipping service to initiate product delivery.

With Kubernetes service discovery, the ordering service can easily locate and connect to these dependent services without worrying about their physical locations or IP addresses. Kubernetes assigns unique identifiers to each service, allowing the ordering service to use their DNS names or cluster IP addresses to establish connections. Even if the underlying pods of these services scale up or down, the ordering service can seamlessly interact with them.

This automated service discovery not only simplifies the development process but also enhances the scalability and reliability of the platform. It allows the team to effortlessly add or remove services as needed, without disrupting the entire system. Furthermore, by reducing network congestion and latency, service discovery helps deliver a lightning-fast and seamless shopping experience to customers.

By leveraging the power of Kubernetes service discovery, the e-commerce platform ensures smooth communication between microservices, enabling efficient order processing, improved customer satisfaction, and ultimately, business success.

## Kubernetes Service Discovery Methods

There are three main Kubernetes service discovery methods: server-side discovery, client-side discovery, and DNS discovery. Each of these methods has its own advantages and disadvantages, and choosing the right one depends on your specific use case.

## Kubernetes Server-side discovery

Kubernetes server-side discovery is a service discovery method that involves using the Kubernetes API server to discover and manage services. In the server-side discovery method, services are registered with the Kubernetes API server, which acts as a central registry for services. Clients then query the API server to discover the available services. The API server responds with a list of available services and their corresponding endpoints. When a client makes a network request for a service, Kubernetes routes the request to the appropriate endpoint using information stored in the API server. Kubernetes also manages load balancing among the available endpoints for a service. Server-side discovery is a simple and straightforward method for service discovery in Kubernetes. It requires no additional infrastructure or tooling beyond the Kubernetes API server, and is easy to configure and manage. However, it can be less flexible than other methods since it relies on the API server to manage service discovery.

To use server-side discovery for service discovery in Kubernetes, services must be registered with the Kubernetes API server. This can be done by creating a Kubernetes service object, which specifies the name and endpoint information for the service. Clients can then query the API server for information about available services using tools like kubectl or the Kubernetes API client libraries. Additionally, Kubernetes provides a number of configuration options for fine-tuning the behavior of server-side discovery, such as load-balancing algorithms and endpoint selection strategies.

Example YAML configuration for creating a Service object:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

![so](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fwllkiyuvtkzmhawxi75p.jpg)

Using LoadBalancer for connecting to Service Instances

## Kubernetes Client-side discovery

Kubernetes client-side discovery is a service discovery method that involves embedding service discovery logic in client applications. In this method, clients use a discovery mechanism to locate services. Unlike server-side discovery, which relies on the Kubernetes API server to manage service discovery, client-side discovery is more flexible since clients can choose which services to discover and how to discover them. In client-side discovery, the client retains the service registry and directly looks up the available service instance addresses in the registry. The client fetches the service fleet, which is a complete list of IP addresses, determines which instances are viable, selects an optimal instance based on available load-balancing strategies, sends a request to the preferred instance, and awaits a response. Client-side discovery eliminates the load balancer as a single point of failure and reduces occasions for bottlenecking. This method is well-suited for highly loaded environments since it ensures less chance of throughput bottleneck and no single point of failure, not to mention less equipment to cope with. However, client-side service discovery complicates the clients with extra logic, requiring integration code for every framework or programming language in the ecosystem and coupling clients with the service registry.

To configure client-side discovery in Kubernetes, you need to set up a service registry that contains information about the available services and their endpoints. Clients can then query the registry to discover the services they need. Some popular service registries for Kubernetes include etcd, ZooKeeper, and Consul. Additionally, you will need to implement client-side service discovery logic in your client applications, which can be done using libraries or tools designed for this purpose. For example, the Netflix Eureka library is a popular choice for client-side service discovery in Java-based applications.

Example Java code for a client using Netflix Eureka for service discovery:

```java
DiscoveryClient discoveryClient = new DiscoveryClient(applicationName, eurekaClientConfig);
List<ServiceInstance> instances = discoveryClient.getInstances(serviceName);

// Select a service instance based on load balancing algorithm
ServiceInstance selectedInstance = loadBalancer.choose(instances);

// Send request to the selected service instance
String targetUrl = selectedInstance.getUri().toString();
HttpResponse response = httpClient.sendRequest(targetUrl, request);

```

![cs](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F7kfhwy9icu9swrnkj5z8.jpg)

Service Discovery using Centralized Registry Service

## Kubernetes DNS discovery

Kubernetes DNS discovery is a method used by Kubernetes to discover services in a cluster. It involves using DNS to map service names to their corresponding IP addresses within the cluster. This allows services to be accessed by their name rather than having to remember the IP address of each individual service. When a client wants to access a service in the cluster, it sends a DNS query for the service name. The query is received by the Kubernetes DNS service, which checks its records for the service name. If a match is found, the DNS service returns the IP address of the corresponding service. The client can then use this IP address to communicate with the service. Kubernetes DNS discovery is a built-in feature of Kubernetes that provides a simple and efficient way to discover services within a cluster. It eliminates the need for manual IP address management and allows services to be accessed by name, which is easier to remember and more intuitive.

Kubernetes DNS discovery is enabled by default in most Kubernetes clusters. However, it can be configured to suit specific needs. For example, the DNS service can be customized to use a different domain name or to support external DNS servers. To configure Kubernetes DNS discovery, the configuration file for the DNS service must be edited, which can be done using the Kubernetes command-line interface (CLI).

Example of DNS-based service discovery in Kubernetes:

```go
import requests

response = requests.get("http://my-service.my-namespace.svc.cluster.local")
print(response.text)
```

![dns](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fq2fecgjtvhz9j0fta8dp.jpg)**

# **[Using Kong to access Kubernetes services, using a Gateway resource with no cloud provided LoadBalancer](https://medium.com/@martin.hodges/using-kong-to-access-kubernetes-services-using-a-gateway-resource-with-no-cloud-provided-8a1bcd396be9)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In this article I look at how to deploy Kong as an API Gateway within a Kubernetes cluster to provide managed access to your services. I do this on a cloud service that does not provide a Kubernetes compatible, external LoadBalancer service. I am also using the new Kubernetes Gateway rather than Ingress resource.

If you have followed any of my **[previous articles](https://medium.com/@martin.hodges/improve-observability-by-adding-logs-to-grafana-on-a-kubernetes-cluster-3b3dddc05769)**, you will know that I use an Australian cloud provider called Binary Lane, who provide reliable, cost effective, but limited range of services.

Providing only a limited range of services means you have to do all of the Kubernetes work yourself but this provides the opportunity to learn and also allows you to control how your solutions work. It also means you are not locked in to any one cloud supplier. It’s cost effective too.

In this article I look at how to add Kong API Gateway to your Kubernetes cluster to provide access to your services. It is a long article as there is quite a bit to do. For this reason I have split out the **[theory about API Gateways in Kubernetes clusters](https://medium.com/@martin.hodges/why-do-i-need-an-api-gateway-on-a-kubernetes-cluster-c70f15da836c)** into a separate article. If you do not understand the role of an API Gateway, I suggest you read that article first.

Whilst Kong is a reputable, enterprise-level API Gateway, it can be very tricky to set up. At the end of this article I will provide some hints on how to debug problems. If you are adjusting the design in this article, make sure you get your names and ports correctly configured.

## Network design

Kubernetes networking is a complex topic and not one I am able to tackle here but we do need to think about out network design at a high-level.

![vpc](https://miro.medium.com/v2/resize:fit:720/format:webp/1*NCnFzHolno1Z0uUqtFRgVQ.png)

If you have been following along with the other articles, you should have a Kubernetes cluster installed on your Binary Lane (or other cloud provider’s) servers. You will have three nodes installed on a Virtual Private Cloud (VPC) private subnet that is not accessible to the Internet, except by way of a private VPN (not shown above). There will be a gateway server that has both Internet and VPC interfaces that provides our ingress from the Internet to our cluster (and also our egress from our cluster to the Internet, **[set up in previous articles](https://medium.com/@martin.hodges/automatic-creation-of-kubernetes-cluster-on-binary-lane-747cdd9b9918)**).

We now have our basic network topology. We now want to be able to manage the APIs our services provide to the outside world. This will be done via the Kong Gateway API.

## Connecting from the Internet (ingress)

With a full-service provider, such as AWS, Google Cloud or Azure, you can use their services to set up Kubernetes in a way that an Internet connection is created for you automatically. This is done using a Kubernetes Service with the type of LoadBalancer.

Whilst Binary Lane has load balancer services they cannot be managed via Kubernetes and so you have to either create and configure the load balancer yourself or create your own ingress point. To avoid being locked in to a specific cloud provider feature, I prefer to create my own ingress point with an NGINX reverse proxy running on my gw server.

In this architecture, NGINX running on the gw server, performs two functions:

- Routes all valid requests to the Kubernetes cluster for Kong to process
- Load balances requests across Kubernetes nodes

As Kong is going to be exposed as a NodePort Service, it will be accessible from any node in the cluster. This allows NGINX to load balance requests across the nodes.

It is interesting to note that the Service itself will randomly load balance across available pods and so any load balancing by NGINX is only there to survive node failures or overloads. You can read more about **[Service load balancing here](https://avinetworks.com/glossary/kubernetes-load-balancer/#:~:text=In%20other%20words%2C%20Kubernetes%20services,through%20the%20kube%2Dproxy%20feature.)**.

For the purposes of this solution, you can consider the NGINX as a manually configured, replacement, external load balancer.

## Kubernetes Service

Kubernetes Services allow access to a service that might be provided by one or more pods. It ensures that if pods are terminated and rescheduled, possibly on different nodes, the Service continues to be a single point of contact, routing requests to the pods as required, regardless if the node the request comes in on.

![k8s service](https://miro.medium.com/v2/resize:fit:720/format:webp/1*a54S9FTQN_zylDDS1ZT9Jw.png)

By using a Service, you have a single, stable IP address to which you can route requests. The Service provides a form of load balancing across the available pods. Kubernetes also adds a reference to the Service in the cluster’s DNS, allowing the service to be accessed by name. A number of different variations are registered:

## API gateway

Whilst an NGINX gateway and Kubernetes Service goes some way towards providing an external interface to your services, it has limited functionality and must be set up manually.

An API Gateway is a cluster component that solves this problem. It forms part of your solution and sits in front of your services to provide additional features as I describe here.

API gateway
Whilst an NGINX gateway and Kubernetes Service goes some way towards providing an external interface to your services, it has limited functionality and must be set up manually.

An API Gateway is a cluster component that solves this problem. It forms part of your solution and sits in front of your services to provide additional features as I describe **[here](https://medium.com/@martin.hodges/why-do-i-need-an-api-gateway-on-a-kubernetes-cluster-c70f15da836c)**.

![api gateway](https://miro.medium.com/v2/resize:fit:720/format:webp/1*SX50XxFrz1fBavnBFZCL2g.png)

## Routing

Whilst we have talked about routing REST requests, you should also be aware that there may be other requests other than HTTP traffic. This may be streaming, web sockets, multi-casts etc. The API Gateway can handle all of these.

## Load Balancing

To ensure High Availability, the API Gateway can load balance across Services. This means that if a Service fails or is terminated, your client does not even realise as its requests will be handled by another Service.

There are a number of load balancing techniques, such as random, sticky, hash, round robin etc and the API Gateway should give you the option.

One thing we have not discussed is the need for an external load balancer but we will come back to that later.

## Security

The API Gateway can act as your TLS endpoint. You can give it the TLS certificates that the client will trust and, using these, clients can confidently and securely connect to your API Gateway.

As a TLS endpoint, the traffic then becomes unencrypted and is open to network eavesdropping. To prevent this, it is recommended that you configure your API Gateway to connect to your Services and microservices over secure connections also.

In some architectures, the API Gateway does not terminate the TLS connection but actually routes it all the way through the microservice.

## Authentication

When a client connects to your microservice, you want to know who they are. This is the process of authentication. Authentication should always take place at the ingress point to your network to ensure that no one gets in without being identified first.

Remember, authentication is knowing who you are, authorisation is allowing you to do something. Authorisation is left up to other parts of the network or the services themselves.

Whilst the API Gateway does not carry out authentication itself, it can ensure that it takes place. You can secure particular request routes such that, if the user is not authenticated, they are either asked to authenticate (through redirection to login) or their request is rejected (by returning a 401 HTTP status).

In some cases authentication and authorisation is possible within the API Gateway by using API keys.

## Service monitoring

As requests are passed southbound to your Services, the API Gateway soon understands if a Service is no longer available. It needs to know this as it needs to redirect the request.

For this reason, the API Gateway becomes a good source of information to monitor your services.

## Request Monitoring and tracing

We have just mentioned that the API Gateway is good for monitoring Services. As it handles requests, it can also provide monitoring of those requests, providing information on the number of requests, types of request, possible cyber-attacks and on the performance of the Services to service requests.

If you have ever worked with microservices and, in particular, a **chain of microservices connected via an asynchronous queue**, you will know it is very difficult to trace requests end-to-end.

The API Gateway solves this particular problem by injecting headers as it passes the request southbound. These headers can include unique identifiers for each request that can be added to logs for monitoring. You can then use tools to report on your requests across your microservices.

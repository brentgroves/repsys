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

It is interesting to note that the Service itself will randomly load balance across available pods and so any load balancing by NGINX is only there to survive node failures or overloads. You can read more about Service load balancing here.

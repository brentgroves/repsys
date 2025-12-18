# **[Why do I need an API Gateway on a Kubernetes cluster](https://medium.com/@martin.hodges/why-do-i-need-an-api-gateway-on-a-kubernetes-cluster-c70f15da836c)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In this article I introduce the concepts of an API Gateway and explain why you would need one in your Kubernetes cluster. In my next article I will show **[how to set one up using Kong](./adv_kong_no_loadbalancer.md)**.

![ms](https://miro.medium.com/v2/resize:fit:720/format:webp/1*4MZkRWrqNvU_NFLmL7w6mw.png)

Unlike most of my articles, this one is about theory rather than practice. If you want to install an API Gateway, read my article on Kong installation **[here](./adv_kong_no_loadbalancer.md)**.

If you are creating a scalable backend for your product, it is likely that you will be implementing a microservice architecture. In such an architecture you want your client to be able to connect to your microservices, regardless of whether it is a browser, mobile device or even Internet of Things (IoT) component.

For this article, I have assumed that you are familiar with Kubernetes.

In the picture above, you can see our microservices inside a Kubernetes cluster. The dotted lines represent the connection of the client to these microservices and it is these dotted lines that we need a solution for.

As well as Kubernetes, I also assume that you are familiar with the creation and use of Services to provide a consistent and persistent point of contact to the Pods that are running your microservices. If you are not familiar with Services, you can read more about **[implementing Services](./auto_create_k8s_cluster.md)** in one of my other articles.

Ok, as we have our Services providing a consistent point of contact for our microservices, we can access them without having to worry about the number of instances (or replicas) we have running, or even where they are running. In fact, if you follow my articles, you will realise this is exactly what I do when I am trying things out. I expose the Service as a NodePort Service and access it from outside the cluster.

Whilst you could do this in a production setting, it is not advised for reasons that will become clear when you see what an API Gateway can do.

## Introducing the API gateway

Let’s say we have a number of microservices, each with their own number of replicas and each set with their own Services. We can now step back and look at how our client connects to these Services.

We need a way whereby the client has a single, consistent and persistent point of contact. Effectively we need a service for our Services!

We call this an API Gateway.

![svc for svc](https://miro.medium.com/v2/resize:fit:720/format:webp/1*cf6QkzASaSE9BDA0WPmekg.png)

You may have noticed I have flipped this picture around. This is so I can introduce the idea of North/South and East/West bound traffic.

These terms are frequently used when discussing Kubernetes traffic flow.

- Northbound refers to traffic going out to the Internet through a point of egress
- Southbound refers to traffic coming in from the Internet through a point of ingress
- East/West refers to traffic flowing between Pods and Services

I do not intend to get into the large and complex world of Kubernetes networking in this article, however, it is useful to understand these terms when talking about an API Gateway.

From the picture, you can see that client connects to our services by way of the API Gateway. It provides an ingress point and provides a consistent and persistent connection point for our southbound traffic.

Our client no longer needs to know about how we have structured our microservices and Services, how many there are or where they are. The client simply connects to our API Gateway and requests our services via, say, a REST interface. Ok, so I am also assuming you know what a REST interface is too!

The API Gateway takes care of routing the request to the appropriate Service based on domain, path or a number of other factors. In some cases, the Services may not be REST APIs but may be other application-level protocols. The API Gateway should route these also.

Technically, routing of the East/West traffic is not carried out by the API Gateway but some suppliers include this in their solutions. There are other solutions, such as the Istio service mesh that can manage the East/West traffic.

## Other features of an API Gateway

Ok, so we have just seen how an API Gateway can route Southbound traffic to the required Service and microservice within our cluster but this is only one of the features of an API gateway. Others include:

- Routing based on host, path, headers and more
- Load balancing
- Security
- Enforcing authentication
- Service monitoring
- Request monitoring and tracing
- A/B testing
- API versioning
- Rating limiting / circuit breaking
- Request transformation

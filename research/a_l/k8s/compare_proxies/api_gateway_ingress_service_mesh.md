# **[API Gateway, Ingress Controller or Service Mesh: When to Use What and Why](https://thenewstack.io/api-gateway-ingress-controller-or-service-mesh-when-to-use-what-and-why/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In just about every conversation on ingress controllers and service meshes, we hear some variation of the questions, “How is this tool different from an API gateway?” or “Do I need both an API gateway and an ingress controller (or service mesh) in Kubernetes?”

This confusion is understandable for two reasons:

- Ingress controllers and service meshes can fulfill many API gateway use cases.
- Some vendors position their API gateway tool as an alternative to using an ingress controller or service mesh — or they roll multiple capabilities into one tool.

Here, we will tackle how these tools differ and which to use for Kubernetes-specific API gateway use cases. For a deeper dive, including demos, watch the webinar “API Gateway Use Cases for Kubernetes.”

## Definitions

At their cores, API gateways, ingress controllers and service meshes are each a type of proxy, designed to get traffic into and around your environments.

## What Is an API Gateway?

An API gateway routes API requests from a client to the appropriate services. But a big misunderstanding about this simple definition is the idea that an API gateway is a unique piece of technology. It’s not. Rather, “API gateway” describes a set of use cases that can be implemented via different types of proxies, most commonly an ADC or load balancer and reverse proxy, and increasingly an ingress controller or service mesh. In fact, we often see users, from startup to enterprise, deploying out-of-the-box NGINX as an API gateway with reverse proxies, web servers or load balancers, and customizing configurations to meet their use case needs.

**[Application Delivery Controller - ADC](https://appviewx.com/education-center/application-delivery-controller/#:~:text=A%20load%20balancer%20simply%20distributes,across%20OSI%20layer%204%2D7.)**

A load balancer simply distributes inbound application traffic across multiple servers whereas ADC is an **advanced version of Load Balancer** that offers various services across OSI layer 4-7

There isn’t a lot of agreement in the industry about what capabilities are “must haves” for a tool to serve as an API gateway. We typically see customers requiring the following abilities (grouped by use case):

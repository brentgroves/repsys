# **[How Do I Choose? API Gateway vs. Ingress Controller vs. Service Mesh](https://www.f5.com/company/blog/nginx/how-do-i-choose-api-gateway-vs-ingress-controller-vs-service-mesh)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Definitions

At their cores, API gateways, Ingress controllers, and service meshes are each a type of proxy, designed to get traffic into and around your environments.

In Kubernetes, a gateway, ingress controller, and service mesh are all types of proxies that manage traffic in different ways:

## What Is an API Gateway?

An API gateway routes API requests from a client to the appropriate services. But a big misunderstanding about this simple definition is the idea that an API gateway is a unique piece of technology. It’s not. Rather, “API gateway” describes a set of use cases that can be implemented via different types of proxies – most commonly an **[ADC](https://appviewx.com/education-center/application-delivery-controller/#:~:text=A%20load%20balancer%20simply%20distributes,across%20OSI%20layer%204%2D7.)** or load balancer and reverse proxy, and increasingly an Ingress controller or service mesh.

**[Application Delivery Controller - ADC](https://appviewx.com/education-center/application-delivery-controller/#:~:text=A%20load%20balancer%20simply%20distributes,across%20OSI%20layer%204%2D7.)**

A load balancer simply distributes inbound application traffic across multiple servers whereas ADC is an **advanced version of Load Balancer** that offers various services across OSI layer 4-7

There isn’t a lot of agreement in the industry about what capabilities are “must haves” for a tool to serve as an API gateway. We typically see customers requiring the following abilities (grouped by use case):

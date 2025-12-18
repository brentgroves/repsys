# Kong Ingress Controller

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/architecture/>

<https://gateway-api.sigs.k8s.io/>

## Architecture

The Kong Ingress Controller configures Kong Gateway using Ingress or Gateway API resources created inside a Kubernetes cluster.

Kong Ingress Controller enables you to configure plugins, load balance the services, check the health of the Pods, and leverage all that Kong offers in a standalone installation.

The Kong Ingress Controller does not proxy any traffic directly. It configures Kong Gateway using Kubernetes resources.

The figure illustrates how Kong Ingress Controller works:

![](https://docs.konghq.com/assets/images/products/kubernetes-ingress-controller/high-level-design.png)

The Controller listens for the changes inside the Kubernetes cluster and updates Kong in response to those changes. So that it can correctly proxy all the traffic. Kong is updated dynamically to respond to changes around scaling, configuration, and failures that occur inside a Kubernetes cluster.

For more information on how Kong works with routes, services, and upstreams, please see the proxy and load balancing documentation.

## Kubernetes resources

In Kubernetes, there are several concepts that are used to logically identify workloads and route traffic between them.

Service / Pods
A Service inside Kubernetes is a way to abstract an application that is running on a set of Pods. This maps to two objects in Kong: Service and Upstream.

The service object in Kong holds the information of the protocol to use to talk to the upstream service and various other protocol specific settings. The Upstream object defines load-balancing and health-checking behavior.

Pods associated with a Service in Kubernetes map as a target belonging to the upstream, where the upstream corresponds to the Kubernetes Service in Kong. Kong load balances across the Pods of your service. This means that all requests flowing through Kong are not directed through kube-proxy but directly to the Pod.

## Kubernetes Gateway API

Gateway API resources can also be used to produce running instances and configurations for Kong Gateway.

The main concepts here are:

- A Gateway resource in Kubernetes describes how traffic can be translated to services within the cluster.
- A GatewayClass defines a set of Gateways that share a common configuration and behaviour. Each GatewayClass is handled by a single controller, although controllers may handle more than one GatewayClass.
- HTTPRoute can be attached to a Gateway which configures the HTTP routing behavior.

For more information about Gateway API resources and features supported by Kong Ingress Controller, see Gateway API.

## Ingress

An Ingress resource in Kubernetes defines a set of rules for proxying traffic. These rules correspond to the concept of a route in Kong.

This image describes the relationship between Kubernetes concepts and Kong’s Ingress configuration.

![](https://docs.konghq.com/assets/images/products/kubernetes-ingress-controller/k8s-to-kong.png)

## Gateway API

<https://gateway-api.sigs.k8s.io/>

## What is the Gateway API?¶

Gateway API is an open source project managed by the SIG-NETWORK community. It is an API (collection of resources) that model service networking in Kubernetes. These resources - GatewayClass, Gateway, HTTPRoute, TCPRoute, etc., as well as the Kubernetes Service resource - aim to evolve Kubernetes service networking through expressive, extensible, and role-oriented interfaces that are implemented by many vendors and have broad industry support.

![](https://gateway-api.sigs.k8s.io/images/api-model.png)

The Gateway API was originally designed to manage traffic from clients outside the cluster to services inside the cluster -- the ingress or north/south case. Over time, interest from service mesh users prompted the creation of the GAMMA initiative to define how the Gateway API could also be used for inter-service or east/west traffic within the same cluster.

If you're familiar with the older Ingress API, you can think of the Gateway API as analogous to a more-expressive next-generation version of that API.

## Gateway API for Ingress

When using the Gateway API to manage ingress traffic, the Gateway resource defines a point of access at which traffic can be routed across multiple contexts -- for example, from outside the cluster to inside the cluster (north/south traffic).

Each Gateway is associated with a GatewayClass, which describes the actual kind of gateway controller that will handle traffic for the Gateway; individual routing resources (such as HTTPRoute) are then associated with the Gateway resources. Separating these different concerns into distinct resources is a critical part of the role-oriented nature of the Gateway API, as well as allowing for multiple kinds of gateway controllers (represented by GatewayClass resources), each with multiple instances (represented by Gateway resources), in the same cluster.

## Gateway API for Service Mesh (the GAMMA initiative) ¶

Experimental in v0.8.0

The GAMMA initiative work for supporting service mesh use cases is experimental in v0.8.0. It is possible that it will change; we do not recommend it in production at this point.

Things are a bit different when using the Gateway API to manage a service mesh. Since there will usually only be one mesh active in the cluster, the Gateway and GatewayClass resources are not used; instead, individual route resources (such as HTTPRoute) are associated directly with Service resources, permitting the mesh to manage traffic from any traffic directed to that Service while preserving the role-oriented nature of the Gateway API.

To date, GAMMA has been able to support mesh functionality with fairly minimal changes to the Gateway API. One particular area that has rapidly become critical for GAMMA, though, is the definition of the different facets of the Service resource.

In Gateway API v0.8.0, GAMMA support for service mesh is experimental. We encourage working with it and providing feedback, but you must be prepared for change in the GAMMA APIs.

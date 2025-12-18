# **[Azure Application Gateway for containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[compare ingress options](https://learn.microsoft.com/en-us/azure/aks/concepts-network-ingress)**

## Azure Application Gateway for containers

Application Gateway for Containers is an application layer (layer 7) load balancing and dynamic traffic management product for workloads running in a Kubernetes cluster. It extends Azure's Application Load Balancing portfolio and is a new offering under the Application Gateway product family.

Application Gateway for Containers is the evolution of the **[Application Gateway Ingress Controller (AGIC)](https://learn.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview)**, a Kubernetes application that enables Azure Kubernetes Service (AKS) customers to use Azure's native Application Gateway application load-balancer. In its current form, AGIC monitors a **subset** of Kubernetes Resources for changes and applies them to the Application Gateway, utilizing Azure Resource Manager (ARM).

![alb](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/media/overview/application-gateway-for-containers-kubernetes-conceptual.png)**

For details about how Application Gateway for Containers accepts incoming requests and routes them to a backend target, see **[Application Gateway for Containers components](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/application-gateway-for-containers-components)**.

## Features and benefits

Application Gateway for Containers offers some entirely new features at release, such as:

- Traffic splitting / Weighted round robin
- Mutual authentication to the backend target
- Kubernetes support for Ingress and Gateway API
- Flexible deployment strategies
- Increased performance, offering near real-time updates to add or move pods, routes, and probes

## Is TLSRoute supported

The **[docs](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview#implementation-of-gateway-api)** say it is not currently supported.

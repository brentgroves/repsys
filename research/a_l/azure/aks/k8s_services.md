# **[Kubernetes Services in AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-network-services)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Kubernetes Services in AKS

Kubernetes Services are used to logically group pods and provide network connectivity by allowing direct access to them through a specific IP address or DNS name on a designated port. This allows you to expose your application workloads to other services within the cluster or to external clients without having to manually manage the network configuration for each pod hosting a workload.

You can specify a Kubernetes ServiceType to define the type of Service you want, e.g., if you want to expose a Service on an external IP address outside of your cluster. For more information, see the Kubernetes documentation on **[Publishing Services (ServiceTypes)](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)**.

The following ServiceTypes are available in AKS:

## ClusterIP

ClusterIP creates an internal IP address for use within the AKS cluster. The ClusterIP Service is good for internal-only applications that support other workloads within the cluster. ClusterIP is used by default if you don't explicitly specify a type for a Service.

![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-clusterip.png)

## NodePort

NodePort creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port.

![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-nodeport.png)

## LoadBalancer

LoadBalancer creates an Azure load balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool. To allow customers' traffic to reach the application, load balancing rules are created on the desired ports.

![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-loadbalancer.png)

For HTTP load balancing of inbound traffic, another option is to use an **[Ingress controller](https://learn.microsoft.com/en-us/azure/aks/concepts-network-ingress#ingress-controllers)**.

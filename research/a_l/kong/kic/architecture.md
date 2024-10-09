# **[Controllers](https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/architecture/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Architecture

The Kong Ingress Controller configures Kong Gateway using Ingress or Gateway API resources created inside a Kubernetes cluster.

Kong Ingress Controller enables you to configure plugins, load balance the services, check the health of the Pods, and leverage all that Kong offers in a standalone installation.

The Kong Ingress Controller does not proxy any traffic directly. It configures Kong Gateway using Kubernetes resources.

The figure illustrates how Kong Ingress Controller works:

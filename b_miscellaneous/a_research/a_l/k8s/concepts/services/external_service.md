# **[How to use a Kubernetes External Service](https://www.kubecost.com/kubernetes-best-practices/kubernetes-external-service/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

Kubernetes external services play a crucial role when you want your internal services (running in a Kubernetes cluster) to consume or interact with an external (outside the cluster) service or endpoint using a static name.

For instance, you might have an external database hosted by Amazon RDS, and within your application, you want to refer to this database by the name 'mysql,' not the whole URL provided by AWS. Kubernetes external services facilitate such requirements, providing a mechanism to map an external DNS name to a static name within your cluster.

This article will explain Kubernetes external services in depth and discuss strategies for utilizing them effectively in your environments, including five key configuration best practices and a hands-on walkthrough of creating and configuring a Kubernetes external service.

## Understanding Kubernetes external services

In Kubernetes, a 'service' is a stable way of accessing a group of Pods. Since Pods can frequently change - destroyed and recreated with new IP addresses - Services allow us to treat this group of Pods as a single, constant entity. This way, applications can reliably communicate without worrying about the underlying Pod changes.

There are four primary types of services in Kubernetes: ClusterIP, NodePort, LoadBalancer, and ExternalName.

| Service      | Summary                                                                                                                                                                                                                                            |
|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ClusterIP    | This is the default service type. Reachable only within the Kubernetes cluster, as it exposes the service on a cluster-internal IP.                                                                                                                |
| NodePort     | The service gets exposed on a static port on each Node’s IP. Accessible outside the cluster by calling [NodeIP]:[NodePort]. In creating a NodePort Service, Kubernetes also creates a ClusterIP service, which the NodePort service will route to. |
| LoadBalancer | Typically used by cloud providers, the service gets exposed externally using the cloud provider’s load balancer. When you create a LoadBalancer service, Kubernetes also creates a NodePort and ClusterIP Service.                                 |
| ExternalName | Instead of using a proxy, the service gets mapped to the contents of the externalName field (e.g., foo.example.com) by returning a CNAME record with its value.                                                                                    |

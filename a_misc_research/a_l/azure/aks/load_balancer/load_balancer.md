# **[Azure AKS Load Balancer](https://learn.microsoft.com/en-us/azure/aks/load-balancer-standard)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[vm load balancer example](https://faultbucket.ca/2020/06/understanding-azure-outbound-internet-and-load-balancer/)**
- **[secure by default](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview#securebydefault)**

## Use a public standard load balancer in Azure Kubernetes Service (AKS)

The Azure Load Balancer operates at layer 4 of the Open Systems Interconnection (OSI) model that supports both inbound and outbound scenarios. It distributes inbound flows that arrive at the load balancer's front end to the back end pool instances.

A public load balancer integrated with AKS serves two purposes:

- To provide outbound connections to the cluster nodes inside the AKS virtual network by translating the private IP address to a public IP address part of its Outbound Pool.
- To provide access to applications via Kubernetes services of type LoadBalancer, enabling you to easily scale your applications and create highly available services.

## Maintain the client's IP on inbound connections

By default, a service of type LoadBalancer in Kubernetes and in AKS doesn't persist the client's IP address on the connection to the pod. The source IP on the packet that's delivered to the pod becomes the private IP of the node. To maintain the client’s IP address, you must set service.spec.externalTrafficPolicy to local in the service definition. The following manifest shows an example.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  externalTrafficPolicy: Local
  ports:
  - port: 80
  selector:
    app: azure-vote-front
```

## Customizations via Kubernetes Annotations

The following annotations are supported for Kubernetes services with type LoadBalancer, and they only apply to INBOUND flows.

| Annotation                                                       | Value                               | Description                                                                                                                                                                            |
|------------------------------------------------------------------|-------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| service.beta.kubernetes.io/azure-load-balancer-internal          | true or false                       | Specify whether the load balancer should be internal. If not set, it defaults to public.                                                                                               |
| service.beta.kubernetes.io/azure-load-balancer-internal-subnet   | Name of the subnet                  | Specify which subnet the internal load balancer should be bound to. If not set, it defaults to the subnet configured in cloud config file.                                             |
| service.beta.kubernetes.io/azure-dns-label-name                  | Name of the DNS label on Public IPs | Specify the DNS label name for the public service. If it's set to an empty string, the DNS entry in the Public IP isn't used.                                                          |
| service.beta.kubernetes.io/azure-shared-securityrule             | true or false                       | Specify exposing the service through a potentially shared Azure security rule to increase service exposure, utilizing Azure Augmented Security Rules in Network Security groups.       |
| service.beta.kubernetes.io/azure-load-balancer-resource-group    | Name of the resource group          | Specify the resource group of load balancer public IPs that aren't in the same resource group as the cluster infrastructure (node resource group).                                     |
| service.beta.kubernetes.io/azure-allowed-service-tags            | List of allowed service tags        | Specify a list of allowed service tags separated by commas.                                                                                                                            |
| service.beta.kubernetes.io/azure-load-balancer-tcp-idle-timeout  | TCP idle timeouts in minutes        | Specify the time in minutes for TCP connection idle timeouts to occur on the load balancer. The default and minimum value is 4. The maximum value is 30. The value must be an integer. |
| service.beta.kubernetes.io/azure-load-balancer-disable-tcp-reset | true or false                       | Specify whether the load balancer should disable TCP reset on idle timeout.                                                                                                            |
| service.beta.kubernetes.io/azure-load-balancer-ipv4              | IPv4 address                        | Specify the IPv4 address to assign to the load balancer.                                                                                                                               |
| service.beta.kubernetes.io/azure-load-balancer-ipv6              | IPv6 address                        | Specify the IPv6 address to assign to the load balancer.                                                                                                                               |

## **[rate limit](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/rate-limiting-overview)**

I could not find information concerning rate limiting for AKS specifically.

# **[Seamless Network Setup in AKS with Application Gateway and Ingress Controller](https://medium.com/@luciferutkarsh/seamless-network-setup-in-aks-with-application-gateway-and-ingress-controller-38b6f3ef15d4)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

<https://learn.microsoft.com/en-us/azure/aks/load-balancer-standard#troubleshooting-snat>

## Seamless Network Setup in AKS with Application Gateway and Ingress Controller

In the world of Kubernetes, network configuration plays a crucial role in ensuring smooth communication between your applications and the outside world. When it comes to Azure Kubernetes Service (AKS), Microsoft’s managed Kubernetes offering, setting up networking can be a breeze with the right tools and techniques. In this blog post, we’ll explore how to leverage the power of Azure Application Gateway and the Application Gateway Ingress Controller to establish a robust and secure network architecture for your AKS cluster, complete with Terraform scripts and deployment files for easy implementation.

## Understanding Application Gateway and Ingress Controller

Azure Application Gateway is a fully managed load balancer service that provides advanced routing capabilities for web traffic. It acts as a reverse proxy, distributing incoming requests across multiple backend pools, including Kubernetes clusters. The Application Gateway Ingress Controller is an add-on component that integrates Application Gateway with your AKS cluster, enabling seamless routing of external traffic to your Kubernetes services.

## Setting up the Network with Terraform

Provisioning the AKS Cluster: Start by creating an AKS cluster using Terraform. Here’s an example Terraform script:

```terraform
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myakscluster"
  
  # Enable HTTP Application Routing
  addon_profile {
    http_application_routing {
      enabled = true
    }
  }
}```

This script provisions an AKS cluster and enables the “HTTP Application Routing” feature, which automatically deploys an Application Gateway and configures the necessary networking components.

Installing the Application Gateway Ingress Controller: Once the AKS cluster is up and running, install the Application Gateway Ingress Controller using a Kubernetes manifest file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ingress-appgw
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ingress-appgw
  template:
    metadata:
      labels:
        app: ingress-appgw
    spec:
      containers:
      - name: appgwingress
        image: mcr.microsoft.com/cosmosdb/kubernetes-ingress-azure-appgw:1.5
        env:
        # This value must match the name of the AKS cluster
        - name: APPGW_RESOURCE_GROUP
          value: my-aks-cluster-rg
        # This value must match the name of the Application Gateway
        - name: APPGW_NAME
          value: myaksgateway
        # This value must match the name of the AKS cluster
        - name: APPGW_SUBSCRIPTION_ID
          value: <your-subscription-id>
```

This manifest deploys the Application Gateway Ingress Controller in your AKS cluster and configures it to work with the Application Gateway deployed by the “HTTP Application Routing” feature.

Configuring DNS: To route traffic from your domain to the Application Gateway’s public IP address, you’ll need to create a DNS record pointing to the Application Gateway’s public IP. This can be done through your domain registrar or Azure DNS service. Here’s an example Terraform script for creating an Azure DNS record:

```terraform
resource "azurerm_dns_a_record" "appgw" {
  name                = "myapp"
  zone_name           = azurerm_dns_zone.mydomain.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_public_ip.appgw.ip_address]
}
```

Defining Ingress Resources: In Kubernetes, Ingress resources define the rules for routing external traffic to your services. Create Ingress resources specifying the hostname, paths, and backend services to which the traffic should be routed. The Application Gateway Ingress Controller will automatically translate these rules into Application Gateway configurations. Here’s an example Ingress resource:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
spec:
  rules:
  - host: myapp.mydomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

This Ingress resource routes all traffic to myapp.mydomain.com to the my-service Kubernetes service.

Securing with TLS/SSL: To enable secure communication over HTTPS, you can configure TLS/SSL termination on the Application Gateway. Upload your SSL/TLS certificate to the Application Gateway and configure the Ingress resources to use the secured paths. Here’s an example Ingress resource with TLS/SSL configuration:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - hosts:
    - myapp.mydomain.com
    secretName: my-tls-secret
  rules:
  - host: myapp.mydomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

## 1

This Ingress resource configures TLS/SSL termination on the Application Gateway, redirects HTTP traffic to HTTPS, and routes HTTPS traffic to the my-service Kubernetes service.

## Alternative Approach: NGINX Ingress Controller

If you prefer not to use the Application Gateway, you can opt for the NGINX Ingress Controller, an open-source solution for ingress management in Kubernetes. The NGINX Ingress Controller can be deployed in your AKS cluster and configured to route external traffic to your Kubernetes services.

Follow the official documentation for setting up the **[NGINX Ingress Controller in AKS](https://github.com/MicrosoftDocs/azure-docs/blob/90f41730b9836e89d3e53b44707109c32b5e52d0/articles/aks/ingress-basic.md)**. This approach involves creating an NGINX Ingress Controller deployment and configuring Ingress resources similar to the examples provided above.

## THIS may work

**[ingress with tls termination example](https://github.com/MicrosoftDocs/azure-docs/blob/90f41730b9836e89d3e53b44707109c32b5e52d0/articles/aks/ingress-own-tls.md)**

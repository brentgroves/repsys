# **[Managed NGINX ingress with the application routing add-on](https://learn.microsoft.com/en-us/azure/aks/app-routing)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Managed NGINX ingress with the application routing add-on

One way to route Hypertext Transfer Protocol (HTTP) and secure (HTTPS) traffic to applications running on an Azure Kubernetes Service (AKS) cluster is to use the Kubernetes Ingress object. When you create an Ingress object that uses the application routing add-on NGINX Ingress classes, the add-on creates, configures, and manages one or more Ingress controllers in your AKS cluster.

This article shows you how to deploy and configure a basic Ingress controller in your AKS cluster.

## Application routing add-on with NGINX features

The application routing add-on with NGINX delivers the following:

- Easy configuration of managed NGINX Ingress controllers based on Kubernetes NGINX Ingress controller.
- Integration with Azure DNS for public and private zone management
- SSL termination with certificates stored in Azure Key Vault.

For other configurations, see:

- **[DNS and SSL configuration](https://learn.microsoft.com/en-us/azure/aks/app-routing-dns-ssl)**
- **[Application routing add-on configuration](https://learn.microsoft.com/en-us/azure/aks/app-routing-nginx-configuration)**
- **[Configure internal NGIX ingress controller for Azure private DNS zone.]<https://learn.microsoft.com/en-us/azure/aks/create-nginx-ingress-private-controller>)**

With the retirement of **[Open Service Mesh (OSM)](https://release-v1-2.docs.openservicemesh.io/)** by the Cloud Native Computing Foundation (CNCF), using the application routing add-on with OSM is not recommended.

## Prerequisites

- An Azure subscription. If you don't have an Azure subscription, you can create a free account.
- Azure CLI version 2.54.0 or later installed and configured. Run az --version to find the version. If you need to install or upgrade, see Install Azure CLI.

## Limitations

- The application routing add-on supports up to five Azure DNS zones.
- The application routing add-on can only be enabled on AKS clusters with managed identity.
- All global Azure DNS zones integrated with the add-on have to be in the same resource group.
- All private Azure DNS zones integrated with the add-on have to be in the same resource group.
- Editing the ingress-nginx ConfigMap in the app-routing-system namespace isn't supported.
- The following snippet annotations are blocked and will prevent an Ingress from being configured: load_module, lua_package, _by_lua, location, root, proxy_pass, serviceaccount, {, }, '.

<https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id>

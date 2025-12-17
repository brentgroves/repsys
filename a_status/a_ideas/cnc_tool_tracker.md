# CNC Tool-Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

The following is in markdown format, which can be viewed better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Automatically collect CNC, job, and start/end tool operation times for problematic tooling.

Users: Albion Engineering and MRP

## Azure Resources

- **[Azure Kubernetes Service, 2nd best Kubernetes platform](https://azure.microsoft.com/en-gb/products/kubernetes-service)**
- **[Azure SQL database (fully managed cloud database)](https://azure.microsoft.com/en-us/products/azure-sql/database)**

## Managed Kubernetes Service

- **[Top 10 Managed K8s Platforms](https://technologymagazine.com/top10/top-10-managed-kubernetes-platforms)**

- **[Azure Kubernetes Service (AKS), 2nd best Kubernetes platform](https://azure.microsoft.com/en-gb/products/kubernetes-service)**

  I have been using this for a few years and what I notice most is that the applications running in it **never fail/restart**.

## Kubernetes Development/Test Platform

- **[Dell PowerEdge R620](https://www.itcreations.com/dell/dell-poweredge-r620-server#:~:text=The%20Dell%20PowerEdge%20R620%20server,need%20powerful%20processing%20and%20storage.)**
- **[Ubuntu Server 24.04](https://ubuntu.com/server)**
- **[Microk8s on Multipass VM](https://ubuntu.com/tutorials/getting-started-with-kubernetes-ha)**  

## Security

- **[Secure a database in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/secure-database-tutorial?view=azuresql)**
- **[Istio Service Mesh](https://istio.io/latest/docs/concepts/security/)**
  - **[authentication policies](https://istio.io/latest/docs/concepts/security/#authentication-policies)**
  - **[authorization policies](https://istio.io/latest/docs/concepts/security/#authorization-policies)**
  - **[secure naming information](https://istio.io/latest/docs/concepts/security/#secure-naming)**

## Kubernetes  

|Component   |Type   |Description   |
|---|---|---|
|**[Istio Service Mesh](https://istio.io/latest/docs/overview/what-is-istio/)**  | OSS   |**[Istioctl CLI](https://istio.io/latest/docs/setup/install/istioctl/)**   |
|**[Redis Sentinel One](https://www.einfochips.com/blog/redis-cache-and-its-use-cases-for-modern-application/)**   |OSS   |**[Redis Operator](https://medium.com/@khadkakripu4/leveraging-redis-sentinel-with-bitnami-redis-helm-chart-for-high-availability-in-kubernetes-a25d79e20e69)**   |
|**[Auth0 IAM Platform](https://www.weareplanet.com/blog/what-is-auth0#:~:text=Auth0%20is%20a%20platform%20companies,security%20and%20compliance%20much%20easier.)**  |Free Tier   |**[Register App with Azure Entra](https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2)**   |
|**[MongoDB](https://www.mongodb.com/company/what-is-mongodb)**   |OSS   |**[MongoDB Community Operator](https://www.mongodb.com/try/download/community-kubernetes-operator)**   |
|**[Minio Object Store](https://min.io/)**   |OSS   |**[Minio Operator](https://min.io/docs/minio/kubernetes/aks/operations/installation.html)**   |
|**[Mailtrap Email service](https://mailtrap.io/email-sending/)**  | Free Tier  |**[gRPC Microservice](https://grpc.io/docs/what-is-grpc/introduction/)**   |
|**[End-User Notification Platform](https://novu.co/)**  | Free Tier |**[Email, SMS, Push, Inbox, and Chat Notification Service](https://novu.co/)**  |

## Azure resources

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - ~ $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
  - Second resource group. When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - ~ $50/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

# IS Team Projects

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Purpose

- We need to shut down the Mobex Azure Tenant.

## Players

- Adrian Wise
- Kristian Smith
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall
- Kevin Young
- Jared Davis
- Dan Martin
- Heather Luttrell
- Jake Kunkel
- Nancy Swank
- Mike Percel
- Vladimir Chevtchenko
- Elden Maynard
## Projects

- Automatic end-user requestable Excel from Plex ERP
  - **[End-user request kicks off scripts to extract data from the Plex ERP, transforms it, and then loads the result into a database table in the data warehouse.](https://grpc.io/docs/what-is-grpc/introduction/)**
- **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**
  Move away managing tooling in Excel and the Busche Tool List to a more rubust and easy to use system.
- **[Tool Tracker](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**
  Automatically collect cnc,job, and start/end tool operation times for problematic tooling.
- INC0417507 - Excel to Power BI Transition
  Find a **[VBA Excel](https://www.datacamp.com/tutorial/vba-excel)** programmer to work on this for the immediate future.  For the long-term solution, I suggest we migrate this VBA Excel program to a Web App, SQL database, and Power BI. The downside to this suggestion is that it would take some time. The upside is that the Web App can perform validation on the dates and other information before being saved to the database. Using VBA it is easy to create complex programs to solve business needs quickly, but it is difficult to make these programs robust.

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

## Custom Software in K8s

- Automatic end-user requestable Excel from Plex ERP
  -  
  - **[End-user request kicks off 8 scripts to extract data from the Plex ERP, transforms it, and then loads the result into a database table in the data warehouse.](https://grpc.io/docs/what-is-grpc/introduction/)**
  - **[Work queue driven report runner](https://redis.io/glossary/redis-queue/)**  
- Future Plans
  - **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**
    - Replace Excel files and a legacy database.
    - Collect start/end times of tool operations with **[MES system](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**.
  - Excel to Power BI
    - Migrate problematic Excel dashboards to Power BI 

## Recommendation

- Brent Groves works with Aamir Ghaffar to create the Azure Kubernetes Cluster.
- Brent G. be given admin access to AKS until it is ready for use.

## Azure resources

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - ~ $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
  - Second resource group. When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - ~ $50/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.



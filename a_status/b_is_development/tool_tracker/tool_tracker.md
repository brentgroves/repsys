# Tool Management and Tracking

The following is in markdown format, which can be viewed better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

Good Morning, Team,

Here are two suggestions that pertain to our custom **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**, and Tool-Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** developed by the Structures Information System team.  Thank you.

Players:

- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor

1. Database access to vending machines.

When purchasing tool vending machines, please think about asking for programmatic access to the SQL database.

Reason: We can compare the tooling in our vending machines with our tool management database. This will help us identify tooling that is not in our vending machines and tooling no longer needed.

Details: When we owned our vending machines, we were able to sync the vending machines with the Busche reporter by running nightly scripts. The process was as follows:

- The engineers entered detailed information about job tooling.  
- The engineering managers approved job tooling changes.
- The MPR personnel, Nancy Swank, was notified of the changes.
- The tool changes were propagated to our vending machines.

2. Consider including the cost of adding network data collection support to CNC when quoting jobs.

Reason:  We will be able to report on tool operation times by job, CNC, and date/time.  Our tool tracking software will not have all the features of expensive software such as **[Predator DNC software](https://www.predator-software.com/predator_dnc_software.htm)**, but it will be good enough to identify tooling issues.

Details: Okuma CNCs have a serial port, which is perfect for collecting data by adding a small change to GCode at the start and end of each tool operation. The only additional cost incurred is an inexpensive **[serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** and running a network cable to each CNC.

For Fanuc-based CNC, a more expensive network module must be purchased to achieve the same result. We have successfully tested a preliminary version of our tool tracking software on Knuckles and RDX jobs running on Okuma CNC. We started testing our custom tool tracking software on a couple of Avilla's Fanuc-based CNC, which worked by monitoring tool counter changes and some additional parameters.

- **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**

  Move away from managing CNC tooling in Excel and the Busche Tool List to a more rubust and easy to use system.
  - Users: Albion MRP and Engineering
  - Estimated completion: TBD
- **[Tool Tracker](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.
  - Users: Albion Engineering and MRP
  - Estimated completion: TBD
- **INC0417507 - Excel VBA to Power BI**

  I suggest we migrate this VBA Excel program to a Web App, SQL database, and Power BI. The downside to this suggestion is that it would take some time. The upside is that the Web App can perform validation on the dates and other information before being saved to the database. Using VBA it is easy to create complex programs to solve business needs quickly, but it is difficult to make these programs robust.
  - Estimated completion: TBD

- Linus **[Platform](https://platformengineering.org/blog/what-is-platform-engineering)** and **[Site Reliability Engineering (SRE)](https://aws.amazon.com/what-is/sre/#:~:text=Site%20reliability%20engineering%20(SRE)%20teams%20collect%20critical%20information%20that%20reflects,application%20responds%20to%20a%20request.)**
  
  - Research and make recommendations to improve platform reliability.
  - Use MicroK8s on-prem cluster for research and testing.
  - Show **[security](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)**
    and reliability of **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks#:~:text=Azure%20Kubernetes%20Service%20(AKS)%20is,of%20that%20responsibility%20to%20Azure.)**.
  - **[Istio Service Mesh SRE monitoring](https://sysdig.com/blog/monitor-istio/)**

    ![isre](https://sysdig.com/wp-content/uploads/image8-6.png)

    - Users: Linus recommendation.
    - Estimated completion: TBD

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

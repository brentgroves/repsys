# IS Team Projects

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

Good Morning, Team,

This is a revised project summary and timeline for the Automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** Reporting System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** that the Structures Information System team is working on. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River. If it meets the approval of Kevin Young and other team members, I would like to add this timetable and summary, or a curtailed version, to the Structures IT Team Meetings and the Albion/Avilla project status tracking systems. Thank you.

Players:

- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Dan Martin, Plant Controller Southfield
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor

The following is in markdown format. It can be viewed better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

## Structures Information System Project Summary

## 1. Avilla Structures **[Kubernetes](https://www.turing.com/blog/importance-of-kubernetes-for-devops)**, K8s, On-Prem and Cloud Platform Services

Set up the cloud-based and low-cost Avilla Structures on-prem virtual machines to provide basic platform services needed by Information Systems projects.

### Platform Services

- **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)**
- **[Zero-Trust Service Mesh Gateway](https://istio.io/latest/about/service-mesh/)**
- **[Job Queue](https://www.ibm.com/think/topics/redis#:~:text=Redis%20(REmote%20DIctionary%20Server)%20is,speed%2C%20reliability%2C%20and%20performance.)**
- **[Email service](https://mailtrap.io/email-sending/)**
- **[SMS Notification Service](https://novu.co/)**

### Platform Services Status

- Time: 3 months
- Due date: July 2025

## 2. Automated Report System

Software system to automate the creation of live or long-running reports, Power BI dashboards, and Excel in the Plex ERP and extended service platforms.

### Automated Report System Scope

User request kicks off scripts to extract data from the Plex ERP and extended services, transform the data, and then load the result into our data warehouse for event monitoring and reporting.

### Automated Report System Users

Anyone needing live or long-running Plex ERP or extended services reports, Excel, and Power BI dashboards.

### Automated Report System Status

Recently, approved for Azure resources needed for this project. Currently, configuring an Avilla On-Prem Kubernetes Cluster for on-site data collection and as a low-cost alternative for Structures Information System projects.

- Time: 3 months
- Due date: Nov 2025

## 3. Tool Management System

Move from managing CNC tooling in Excel and the Legacy Busche Tool List system to a modern, more robust, and easy-to-use platform.

### Tool Management Users

- Albion MRP and Engineering
- Possibly Mills River

### Tool Management Status

- Time: 6 months
- Due date: Jun 2026

## 4. Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

### Tool Tracker Scope

Automatically collect and report on CNC, job, and start/end tool operation times for problematic tooling.

### Tool Tracker Users

- Albion Engineering and MRP
- Possibly Mills River

### Tool Tracker Status

- Time: 6 months
- Due date: November 2027

## Project Details

- **[Avilla Structures redundant on-prem MAAS, MicroStack, Structures MicroK8s Clusters for Automated Reporting, Tool Management System, and Tool Tracker MES](https://canonical.com/microstack/docs/multi-node-maas)**

  MicroStack MAAS is a combination of MicroStack and MAAS (Metal as a Service) that allows for network traffic isolation and cloud deployment. MicroStack is an OpenStack distribution that's designed for small-scale cloud environments. MAAS is a tool that allows users to control pools of physical servers like virtual machines in the cloud.

  Tasks:
  - **[Setup Virtual Private Switch and Router](https://maas.io/docs/maas-in-thirty-minutes)**
  
    Inside the VM, Multipass will use LXD and Linux configuration to build a virtual private switch and router, and provide a way to create what are called “nested VMs”, or virtual machines inside the virtual machine made by Multipass. These nested VMs will represent servers that MAAS can provision.

  ![vps](https://assets.ubuntu.com/v1/6e132859-MAAS+tutorial+diagram-02.svg)
  
  Timeline: Start setup 10 Feb when unrestricted internet access is scheduled.

- Automated Reporting System
  - End-user request kicks off scripts to extract data from the Plex ERP, transforms it, and then loads the result into a database table in the data warehouse.
  - Produce Excel, archive result set, and email to end user.
  - Used for reports requiring long running scripts or live data.
  - Used to enable the creation of PowerBI dashboards for Plex ERP.

  Users: Anyone needing live or long running reports, Excel, or Power BI dashboards.

  Status: Recently, got approval for Azure resources needed for this project.

  Timeline:

  - Test TB report scripts and Power BI report on Linamar Azure SQL DB.
  - Setup Azure Kubernetes Platform with general purpose services such as **[mTLS](https://www.cloudflare.com/learning/access-management/what-is-mutual-tls/#:~:text=Mutual%20TLS%2C%20or%20mTLS%20for,have%20the%20correct%20private%20key.)**, **[service mesh](https://aws.amazon.com/what-is/service-mesh/#:~:text=A%20service%20mesh%20is%20a,with%20multiple%20service%20management%20systems.)**, **[authentication, and authorization](https://auth0.com/docs/get-started/auth0-overview#:~:text=Auth0%20is%20a%20flexible%2C%20drop,delivered%20by%20email%20or%20SMS.)**, **[email delivery](https://mailtrap.io/)**, **[notification system](https://novu.co/)**, and **[site reliability engineering monitoring](https://sysdig.com/blog/monitor-istio/)**.
    - Estimated completion: May

  - Create **[ETL scripts](https://www.sas.com/en_us/insights/data-management/what-is-etl.html#:~:text=ETL%20is%20a%20method%20of,and%20programmatic%20data%20movement%20methods.%20.)** and **[microservices](https://aws.amazon.com/microservices/#:~:text=Microservices%20are%20an%20architectural%20and,to%2Dmarket%20for%20new%20features.)** to automate report requests using the platform services discussed above.
    - Estimated completion: Sept

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

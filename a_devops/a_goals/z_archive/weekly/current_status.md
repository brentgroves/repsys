# Status

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

## AI Overview: **[Linux Namespaces](https://linux-blog.anracom.com/2017/10/30/fun-with-veth-devices-linux-bridges-and-vlans-in-unnamed-linux-network-namespaces-i/)**

Linux namespaces were created to provide process isolation by allowing processes to have their own, separate view of system resources, enabling the creation of lightweight, self-contained environments, which forms the basis of containerization technologies like Docker.

## AI Overview: **[Kubernetes](https://www.ibm.com/think/topics/kubernetes-history)**

Kubernetes was created to address the challenges of managing and orchestrating containerized applications, especially in large-scale, distributed environments, by automating deployment, scaling, and management, building upon Google's internal system Borg.

## Next

- Ask Jared to review Dell PowerEdge Network Config request.

## Informational

- MRP is transitioning from MSC vending machines and are anxious about the tool management system.
- We manually run scripts to update the data warehouse that Power BI reports use as its data source.  The automated report system could be used to to run the scripts automatically.

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

Purpose: Provide and Support Platform Services common to all Microservices.

### AI Overview: Platform Engineering

A platform engineer designs, builds, and maintains the internal developer platform (IDP) that enables software engineering teams to have self-service capabilities, streamlining development processes and improving developer experience.

- **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)**
- **[Zero-Trust Service Mesh Gateway](https://istio.io/latest/about/service-mesh/)**
- **[Job Queue](https://www.ibm.com/think/topics/redis#:~:text=Redis%20(REmote%20DIctionary%20Server)%20is,speed%2C%20reliability%2C%20and%20performance.)**
- **[Email service](https://mailtrap.io/email-sending/)**
- **[SMS Notification Service](https://novu.co/)**

- Time: 3 months
- Due date: July 2025

### K8s Network configuration Tasks

Purpose: Make K8s accessible and fast.
Request: Please update all 3 PowerEdge R620s at our Avilla location with a **[DELL Mt09V Broadcom 57800S Quadport Sfp+ Rack Converged Network Daughter Card](https://www.ebay.com/itm/DELL-Mt09V-Broadcom-57800S-Quadport-Sfp-Rack-Converged-Network-Daughter-Card/303465861553?epid=1622568435&hash=item46a7f991b1:g:wlEAAOSw5eNeMc9-)** to support two 10GB SPF+ modules.  Then connect to the extreme core switches in a bond configuration to the Fortigate Firewall pair.  Then configure the bonded pair in trunk mode on VLANs 50 and 220.

- MicroK8s install internet access testing on r620_202.
- MicroCloud install on r620_201,r620_203.
- Working with Justin L. to get needed internet access.
- Created MicroK8s VLAN github bug report.
Compiled a resource list to help us troubleshoot Kubernetes issues.

- Time: Ongoing
- Due date: NA

### Azure SQL database

- Modify TB scripts to work on the Azure SQL db running on Linamar's tenant.
- transfer report system schema from Mobex tenant
- test scripts on Linamar Azure tenant SQL database

time: 1 month
due date: June 2025

## Structures Information Systems, Kubernetes, or K8s, Platform Trouble-Shooting and Observability

Purpose: Kubernetes is a great place to run software securely.  On the downside, it is also a complex system, so it is good to understand how it works to fix issues as best we can.

## AI Overview: What Is Kubernetes Observability?

Kubernetes observability is the process of gaining insight into the behavior and performance of applications running on Kubernetes, as well as the underlying infrastructure and components, in order to identify and resolve issues more effectively. It can help ensure the stability and performance of Kubernetes workloads, reduce downtime and outages, and improve efficiency.

### Research

- **[K3s code](https://github.com/k3s-io/k3s)**
- **[Visual Studio Code extion for k8s](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)**
- **[Azure Kubernetes](https://learn.microsoft.com/en-us/azure/aks/)**
- **[Build MicroK8s](https://github.com/canonical/microk8s/blob/master/docs/build.md)**
- **[Configure Services](https://microk8s.io/docs/configuring-services)**
- **[Configuring CNI](https://microk8s.io/docs/change-cidr)**
Given our complex network, start learning this networking part of K8s.
- **[Configuring Host Interfaces](https://microk8s.io/docs/configure-host-interfaces)**

- Time: Ongoing
- Due date: NA

## Structures Information System Certificate Management Support

1. create server certificate for fruitport mach2 server
2. install certificate chain on jboss server
3. verify jboss is serving certificate chain
4. Give intermediate and root CA certificate to Matt Irey and David Maitner.
5. update thin clients one by one.
6. create server and client certificates for Structure Avilla Kubernetes Cluster.

time: 1 month, initial setup
due date: June 2025
recurrence: yearly

## IS Projects

### Automated Report System

- Request kicks off scripts to extract data from the Plex ERP, transform it, and then load the result into a database table in the data warehouse.
- Produce Excel, archive result set, and email to end user.
- Used for reports requiring long-running scripts or live data.
- Used to enable the creation of PowerBI dashboards for Plex ERP.

  Users: Anyone needing live or long-running reports, Excel, or Power BI dashboards.
  Status: Recently, approved for Azure resources needed for this project.

  time: 3 months
  due date: Nov 2025

### Tool Management System

  Move from managing CNC tooling in Excel and the Busche Tool List to a more robust and easy-to-use system.

  Users: Albion MRP and Engineering
  Hayley and someone else has an existing system.

- Albion is transitioning to a new vending machine and currently has older tool lists in a legacy database and newer tool lists in Excel.
- The Structures Information Systems team is scheduled to update the Busche Reporter legacy tool management system. If an existing system is available we could use it and possibly add some additional features listed below.
- We were planning to run it on the Structures Avilla Kubernetes Cluster so that we can use **[Kubernetes Observability features](https://www.cloudbolt.io/blog/kubernetes-observability#:~:text=Kubernetes%20observability%20is%20essential%20for,pinpoint%20issues%20when%20they%20arise.)**  and make available the following Platform services.

## Tool Management System Feature List

- CNC engineers use it to manage job tooling.
- Engineering managers use it to approve job tooling.
- MRO personnel are notified by it of new tooling to stock.
- ERP and Vending Machines integration with our automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** reporting system.
- Since it is integrated with our vending machines and **[Plex ERP system](https://www.plex.com/products/enterprise-resource-planning)** we can report which tooling is needed to fulfill job orders.
- Since it stores all data in a centralized data warehouse we can link it with data collected by our tool-focused **[MES](http://ibm.com/think/topics/mes-system#:~:text=The%20primary%20purpose%20of%20an,the%20status%20of%20production%20activities.)** system to track tooling issues in real-time.
- It leverages platform services provided by the Structures Avilla Kubernetes Cluster such as **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)** and **[Email service](https://mailtrap.io/email-sending/)**.

  time: 6 months
  due date: Jun 2026

### Tool Tracker MES

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.
  Users: Albion Engineering and MRP
  time: 6 months
  due date: Jun 2027

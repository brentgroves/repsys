# Status

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

## **[Start Here](../k8s/menu.md)**

## Informational

- MRP is transitioning from MSC vending machines and are anxious about the tool management system.
- We manually run scripts to update the data warehouse that Power BI reports use as its data source.  The automated report system could be used to to run the scripts automatically.

## AI Overview: **[Linux Namespaces](https://linux-blog.anracom.com/2017/10/30/fun-with-veth-devices-linux-bridges-and-vlans-in-unnamed-linux-network-namespaces-i/)**

Linux namespaces were created to provide process isolation by allowing processes to have their own, separate view of system resources, enabling the creation of lightweight, self-contained environments, which forms the basis of containerization technologies like Docker.

## AI Overview: **[Kubernetes](https://www.ibm.com/think/topics/kubernetes-history)**

Kubernetes was created to address the challenges of managing and orchestrating containerized applications, especially in large-scale, distributed environments, by automating deployment, scaling, and management, building upon Google's internal system Borg.

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

Purpose: Provide and Support Platform Services common to all K8s Microservices.

### AI Overview: Platform Engineering

A platform engineer designs, builds, and maintains the internal developer platform (IDP) that enables software engineering teams to have self-service capabilities, streamlining development processes and improving developer experience.

### Structures Information System Certificate Management Support

#### For all sites Mach2 Server

- create server certificate for each mach2 server
- install certificate chain on jboss server
- create Network config request to temporarily allow platform engineer access to Fruitport's OT network for certificate testing.
- verify jboss is serving structures certificate chain
- give intermediate and root CA certificate to DST to create a new image to deploy to each Wise thin client

#### For Structures Avilla On-Prem Kubernetes Cluster

- create server and client certificates using Structure's **[PKI](https://www.digicert.com/faq/trust-and-pki/why-is-pki-important-and-how-does-it-increase-trust#:~:text=Public%20Key%20Infrastructure%20(PKI)%20is,authentication%2C%20and%20data%20access%20control.)**.
- configure Istio Gateway for **[mTLS](https://www.f5.com/labs/learning-center/what-is-mtls#:~:text=Mutual%20Transport%20Layer%20Security%20(mTLS)%20is%20a%20process%20that%20establishes,parties%20from%20imitating%20genuine%20apps.)** using server and client certificates.
- create GPO to deploy structures certificate chain and client certificate to endusers laptops.

### Azure Managed **[Kubernetes](https://www.turing.com/blog/importance-of-kubernetes-for-devops)**, AKS, Cluster

- Automate Structures public kubernetes cluster certificate management process with the **[Automated Certificate Management Environment (ACME) protocol](https://www.keyfactor.com/blog/what-is-acme-protocol-and-how-does-it-work/)** and the **[Let's Encrypt](https://letsencrypt.org/#:~:text=Let's%20Encrypt%20is%20a%20Certificate,demonstrate%20control%20over%20the%20domain.)** certificate authority.

- request public key to allow TXT records to be programatically inserted into Linamar mail server.
- configure istio gateway for TLS termination using the Let's Encrypt and the ACME protocol.

### Avilla Structures On-Prem **[Kubernetes](https://www.turing.com/blog/importance-of-kubernetes-for-devops)**, MicroK8s Cluster Configuration

- **[Connect Dell PowerEdge servers](./b_platform_engineering/c_network_support/bonded_10GB_connection.md)** to extreme core switches with 10GB SPF+ modules in truck mode to VLANs 50 and 220.

### Azure Managed **[Kubernetes](https://www.turing.com/blog/importance-of-kubernetes-for-devops)**, AKS, Cluster Configuration

- create EntraId group

### Setup Kubernetes Platform Services

- **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)**
- **[Zero-Trust Service Mesh Gateway](https://istio.io/latest/about/service-mesh/)**
- **[Job Queue](https://www.ibm.com/think/topics/redis#:~:text=Redis%20(REmote%20DIctionary%20Server)%20is,speed%2C%20reliability%2C%20and%20performance.)**
- **[Email service](https://mailtrap.io/email-sending/)**
- **[SMS Notification Service](https://novu.co/)**

### Azure SQL database

- Modify TB scripts to work on the Azure SQL db running on Linamar's tenant.
- transfer report system schema from Mobex tenant
- test scripts on Linamar Azure tenant SQL database

### Kubernetes Trouble-Shooting

Purpose: Kubernetes is a great place to run software securely.  On the downside, it is also a complex system, so it is good to understand how it works to fix issues as best we can.

- **[0pen vswitch](https://medium.com/@ozcankasal/understanding-open-vswitch-part-1-fd75e32794e4)**
- **[K3s code](https://github.com/k3s-io/k3s)**
- **[Visual Studio Code extion for k8s](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)**
- **[Azure Kubernetes](https://learn.microsoft.com/en-us/azure/aks/)**
- **[Build MicroK8s](https://github.com/canonical/microk8s/blob/master/docs/build.md)**
- **[Configure Services](https://microk8s.io/docs/configuring-services)**
- **[Configuring CNI](https://microk8s.io/docs/change-cidr)**
Given our complex network, start learning this networking part of K8s.
- **[Configuring Host Interfaces](https://microk8s.io/docs/configure-host-interfaces)**

### Kubernetes Observability

## AI Overview: What Is Kubernetes Observability?

Kubernetes observability is the process of gaining insight into the behavior and performance of applications running on Kubernetes, as well as the underlying infrastructure and components, in order to identify and resolve issues more effectively. It can help ensure the stability and performance of Kubernetes workloads, reduce downtime and outages, and improve efficiency.

- Setup basic logging
- Setup **[Prometheus system monitoring and alerting](https://prometheus.io/docs/introduction/overview/)**
- Setup **[Grafana data visualization and monitoring platform](https://grafana.com/)**

### Transition from Multipass to MicroCloud

- **[Micro-Cloud](https://canonical.com/microcloud)**
- **[LXD]()**
- **[Ceph Storage]()**

Ceph has become a de facto standard for open-source storage solutions. It provides interfaces for several storage types (block, file and object) within a single cluster, eliminating the need for multiple storage solutions. It is scalable and reliable, making it the perfect solution for any cloud.

- **[OVN]()**

OVN is a trusted open source software-defined networking solution. It provides virtual network abstractions, such as virtual L2 and L3 overlays, security groups, DHCP and other networking services. It was designed to support highly scalable and production-grade implementations.

Open Virtual Network (OVN) builds upon Open vSwitch (OVS) to provide a higher-level abstraction for virtual networks, offering features like virtual L2 and L3 overlays and security groups, while OVS handles the underlying packet forwarding.

- **[0pen vswitch](https://medium.com/@ozcankasal/understanding-open-vswitch-part-1-fd75e32794e4)**
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

## CNC tool adjustment app

Purpose: To have an electronic alternate to color printer cmm reports.

### Process

- Send CMM output to database include CNC, feature, out of spec info.
- Tool Setter subscribes to CNC CMM reports from mobile app.
- Tool Setter updates the mobile app tool adjustments made.
- Since all CMM report data and tool adjustments are recorded in a database they are easily viewable.

### Feature Set

- tablet app contains cmm report data.
- tool setter updates app with offset made.

time: 6 months
due date: unknown

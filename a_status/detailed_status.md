# Status

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

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

- **[Set up MySQL InnoDB Cluster](https://medium.com/@aaxsh/mysql-innodb-cluster-bdba9af61b79#:~:text=InnoDB%20Cluster%20is%20a%20high%20availability%20solution,Master%20Server%20to%20the%20MySQL%20Workers%20Servers.)**
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

## IS Projects

### Automated Report System

- Move schema from Mobex Azure SQL MI to the Linamar Azure SQL DB.
- Write scripts to compare Mobex Azure SQL result sets to Linamar Azure SQL DB result set.
- Create a new set of **[ETL](https://www.getdbt.com/blog/extract-transform-load)** scripts that work on the Linamar Azure SQL DB.
- Create a new set of **[ETL](https://www.getdbt.com/blog/extract-transform-load)** scripts that use two data sources for the Structures Avilla Kubernetes Cluster MySQL InnoDB Cluster and the Azure SQL DB.
- Create the ETL script runner microservice.

### Tool Management System

- Add the Plex supply item number to the new vending machines.
- Add tool list support.
- Add Engineering manager approvals.
- Add MRO personnel notifications of tooling change requests.
- Work on ERP and Vending Machines integration with our automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** reporting system.
- Create tooling reports based job orders in ERP.

### Tool Tracker MES

- Add Tool Tracker DB schema to data sources.
- Insert GCode changes into Okuma RDX line.  
- Configure and connect Moxa Serial device server to RDX line.
- Configure Kubernetes network to access Albion OT network.

## CNC tool adjustment app

- Send CMM output to database include CNC, feature, out of spec info.
- Tool Setter subscribes to CNC CMM reports from mobile app.
- Tool Setter updates the mobile app tool adjustments made.
- Since all CMM report data and tool adjustments are recorded in a database they are easily viewable.
- tablet app contains cmm report data.
- tool setter updates app with offset made.

time: 6 months
due date: unknown

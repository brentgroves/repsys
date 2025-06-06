# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## K8s Support

- MicroK8s install
- Working with Justin L. to get needed internet access.
- Created MicroK8s VLAN github bug report.
Compiled a resource list to help us troubleshoot Kubernetes issues.

- K3s and K8s upstream github
- **[Build and Debug MicroK8s](https://github.com/canonical/microk8s/blob/master/docs/build.md)**
- **[Configure Services](https://microk8s.io/docs/configuring-services)**
- **[Configuring CNI](https://microk8s.io/docs/change-cidr)**
Given our complex network start learning this networking part of K8s.
- **[Configuring Host Interfaces](https://microk8s.io/docs/configure-host-interfaces)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

## Informational

MRP is transitioning from MSC vending machines and are anxious about the tool management system.

## Avilla Structures K8s Server Setup

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## IS Support

## Azure SQL database

- Modify TB scripts to work on the Azure SQL db running on Linamar's tenant.
- transfer report system schema from Mobex tenant
- test scripts on Linamar Azure tenant SQL database

time: 1 month
due date: June 2025

## OT provisioning support

## Certificate Management Support

1. create server certificate for fruitport mach2 server
2. install certificate chain on jboss server
3. verify jboss is serving certificate chain
4. Give intermediate and root CA certificate to Matt Irey and David Maitner.
5. update thin clients one by one.

## Avilla Structures K8s

- Avilla Structures K8s deployment
- Azure K8s deployment

Network Configuration and Platform Services:

- Service Mesh Gateway
- App Notification
- Email service

time: 3 months
due date: June 2025

## IS Projects

## Automated Report System

- Request kicks off scripts to extract data from the Plex ERP, transform it, and then load the result into a database table in the data warehouse.
- Produce Excel, archive result set, and email to end user.
- Used for reports requiring long-running scripts or live data.
- Used to enable the creation of PowerBI dashboards for Plex ERP.

  Users: Anyone needing live or long-running reports, Excel, or Power BI dashboards.
  Status: Recently, approved for Azure resources needed for this project.

  time: 3 months
  due date: Nov 2025

## Tool Management System

  Move from managing CNC tooling in Excel and the Busche Tool List to a more robust and easy-to-use system.

  Users: Albion MRP and Engineering

  time: 6 months
  due date: Jun 2026

## Tool Tracker MES

  Automatically collect CNC, job, and start/end tool operation times for problematic tooling.
  Users: Albion Engineering and MRP
  time: 6 months
  due date: Jun 2027

## Research

- **[Setting Up Virtual Machines with QEMU, KVM, and Virt-Manager on Debian/Ubuntu](https://linuxconfig.org/setting-up-virtual-machines-with-qemu-kvm-and-virt-manager-on-debian-ubuntu)**
- **[Linux VLAN Filtering](https://www.youtube.com/watch?v=a8ghZoBZcE0&list=PLmZU6NElARbZtvrVbfz9rVpWRt5HyCeO7&index=3)**

## Azure Solution for for Automated Reporting, Tool Management System, and Tool Tracker MES

- Test TB report scripts and Power BI report on Linamar Azure SQL DB.
- Azure AKS
  - create Microsoft Entra K8s Admin Group (done)
  - create K8s cluster
    - deploy Istio Service Mesh Gateway

## **[Avilla Structures redundant on-prem MAAS, MicroStack, Structures MicroK8s Clusters for Automated Reporting, Tool Management System, and Tool Tracker MES](https://canonical.com/microstack/docs/multi-node-maas)** On-Prem Kubernetes Cluster

### 2 Physical Network interfaces to different vlan's goes against Linamar policy

After discussing the network requirements with Justin Langille, I am disconnecting the 2nd network interface, since it is against Linamar's network policies. Also, I have changed the Avilla Structures Kubernetes Cluster from the OT to Server vlan. For the requirement of connecting to the UDP serial device servers connected to CNC in the OT vlan I am creating a 2nd Kubernetes cluster on the OT vlan and can either insert records into a mysql database running in the 2nd cluster or insert them into our Azure SQL db for easier access by reporting software.

### 1 physical network interface configured to carry traffic from multiple vlans is allowed

In this configuration vlan tagging must be done by the host or server.

"Switch trunk mode" refers to a configuration on a network switch where a specific port can carry traffic from multiple VLANs (Virtual Local Area Networks) simultaneously, allowing data from different VLANs to be transmitted over a single physical link, essentially acting like a "trunk" to carry multiple data streams at once; this is in contrast to an access port which is dedicated to only one VLAN.

- making a docker base image that is able to connect to data sources. This is tricky. We can then use this base image in other specific docker images that need access to our data sources.
- **[Avilla OnPrem K8s Gateway Network](../../datacenter/avilla/network_configuration.md)**
- Noticed that Linar Network routes traffic by assigning the 10.*.*.254 address as the default route. These 254 addresses are located on the Fortigate switch which maintains all Firewall rulesets. Can add multiple network interfaces to host which is each assigned an address on a different vlan and use Linux local routing table to access both networks.
- eno1 - vlan 10.188.220.0
  - access moxa serial device server
- eno2 - vlan 10.188.50.0
  - access from other vlan
  - local router port forward to istio service mesh gateway.
- en03 - private 10.1.10.x k8s network
- vm adds tap device to mpqemubro bridge which mp has setup routing outgoing traffic using nat to change source address to 10.188.220.200 which has been given access to internet domains k8s needs for production. Only on config request needs completed for all vms.
- vm created on r620 use mpqemubr0
- everyone can access 10.188.70.0 and then use iptables to nat/port forward to the reporing system microservices.

## **[IS Projects](../is_projects/is_projects.md)**

## Next Steps

- **[How to add In-App notifications to any web app!](https://dev.to/novu/how-to-add-in-app-notifications-to-any-web-app-1b4n)**
- **[DevOps Concepts: Pets vs Cattle](https://joachim8675309.medium.com/devops-concepts-pets-vs-cattle-2380b5aab313)**
- Test run TB from Azure SQL db.
- To enable **[Azure managed identity authentication for Kubernetes clusters with kubelogin](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)** we need to create a **[Microsoft Entra group](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-create-eligible?tabs=admin-center)** and add Brent Groves and Kevin Young as a member or owner of the group.
Azure - Linamar Structures – repsys.
Members of the group are Brent Groves and Kevin Young.  

- Add HOME IP to firewall rules.
- We will need a config request submitted with the **[firewall config form](https://linamarcorporation.sharepoint.com/:w:/r/sites/FITS/_layouts/15/Doc.aspx?sourcedoc=%7B4ECE7AB5-ABFD-4A82-9D68-3EFB22638688%7D&file=Firewall%20Config%20Request%20Form.docx&action=default&mobileredirect=true)** filled out. Make request to allow inbound/outbound connections to odbc.plex.com and test.odbc.plex.com on port 19995.
- Verified access to Linamar tenant.
- Create minimal Azure SQL DB from MI.
- Imported repsys linamar database from last backup.
- Point TB scripts to new database and test.
- Price savings.

- Continue research of Tun/Tap device in golang.
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](../../../research/a_l/istio/cert_manager/secure_microservices_istio.md#install-cert-manager)**
- **[Azure resources next steps](../azure_resources/next_steps.md)**
- **[Kubernetes VLAN request](../k8s_vlan/k8s_vlan.md)**
- **[Monitoring Istio on AKS with Prometheus and Grafana](https://hshahin.com/monitoring-istio-on-aks-with-prometheus-and-grafana/)**

- Read **[Run Kubernetes in Azure the Cheap Way](https://trstringer.com/cheap-kubernetes-in-azure/)** for more cost saving tips.
- **[Godaddy to Route53](https://medium.com/@rivera5656/migrating-a-domain-from-godaddy-to-aws-route-53-using-terraform-e12f3dec24bc)**
- **[Busche Tool List and Azure SQL with firewall IP](../azure_resources/azure_toollist.md)**
- Register Web App
- **[Basic Go Web App](https://go.dev/doc/articles/wiki/)**
- **[Basic Go Web App with HTMLX](https://coderonfleek.medium.com/htmx-go-build-a-crud-app-with-golang-and-htmx-081383026466)**
- **[auth0 golang login](https://auth0.com/docs/quickstart/webapp/golang/01-login)**
- **[auth0 flask login](https://auth0.com/docs/quickstart/webapp/python/interactive)**
- **[auth python library](https://authlib.org/)**
- **[Istio and Keycloak](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)**
- **[Tailwind.css](https://tailwindcss.com/)**
- **[Flask render_templates](https://www.tutorialspoint.com/flask/flask_templates.htm)**
- **[Let's Encrypt with Istio](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[gorilla mux](https://curity.io/resources/learn/go-api/)**
- **[crud with golang and htmx](https://coderonfleek.medium.com/htmx-go-build-a-crud-app-with-golang-and-htmx-081383026466)**
- **[Microservices with go and grpc](https://dev.to/nikl/building-production-grade-microservices-with-go-and-grpc-a-step-by-step-developer-guide-with-example-2839)**
- **[Graph QL in Golang](https://gqlgen.com/getting-started/)**
- **[Web Server](https://h2o.examp1e.net/)**

## **[Service Now Tickets](../service_now/menu.md)**

## **[Report System Service](../../report_system/report_system.md)**

## **[Research Topics](../../../research/topics/research_summary.md)**

### **[Purpose of Kubectl Rollout Restart](../../../research/a_l/k8s/kubectl/rollout.md)**

A rollout restart is a way to update running pods in a StatefulSet with new or updated configuration without disrupting the availability of running pods or services.

### **[SMTP Research](../../../research/topics/smtp_service.md)**

### **[Cloud-Based EDI for Full Integration](../../../research/topics/edi.md)**

## **[Platform Features](../../report_system/platform_features.md)**

## **[Task List](../../report_system/task_list.md)**

## **[What is site reliability engineering?](../../../research/a_l/application_architecture/sre.md)**

Site reliability engineering (SRE) is the practice of using software tools to automate IT infrastructure tasks such as system management and application monitoring. Organizations use SRE to ensure their software applications remain reliable amidst frequent updates from development teams. SRE especially improves the reliability of scalable software systems because managing a large system using software is more sustainable than manually managing hundreds of machines.

## What is monitoring in site reliability engineering?

Monitoring is a process of observing predefined metrics in an application. Developers decide which parameters are critical in determining the application's health and set them in monitoring tools. Site reliability engineering (SRE) teams collect critical information that reflects the system performance and visualize it in charts.

## Istio Service Mesh SRE monitoring

![pdb](https://www.istioworkshop.io/images/grafana-istio-dashboards.png?width=50pc)

![db](https://www.istioworkshop.io/images/istio-performance-dashboard.png?width=50pc)

## Repsys Architecture

- **[Architecture Choices](../../report_system/architecture_choices.md)**
- **[Databases and Schemas](../../report_system/databases_shemas.md)**

## **[Threat Protection](../../report_system/threat_protection.md)**

### **[Design Patterns](../../../research/a_l/application_architecture/design_pattern.md)**

- **[Service Mesh](../../../research/a_l/application_architecture/service_mesh_101.md)**

  When building software, code can be structured as a single large program (monolith) or multiple smaller programs (microservices). While it is true that many organizations are migrating from monolith to microservices to leverage the flexibility and scalability microservices offer, it gets difficult to manage them as their number grows. Challenges arise in tracking, latency control, optimizing load between replicas of a service, service-to-service communication security, and maintaining resilience. All these features can be encoded with the service giving an opportunity for vulnerabilities & mixing of business logic with management logic.

  **Service mesh** fills this gap and helps build a secure infrastructure with the optimized usage of the service by adding reliability, observability, and security features across all services uniformly without any application code change.

  **Service mesh** is an infrastructure layer deployed alongside an application, which means all the network complexities are handled outside the application code. It operates independently from the application and provides capabilities to optimize networking and enable service-to-service communication. By configuring and managing network behavior and traffic flow through policies, the service mesh enhances the application’s networking capabilities.

- **[Request Level Authentication and Authorization](../../../research/a_l/istio/authentication_and_authorization.md#what-is-request-level-authentication-and-authorization)**
- **[Microservices](../../../research/a_l/application_architecture/microservices.md)**
  ![sm](https://www.infracloud.io/assets/img/blog/demystifying-service-mesh/service-mesh-architecture.png)
- **[Learn microservices with istio](../../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)**
- **[Websockets and Microservices](../../report_system/repsys_architecture_notes.md)**
- **[Modularize React.js applications](../../../research/m_z/reactjs/modularize_react_applications.md)**
- **[GoRoutines: Concurrency in Golang](../../../research/a_l/golang/goroutines.md)**
- **[Full Stack App in istio Service Mesh](../../../research/a_l/istio/full_stack_app_in_istio.md)**

## **[AntiPatterns](../../../research/a_l/application_architecture/antipattern.md)**

- **[Ops Embedded in Dev Team](../../../research/a_l/application_architecture/platform_engineer.md#antipattern)**

  ![anti](https://cdn.prod.website-files.com/6489e23dd070ba71d41a33b2/649163cff008fbb11c51cb9f_6200ce7b574bad7eea1a5e1b_61bcb69ae99f82039b617b4d_image4.png)

  This type of antipatterns has been shown by a number of studies, such as the State of DevOps by Puppet or, most recently, by Humanitec’s Benchmarking study. In the latter, top and low performing organizations were clustered, based on standard DevOps metrics (lead time, deployment frequency, MTTR, etc.). As shown below, a stunning 44% of low performing organizations experience the above antipattern, with some developers doing DevOps tasks on their own and helping less experienced colleagues. This is compared to top performers, where 100% of the organizations have successfully implemented a true “you build it, you run it” approach.

### Diagrams

- **[Report System Block and Sequence Diagrams](../../report_system/sequence_block.md)**
- **[Report System Redundant K8s Clusters](../../report_system/report_system_redundant_k8s_clusters.md)**

### **[Report System Components](../../report_system/component_menu.md)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- **[Application Delivery Controller](../../../research/a_l/k8s/load_balancer/load_balancer_adc.md)**

  In the current era, demanding digital transformations has led to several transforming initiatives like mobility and collaborative mobile workspaces. The new standards in the digital strategy of businesses is leveraging the cloud technology and enhancing application infrastructure to gain better profitability while eliminating data-breach risks. As applications play a decisive role in this regard, it is important to ensure their peak performance, which is critically dependent on traffic management.

  I would say Linamar's **[F5 Load Balancer](https://www.f5.com/glossary/load-balancer)** qualifies as an ADC.

- **[Proxy](../../../research/a_l/k8s/concepts/proxy_servers.md)**

- **[Sessions and Cookies](../../../research/m_z/virtualization/networking/http/session_and_cookies.md)**

  When a user logs into the website, a session is created. In this session, you can created variable called “session variable” that store data in a key/value format ( like cookies ).

  This session is associated with a randomly generated unique ID, which is created by the server. It’s called “session ID”.

  The generated session ID is then sent to the user’s browser and stored as a cookie, while the session data is stored on the server-side.

  Now, when the browser send a request to the server, it’ll send the cookies with the request.

  The server will receive the cookie from the incoming request and retrieve the value of the session ID.

  ![session](https://miro.medium.com/v2/resize:fit:720/format:webp/1*Mc3AiM1OIL4rH4DaC9m6Dg.png)

  Afterwards, the server will search for the session and retrieve all the data stored within it once it is found.

- **[Learn Microservices using Kubernetes and Istio](../../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)**

In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. These services are built around business capabilities and independently deployable by fully automated deployment machinery. There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.

## Important date

March remove active directory.  

## Adrian Wise

Migrate Mobex Azure report system resources to Azure Subscriptions Linamar Special Projects EA

## Dan Martin Status

Give Dan monthly status report of progress on the TB part of the report system.

50% done.  Estimated completion date Feb.

## Tickets

The goal is to nail down the details of where the various parts of our report system will be running.

- Can we still use Mobex tenant after March for **[AKS, Azure SQL db](../tickets/azure_resources.md)**? How are we currently paying for these resources? If we can keep them we probably need to continue to pay for an E5 developers license as well as the AKS and Azure SQL Server resources which are appoximately $300 per month.
- Request AKS and Azure SQL server so that we can put the report system requestor and archive viewer in a teams tab?
- Request a GPO to distribute our intermediate and root certificates to the trust stores of IT/OT hosts that will be accessing Mach2 or our reporting system?
- Request to register our report system Oauth2 app in linamar azure tenant?

## PKI

- Internal Certificates (Self-Signed) - Aamir gaffar
- DigiCert - John Biel
- Our PKI

## **[Network Upgrade Request for the Reporting System](../jdavis/network_upgrade.md)**

- 60 static IP addresses.
- 8 network cables ran to each R620 currently I only have 3.
- New gateway address
- New name server addresses
- Need to be physically on the servers to change the IPs.
- I completely wipe these R620s occassionally so I would like a key to the server room.

## Important Windows VMs

- alb-utl.busche-cnc.com (10.1.1.150) has ETL ssis scripts which we run from Visual Studio
- alb-utl4 (10.1.1.151) Power BI Report Builder
- busche-sql.BUSCHE-CNC.com (10.1.2.74) Busche Tool List for the Busche Reporter.

## Azure SQL MI

Add new home public IP4 and IP6 address and our Linamar vlan's public IP to the database firewall rules if different than current IP.

My Public IPv4:
64.184.116.66
My Public IPv6:
2605:7b00:201:e540::787
My IP Location:
Ligonier, IN US
My ISP:
Ligonier Telephone

## 3 Dell PowerEdge R620s

Each Dell PowerEdge R620S has 132 GB of RAM so each can run a 4 node K8s cluster with the report system installed.  Two can be used for production and backup report system deployments. The third can be used for Albion or home development.

## Questions

Mills River Production and Downtime Tracking System.

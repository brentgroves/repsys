# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

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

## **[Plex Ticket](../tickets/plex.md)**

## **[IT Structures Tickets](../tickets/tickets.md)**

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

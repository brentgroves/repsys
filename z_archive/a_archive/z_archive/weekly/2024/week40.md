# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## Questions

Is there any Kubernetes clusters currently running at Linamar? The need is to install reporting software used to run reports requiring live data or reports that time out when run from Intelliplex.

Mills River Production and Downtime Tracking System.

## ToDo

- **[ToDo List](../../report_system/todo_list.md)**
- **[ToDo Gnatt](../../report_system/todo_gantt.md)**

## Repsys Architecture

- **[Architecture Choices](../../report_system/architecture_choices.md)**
- **[Databases and Schemas](../../report_system/databases_shemas.md)**

### **[Design Patterns](../../../research/a_l/application_architecture/design_pattern.md)**

- **[Request Level Authentication and Authorization](../../../research/a_l/istio/authentication_and_authorization.md#what-is-request-level-authentication-and-authorization)**
- **[Microservices](../../../research/a_l/application_architecture/microservices.md)**
- **[Service Mesh](../../../research/a_l/application_architecture/service_mesh_101.md)**
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

- **[Docker Niagara](https://www.broudyprecision.com/docker-niagara/)**

  **[Video](https://youtu.be/rzshJ82JxDY)**

  With the upcoming release of Niagara Framework® 4.13, Niagara will be available as a Docker® container that packages together the Niagara core, the JRE (Java Runtime Environment), and any additional modules required at runtime. This containerized delivery mechanism has advantages during development, at first provisioning for a given customer and for each version upgrade compared to standard deployment and integration processes.

- **[What is platform engineering?](../../../research/a_l/application_architecture/platform_engineer.md)**

  **Gone are the days of running a single script to deploy a monolithic application consuming one relational database.** We now have transactional and reporting databases. We also have cache and message queue servers, containers and container orchestrators, identity and access management servers, PKI systems, and tls as well as mTLS certificate management for microservices, declarative tools to manage infrastructure through code. The platform engineer takes care of all these new things.

- **[Keycloak](../../../research/a_l/istio/authentication_and_authorization.md#what-is-keycloak)**\

  We used to have IAM embedded embedded in our code, but now we can separate this code from our main code by using an IAM server. These servers handle all the IAM chores and integrate with popular identity providers so you can leverage existing tenants.

- **[Service Mesh](../../../research/a_l/application_architecture/service_mesh_101.md)**\
  When building software, code can be structured as a single large program (monolith) or multiple smaller programs (microservices). While it is true that many organizations are migrating from monolith to microservices to leverage the flexibility and scalability microservices offer, it gets difficult to manage them as their number grows. Challenges arise in tracking, latency control, optimizing load between replicas of a service, service-to-service communication security, and maintaining resilience. All these features can be encoded with the service giving an opportunity for vulnerabilities & mixing of business logic with management logic.

  Implementing a reliable service discovery mechanism and maintaining an up-to-date service registry becomes difficult. **[Adopting Kubernetes](https://www.infracloud.io/kubernetes-consulting-partner/)** resolves some deployment issues, but runtime issues persist due to tight coupling with the application. Testing new features and making changes while maintaining infrastructure security becomes challenging.

  Service mesh fills this gap and helps build a secure infrastructure with the optimized usage of the service by adding reliability, observability, and security features across all services uniformly without any application code change. In this blog post, we will understand the concept of the service mesh, its components, its functionality, and how it can be helpful in Kubernetes and beyond.

  ## What is a service mesh?

  Service mesh is an infrastructure layer deployed alongside an application, which means all the network complexities are handled outside the application code. It operates independently from the application and provides capabilities to optimize networking and enable service-to-service communication. By configuring and managing network behavior and traffic flow through policies, the service mesh enhances the application’s networking capabilities.

  ## Why is a service mesh needed?

  There are multiple reasons why an organization would wish to implement a service mesh. We can start with the API endpoint discovery feature of service mesh that helps in identifying the backend service based on the client’s request and preventing the exposure of the API to unauthorized access. Another reason is that an outbound proxy can only protect the cluster or VMs from the outside. However, once a request enters the infrastructure, all communication becomes insecure, and the request gains access to all the services. This leaves it vulnerable to potential threats.

  Service mesh fills this gap and routes all the inter-service communication through proxies. It allows platform engineers to rate limit, trace, access control, etc. the service request which helps in keeping the infrastructure secure. Though very frequently used with Kubernetes and microservices, service mesh can be used outside of microservices and containers on virtual or bare metal servers. Let us understand the architecture of service mesh to know how we can modernize existing services.

- **[Quarkus and GraalVM](../../../research/a_l/java/quarkus_graalvm.md)**\
Quarkus is a Java framework tailored for deployment on Kubernetes. Key technology components surrounding it are OpenJDK HotSpot and GraalVM. Wikipedia

- **[What is IOPS (Input/Output Operations Per Second)?  Understanding the Key Metric for Storage Performance](../../../research/m_z/storage/iops.md)**

  When measuring the performance of storage devices, one key metric often used is IOPS or Input/Output Operations Per Second. This metric provides an important measure of how fast a storage device can read and write data, which ultimately affects its overall performance.

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

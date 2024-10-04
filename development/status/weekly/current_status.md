# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## Question

- Does Linamar have an **[transparent proxy server](../../../research/a_l/k8s/concepts/proxy_servers.md#transparent-proxy)** or some other **threat protection software** that would prevent some web apps from working?

```text
The following is in markdown format it can be viewed better from https://markdownlivepreview.com/. if you copy and paste the contents below.
```

## High Level Summary

- Setup redundant **[kubernetes](https://kubernetes.io/docs/concepts/overview/)** clusters on-prem at Avilla with **[MicroK8s](https://microk8s.io/docs)** and in the cloud on **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)**. 2 weeks
- Research how best get http routing, https termination, and **[rate limiting](https://www.getambassador.io/blog/configure-rate-limits-prevent-ddos-best-practices)** features for the report system web app using **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/)**, **[istio service mesh](https://istio.io/latest/about/service-mesh/)**, or **[Kong API Gateway](https://konghq.com/products/kong-gateway)**? We are attempting to offload as much of the non-business logic to OSS. 2 weeks.
- Create TLS certificates for repsys.linamar.com and keycloak.linamar.com using our internal **[PKI](https://www.keyfactor.com/education-center/what-is-pki/)** and **[OpenSSL](https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/)** that passes SAN certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)**

| task                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | estimate |   |   |   |   |   |   |   |   |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---|---|---|---|---|---|---|---|
| Setup redundant **[kubernetes](https://kubernetes.io/docs/concepts/overview/)** clusters on-prem at Avilla with **[MicroK8s](https://microk8s.io/docs)** and in the cloud on **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)**.                                                                                                                                                                                                                                                        | 2 weeks  |   |   |   |   |   |   |   |   |
| Research how best get http routing, https termination, and **[rate limiting](https://www.getambassador.io/blog/configure-rate-limits-prevent-ddos-best-practices)** features for the report system web app using **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/)**, **[istio service mesh](https://istio.io/latest/about/service-mesh/)**, or **[Kong API Gateway](https://konghq.com/products/kong-gateway)**? We are attempting to offload as much of the non-business logic to OSS. | 2 weeks  |   |   |   |   |   |   |   |   |
| Create TLS certificates for repsys.linamar.com and keycloak.linamar.com using our internal **[PKI](https://www.keyfactor.com/education-center/what-is-pki/)** and **[OpenSSL](https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/)** that passes SAN certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)**                                                                                                                                                     | 1 week   |   |   |   |   |   |   |   |   |

## **[Platform Features](../../report_system/feature_list.md)**

| Software      | routing | tls termination | rate limiting | IAM | Identity Provider |
|---------------|---------|-----------------|---------------|-----|-------------------|
| Nginx Gateway |         |                 |               |     |                   |
| Nginx Ingress |         |                 |               |     |                   |
| istio mesh    |         |                 |               |     |                   |
| kong api      |         |                 |               |     |                   |
| keycloak      |         |                 |               |     |                   |
| Entra ID      |         |                 |               |     |                   |

## ToDo

- **[ToDo List](../../report_system/todo_list.md)**
- **[ToDo Gnatt](../../report_system/todo_gantt.md)**

## Network setup

**[Network access](../jdavis/network_access.md)**

## Repsys Architecture

- **[Architecture Choices](../../report_system/architecture_choices.md)**
- **[Databases and Schemas](../../report_system/databases_shemas.md)**

## **[Threat Protection](../../report_system/threat_protection.md)**

- **[Mastering Istio Rate Limiting for Efficient Traffic Management](../../research/a_l/istio/threat_protection/rate_limiting.md)**

A SYN flood (half-open attack) is a type of denial-of-service (DDoS) attack which aims to make a server unavailable to legitimate traffic by consuming all available server resources. By repeatedly sending initial connection request (SYN) packets, the attacker is able to overwhelm all available ports on a targeted server machine, causing the targeted device to respond to legitimate traffic sluggishly or not at all.

Rate limiting is remarkably effective and ridiculously simple. It's also regularly forgotten. Rate limiting is a defensive measure you can use to prevent your server or application from being paralyzed. By restricting the number of similar requests that can hit your server within a window of time, you ensure your server won't be overwhelmed and debilitated.

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

- **[Docker Niagara](https://www.broudyprecision.com/docker-niagara/)**

  **[Video](https://youtu.be/rzshJ82JxDY)**

  With the upcoming release of Niagara Framework® 4.13, Niagara will be available as a Docker® container that packages together the Niagara core, the JRE (Java Runtime Environment), and any additional modules required at runtime. This containerized delivery mechanism has advantages during development, at first provisioning for a given customer and for each version upgrade compared to standard deployment and integration processes.

- **[Proxy](../../../research/a_l/k8s/concepts/proxy_servers.md)**
- **[Gateway, Ingress Controllers, vs Service Mesh](../../../research/a_l/k8s/concepts/gateways_ingess_service_mesh.md)**

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

## Questions

Mills River Production and Downtime Tracking System.

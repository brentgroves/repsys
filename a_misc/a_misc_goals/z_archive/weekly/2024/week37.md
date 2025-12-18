# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## Thoughts

I could put in tickets for software to be installed on our k8s clusters if that would help.

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

## Diagrams

- **[Report System Block and Sequence Diagrams](../../report_system/sequence_block.md)**

- **[Report System Redundant K8s Clusters](../../report_system/report_system_redundant_k8s_clusters.md)**

## ToDo

- Create Firewall rule for repsys Azure SQL db which include new Albion/Avilla public IP

- **[Deploy mssql data warehouse hosted on one of our r620 k8s cluster to Azure SQL server.](../../../research/m_z/sql_server/migration/onprem_to_azure_sql.md)**\
This involves manual SQL creation of schema and automated copying of table records.
- Deploy on-premise mysql stateful-set data warehouse to InnoDB HA MySQL database hosted on one of our r620 k8s cluster.\
This will involve adding a primary key to those tables without one. It also involves manual SQL creation of schema and automated copying of table records.
- Create **[Plex ODBC connection instructions for Windows](../../../research/m_z/sql_server/p)**

## Review

- **[Brad_Intelli_Scrap_Report_2](../bcook/Brad_Intelli_Scrap_Report_2.sql)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- NEXT **[Update or rotate the credentials for an Azure Kubernetes Service (AKS) cluster](../../../../azure/update_credentials.md)**

```bash
 Original Error: adal: Refresh request failed. Status Code = '401'. Response body: {"error":"invalid_client","error_description":"AADSTS7000222: The provided client secret keys for app '15cdd566-98bb-4130-8ec5-5c58cffb34bf' are expired. Visit the Azure portal to create new keys for your app: https://aka.ms/NewClientSecret, or consider using certificate credentials for added security: https://aka.ms/certCreds. Trace ID
 ```

- **[Deploy RabbitMQ Azure](../../../k8s/rabbitmq-quickstart.md)**
Just like you did for repsys11-c2
- **[AKS Free tier](https://learn.microsoft.com/en-us/azure/aks/free-standard-pricing-tiers)**
- **[Building Scalable Microservices: Creating a GRPC Service with Go and Consuming it in a React App via Envoy](../../../research/a_l/envoy/go_react_envoy.md)**\
In today’s blog post, we’ll explore the process of creating a GRPC service using Go and consuming it in a React app with the help of Envoy proxy. GRPC is a high-performance, language-agnostic remote procedure call (RPC) framework, and when combined with Go and Envoy, it becomes a powerful tool for building distributed systems. We’ll walk through each step of the process, from setting up the GRPC service in Go to creating a React app that communicates with it via Envoy.

- **[Learn Microservices using Kubernetes and Istio](../../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)**\

In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. These services are built around business capabilities and independently deployable by fully automated deployment machinery. There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.

- **[AKS simple web app](https://medium.com/@dheemandas1997/deploy-simple-static-web-application-on-azure-kubernetes-service-aks-a-step-by-step-guide-e94932a9ce65)**

- **[Understanding MVVM: Model-View-ViewModel Architecture Explained](../../../research/a_l/application_architecture/model_view_viewmodel.md)**\
  Model-View-ViewModel (MVVM) is a design pattern that helps you separate your application logic from the user interface. It's a different way to think about your code, but it can make your applications easier to build and test. The Model-View-ViewModel pattern is an architectural software design pattern in which the model represents the data, the view is what the user sees and interacts with, and the viewmodel acts as a mediator between the model and view.

![mvvm](https://www.datocms-assets.com/48294/1724770090-model-view-viewmodel-mvvm.webp?auto=format&dpr=0.5&w=1600)

- **[Presentation Domain Data Layering](../../../research/a_l/application_architecture/presentation_domain_data_layering.md)**\
One of the most common ways to modularize an information-rich program is to separate it into three broad layers: presentation (UI), domain logic (aka business logic), and data access. So you often see web applications divided into a web layer that knows about handling HTTP requests and rendering HTML, a business logic layer that contains validations and calculations, and a data access layer that sorts out how to manage persistent data in a database or remote services.

  ![pddl](https://martinfowler.com/bliki/images/presentationDomainDataLayering/all_basic.png)

- **[Modularizing React Applications with Established UI Patterns](../../../research/m_z/reactjs/modularize_react_applications.md)**\
  The application keeps evolving, and then you find some patterns emerge. There are a bunch of objects that do not belong to any user interface, and they also don’t care about whether the underlying data is from remote service, local storage or cache. And then, you want to split them into different layers. Here is a detailed explanation about the layer splitting **[Presentation Domain Data Layering](https://martinfowler.com/bliki/PresentationDomainDataLayering.html)**.

  ![e5](https://martinfowler.com/articles/modularizing-react-apps/evolution-5.png)

- **[Next - Kubernetes Services in AKS](../../../research/a_l/azure/aks/k8s_services.md)**\
  ![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-clusterip.png)
  ![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-nodeport.png)
  ![](https://learn.microsoft.com/en-us/azure/aks/media/concepts-network/aks-loadbalancer.png)
- **[Next - Ingress Controllers](../../../research/a_l/azure/aks/ingress_controllers.md)**\

- **[Next - Create cluster with kubeadm](../../../research/a_l/k8s/kubeadm/create_cluster_with_kubeadm.md)**

- **[What’s the difference between client certificates vs. server certificates?](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)**

  **[Client certificates](https://www.digicert.com/tls-ssl/client-certificates)** are digital certificates for users and individuals to prove their identity to a server. Client certificates tend to be used within private organizations to authenticate requests to remote servers. Whereas server certificates are more commonly known as **[TLS/SSL certificates](https://www.digicert.com/tls-ssl/tls-ssl-certificates)** and are used to protect servers and web domains. Server certificates perform a very similar role to Client certificates, except the latter is used to identify the client/individual and the former authenticates the owner of the site.

  **What is a client certificate?**\
  Client certificates are, as the name indicates, used to identify a client or a user, authenticating the client to the server and establishing precisely who they are. To some, the mention of PKI or ‘Client certificates’ may conjure up images of businesses protecting and completing their customers’ online transactions, yet such certificates are found throughout our daily lives, in any number of flavors; when we sign into a VPN, use a bank card at an ATM, or a card to gain access to a building or within public transport smart cards. These digital certificates are even found in petrol pumps, the robots on car assembly lines and even in our passports.

  In Continental Europe and in many other countries, the use of client certificates is particularly widespread, with governments issuing ID cards that have multiple uses, such as to pay local taxes, electricity bills and for drivers’ licenses. And the reason why is simple—client certificates play a vital role in ensuring people are safe online.  

- **[TLS Bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/)**

  In a Kubernetes cluster, the components on the worker nodes - kubelet and kube-proxy - need to communicate with Kubernetes control plane components, specifically kube-apiserver. In order to ensure that communication is kept private, not interfered with, and ensure that each component of the cluster is talking to another trusted component, we strongly recommend using client TLS certificates on nodes.

  The normal process of bootstrapping these components, especially worker nodes that need certificates so they can communicate safely with kube-apiserver, can be a challenging process as it is often outside of the scope of Kubernetes and requires significant additional work. This in turn, can make it challenging to initialize or scale a cluster.

  In order to simplify the process, beginning in version 1.4, Kubernetes introduced a certificate request and signing API. The proposal can be found **[here](https://github.com/kubernetes/kubernetes/pull/20439)**.

- **[bootstrap tokens](../../../research/a_l/k8s/concepts/bootstrap_tokens.md)**

  Bootstrap tokens are a simple bearer token that is meant to be used when creating new clusters or joining new nodes to an existing cluster. It was built to support kubeadm, but can be used in other contexts for users that wish to start clusters without kubeadm. It is also built to work, via RBAC policy, with the **[kubelet TLS Bootstrapping system](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/).

  A Bearer Token is an opaque string, not intended to have any meaning to clients using it. Some servers will issue tokens that are a short string of hexadecimal characters, while others may use structured tokens such as JSON Web Tokens.

- **[Extending Kubernetes with Custom Resource Definitions (CRDs)](../../../research/a_l/k8s/concepts/crd/extending_k8s_with_crds.md)**\
  CRDs extend the API with support for arbitrary data types. Each CRD you create gets its own API endpoints that you can use to query, create, and edit instances of that resource. Custom resources are fully supported within kubectl, so you can run commands like kubectl get backgroundjobs to interact with your application's objects.

  Like Windows regedit except rather than a hiarchical database it's a key-value store like redis but uses etcd.

- **[Pod Security Admission](../../../research/a_l/k8s/concepts/pod_security_standards/pod_security_admission.md)**\
  The Kubernetes Pod Security Standards define different isolation levels for Pods. These standards let you define how you want to restrict the behavior of pods in a clear, consistent fashion.

  Kubernetes offers a built-in Pod Security admission controller to enforce the Pod Security Standards. Pod security restrictions are applied at the namespace level when pods are created.

![](https://imgix.datadoghq.com/img/blog/kubernetes-cpu-requests-limits/kubernetes-cpu-requests-limits-diagram-1-final.png?auto=format&fit=max&w=847)

For any time slice of 100 ms, pod 1 is guaranteed to have 20 ms of CPU time, pod 2 is guaranteed to have 40 ms of CPU time, and pod 3 is guaranteed to have 20 ms of CPU time. But if the pods are not using these CPU cycles, these numbers don’t mean anything—any pod scheduled on the node could use them. For example, in a time slice of 100 ms, this scenario is possible:

- **[Types of Transmission Media](https://www.geeksforgeeks.org/types-transmission-media/)**\
  Cell-phones, Wi-Fi, GPS, Bluetooth and many other technologies use microwaves to enable much in modern life. It's worth getting to know them a little. Microwaves are a form of electromagnetic (EM) radiation: just like gamma rays, x-rays, ultraviolet radiation, visible light, infrared radiation and radio waves.

- **[Network Speed Test](../../../research/m_z/virtualization/networking/iperf/network_speed_testing.md)**\
Testing Network Speed Between Two Linux Servers

- **[Power BI connection to Plex](https://www.revolutiongroup.com/wp-content/uploads/PSCC2102_UsingTodaysTechnologytoBetterServeYourPlex_TonyBrown.pdf)**

- **[Create SQL Server admin user](../../../research/m_z/sql_server/create_admin_user.md)**\
Instructions for creating an admin user for SQL Server.

- **[F5 Load Balancer](https://www.f5.com/products/big-ip-services/local-traffic-manager)**\
Application Traffic Management
BIG-IP LTM includes static and dynamic load balancing to eliminate single points of
failure. Application proxies give you protocol awareness to control traffic for your most
important applications. BIG-IP LTM also tracks the dynamic performance levels of servers
in a group, ensuring that your applications are not just always on, but also are easier to
scale and manage.

- **[Terraform](../../../research/m_z/terraform/terraform.md)**\
Terraform, an open source “Infrastructure as Code” tool created by HashiCorp, allows programmers to build, change and version infrastructure safely and efficiently.

- **[k8s concepts](../../../research/a_l/k8s/concepts/k8s_concepts_menu.md)**\
Research K8s concepts, architecture, and inner working to better understand kubernetes.

- **[Create a cluster with kubeadm](../../../research/a_l/k8s/kubeadm/create_cluster_with_kubeadm.md)\
Our productions clusters are created by microk8s. MicroK8s is easy to use and can handle advanced configurations. The advantage of using kubeadm to create your cluster is that you have complete control of all kubernetes features.  In short kubeadm is a great learning tool in order to understand exactly what is going on in a kubernetes cluster.

- **[Hailey's Project](../../../research/a_l/hailey/hailey_project.md)**\
Hailey could use the report system's Zitadel for IAM.

- **[Linamar PKI](../bhall/frt-kors43.md)**\

  Next: After Mach2 is installed on new server then generate a new private key and give it to Brent Hall.

  Linamar ssl certificate for Fruitport's Mach2 server.

  - Lint certificate chain
  - Lint kors43 SAN server certificate
  - Fix any errors
  - Test certificate chain
  - Format kors43 certificate chain for jboss/Niagara
  - Ask Sam to import certificate chain on kors43 using Niagara front-end

- **[Golang Certificate Tester](../../../volumes/go/tutorials/ssl/ssl_server/ssl_server.md)**\
This is a very simple program that you can use to test a full x509 certificate chain with any browser.

- **[Modify ETL scripts to use local SQL Server container](../../../research/m_z/sql_server/sql_server_containers.md)**

- Intermediate step in the report system to ensure we can always run the TB.
- The MI is backed up to a local drive and SQL server currently runs from a dockerfile.

## NEXT Research Topics

- **[Go Backend with IAM](../../../../go_zit_backend/README.md#next)**\
Read more about how to **[generate a key file](../../../research/m_z/zitadel/key_file.md)**.

- **[Go Frontend with IAM](../../../research/m_z/zitadel/zitadel_article.md)**\
Research Zitadel IAM

- **[Go web app in Docker](https://semaphoreci.com/community/tutorials/how-to-deploy-a-go-web-application-with-docker)**

- Verify TB Power BI report runs from alb-utl and add it to repsys volume/powerbi dir.
- **[Test k8s.io from within Cluster](https://github.com/kubernetes/client-go/blob/master/examples/in-cluster-client-configuration/main.go)**
  - read database passwords from k8s secret and write to k8s log.
- Remove password from mutex tutorial.

- **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**

## Project List

- **[Report System](../../../projects/report_system/report_system.md)**
- **[Observability System](../../../projects/observability_system/observability_system.md)**
- Mean Time to Failure

## Development

- **[Setup Development System](../../report_system/setup_dev_system/setup_dev_system.md)**
- **[IT/OT database access](../../report_system/it_ot_database.md)**
- **[Virtual Network](../../report_system/virtual_network.md)**
- **[All Software MindMap](../../report_system/all_sw_mindmap.md)**
- **[All Software Gantt](../../report_system/all_sw_gantt.md)**
- **[Report Creation Sequence Diagram](../../report_system/report_creation_sequece_diagram.md)**
- **[Trial Balance Runner Flow Chart](../../report_system/trial_balance_runner_flow_chart.md)**
- **[Task List](../../report_system/task_list.md)**
- **[Requester Mockup](../../report_system/requester_mockup/requester_mockup.md)**

## IT Admin

- **[PKI](../../../it_admin/pki/pki_menu.md)**

## Tutorials

- **[Go Tutorials](../../../volumes/go/tutorials/tutorial_list.md)**
- **[Zitadel with Go (Backend)](../../../research/m_z/zitadel/go_backend/go_backend.md)**
- **[Zitadel with Go (Frontend)](../../../research/m_z/zitadel/go_frontend/go_frontend.md)**
- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**
- **[In-Cluster K8s API access](../../../volumes/go/tutorials/k8s/in_cluster_client_configuration/in-cluster-client-configuration.md)**
- **[Out-of-Cluster K8s API access](../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**
- **[Containerize your Go app and use semaphore for CI/CD.](../../../volumes/go/tutorials/docker/go_web_docker/go_web_docker.md)**

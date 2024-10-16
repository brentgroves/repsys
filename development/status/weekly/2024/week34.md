# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## Important date

March remove active directory.  

## Dan Martin Status

Give Dan monthly status report of progress on the TB part of the report system.

50% done.  Estimated completion date Feb.

## Tickets

The goal is to nail down the details of where the various parts of our report system will be running.

- Can we still use Mobex tenant after March for **[AKS, Azure SQL db](../tickets/azure_resources.md)**
- Can we get approval to have AKS in Mobex Azure tenant so that we can put the report system requestor and archive viewer in a teams tab?
- Can we use a GPO to distribute our intermediate and root certificates to the trust stores of IT/OT hosts that will be accessing Mach2 or our reporting system?
- Can we register an Oauth2 app in linamar azure tenant?

## PKI

- Internal Certificates (Self-Signed) - Aamir gaffar
- DigiCert - John Biel
- Our PKI

## **[Sentinel One](../../../../../src/secrets/sentinelone/sentinelone.md)**

Installed on development system and researched the Linux CLI.

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

May need rights to add our public IP to the database firewall rules.

## 3 Dell PowerEdge R620s

Will probably need to be physically on the servers to change the IPs.

## Diagrams

- **[Report System Redundant K8s Clusters](../../report_system/report_system_redundant_k8s_clusters.md)**

## ToDo

- Create Firewall rule for repsys Azure SQL db which include new Albion/Avilla public IP
- Got SSL certificate from mssql server 2022 installed on r620 k8s.
- Add certificate to trust store or lower default security level for OpenSSL installation. Could not get to work using odbc driver and pyodbc.
- Prepare for Albion/Avilla Linamar Networking/VM changes
  - Test Visual Studio SSIS scripts on alb-util/10.1.1.150.
  - Test running trial_balance.rdl using Power BI report builder from alb-utl4/10.1.1.151,
Run TB report, trial_balance.rdl, from any Windows machine with the Power BI report builder installed.

- **[Deploy mssql data warehouse hosted on one of our r620 k8s cluster to Azure SQL server.](../../../research/m_z/sql_server/migration/onprem_to_azure_sql.md)**\
This involves manual SQL creation of schema and automated copying of table records.
- Deploy on-premise mysql stateful-set data warehouse to InnoDB HA MySQL database hosted on one of our r620 k8s cluster.\
This will involve adding a primary key to those tables without one. It also involves manual SQL creation of schema and automated copying of table records.
- Create **[Plex ODBC connection instructions for Windows](../../../research/m_z/sql_server/p)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- **[CPU request](../../../research/a_l/k8s/concepts/cpu_requests.md)**

  ...Let’s say we have a single node with 1 CPU core and three pods (each of which have one container and one thread) that are requesting 200, 400, and 200 millicores (m) of CPU, respectively. The scheduler is able to place them all on the node because the sum of requests is less than 1 CPU core:

![](https://imgix.datadoghq.com/img/blog/kubernetes-cpu-requests-limits/kubernetes-cpu-requests-limits-diagram-1-final.png?auto=format&fit=max&w=847)

For any time slice of 100 ms, pod 1 is guaranteed to have 20 ms of CPU time, pod 2 is guaranteed to have 40 ms of CPU time, and pod 3 is guaranteed to have 20 ms of CPU time. But if the pods are not using these CPU cycles, these numbers don’t mean anything—any pod scheduled on the node could use them. For example, in a time slice of 100 ms, this scenario is possible:

- **[TCP congestion control](https://www.geeksforgeeks.org/tcp-congestion-control/)**

  TCP congestion control is a method used by the TCP protocol to manage data flow over a network and prevent congestion. TCP uses a congestion window and congestion policy that avoids congestion. Previously, we assumed that only the receiver could dictate the sender’s window size. We ignored another entity here, the network. If the network cannot deliver the data as fast as it is created by the sender, it must tell the sender to slow down. In other words, in addition to the receiver, the network is a second entity that determines the size of the sender’s window.

- **[RTT](https://www.geeksforgeeks.org/what-is-rttround-trip-time/)**

  RTT (Round Trip Time) also called round-trip delay is a crucial tool in determining the health of a network. It is the time between a request for data and the display of that data. It is the duration measured in milliseconds.

  RTT can be analyzed and determined by pinging a certain address. It refers to the time taken by a network request to reach a destination and to revert back to the original source. In this scenario, the source is the computer and the destination is a system that captures the arriving signal and reverts it back.

- **[Types of Transmission Media](https://www.geeksforgeeks.org/types-transmission-media/)**\
  Cell-phones, Wi-Fi, GPS, Bluetooth and many other technologies use microwaves to enable much in modern life. It's worth getting to know them a little. Microwaves are a form of electromagnetic (EM) radiation: just like gamma rays, x-rays, ultraviolet radiation, visible light, infrared radiation and radio waves.

- **[Network Speed Test](../../../research/m_z/virtualization/networking/iperf/network_speed_testing.md)**\
Testing Network Speed Between Two Linux Servers
- **[Power BI connection to Plex](https://www.revolutiongroup.com/wp-content/uploads/PSCC2102_UsingTodaysTechnologytoBetterServeYourPlex_TonyBrown.pdf)**

- **[Create SQL Server admin user](../../../research/m_z/sql_server/create_admin_user.md)**\
Instructions for creating an admin user for SQL Server.

- **[Introducing Software Certification for Kubernetes](https://kubernetes.io/blog/2017/10/software-conformance-certification/)**\
Over the last three years, Kubernetes® has seen wide-scale adoption by a vibrant and diverse community of providers. In fact, there are now more than 60 known Kubernetes platforms and distributions. From the start, one goal of Kubernetes has been consistency and portability.

In order to better serve this goal, today the Kubernetes community and the Cloud Native Computing Foundation® (CNCF®) announce the availability of the beta Certified Kubernetes Conformance Program. The Kubernetes conformance certification program gives users the confidence that when they use a Certified Kubernetes™ product, they can rely on a high level of common functionality. Certification provides Independent Software Vendors (ISVs) confidence that if their customer is using a Certified Kubernetes product, their software will behave as expected.

- **[F5 Load Balancer](https://www.f5.com/products/big-ip-services/local-traffic-manager)**\
Application Traffic Management
BIG-IP LTM includes static and dynamic load balancing to eliminate single points of
failure. Application proxies give you protocol awareness to control traffic for your most
important applications. BIG-IP LTM also tracks the dynamic performance levels of servers
in a group, ensuring that your applications are not just always on, but also are easier to
scale and manage.

- **[Terraform](../../../research/m_z/terraform/terraform.md)**\
Terraform, an open source “Infrastructure as Code” tool created by HashiCorp, allows programmers to build, change and version infrastructure safely and efficiently.

- **[TDS 8.0](../../../research/m_z/sql_server/tds8.md)**\
**odbc/ado.net/oledb -> tds8**

SQL Server 2022 (16.x), Azure SQL Database, and Azure SQL Managed Instance support Tabular Data Stream (TDS) 8.0.

The Tabular Data Stream (TDS) protocol is an application layer protocol used by clients to connect to SQL Server. SQL Server uses Transport Layer Security (TLS) to encrypt data that is transmitted across a network between an instance of SQL Server and a client application.

TDS is a secure protocol, but in previous versions of SQL Server, encryption could be turned off or not enabled. To meet the standards of mandatory encryption while using SQL Server, an iteration of the TDS protocol was introduced: TDS 8.0.

The TLS handshake now precedes any TDS messages, wrapping the TDS session in TLS to enforce encryption, making TDS 8.0 aligned with HTTPS and other web protocols. This significantly contributes to TDS traffic manageability, as standard network appliances are now able to filter and securely passthrough SQL queries.

Another benefit to TDS 8.0 compared to previous TDS versions is compatibility with TLS 1.3, and TLS standards to come. TDS 8.0 is also fully compatible with TLS 1.2 and previous TLS versions.

- **[IDENTIFYING AND RESOLVING IP ADDRESS CONFLICTS WITH LINUX](../../../research/a_l/ip-scanners/ip_conflicts.md/)**\
One of the most frustrating problems a network administrator can come across is an IP address conflict, when two or more machines on a network try to use the same IP. The result is typically that some packets on the network go to one machine, and some packets go to the other – leading to intermittent packet loss and dropped connections.

Luckily, however, resolving IP address conflicts is easy if you know the right tools. This how to will teach you to find and resolve IP address conflicts on your network.

- **[k8s concepts](../../../research/a_l/k8s/concepts/k8s_concepts_menu.md)**\
Research K8s concepts, architecture, and inner working to better understand kubernetes.

- **[Create a cluster with kubeadm](../../../research/a_l/k8s/kubeadm/create_cluster_with_kubeadm.md)\
Our productions clusters are created by microk8s. MicroK8s is easy to use and can handle advanced configurations. The advantage of using kubeadm to create your cluster is that you have complete control of all kubernetes features.  In short kubeadm is a great learning tool in order to understand exactly what is going on in a kubernetes cluster.

- **[Intel Clear Linux OS](../../../research/a_l/k8s/concepts/intel_clear_containers.md)**\
Intel Clear Containers offer a means of combining the best features of VMs with the power and flexibility that containers bring to application developers.

You can find more information about **[Intel Clear Containers](http://clearlinux.org/features/intel%C2%AE-clear-containers)** at the official website.

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

- **[Deploy MicroK8s on R620 using Multipass](../../../research/m_z/virtualization/multipass/microk8s/install_microk8s_on_multipass_vm.md)**

- **[Deploy SQL Server on MicroK8s on R620](../../../k8s/sql_server_install.md)**

- **[Modify ETL scripts to use local SQL Server container](../../../research/m_z/sql_server/sql_server_containers.md)**

- Intermediate step in the report system to ensure we can always run the TB.
- The MI is backed up to a local drive and SQL server currently runs from a dockerfile.

- **[VMs vs Containers](../../../research/m_z/virtualization/research/vm_vs_container.md)**

  ![](https://www.mssqltips.com/tipimages2/5907_introduction-containers-sql-server-dba.002.png)

  In the diagram above, you only have one operating system. The containers share the same operating system kernel with other containers, each one running as isolated processes in user space. **Instead of abstracting the hardware like what virtualization does, containers abstract the operating system kernel.** This reduces the amount of storage space requirement for containers, eliminating the inefficiencies of having multiple copies of the operating system running on guest virtual machines. It also significantly reduces the amount of administrative overhead necessary to manage operating systems. Plus, they use far fewer resources than virtual machines.

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

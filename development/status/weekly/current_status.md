# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## try next to enable connections to sql server

1. Look at repsys\volumes/python\soap\openssl.cnf.bak for add system default section to config file but add minprotocol section
2. get certificate from python. <https://gist.github.com/lnattrass/a4a91dbf439fc1719d69f7865c1b1791>

## **[Sentinel One](../../../../../src/secrets/sentinelone/sentinelone.md)**

## **[Network Upgrade Request for the Reporting System](../jdavis/network_upgrade.md)**

- 50 static IP addresses.
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

- Got SSL certificate from mssql server 2022 installed on r620 k8s.
- Add certificate to trust store or lower default security level for OpenSSL installation. Could not get to work using odbc driver and pyodbc.
- Prepare for Albion/Avilla Linamar Networking/VM changes
  - Test Visual Studio SSIS scripts on alb-util/10.1.1.150.
  - Test running trial_balance.rdl using Power BI report builder from alb-utl4/10.1.1.151,
Run TB report, trial_balance.rdl, from any Windows machine with the Power BI report builder installed.

- Deploy mssql data warehouse hosted on one of our r620 k8s cluster to Azure SQL server.\
This involves manual SQL creation of schema and automated copying of table records.
- Deploy on-premise mysql stateful-set data warehouse to InnoDB HA MySQL database hosted on one of our r620 k8s cluster.\
This will involve adding a primary key to those tables without one. It also involves manual SQL creation of schema and automated copying of table records.

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- **[TDS 8.0](../../../research/m_z/sql_server/tds8.md)**\
**odbc/ado.net/oledb -> tds8**

SQL Server 2022 (16.x), Azure SQL Database, and Azure SQL Managed Instance support Tabular Data Stream (TDS) 8.0.

The Tabular Data Stream (TDS) protocol is an application layer protocol used by clients to connect to SQL Server. SQL Server uses Transport Layer Security (TLS) to encrypt data that is transmitted across a network between an instance of SQL Server and a client application.

TDS is a secure protocol, but in previous versions of SQL Server, encryption could be turned off or not enabled. To meet the standards of mandatory encryption while using SQL Server, an iteration of the TDS protocol was introduced: TDS 8.0.

The TLS handshake now precedes any TDS messages, wrapping the TDS session in TLS to enforce encryption, making TDS 8.0 aligned with HTTPS and other web protocols. This significantly contributes to TDS traffic manageability, as standard network appliances are now able to filter and securely passthrough SQL queries.

Another benefit to TDS 8.0 compared to previous TDS versions is compatibility with TLS 1.3, and TLS standards to come. TDS 8.0 is also fully compatible with TLS 1.2 and previous TLS versions.

- **[TDS Protocol](../../../research/m_z/tds/tds_protocol.md)**\
is a protocol, or a set of rules describing how to transmit data between two computers. Like any protocol, it defines the types of messages that can be sent, and the order in which they may be sent. Protocols describe the "bits on the wire", specifying how data flows. It confuses many but entrances a few.

A protocol is not an API, although the two are related. The server recognizes and speaks a protocol; anything that can send it the correct combination of bytes in the right order can communicate with it. Typically this task is handled by a software library. Over the years, there have been a few libraries — each with its own API — that do the work of moving SQL through a TDS pipe. ODBC, db-lib, ct-lib, and JDBC have very different APIs, but they're all one to the server, because on the wire they speak TDS.

- **[sqlcmd](../../../research/m_z/sql_server/golang/tds8.md)**\
Installing sqlcmd (Go) via a package manager will replace sqlcmd (ODBC) with sqlcmd (Go) in your environment path. Any current command line sessions will need to be closed and reopened for this take to effect. sqlcmd (ODBC) won't be removed and can still be used by specifying the full path to the executable. You can also update your PATH variable to indicate which will take precedence.

- **[Pytds - Microsoft SQL Server database adapter for Python](../../../research/m_z/sql_server/python/python-tds.md)**\

Pytds is the top to bottom pure Python TDS implementation, that means cross-platform, and no dependency on ADO or FreeTDS. It supports large parameters (>4000 characters), MARS, timezones, new date types (datetime2, date, time, datetimeoffset). Even though it is implemented in Python performance is comparable to ADO and FreeTDS bindings.

- **[Automation X](../../../research/a_l/automation_x/automation_x.md)**\
The automationX software provides interfaces for operator/HMI (aXViewer) and interfaces engineering & maintenance (aXEditor). There is also a fully integrated "real-time" control engine. This engine along with a global database, replaces the function of DCS/PLC controllers in the IT or aXserver.

Each aXserver can handle 1000's of I/O. Some of the aXServers in the world are serving 6000-7000 real inputs and outputs (both analog loops and digital) with scan times as low as 20 mS on the server, lower on the integrated distributed controllers (aXController). To make best use of resources we typically scan at 200 ms.

- **[What is IPAM](../../../research/a_l/ipam/what-is-ipam.md)**\
IP address management (IPAM) is method for enterprises to plan, track, and manage IP address space on a network using software tools.

Together, DNS, DHCP, and IPAM make up a triad known as DDI.

Managing the three components the comprise the DDI meaning separately presents inherent risks. Bringing them together into one managed solution transforms network management. DDI provides core network services and enables communications across all points of the network.

- **[IDENTIFYING AND RESOLVING IP ADDRESS CONFLICTS WITH LINUX](../../../research/a_l/ip-scanners/ip_conflicts.md/)**\
One of the most frustrating problems a network administrator can come across is an IP address conflict, when two or more machines on a network try to use the same IP. The result is typically that some packets on the network go to one machine, and some packets go to the other – leading to intermittent packet loss and dropped connections.

Luckily, however, resolving IP address conflicts is easy if you know the right tools. This how to will teach you to find and resolve IP address conflicts on your network.

- **[k8s concepts](../../../research/a_l/k8s/concepts/k8s_concepts_menu.md)**\
Research K8s concepts, architecture, and inner working to better understand kubernetes.

- **[Create a cluster with kubeadm](../../../research/a_l/k8s/concepts/kubeadm/create_cluster_with_kubeadm.md)\
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

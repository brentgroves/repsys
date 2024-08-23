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

- Can we still use Mobex tenant after March for **[AKS, Azure SQL db](../tickets/azure_resources.md)**? How are we currently paying for these resources? If we can keep them we probably need to continue to pay for an E5 developers license as well as the AKS and Azure SQL Server resources which are appoximately $300 per month.
- Request AKS and Azure SQL server so that we can put the report system requestor and archive viewer in a teams tab?
- Request a GPO to distribute our intermediate and root certificates to the trust stores of IT/OT hosts that will be accessing Mach2 or our reporting system?
- Request to register our report system Oauth2 app in linamar azure tenant?

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

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- **[what is busybox](../../../research/a_l/busybox/busybox.md)**\
  The Swiss Army Knife of Embedded Linux

  Coming in somewhere between 1 and 5 Mb in on-disk size (depending on the variant), BusyBox⁠ is a very good ingredient to craft space-efficient distributions.

- **[Extending Kubernetes with Custom Resource Definitions (CRDs)](../../../research/a_l/k8s/concepts/crd/extending_k8s_with_crds.md)**\
  CRDs extend the API with support for arbitrary data types. Each CRD you create gets its own API endpoints that you can use to query, create, and edit instances of that resource. Custom resources are fully supported within kubectl, so you can run commands like kubectl get backgroundjobs to interact with your application's objects.

  Like Windows regedit except rather than a hiarchical database it's a key-value store like redis but uses etcd.

- **[Pod Security Admission](../../../research/a_l/k8s/concepts/pod_security_standards/pod_security_admission.md)**\
  The Kubernetes Pod Security Standards define different isolation levels for Pods. These standards let you define how you want to restrict the behavior of pods in a clear, consistent fashion.

  Kubernetes offers a built-in Pod Security admission controller to enforce the Pod Security Standards. Pod security restrictions are applied at the namespace level when pods are created.

- **[DKMS](../../../research/a_l/linux/concepts/dkms.md)**\
  ![](https://wiki.ubuntu.com/Kernel/Dev/DKMSPackaging?action=AttachFile&do=get&target=dkms.png)

  Dynamic Kernel Module Support (DKMS) is a Linux framework that helps manage and install kernel modules that are external to the standard kernel distribution. These modules are often from hardware vendors and can add functionality to the Linux kernel, such as a hardware driver. DKMS has several benefits, including:\
  **Compatibility**\
  DKMS is compatible with most Linux distributions and monitors the system for kernel updates. When a new kernel is installed, DKMS automatically rebuilds the external modules using the latest kernel headers to ensure compatibility.\
  **Convenience**\
  DKMS is a convenient way to install additional drivers that are outside of the kernel tree.
  However, DKMS also has some potential drawbacks, including:\
  **Additional handling**\
  Resident modules may require additional handling.
  **Source code**\
  Source code for NVIDIA-like modules with blob parts may not be convenient to deliver with DKMS.
  **Module building**\
  DKMS may not build a module if its function names have changed or if there are changes in how the kernel interacts with its components.
  **Installation**\
  DKMS doesn't guarantee proper installation if the kernel application binary interface changes.

- **[CPU request](../../../research/a_l/k8s/concepts/cpu_requests.md)**

  ...Let’s say we have a single node with 1 CPU core and three pods (each of which have one container and one thread) that are requesting 200, 400, and 200 millicores (m) of CPU, respectively. The scheduler is able to place them all on the node because the sum of requests is less than 1 CPU core:

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

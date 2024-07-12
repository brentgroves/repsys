# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## Requests

**[Reporting System IP Request](../../report_system/r620s.md)**

- 12 for r620s
- 4 for Albion dev system and k8s cluster
- 4 for Avilla dev system and k8s cluster

## Notes

- **[Cyber Security Metrics](app.powerbi.com/groups/me/apps)**\
This seems to be a cloud based PowerBI report server.
- Plex IP restrictions. If this is like Azure SQL Server IP restrictions it may affect ODBC and SOAP Web Service connections.

## Diagrams

- **[Report System Redundant K8s Clusters](../../report_system/report_system_redundant_k8s_clusters.md)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- Prepare for Albion/Avilla Linamar Networking/VM changes
  - Test Visual Studio SSIS scripts on alb-util/10.1.1.150.
  - Test running trial_balance.rdl using Power BI report builder from alb-utl4/10.1.1.151,
Run TB report, trial_balance.rdl, from any Windows machine with the Power BI report builder installed.

- **[k8s concepts](../../../research/a_l/k8s/concepts/k8s_concepts_menu.md)**\
K8s concepts and inner working.

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

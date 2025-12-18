# IS Project Bullet List

Hi Christian, Kevin, and Jared

This is a revised bullet list for the Structures information systems projects. It is suitable for our Bi-Weekly meeting.

Thank you.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Set up and **[administrator](https://learn.microsoft.com/en-us/training/modules/administer-fabric/3-admin-role-tools)** the Structures Microsoft Fabric analytics workspace to centralize business data to give us previously impossible insights using Power BI reporting and analytic services

The Structures Information Systems group is setting up and administering the Structures Microsoft Fabric workspace. This workspace will help us achieve the goal of centralizing our business data to give us previously impossible insights.  

Time: ongoing

## Set up an administer the Structures data gateway

This **[data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)** will enable the Microsoft Fabric **[Data Factory](https://azure.microsoft.com/en-us/products/data-factory)** to access on-premise data and data sources available through ODBC connections, such as the Plex ERP. A high-availability gateway cluster can be set up on our Structures MicroCloud.  This gateway will help us achieve the goal of centralizing our business data in Linamar's Microsoft Fabric OneLake.

Time: 1 to 3 months

## Set up and Administer the Structures MicroCloud

Structures **[MicroCloud](https://canonical.com/microcloud)** has the following components:

- **[LXD system container and VM Cluster manager](https://documentation.ubuntu.com/lxd/stable-5.21/explanation/instances/)**
- **[OVN Cluster for SDN](https://www.ovn.org/en/architecture/)**
- **[Ceph Storage Cluster](https://docs.ceph.com/en/reef/architecture/)**

**[MicroCloud Demo](https://www.youtube.com/watch?v=M0y0hQ16YuE&t=409s)**

This is the supporting platform base of our data gateway and on-prem K8s based services such as the automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)**.

Time: ongoing

- Provide disaster recovery and meet corporate Recovery Time Objective (RTO) and Recovery Point Objective (RPO) for applications and data in the Structures MicroCloud using Ceph Storage clusters Multisite [RGW replication](https://ceph.io/en/news/blog/2025/rgw-multisite-replication_part1/) and **[One-way (Active-Passive) RBD mirroring](https://docs.ceph.com/en/reef/rbd/rbd-mirroring/)** features to ensure data is available at a secondary location.

**Disaster Recovery:** Provides data protection and minimizes downtime and data loss during a primary site failure.
**Reduced RTO/RPO:** Improves the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) by ensuring data is available at a secondary location.

Time: 3 months

## Manage Structures Storage Cluster

![i1](https://docs.ceph.com/en/reef/_images/stack.png)

![i2](https://docs.ceph.com/en/reef/_images/ditaa-db39e087bb6fb671969d38bd44c9e71ff716334d.png)

- higher availability and fault tolerance
- self-healing
- 50 nodes max
- Configurable network interfaces for both public and internal traffic.
- **[S3 compatible object storage](https://www.nakivo.com/blog/wp-content/uploads/2020/06/Accessing-files-stored-in-the-S3-bucket-from-Windows-Explorer-and-a-web-browser.webp)**
- **[RBD block storage](https://docs.ceph.com/en/reef/rbd/#ceph-block-device)** for VM root file system.
- **[CephFS POSIX-compliant file system](https://docs.ceph.com/en/squid/cephfs/)**.

Time: ongoing

## Set up an automated and on-demand ETL pipeline in K8s

We manually run scripts to update the data warehouse and data lake that Power BI reports use as raw and golden data sources.  The Automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** runs these scripts automatically or on demand.

time: 6 months to 1 year

- Administer Structures on-prem and multi-cloud **[Charmed Kubernetes](https://ubuntu.com/kubernetes/charmed-k8s)**

By using **[Charmed Kubernetes](https://ubuntu.com/kubernetes/charmed-k8s)** we can manage our on-prem Kubernetes Cluster and our Azure AKS cluster using the same automation software.

![i1](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_1681/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2Ff4a59bfe-k8s-chart-updated.png)

The Kubernetes Clusters and/or services will run and manage the software lifecycle for the following projects, under development.

- Set up an automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** as a containerized service in K8s to support the goal of centralizing Structures business data to give us previously impossible insights using Power BI reporting and analytic services.
- **Tool Management System:** Move from managing CNC tooling in Excel and the Legacy Busche Tool List system to a modern, more robust, easy-to-use platform.
- **CNC tool adjustment app:** used to record and report all tool adjustments for quality purposes.
- Tool Tracker Focused **[Manufacturing Execution System:](https://www.ibm.com/think/topics/mes-system)** Automatically collect and report on CNC, job, and start/end tool operation times for costly problematic tooling.

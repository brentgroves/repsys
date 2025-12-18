# IS responsibilites and projects bullet List

Hi Christian and Kevin,

This is a revised bullet list of information systems responsibities and projects. It has been updated to include Microsoft Fabric data analytics set up and administration and is suitable for our Bi-Weekly status meeting.

Thank you.

The following is in markdown format and can be viewed by copying and pasting the contents below in an online markdown viewer such as at <https://markdownlivepreview.com/> .

- Set up and **[administrator](https://learn.microsoft.com/en-us/training/modules/administer-fabric/3-admin-role-tools)** the Structures Microsoft Fabric analytics workspace to centralize data to give us previously impossible insights into our business using Power BI reporting and analytic services.
- Set up and administor the Structures **[data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)** to achieve the goal of accessing on-prem data from Power BI analytic and reporting services made available in our Microsoft Fabric workspace.
- Set up and administor the Structures **[MicroCloud](https://canonical.com/microcloud)** which is the supporting platform base of our data gateway and on-prem K8s based services such as the automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)**.
- Provide disaster recovery and meet corporate Recovery Time Objective (RTO) and Recovery Point Objective (RPO) for applications and data in the Structures MicroCloud using Ceph Storage clusters' Multisite [RGW replication](https://ceph.io/en/news/blog/2025/rgw-multisite-replication_part1/) and **[One-way (Active-Passive) RBD mirroring](https://docs.ceph.com/en/reef/rbd/rbd-mirroring/)** features to ensure data is available at a secondary location.
- Set up and administer, in a consistent manner, Structures on-prem and multi-cloud **[Charmed Kubernetes](https://ubuntu.com/kubernetes/charmed-k8s)** Clusters used to run and manage the software lifecycle for services such as the automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** and **Tool Management System**.
- Set up an automated and on-demand **[ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** as a containerized service in K8s to support the goal of centralizing Structures data to give us previously impossible insights into our business using Power BI reporting and analytic services.
- **Tool Management System:** Move from managing CNC tooling in Excel and the Legacy Busche Tool List system to a modern, more robust, easy-to-use platform.
- **CNC tool adjustment app:** It will be used to record tool adjustment data that was previously only availble by looking at a paper CMM report or pdf file, and will help us to more easily identify and resolve part quality issues.
- Tool Tracker Focused **[Manufacturing Execution System:](https://www.ibm.com/think/topics/mes-system)** Automatically collect and report on CNC, job, and start/end tool operation times for costly problematic tooling.

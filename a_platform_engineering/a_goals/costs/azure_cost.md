# Azure Resource Cost Summary and Business Justification

Hi Team,

This is a cost summary and business justification for the Structures Azure SQL database and Azure Kubernetes Cluster (AKS) resources. We may be moving the Structures Azure SQL database to Microsoft Fabric, which could affect the cost summary. Included are combined and individual cost summaries in Canadian dollars on July 8th.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

Resources: Structures Azure SQL database and Azure Kubernetes Cluster (AKS)

Business Justification: The Structures Azure SQL database and Kubernetes Cluster (AKS) will be used to run the production versions of Structures software such as the Automated **[ETL](https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/etl)** and Reporting System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These software projects are in development. The Azure resources are for all of Linamar Structures, but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Azure SQL database

- Single Database, DTU Purchase Model, Standard Tier, S1: 20 DTUs, 250 GB included storage per DB, 1 Database(s) x 730 Hours, 250 GB Storage, RA-GRS Backup Storage Redundancy,  3 x 20 GB Long Term Retention
- There is a good chance we will move the Structures Azure SQL database to Microsoft Fabric soon. Tarek Mohamed, Data and Analytics IT, Supervisor.
- **[Geo-redundant storage (GRS)](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql#backup-storage-redundancy)**
- **[Point-In-Time Restore](https://learn.microsoft.com/en-us/azure/azure-sql/database/recovery-using-backups?view=azuresql&tabs=azure-portal#point-in-time-restore)**

## Kubernetes

**[Azure Kubernetes, AKS](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-start-here?toc=%2Fazure%2Faks%2Ftoc.json&bc=%2Fazure%2Faks%2Fbreadcrumb%2Ftoc.json)**:

- Standard; Cluster management for 1 clusters; 1 D8 v3 (8 vCPUs, 32 GB RAM) x 160 Hours (Pay as you go), Linux; 1 managed OS disk – E10
- One **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
- **[160 hours per month](https://learn.microsoft.com/en-us/azure/aks/start-stop-cluster?tabs=azure-cli)**

OnPrem Kubernetes Cluster:

This entirely open-source Kubernetes cluster is used for development, but can be upgraded for production usage.

- 3 Dell Power Edge R620s.
- Testing **[MicroCloud](https://canonical.com/microcloud)** which is a fancy name for an **[LXD](https://canonical.com/lxd)**, **[OVN](https://www.ovn.org/en/)**, **[Ceph](https://docs.ceph.com/)** cluster for VMs and containers. Run Kubernetes on physical, r620s, or in LXD VMs.
- Open source Kubernetes cluster.
- Not as hands-off as AKS.

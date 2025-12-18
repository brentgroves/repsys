# Azure cost

Project: Structures Azure Kubernetes Cluster (AKS)

Business Justification: The Structures Azure Kubernetes Cluster (AKS) will be used to run Structures software such as the Automated **[ETL](https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/etl)** and Reporting System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are in development and are for all of Linamar Structures, but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Mobex tenant

No longer needed.

## Azure SQL database

```bash
Subscription name                     Subscription ID                       Tenant
------------------------------------  ------------------------------------  ------------------
LinamarCorporation Special Projec...  6fdb2836-d884-43d9-806d-78e653dbe236  LinamarCorporation

Resource Group              Location
--------------------------  -------------
Structures-SP-repsys-CC-RG  canadacentral

Resource                    Location
--------------------------  -------------
Structures-SP-repsys-CC-RG  centralus
```

### Notes

- Yes, in Azure, you can create a resource within a resource group that is located in a different region than the resource group itself; meaning you can place a resource in a different location than where the resource group metadata is stored, allowing you to distribute resources across various regions even if they belong to the same resource group.
- probably moving Structures Azure SQL database to Microsoft Fabric soon. Tarek Mohamed, Data and Analytics IT, Supervisor
- **[Geo-redundant storage (GRS)](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql#backup-storage-redundancy)**
- **[Point-In-Time Restore](https://learn.microsoft.com/en-us/azure/azure-sql/database/recovery-using-backups?view=azuresql&tabs=azure-portal#point-in-time-restore)**

## Kubernetes

OnPrem:

- 3 Dell Power Edge R620s.
- Testing **[MicroCloud](https://canonical.com/microcloud)** which is a fancy name for an **[LXD](https://canonical.com/lxd)**, **[OVN](https://www.ovn.org/en/)**, **[Ceph](https://docs.ceph.com/)** cluster for VMs and containers. Run Kubernetes on physical, r620s, or in LXD VMs.
- Open source Kubernetes cluster.
- Not as hands off as AKS.

**[Azure Kubernetes, AKS](https://learn.microsoft.com/en-us/azure/aks/)**:

- One **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
- **[40 hours per month](https://learn.microsoft.com/en-us/azure/aks/start-stop-cluster?tabs=azure-cli)**

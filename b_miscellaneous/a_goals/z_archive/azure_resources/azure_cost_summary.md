# Mobex to Linamar Azure tenant migration

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

Found an **[article](https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster)** describing a way to stop the cluster when not in use which will significantly save cost.

## Players

- Adrian Wise
- Kristian Smith
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall
- Kevin Young
- Jared Davis
- Dan Martin
- Heather Luttrell

## Azure Cost Summary

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - $497.51CAD/month
  - $345.24USD/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
  - Second resource group. When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - $46.66CAD/month
  - $32.38USD/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

- **[Storage Mangaged Disks](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - $4.09CAD/month
  - $2.84USD/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.


## **[Azure Cost Savings](https://trstringer.com/cheap-kubernetes-in-azure/)**

### Stop your cluster

AKS just recently introduced a new feature to **[stop and start a Kubernetes cluster](https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster)**. Until we start running reports and we complete the the Tool Management and Tracker software, we can stop it often. 

To stop the cluster, it is as easy as running:

```bash
$ az aks stop \
    --resource-group <resource_group> \
    --name <aks>
```

![stopped cluster cost](https://trstringer.com/images/aks-cheap-off.png)

Our cluster may cost a little more but this stopped cluster only costs $4.05USD per week. That’s only $0.58USD per day!


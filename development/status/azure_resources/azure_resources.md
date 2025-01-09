# Azure Resource Usage and Configuration Summary

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Recommendation

I work with Amir to create these resources from the az cli.
- I need to finish it so I will need admin access.
- Manual install from the command line is better because you can easily reproduce the cluster if we want to move it, get it back to a set state, or delete the cluster to change it slightly which I do often. 

## Azure resources

We mostly use "free and open source software" on our on-prem Kubernetes Cluster.  The following costs are for the cloud-based version of the report system and are only needed for Microsoft Teams tab accessibility.

- Create a reports-aks resource group and add me as a contributer. This group will contain an azure keyvault.
- Create an active directory group called reports-aks and add me to it. This is so that the K8s user can access the Azure keyvault and create more secure secrets than provided by K8s.
- Create a repsys resource group for the cluster and give me contributer or admin rights to it.
- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - mTLS secured gateway
  - cost $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

| instance | vCPU | RAM    | Temp Storage | Pay as you go   | 1 year savings plan          | 3 year savings plan          | Spot                        |
|----------|------|--------|--------------|-----------------|------------------------------|------------------------------|-----------------------------|
| D8v3     | 8    | 32 GiB | 200 GiB      | $280.3200/month | $193.4208/month ~31% savings | $131.7504/month ~53% savings | $39.2448/month ~85% savings |

## second resource group

When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

```bash
az aks list --resource-group "MC_reports-aks_repsys1_centralus"

The behavior of this command has been altered by the following extension: aks-preview
[]

```

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - **[Secured by Server Level IP Firewall rule](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**
  - cost $50/month
  - Current db was created with the standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.


## Configuration Needs

- **[Register App with Azure Entra](https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2)**

- **[Create Azure SQL DB firewall rules](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**

- **[Add 5 DNS records to completely secure emails](https://help.mailtrap.io/article/79-dns-records#why)**

  - CNAME domain verification
  - SPF
  - DKIM (2)
  - DMARC

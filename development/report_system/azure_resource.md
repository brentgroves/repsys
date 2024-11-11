# Azure Resource Usage and Configuration Summary

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Recommend

Recreate or transfer ownership of all resources in the reports-aks resource group.

## Azure resources

We mostly use Free-Tier services or "free and open source software" on our on-prem Kubernetes Cluster.  The following costs are for the cloud-based version of the report system and are only needed for Microsoft Teams tab accessibility.

- A secure **[container registry](https://azure.microsoft.com/en-us/products/container-registry)** to store images of custom and OSS software used by our report system running on our Azure AKS cluster.
  - cost $10/month
  
- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - mTLS secured gateway
  - cost $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - **[Secured by Server Level IP Firewall rule](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**
  - cost $50/month
  - Current db was created with the standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

- **[Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)** for TLS certificates and other secrets.

## Configuration Needs

- **[Register App with Azure Entra](https://auth0.com/docs/authenticate/identity-providers/enterprise-identity-providers/azure-active-directory/v2)**

- **[Create Azure SQL DB firewall rules](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart?view=azuresql)**

- **[Add 5 DNS records to completely secure emails](https://help.mailtrap.io/article/79-dns-records#why)**

  - CNAME domain verification
  - SPF
  - DKIM (2)
  - DMARC

## Other Azure Resource Usages

- **[Azure Blob Storage:](https://azure.microsoft.com/en-us/products/storage/blobs)** Could be used as a replacement for the Minio S3 compatible storage running in our Kubernetes Clusters.

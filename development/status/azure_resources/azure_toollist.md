# Azure Resource and Busche Tool List

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Topics

- Can we create a Azure SQL database with the standard S1 service tier and 20 DTU capacity at $50/month for the report system.
- Is it ok to put the Busche Tool list in that Azure SQL database?

## What is being requested?

A way to run the "Where Used" and "Tool List" Crystal Reports.

### 1. Current Way

- The laptops and desktops have Crystal Report Viewer installed and a connection to a share containing the Crystal reports and ODBC DSNs.
- A central share containing Crystal reports and multiple ODBC DSNs.

## 2. VM Way

- Crystal Report Viewer.
- A Share containing Crystal reports and ODBC DSNs.

## Reason for request

- All Job Tooling data from 2004 until the time Mobex Global bought Busche was entered in the Busche Tool List SQL database.
- Several Crystal reports access this database to identify tooling associated with each job.
- We need to get rid of tooling no longer needed.

## Azure resources

We mostly use "free and open source software" on our on-prem Kubernetes Cluster.  The following costs are for the cloud-based version of the report system and are only needed for Microsoft Teams tab accessibility.

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - mTLS secured gateway
  - cost $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

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

# Azure Virtual Desktop, Azure SQL DB, and Busche Tool List

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Topics

- Can we create a Azure SQL database with the standard S1 service tier and 20 DTU capacity at $50/month for the report system.
- Is it ok to put the Busche Tool list in that Azure SQL database?

## What is discussed?

A way to run the "Where Used" and "Tool List" Crystal Reports.

### 1. Current Way

- The laptops and desktops have Crystal Report Viewer installed and a connection to a share containing the Crystal reports and ODBC DSNs.
- A central share containing Crystal reports and multiple ODBC DSNs.

## 2. **[Azure Virtual Desktop Way](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)**

Securely deliver virtual desktops and applications remotely with maximum control to any device from a flexible cloud virtual desktop infrastructure (VDI) platform. Bring together Microsoft 365 and Azure to provide users with the only multi-session Windows 11 and Windows 10 experience, with exceptional scale and reduced IT costs.

Only manage the image and virtual machines you use for the sessions in your Azure subscription, not the infrastructure. You don't need to personally manage the supporting infrastructure roles, such as a gateway or broker, like you do with Remote Desktop Services.

**[Windows 10 or Windows 11 Enterprise multi-session remote desktops](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)**

Windows 10 or Windows 11 Enterprise multi-session is a new Remote Desktop Session Host exclusive to **[Azure Virtual Desktop on Azure](https://learn.microsoft.com/en-us/azure/virtual-desktop/)**. It provides the following benefits:

- Allows multiple concurrent user sessions.
- Gives users a familiar Windows 10 or Windows 11 experience.
- Supports use of existing per-user Microsoft 365 licensing.

- Crystal Report Viewer.
- A Share containing Crystal reports and ODBC DSNs.

## For either way

- **[File Share Option](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction#why-azure-files-is-useful)**

Why Azure Files is useful

You can use Azure file shares to:

- "Lift and shift" applications:
Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store file application or user data. Azure Files enables both the "classic" lift and shift scenario, where both the application and its data are moved to Azure, and the "hybrid" lift and shift scenario, where the application data is moved to Azure Files, and the application continues to run on-premises.

- Replace or supplement on-premises file servers:
Use Azure Files to replace or supplement traditional on-premises file servers or network-attached storage (NAS) devices. Popular operating systems such as Windows, macOS, and Linux can directly mount Azure file shares wherever they are in the world. SMB Azure file shares can also be replicated with Azure File Sync to Windows servers, either on-premises or in the cloud, for performance and distributed caching of the data. With **[Azure Files AD Authentication](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview)**, SMB Azure file shares can work with Active Directory Domain Services (AD DS) hosted on-premises for access control.

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

# Azure Virtual Desktop, Azure SQL DB, and Busche Tool List

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## What is being requested

A way to run the "Where Used" and "Tool List" Crystal Reports.

## Reason for request

- All Job Tooling data from 2004 until the time Mobex Global bought Busche was entered in the Busche Tool List SQL database.
- Several Crystal reports access this database to identify tooling associated with each job.
- We need to get rid of tooling no longer needed.

## Topics

- Current Status. 
  - On-prem VM running on server VLAN. 
  - Need to Install an acceptable SQL Server version. 
  - Need to copy DSN and Crystal Reports to a share accessable to the **[Crystal report viewer](https://www.sap.com/registration/trial.e58efd26-79e3-4f97-8726-10c1327b0538.html)**. 
  - **[SQL Server 2019](https://learn.microsoft.com/en-us/sql/database-engine/install-windows/supported-version-and-edition-upgrades-2019?view=sql-server-ver16)** would work.
  - When you **[install 2019](https://learn.microsoft.com/en-us/answers/questions/1166282/how-to-update-sql-server-2012-to-2019)**, pick update existing instance. You should be sure to backup the databases first in case of any issues.  
- Alternate Way
  - What do you think of using an Azure SQL IP firewalled database with the standard S1 service tier and 20 DTU capacity at $50/month for the Busche Tool List this also could be used for the report system?
  - What do you think of using an **[Azure Virtual Desktop](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)** to access the Busche Tool list Crystal reports?
  - What do you thing of using an **[Azure File Share](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction#why-azure-files-is-useful)** to store the Crystal Reports and DSN?

### 1. Current Way

- The laptops and desktops have Crystal Report Viewer installed and a connection to a share containing the Crystal reports and ODBC DSNs.
- A central share containing Crystal reports and multiple ODBC DSNs.

### 2. **[Azure Virtual Desktop Way](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)**

**[Windows 10 or Windows 11 Enterprise multi-session remote desktops](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)**

Windows 10 or Windows 11 Enterprise multi-session is a new Remote Desktop Session Host exclusive to **[Azure Virtual Desktop on Azure](https://learn.microsoft.com/en-us/azure/virtual-desktop/)**. It provides the following benefits:

- Allows multiple concurrent user sessions.
- Gives users a familiar Windows 10 or Windows 11 experience.
- Supports use of existing per-user Microsoft 365 licensing.

- Crystal Report Viewer.
- A Share containing Crystal reports and ODBC DSNs.

#### Azure Virtual Desktop cost

When using Windows 10 or 11 Enterprise multi-session for remote desktops, the primary cost is tied to the Azure Virtual Desktop (AVD) service, where you can access these desktops at no additional cost if you already have an eligible Windows or Microsoft 365 license; essentially, the cost is primarily based on the underlying Azure VM resources you provision for your desktop environment, including CPU, memory, and storage.

cost: $350/month for **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

### For either way use an **[Azure File Share](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction#why-azure-files-is-useful)**

#### **Why Azure Files is useful?:**

- "Lift and shift" applications:
Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store file application or user data. Azure Files enables both the "classic" lift and shift scenario, where both the application and its data are moved to Azure, and the "hybrid" lift and shift scenario, where the application data is moved to Azure Files, and the application continues to run on-premises.

- Replace or supplement on-premises file servers:
Use Azure Files to replace or supplement traditional on-premises file servers or network-attached storage (NAS) devices. Popular operating systems such as Windows, macOS, and Linux can directly mount Azure file shares wherever they are in the world. SMB Azure file shares can also be replicated with Azure File Sync to Windows servers, either on-premises or in the cloud, for performance and distributed caching of the data. With **[Azure Files AD Authentication](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-active-directory-overview)**, SMB Azure file shares can work with Active Directory Domain Services (AD DS) hosted on-premises for access control.

## **[Azure Files Pricing](https://azure.microsoft.com/en-us/pricing/details/storage/files/)**

### Provisioned v2

In a provisioned model, the primary costs of the Azure file share are based on the amount of storage, IOPS, and throughput you provision when you create or update your file share, regardless of how much you use. With the provisioned v2 billing model, you have the ability to separately provision storage, IOPS, and throughput, although we will recommend IOPS and throughput provisioning to you based on the amount of provisioned storage you select. For more information on the provisioned v2 billing model, see **[understanding the provisioned v2 billing model](https://go.microsoft.com/fwlink/?linkid=2286278&clcid=0x409)**.

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

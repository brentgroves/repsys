# **[Configure and manage Microsoft Entra authentication with Azure SQL](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-portal)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

This article shows you how to use Microsoft Entra ID for authentication with Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics.

Alternatively, you can also **[configure Microsoft Entra authentication for SQL Server on Azure Virtual Machines](https://learn.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/configure-azure-ad-authentication-for-sql-vm?view=azuresql)**.

## Prerequisites

To use Microsoft Entra authentication with your Azure SQL resource, you need the following prerequisites:

- A Microsoft Entra tenant populated with users and groups.
- An existing Azure SQL resource, such as Azure SQL Database, or Azure SQL Managed Instance.

## Create and populate a Microsoft Entra tenant

Before you can configure Microsoft Entra authentication for your Azure SQL resource, you need to create a Microsoft Entra tenant and populate it with users and groups. Microsoft Entra tenants can be managed entirely within Azure or used for the federation of an on-premises Active Directory Domain Service.

For more information, see:

- What is Microsoft Entra ID?
- Integrating your on-premises identities with Microsoft Entra ID
- **[Add your domain name to Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/add-custom-domain)**
What is federation with Microsoft Entra ID?
Directory synchronization with Microsoft Entra ID
Manage Microsoft Entra ID using Windows PowerShell
Hybrid Identity Required Ports and Protocols

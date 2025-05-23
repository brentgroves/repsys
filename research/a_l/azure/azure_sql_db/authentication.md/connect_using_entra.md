# **[Connect to Azure SQL resource with Microsoft Entra authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-microsoft-entra-connect-to-azure-sql?view=azuresql)**

<!-- https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-cli -->

This article shows you how to use Microsoft Entra authentication to connect to Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics.

## Prerequisites

To connect to your Azure SQL resource, you need to have **[configured Microsoft Entra authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql)** for your resource.

To confirm the Microsoft Entra administrator is properly set up, connect to the master database using the Microsoft Entra administrator account. To create a Microsoft Entra-based contained database user, connect to the database with a Microsoft Entra identity with access to the database and at least the ALTER ANY USER permission.

## Connect with SSMS or SSDT

The following procedures show you how to connect to SQL Database with a Microsoft Entra identity using SQL Server Management Studio (SSMS) or SQL Server Database Tools (SSDT).

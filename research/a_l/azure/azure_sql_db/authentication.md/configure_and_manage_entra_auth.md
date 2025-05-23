# **[Configure and manage Microsoft Entra authentication with Azure SQL](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-cli)**

## Prerequisites

Set Microsoft Entra admin
Assign Microsoft Graph permissions
Create Microsoft Entra principals in SQL
Configure multifactor authentication
Connect with Microsoft Entra
Troubleshoot Microsoft Entra authentication
Related content

This article shows you how to use Microsoft Entra ID for authentication with Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics.

Microsoft Entra ID was previously known as Azure Active Directory (Azure AD).

Alternatively, you can also configure Microsoft Entra authentication for SQL Server on Azure Virtual Machines.

## Prerequisites

To use Microsoft Entra authentication with your Azure SQL resource, you need the following prerequisites:

- A Microsoft Entra tenant populated with users and groups.
- An existing Azure SQL resource, such as Azure SQL Database, or Azure SQL Managed Instance.

## Create and populate a Microsoft Entra tenant

Before you can configure Microsoft Entra authentication for your Azure SQL resource, you need to create a Microsoft Entra tenant and populate it with users and groups. Microsoft Entra tenants can be managed entirely within Azure or used for the federation of an on-premises Active Directory Domain Service.

For more information, see:

What is Microsoft Entra ID?
Integrating your on-premises identities with Microsoft Entra ID
Add your domain name to Microsoft Entra ID
What is federation with Microsoft Entra ID?
Directory synchronization with Microsoft Entra ID
Manage Microsoft Entra ID using Windows PowerShell
Hybrid Identity Required Ports and Protocols

## Set Microsoft Entra admin

To use Microsoft Entra authentication with your resource, it needs to have the Microsoft Entra administrator set. While conceptually the steps are the same for Azure SQL Database, Azure Synapse Analytics, and Azure SQL Managed Instance, this section describes in detail the different APIs and portal experiences to do so per product.

The Microsoft Entra admin can also be configured when the Azure SQL resource is created. If a Microsoft Entra admin is already configured, skip this section.

## Azure SQL Database and Azure Synapse Analytics

Setting the Microsoft Entra admin enables Microsoft Entra authentication for your logical server for Azure SQL Database and Azure Synapse Analytics. You can set a Microsoft Entra admin for your server by using the Azure portal, PowerShell, Azure CLI, or REST APIs.

In the Azure portal, you can find the logical server name

In the server name field on the Overview page of Azure SQL Database.
In the server name field on the Overview page of your standalone dedicated SQL pool in Azure Synapse Analytics.
In the relevant SQL endpoint on the Overview page of your Azure Synapse Analytics workspace.

You can set a Microsoft Entra admin for Azure SQL Database and Azure Synapse Analytics with the following Azure CLI commands:

| Command                       | Description                                                                                                                                |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| az sql server ad-admin create | Sets a Microsoft Entra administrator for the logical server hosting SQL Database or Azure Synapse Analytics.                               |
| az sql server ad-admin delete | Removes a Microsoft Entra administrator from the logical server hosting the SQL Database or Azure Synapse Analytics.                       |
| az sql server ad-admin list   | Returns information about the Microsoft Entra administrator configured for the server hosting the SQL Database or Azure Synapse Analytics. |
| az sql server ad-admin update | Updates the Microsoft Entra administrator for the server hosting the SQL Database or Azure Synapse Analytics.                              |

For more CLI commands, see az sql server.

 Note

The Microsoft Entra admin is stored in the server's master database as a user (database principal). Since database principal names must be unique, the display name of the admin can't be the same as the name of any user in the server's master database. If a user with the name already exists, the Microsoft Entra admin setup fails and rolls back, indicating that the name is already in use.

## Assign Microsoft Graph permissions

SQL Managed Instance needs permissions to read Microsoft Entra ID for scenarios like authorizing users who connect through security group membership and new user creation. For Microsoft Entra authentication to work, you need to assign the managed instance identity to the Directory Readers role. You can do this using the Azure portal or PowerShell.

For some operations, **Azure SQL Database and Azure Synapse Analytics** also require permissions to query Microsoft Graph, explained in **[Microsoft Graph permissions](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql#microsoft-graph-permissions)**. Azure SQL Database and Azure Synapse Analytics support fine-grained Graph permissions for these scenarios, whereas SQL Managed Instance requires the Directory Readers role. Fine-grained permissions and their assignment are described in detail in enable service principals to create Microsoft Entra users.

See details for how to assign Azure roles via the Azure CLI here **[Assign Azure roles using Azure CLI](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-cli)**.

## Create Microsoft Entra principals in SQL

To connect to a database in SQL Database or Azure Synapse Analytics with Microsoft Entra authentication, a principal has to be configured on the database for that identity with at least the CONNECT permission.

## Database user permissions

When a database user is created, it receives the CONNECT permission to the database by default. A database user also inherits permissions in two circumstances:

If the user is a member of a Microsoft Entra group that's also assigned permissions on the server.
If the user is created from a login, it inherits the server-assigned permissions of the login applicable on the database.
Managing permissions for server and database principals works the same regardless of the type of principal (Microsoft Entra ID, SQL authentication, etc.). We recommend granting permissions to database roles instead of directly granting permissions to users. Then users can be added to roles with appropriate permissions. This simplifies long-term permissions management and reduces the likelihood of an identity retaining access past when is appropriate.

For more information, see:

- **[Database engine permissions and examples](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine)**
- **[Blog: Database Engine permission basics](https://techcommunity.microsoft.com/t5/sql-server-blog/database-engine-permission-basics/ba-p/383905)**
- **[Managing special databases roles and logins in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?view=azuresql)**

## Contained database users

A contained database user is a type of SQL user that isn't connected to a login in the master database. To create a Microsoft Entra contained database user, connect to the database with a Microsoft Entra identity that has at least the ALTER ANY USER permission. The following T-SQL example creates a database principal Microsoft_Entra_principal_name from Microsoft Entra ID.

```sql
CREATE USER [<Microsoft_Entra_principal_name>] FROM EXTERNAL PROVIDER;
```

create a contained database user for a Microsoft Entra group, enter the display name of the group:

```sql
CREATE USER [ICU Nurses] FROM EXTERNAL PROVIDER;
```

To create a contained database user for a managed identity or service principal, enter the display name of the identity:

```sql
CREATE USER [appName] FROM EXTERNAL PROVIDER;
```

To create a contained database user for a Microsoft Entra user, enter the user principal name of the identity:

```sql
CREATE USER [adrian@contoso.com] FROM EXTERNAL PROVIDER;
```

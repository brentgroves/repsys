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

## Set Microsoft Entra admin

To use Microsoft Entra authentication with your resource, it needs to have the Microsoft Entra administrator set. While conceptually the steps are the same for Azure SQL Database, Azure Synapse Analytics, and Azure SQL Managed Instance, this section describes in detail the different APIs and portal experiences to do so per product.

The Microsoft Entra admin can also be configured when the Azure SQL resource is created. If a Microsoft Entra admin is already configured, skip this section.

## Azure SQL Database and Azure Synapse Analytics

Setting the Microsoft Entra admin enables Microsoft Entra authentication for your **[logical server](https://learn.microsoft.com/en-us/azure/azure-sql/database/logical-servers?view=azuresql)** for Azure SQL Database and Azure Synapse Analytics. You can set a Microsoft Entra admin for your server by using the Azure portal, PowerShell, Azure CLI, or REST APIs.
In the Azure portal, you can find the logical server name

- In the server name field on the Overview page of Azure SQL Database.
- In the server name field on the Overview page of your standalone dedicated SQL pool in Azure Synapse Analytics.
- In the relevant SQL endpoint on the Overview page of your Azure Synapse Analytics workspace.

## Azure CLI

You can set a Microsoft Entra admin for Azure SQL Database and Azure Synapse Analytics with the following Azure CLI commands:

```bash
az sql server list

az sql server list --output json --query '[].{administratorLogin:administratorLogin,fullyQualifiedDomainName:fullyQualifiedDomainName,location:location,id:id,name:name,version:version}'

```

 Note

The Microsoft Entra admin is stored in the server's master database as a user (database principal). Since database principal names must be unique, the display name of the admin can't be the same as the name of any user in the server's master database. If a user with the name already exists, the Microsoft Entra admin setup fails and rolls back, indicating that the name is already in use.

## Is there already a server admin?

```bash
# az sql server ad-admin list [--ids]
#                             [--resource-group]
#                             [--server]
#                             [--subscription]

az sql server ad-admin list --server $SERVER --resource-group "$RESOURCE_GROUP"  --debug
```

## Create Microsoft Entra admin

```bash
# az sql server ad-admin create --display-name
#                               --object-id
#                               --resource-group
#                               --server

# --display-name -u
# Display name of the Azure AD administrator user or group.

# --object-id -i
# The unique ID of the Azure AD administrator.

# --resource-group -g
# Name of resource group. You can configure the default group using az configure --defaults group=<name>.

# --server --server-name -s
# Name of the Azure SQL Server. You can configure the default using az configure --defaults sql-server=<name>.

# az ad user show --id "175774d2-02a8-459c-9570-8ad0ec49ea7c"
# {
#   "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
#   "businessPhones": [],
#   "displayName": "Brent Groves",
#   "givenName": "Brent",
#   "id": "175774d2-02a8-459c-9570-8ad0ec49ea7c",
#   "jobTitle": "IS Administrator",
#   "mail": "Brent.Groves@Linamar.com",
#   "mobilePhone": null,
#   "officeLocation": "Linamar",
#   "preferredLanguage": null,
#   "surname": "Groves",
#   "userPrincipalName": "bGroves@linamar.com"
# }

az sql server ad-admin create --display-name "Brent Groves" --object-id "175774d2-02a8-459c-9570-8ad0ec49ea7c" --resource-group "$RESOURCE_GROUP" --name $SERVER

# check

az sql server ad-admin list --server $SERVER --resource-group "$RESOURCE_GROUP"  --debug

```

## Assign Microsoft Graph permissions

SQL Managed Instance needs permissions to read Microsoft Entra ID for scenarios like authorizing users who connect through security group membership and new user creation. For Microsoft Entra authentication to work, you need to assign the managed instance identity to the Directory Readers role. You can do this using the Azure portal or PowerShell.

For some operations, Azure SQL Database and Azure Synapse Analytics also require permissions to query Microsoft Graph, explained in Microsoft Graph permissions. Azure SQL Database and Azure Synapse Analytics support fine-grained Graph permissions for these scenarios, whereas SQL Managed Instance requires the Directory Readers role. Fine-grained permissions and their assignment are described in detail in enable service principals to create Microsoft Entra users.

## Azure Portal

To set the Microsoft Entra admin for your logical server in the Azure portal, follow these steps:

1. In the Azure portal Directories + subscriptions pane, choose the directory that contains your Azure SQL resource as the Current directory.

2. Search for SQL servers and then select the logical server for your database resource to open the SQL server pane.

    ![sn](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-aad-configure/search-for-and-select-sql-servers.png?view=azuresql)

3. On the SQL server pane for your logical server, select Microsoft Entra ID under Settings to open the Microsoft Entra ID pane.

4. On the Microsoft Entra ID pane, select Set admin to open the Microsoft Entra ID pane.

    ![on](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-aad-configure/sql-servers-set-active-directory-admin.png?view=azuresql#lightbox)

5. The Microsoft Entra ID pane shows all users, groups, and applications in your current directory and allows you to search by name, alias, or ID. Find your desired identity for your Microsoft Entra admin and select it, then click Select to close the pane.

6. At the top of the Microsoft Entra ID page for your logical server, select Save.

    ![s](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-aad-configure/save.png?view=azuresql#lightbox)

The Object ID is displayed next to the admin name for Microsoft Entra users and groups. For applications (service principals), the Application ID is displayed.

The process of changing the administrator might take several minutes. Then the new administrator appears in the Microsoft Entra admin field.

To remove the admin, at the top of the Microsoft Entra ID page, select Remove admin, then select Save. Removing the Microsoft Entra admin disables Microsoft Entra authentication for your logical server.

The Microsoft Entra admin is stored in the server's master database as a user (database principal). Since database principal names must be unique, the display name of the admin can't be the same as the name of any user in the server's master database. If a user with the name already exists, the Microsoft Entra admin setup fails and rolls back, indicating that the name is already in use.

## Assign Microsoft Graph permissions

SQL Managed Instance needs permissions to read Microsoft Entra ID for scenarios like authorizing users who connect through security group membership and new user creation. For Microsoft Entra authentication to work, you need to assign the managed instance identity to the Directory Readers role. You can do this using the Azure portal or PowerShell.

For some operations, Azure SQL Database and Azure Synapse Analytics also require permissions to query Microsoft Graph, explained in Microsoft Graph permissions. Azure SQL Database and Azure Synapse Analytics support fine-grained Graph permissions for these scenarios, whereas SQL Managed Instance requires the Directory Readers role. Fine-grained permissions and their assignment are described in detail in **[enable service principals to create Microsoft Entra users](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-service-principal?view=azuresql#enable-service-principals-to-create-azure-ad-users)**.

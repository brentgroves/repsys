# **[Set Microsoft Entra admin](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-cli#set-microsoft-entra-admin)**

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

```bash
pushd .
cd ~/src/azure/linamar.com/sqldb
source set_vars.sh
az login
# is there already an Entra admin
az sql server ad-admin list --server $SERVER --resource-group "$RESOURCE_GROUP"
[
  {
    "administratorType": "ActiveDirectory",
    "azureAdOnlyAuthentication": null,
    "id": "/subscriptions/6fdb2836-d884-43d9-806d-78e653dbe236/resourceGroups/Structures-SP-repsys-CC-RG/providers/Microsoft.Sql/servers/repsys1/administrators/ActiveDirectory",
    "login": "Brent Groves",
    "name": "ActiveDirectory",
    "resourceGroup": "Structures-SP-repsys-CC-RG",
    "sid": "175774d2-02a8-459c-9570-8ad0ec49ea7c",
    "tenantId": "ceadc058-fad7-4b6b-830b-00ac739654f0",
    "type": "Microsoft.Sql/servers"
  }
]
# id is sid in az sql server ad-admin list

# to create a entra admin 
az sql server ad-admin create --display-name "Brent Groves" --object-id "175774d2-02a8-459c-9570-8ad0ec49ea7c" --resource-group "$RESOURCE_GROUP" --server $SERVER
```

# **[Azure SQL Database and Azure Synapse IP firewall rules](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-configure?view=azuresql)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../README.md)**

When you create a new server in Azure SQL Database or Azure Synapse Analytics named mysqlserver, for example, a server-level firewall blocks all access to the public endpoint for the server (which is accessible at mysqlserver.database.windows.net). For simplicity, SQL Database is used to refer to both SQL Database and Azure Synapse Analytics. This article does not apply to Azure SQL Managed Instance. For information about network configuration, see **[Connect your application to Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/connect-application-instance?view=azuresql)**.

## How the firewall works

Connection attempts from the internet and Azure must pass through the firewall before they reach your server or database, as the following diagram shows.

![hw](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/firewall-configure/sqldb-firewall-1.png?view=azuresql)**

Azure Synapse only supports server-level IP firewall rules. It doesn't support database-level IP firewall rules.

## Server-level IP firewall rules

These rules enable clients to access your entire server, that is, all the databases managed by the server. The rules are stored in the master database. The maximum number of server-level IP firewall rules is limited to 256 for a server. If you have the Allow Azure Services and resources to access this server setting enabled, this counts as a single firewall rule for the server.

You can configure server-level IP firewall rules by using the Azure portal, PowerShell, or Transact-SQL statements.

The maximum number of server-level IP firewall rules is limited to 256 when configuring using the Azure portal.

- To use the portal or PowerShell, you must be the subscription owner or a subscription contributor.
- To use Transact-SQL, you must connect to the master database as the server-level principal login or as the Microsoft Entra administrator. (A server-level IP firewall rule must first be created by a user who has Azure-level permissions.)

By default, during creation of a new logical SQL server from the Azure portal, the Allow Azure Services and resources to access this server setting is set to No.

## Database-level IP firewall rules

Database-level IP firewall rules enable clients to access certain (secure) databases. You create the rules for each database (including the master database), and they're stored in the individual database.

- You can only create and manage database-level IP firewall rules for master and user databases by using Transact-SQL statements and only after you configure the first server-level firewall.
- If you specify an IP address range in the database-level IP firewall rule that's outside the range in the server-level IP firewall rule, only those clients that have IP addresses in the database-level range can access the database.
- The default value is up to 256 database-level IP firewall rules for a database. For more information about configuring database-level IP firewall rules, see the example later in this article and see sp_set_database_firewall_rule (Azure SQL Database).

## Recommendations for how to set firewall rules

We recommend that you use database-level IP firewall rules whenever possible. This practice enhances security and makes your database more portable. Use server-level IP firewall rules for administrators. Also use them when you have many databases that have the same access requirements, and you don't want to configure each database individually.

For information about portable databases in the context of business continuity, see **[Authentication requirements for disaster recovery](https://learn.microsoft.com/en-us/azure/azure-sql/database/active-geo-replication-security-configure?view=azuresql)**.

## Server-level versus database-level IP firewall rules

Should users of one database be fully isolated from another database?

If yes, use database-level IP firewall rules to grant access. This method avoids using server-level IP firewall rules, which permit access through the firewall to all databases. That would reduce the depth of your defenses.

## Connections from the internet

When a computer tries to connect to your server from the internet, the firewall first checks the originating IP address of the request against the database-level IP firewall rules for the database that the connection requests.

- If the address is within a range that's specified in the database-level IP firewall rules, the connection is granted to the database that contains the rule.
- If the address isn't within a range in the database-level IP firewall rules, the firewall checks the server-level IP firewall rules. If the address is within a range that's in the server-level IP firewall rules, the connection is granted. Server-level IP firewall rules apply to all databases managed by the server.
- If the address isn't within a range that's in any of the database-level or server-level IP firewall rules, the connection request fails.
 Note

To access Azure SQL Database from your local computer, ensure that the firewall on your network and local computer allow outgoing communication on TCP port 1433.

## Connections from inside Azure

To allow applications hosted inside Azure to connect to your SQL server, Azure connections must be enabled. To enable Azure connections, there must be a firewall rule with starting and ending IP addresses set to 0.0.0.0. This recommended rule is only applicable to Azure SQL Database.

When an application from Azure tries to connect to the server, the firewall checks that Azure connections are allowed by verifying this firewall rule exists. This can be turned on directly from the Azure portal pane by switching the Allow Azure Services and resources to access this server to ON in the Firewalls and virtual networks settings. Switching the setting to ON creates an inbound firewall rule for IP 0.0.0.0 - 0.0.0.0 named AllowAllWindowsAzureIps. The rule can be viewed in your master database **[sys.firewall_rules](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-firewall-rules-azure-sql-database)** view. Use PowerShell or the Azure CLI to create a firewall rule with start and end IP addresses set to 0.0.0.0 if you're not using the portal.

This option configures the firewall to allow all connections from Azure, including connections from the subscriptions of other customers. If you select this option, make sure that your login and user permissions limit access to authorized users only.

## Permissions

To be able to create and manage IP firewall rules for the Azure SQL Server, you will need to either be:

- in the SQL Server Contributor role
- in the SQL Security Manager role
- the owner of the resource that contains the Azure SQL Server

## Create and manage IP firewall rules

You create the first server-level firewall setting by using the Azure portal or programmatically by using Azure PowerShell, Azure CLI, or an Azure REST API. You create and manage additional server-level IP firewall rules by using these methods or Transact-SQL.

Database-level IP firewall rules can only be created and managed by using Transact-SQL.

To improve performance, server-level IP firewall rules are temporarily cached at the database level. To refresh the cache, see DBCC FLUSHAUTHCACHE.

You can use Database Auditing to audit server-level and database-level firewall changes.

## Use the Azure portal to manage server-level IP firewall rules

To set a server-level IP firewall rule in the Azure portal, go to the overview page for your database or your server.

For a tutorial, see **[Create a database using the Azure portal](https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql)**.

## Use CLI to manage server-level IP firewall rules

| Cmdlet                             | Level  | Description                             |
|------------------------------------|--------|-----------------------------------------|
| az sql server firewall-rule create | Server | Creates a server IP firewall rule       |
| az sql server firewall-rule list   | Server | Lists the IP firewall rules on a server |
| az sql server firewall-rule show   | Server | Shows the detail of an IP firewall rule |
| az sql server firewall-rule update | Server | Updates an IP firewall rule             |
| az sql server firewall-rule delete | Server | Deletes an IP firewall rule             |

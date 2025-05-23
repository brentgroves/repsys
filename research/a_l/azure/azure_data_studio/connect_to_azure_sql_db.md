# **[Quickstart: Use Azure Data Studio to connect and query Azure SQL Database](https://learn.microsoft.com/en-us/azure-data-studio/quickstart-sql-database)**

## keyring

```bash
# start passwords and keys program first.
# got errors if used gnome-keyring store
azuredatastudio --password-store="basic"
```

## Prerequisites

Connect to your Azure SQL Database server
Create the tutorial database
Create a table
Insert rows into the table
View the result
Clean up resources
Next steps

Azure Data Studio is retiring on February 28, 2026. We recommend that you use Visual Studio Code. For more information about migrating to Visual Studio Code, visit What's happening to Azure Data Studio?

In this quickstart, you'll use Azure Data Studio to connect to an Azure SQL Database server. You'll then run Transact-SQL (T-SQL) statements to create and query the TutorialDB database, which is used in other Azure Data Studio tutorials.

 Note

While Microsoft Entra ID is the new name for Azure Active Directory (Azure AD), to prevent disrupting existing environments, Azure AD still remains in some hardcoded elements such as UI fields, connection providers, error codes, and cmdlets. In this article, the two names are interchangeable.

## Prerequisites

To complete this quickstart, you need Azure Data Studio, and an Azure SQL Database server.

Install Azure Data Studio
If you don't have an Azure SQL server, complete one of the following Azure SQL Database quickstarts. Remember the fully qualified server name and sign in credentials for later steps:

Create DB - Portal
Create DB - CLI
Create DB - PowerShell

## Connect to your Azure SQL Database server

Use Azure Data Studio to establish a connection to your Azure SQL Database server.

The first time you run Azure Data Studio the Welcome page should open. If you don't see the Welcome page, select Help > Welcome. Select New Connection to open the Connection pane:

![i1](https://learn.microsoft.com/en-us/azure-data-studio/media/quickstart-sql-database/new-connection-icon.png)

This article uses SQL authentication, but Microsoft Entra authentication is supported for all SQL Server products and services. Fill in the following fields using the server name, user name, and password for your Azure SQL server:

| Setting              | Suggested value                    | Description                                                    |
|----------------------|------------------------------------|----------------------------------------------------------------|
| Server name          | The fully qualified server name    | Something like: servername.database.windows.net.               |
| Authentication       | SQL Login                          | This tutorial uses SQL Authentication.                         |
| User name            | The server admin account user name | The user name from the account used to create the server.      |
| Password (SQL Login) | The server admin account password  | The password from the account used to create the server.       |
| Save Password?       | Yes or No                          | Select Yes if you don't want to enter the password each time.  |
| Database name        | leave blank                        | You're only connecting to the server here.                     |
| Server Group         | Select <Default>                   | You can set this field to a specific server group you created. |

![i2](https://learn.microsoft.com/en-us/azure-data-studio/media/quickstart-sql-database/new-connection-screen.png)

Select Connect

If your server doesn't have a firewall rule allowing Azure Data Studio to connect, the Create new firewall rule form opens. Complete the form to create a new firewall rule. For details, see **[Firewall rules](https://learn.microsoft.com/en-us/azure/sql-database/sql-database-firewall-configure)**.

![i2](https://learn.microsoft.com/en-us/azure-data-studio/media/quickstart-sql-database/firewall.png)

After successfully connecting, your server opens in the SERVERS sidebar.

## Create the tutorial database

The next sections create the TutorialDB database that's used in other Azure Data Studio tutorials.

Right-click on your Azure SQL server in the SERVERS sidebar and select New Query.

Paste this SQL into the query editor.

```sql
IF NOT EXISTS (

   SELECT name
   FROM sys.databases
   WHERE name = N'TutorialDB'
)
CREATE DATABASE [TutorialDB]
GO

ALTER DATABASE [TutorialDB] SET QUERY_STORE=ON
GO
```

# **[Quickstart: Use Visual Studio Code to connect and query Azure SQL Database or Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-vscode?view=azuresql)**

Visual Studio Code is a graphical code editor for Linux, macOS, and Windows. It supports extensions, including the mssql extension for querying SQL Server, Azure SQL Database, Azure SQL Managed Instance, SQL database in Microsoft Fabric, and other platforms. In this quickstart, you use Visual Studio Code to connect to Azure SQL Database or Azure SQL Managed Instance and then run Transact-SQL statements to query, insert, update, and delete data.

## Prerequisites

A database in Azure SQL Database or Azure SQL Managed Instance. You can use one of these quickstarts to create and then configure a database in Azure SQL Database:

## Configure Visual Studio Code

To configure Visual Studio Code for connecting to Azure SQL Database or Azure SQL Managed Instance, you need to install the necessary extensions and dependencies based on your operating system. Follow the steps below for your specific OS to get started.

## Linux (Ubuntu)

Load the mssql extension by following these steps:

Open Visual Studio Code.
Open the Extensions pane (or Ctrl + Shift + X).
Search for sql and then install the SQL Server (mssql) extension.
For additional installation guidance, see mssql for Visual Studio Code.

## Get server connection information

Get the connection information you need to connect to Azure SQL Database. You need the fully qualified server name or host name, database name, and login information for the upcoming procedures.

Sign in to the Azure portal.

Navigate to the SQL databases or SQL Managed Instances page.

On the Overview page, review the fully qualified server name next to Server name for SQL Database or the fully qualified server name next to Host for a SQL Managed Instance. To copy the server name or host name, hover over it and select the Copy icon.

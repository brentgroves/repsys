# **[Portability](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver16#portability)**

Database portability is the ability to move a database schema and data between different instances of SQL Server, Azure SQL, and Azure Synapse Analytics. Exporting a database from Azure SQL Database to an on-premises SQL Server instance, or from SQL Server to Azure SQL Database, are examples of database portability. SqlPackage supports database portability through the **[Export](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-export?view=sql-server-ver16)** and Import actions, which create and consume BACPAC files. SqlPackage also supports database portability through the Extract and Publish actions, which create and consume DACPAC files, which can either contain the data directly or reference data stored in Azure Blob Storage.

Export: Exports a connected SQL database - including database schema and user data - to a BACPAC file (.bacpac).

Import: Imports the schema and table data from a BACPAC file into a new user database.

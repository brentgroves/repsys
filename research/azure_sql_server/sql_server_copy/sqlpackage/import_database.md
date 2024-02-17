# Import Azure SQL database

The SqlPackage Import action imports the schema and table data from a BACPAC file (.bacpac) into a new or empty database in SQL Server or Azure SQL Database. At the time of the import operation to an existing database the target database cannot contain any user-defined schema objects. Alternatively, a new database can be created by the import action when the authenticated user has create database permissions.

BACPAC files contain data that is exported using BCP's "native" file format, which is a binary type file. The data for the table is simply exported across multiple files, rather than one big file. If you look through the .bcp files across different tables, you'll find that the file size will vary, with skew in size related to variation in different rows having different data width. For example, when I create a bacpac of AdventureWorks, the .bcp files for Purchasing.PurchaseOrderDetail range from 39kb to 62kb.

BCP (and thus BACPAC generation) does not back up data by copying data pages like a standard backup, but rather is doing table-level querying & exporting.

## example import to Azure SQL Database using SQL authentication and a connection string

```bash
```bash
pushd .
cd ~/sqlpackage
sqlpackage /a:import /tsn:tcp:bgtest.database.windows.net /tdn:test /tu:mgadmin /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mi/script_history.bacpac 

*** Error importing database:Data cannot be imported into target because it contains one or more user objects. Import should be performed against a new, empty database.
Warning SQL0: A project which specifies SQL Server 2022 or Azure SQL Database Managed Instance as the target platform may experience compatibility issues with Microsoft Azure SQL Database v12.
Error SQL71659: Data cannot be imported into target because it contains one or more user objects. Import should be performed against a new, empty database.

Time elapsed 0:01:00.35

```

```bash
*use the following T-SQL command to get your server name:
PRINT @@SERVERNAME
Abbreviations:
/Action: /a
/SourceServerName: /ssn
/SourceDatabaseName: /sdn
/SourceUser:         /su
/SourcePassword: /sp
/TargetFile:         /tf
/Properties:         /p
```

## Next

## Create a database to import into

<https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal>

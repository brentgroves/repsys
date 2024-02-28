# Export Azure SQL Managed Instance database

When you need to export a database for archiving or for moving to another platform, you can export the database schema and data to a BACPAC file. A BACPAC file is a ZIP file with an extension of BACPAC containing the metadata and data from the database. A BACPAC file can be stored in Azure Blob storage or in local storage in an on-premises location and later imported back into Azure SQL Database, Azure SQL Managed Instance, or a SQL Server instance.

BACPAC files contain data that is exported using BCP's "native" file format, which is a binary type file. The data for the table is simply exported across multiple files, rather than one big file. If you look through the .bcp files across different tables, you'll find that the file size will vary, with skew in size related to variation in different rows having different data width. For example, when I create a bacpac of AdventureWorks, the .bcp files for Purchasing.PurchaseOrderDetail range from 39kb to 62kb.

BCP (and thus BACPAC generation) does not back up data by copying data pages like a standard backup, but rather is doing table-level querying & exporting.

## references

<https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-export?view=sql-server-ver16>

<https://www.madeiradata.com/post/how-to-export-a-database-from-azure-managed-instance-to-sql-server-using-sqlpackage-exe>

<https://www.youtube.com/watch?v=1yZ70VhftnI>

<https://learn.microsoft.com/en-us/azure/azure-sql/database/database-export?view=azuresql>

## SqlPackage Export

The SqlPackage Export action exports a connected database to a BACPAC file (.bacpac). By default, data for all tables will be included in the .bacpac file. Optionally, you can specify only a subset of tables for which to export data. Validation for the Export action ensures Azure SQL Database compatibility for the complete targeted database even if a subset of tables is specified for the export.

Example

```bash
# example export from Azure SQL Database using SQL authentication and a connection string
sqlpackage /Action:Export /TargetFile:"C:\AdventureWorksLT.bacpac" \
    /SourceConnectionString:"Server=tcp:{yourserver}.database.windows.net,1433;Initial Catalog=AdventureWorksLT;Persist Security Info=False;User ID=sqladmin;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
```

## How to export a database from Azure Managed Instance to your local SQL Server instance

EXPORT a database from an Azure Managed Instance by creating a .bacpac file using SqlPackage.exe:

Note: Make sure you exit out of dbeaver before exporting database.

```bash
pushd .
cd ~/sqlpackage
# You can remove /p:Storage=File. This worked for me.
# /p:Storage=File : is used to redirect the backing storage for the schema model used during extraction, this helpful with large databases that may cause out-of-memory exception if the default memory location is used. 
# It seems that the file backed model uses a feature which is only available on the windows platform and in full .NET, not in Core. (github.com/microsoft/azuredatastudio/issues/12754) 
# https://dba.stackexchange.com/questions/255163/ms-azure-remote-back-up-with-sqlpackage

# https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-export?view=sql-server-ver16#properties-specific-to-the-export-action
# /p: TableData=(STRING) Indicates the table from which data will be extracted. Specify the table name with or without the brackets surrounding the name parts in the following format: schema_name.table_identifier. This property may be specified multiple times to indicate multiple options.

sqlpackage /a:export /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /p:TableData=ETL.script_history /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw_full.bacpac /p:VerifyExtraction=false

sqlpackage /a:export /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw_full.bacpac /p:VerifyExtraction=false

s1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false
Connecting to database 'mgdw' on server 'tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342'.
Extracting schema
Extracting schema from database
Resolving references in schema model
Validating schema model for data package
Validating schema
Exporting data from database
Exporting data
Processing Export.
Processing Table '[ETL].[Script_History]'.
Successfully exported database and saved it to file '/home/brent/backups/mi/mgdw.bacpac'.
Changes to connection setting default values were incorporated in a recent release.  More information is available at https://aka.ms/dacfx-connection
Time elapsed 0:00:48.00

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

## How to export a database from Azure SQL database

EXPORT a database from an Azure Managed Instance by creating a .bacpac file using SqlPackage.exe:

## Note

Both server names are identical for different tenants and subscriptions.  Maybe the API gateway takes care of this routing.

```bash
pushd .
cd ~/sqlpackage
# You can remove /p:Storage=File. This worked for me.
# /p:Storage=File : is used to redirect the backing storage for the schema model used during extraction, this helpful with large databases that may cause out-of-memory exception if the default memory location is used. 
# It seems that the file backed model uses a feature which is only available on the windows platform and in full .NET, not in Core. (github.com/microsoft/azuredatastudio/issues/12754) 
# https://dba.stackexchange.com/questions/255163/ms-azure-remote-back-up-with-sqlpackage

sqlpackage /a:export /ssn:tcp:mgsqlsrv.database.windows.net /sdn:mgdw /p:TableData=AlbSPS.Import /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mgsqlsvr/mgdw.bacpac /p:VerifyExtraction=false
Connecting to database 'mgdw' on server 'tcp:mgsqlsrv.database.windows.net'.
Extracting schema
Extracting schema from database
Resolving references in schema model
Validating schema model for data package
Validating schema
Exporting data from database
Exporting data
Processing Export.
Processing Table '[AlbSPS].[Import]'.
Successfully exported database and saved it to file '/home/brent/backups/mgsqlsvr/mgdw.bacpac'.
Changes to connection setting default values were incorporated in a recent release.  More information is available at https://aka.ms/dacfx-connection
Time elapsed 0:02:34.06

[SalesLT].[Address]

sqlpackage /a:export /ssn:tcp:bgtest.database.windows.net /sdn:test /p:TableData=SalesLT.Address /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mgsqlsvr/test.bacpac /p:VerifyExtraction=false

Connecting to database 'test' on server 'tcp:bgtest.database.windows.net'.
Extracting schema
Extracting schema from database
Resolving references in schema model
Validating schema model for data package
Validating schema
Exporting data from database
Exporting data
Processing Export.
Processing Table '[SalesLT].[Address]'.
Successfully exported database and saved it to file '/home/brent/backups/mgsqlsvr/test.bacpac'.
Changes to connection setting default values were incorporated in a recent release.  More information is available at https://aka.ms/dacfx-connection
Time elapsed 0:00:31.38

```

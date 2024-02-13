# Export Azure SQL Managed Instance database

When you need to export a database for archiving or for moving to another platform, you can export the database schema and data to a BACPAC file. A BACPAC file is a ZIP file with an extension of BACPAC containing the metadata and data from the database. A BACPAC file can be stored in Azure Blob storage or in local storage in an on-premises location and later imported back into Azure SQL Database, Azure SQL Managed Instance, or a SQL Server instance.

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

```bash
pushd .
cd ~/sqlpackage
sqlpackage /a:export /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /p:TableData=ETL.script_history /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false /p:Storage=File

s1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false /p:Storage=File

Connecting to database 'mgdw' on server 'tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342'.
Extracting schema
Extracting schema from database
Time elapsed 0:00:08.70
*** An unexpected failure occurred: .NET Core should not be using a file backed model..


# You can remove /p:Storage=File. This worked for me.
# /p:Storage=File : is used to redirect the backing storage for the schema model used during extraction, this helpful with large databases that may cause out-of-memory exception if the default memory location is used. 
# It seems that the file backed model uses a feature which is only available on the windows platform and in full .NET, not in Core. (github.com/microsoft/azuredatastudio/issues/12754) 
# https://dba.stackexchange.com/questions/255163/ms-azure-remote-back-up-with-sqlpackage

sqlpackage /a:export /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /p:TableData=ETL.script_history /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false

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

          '/p:TableData=[dbo].[QRTZ_CALENDARS]',
          '/p:TableData=[dbo].[QRTZ_SCHEDULER_STATE]'

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

SqlPackage.exe /Action:Export /ssn:tcp:yourmanagedinstance.public.12345qwerty.database.windows.net,3342 /sdn:YourDatabaseName /su:yourusername /sp:YourP@$$word! /tf:C:\temp\YourDatabaseName.bacpac /p:VerifyExtraction=false /p:Storage=File

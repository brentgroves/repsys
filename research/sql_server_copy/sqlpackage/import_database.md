# Import Azure SQL database

When you need to export a database for archiving or for moving to another platform, you can export the database schema and data to a BACPAC file. A BACPAC file is a ZIP file with an extension of BACPAC containing the metadata and data from the database. A BACPAC file can be stored in Azure Blob storage or in local storage in an on-premises location and later imported back into Azure SQL Database, Azure SQL Managed Instance, or a SQL Server instance.

BACPAC files contain data that is exported using BCP's "native" file format, which is a binary type file. The data for the table is simply exported across multiple files, rather than one big file. If you look through the .bcp files across different tables, you'll find that the file size will vary, with skew in size related to variation in different rows having different data width. For example, when I create a bacpac of AdventureWorks, the .bcp files for Purchasing.PurchaseOrderDetail range from 39kb to 62kb.

BCP (and thus BACPAC generation) does not back up data by copying data pages like a standard backup, but rather is doing table-level querying & exporting.

```bash
pushd .
cd ~/sqlpackage
sqlpackage /a:import /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /p:TableData=ETL.script_history /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false /p:Storage=File
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

# Import Azure SQL database

The SqlPackage Import action imports the schema and table data from a BACPAC file (.bacpac) into a new or empty database in SQL Server or Azure SQL Database. At the time of the import operation to an existing database the target database cannot contain any user-defined schema objects. Alternatively, a new database can be created by the import action when the authenticated user has create database permissions.

BACPAC files contain data that is exported using BCP's "native" file format, which is a binary type file. The data for the table is simply exported across multiple files, rather than one big file. If you look through the .bcp files across different tables, you'll find that the file size will vary, with skew in size related to variation in different rows having different data width. For example, when I create a bacpac of AdventureWorks, the .bcp files for Purchasing.PurchaseOrderDetail range from 39kb to 62kb.

BCP (and thus BACPAC generation) does not back up data by copying data pages like a standard backup, but rather is doing table-level querying & exporting.

## Notes

### **[Can't import Azure SQL Database Managed Instance bacpac into Azure SQL Database](https://www.sqlservercentral.com/forums/topic/database-projects-dont-allow-3-parts-objects-names-and-cross-refs)**

Warning SQL0: A project which specifies SQL Server 2022 or Azure SQL Database Managed Instance as the target platform may experience compatibility issues with Microsoft Azure SQL Database v12.

sqlpackage /a:import /tsn:tcp:bgtest.database.windows.net /tdn:test /tu:mgadmin /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mi/script_history.bacpac

Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 40515, Level 15, State 1, Procedure production_twohour_p, Line 16 Reference to database and/or server name in 'mgdw.Plex.Detailed_Production_History' is not supported in this version of SQL Server.

## example import to Azure SQL Database using SQL authentication and a connection string

<https://stackoverflow.com/questions/63906108/reference-to-database-and-or-server-name-is-not-supported-in-this-version-of-sql>
<https://stackoverflow.com/questions/47213938/azure-sql-server-bacpac-import-failed>

```bash
```bash
pushd .
cd ~/sqlpackage

sqlpackage /a:export /ssn:tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342 /sdn:mgdw /p:TableData=ETL.script_history /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mi/mgdw.bacpac /p:VerifyExtraction=false

sqlpackage /TargetTrustServerCertificate:True /a:import /tsn:tcp:localhost /tdn:rsdw /tu:sa /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mi/script_history.bacpac 

*** Error importing database:Could not import package.
Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 207, Level 16, State 1, Procedure datasource_view, Line 30 Invalid column name 'datasource_type_key'.
Error SQL72045: Script execution error.  The executed script:
CREATE VIEW DataSource.datasource_view
AS
SELECT ds.name AS datasource_name,
       mp.friendly_name AS mobex_procedure,
       mpr.name AS mobex_procedure_repo,
       mpp.name AS mobex_project,
       es.name AS etl_script,
       esr.name AS etl_script_repo,
       esp.name AS etl_project
FROM   DataSource.datasource AS ds
       INNER JOIN
       DataSource.datasource_type AS dst
       ON ds.datasource_type_key = dst.datasource_type_key
       INNER JOIN
       DataSource.base_source AS b
       ON ds.base_source_key = b.base_source_key
       INNER JOIN
       DataSource.base_source_type AS bt
       ON b.base_source_type_key = bt.base_source_type_key
       INNER JOIN
       DataSource.datasource_warehouse AS dsw
       ON ds.datasource_key = dsw.datasource_key
       INNER JOIN
       DataSource.data_warehouse AS dw
       ON dsw.data_warehouse_key = dw.data_warehouse_key
       INNER JOIN
       DataSource.dw_schema AS sc
       ON dw.dw_schema_key = sc.dw_schema_key
       INNER JOIN
       DataSour

busche-sql.busche-cnc.com
sqlpackage /TargetTrustServerCertificate:True /a:import /tsn:tcp:busche-sql.busche-cnc.com /tdn:rsdw /tu:sa /tp:buschecnc1 /sf:/home/brent/backups/mi/script_history.bacpac 
*** Error importing database:Data cannot be imported into target because it contains one or more user objects. Import should be performed against a new, empty database.

sqlpackage /a:import /tsn:tcp:repsys.database.windows.net /tdn:rsdw /tu:mgadmin /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mi/script_history.bacpac 

Importing to database 'rsdw' on server 'tcp:repsys.database.windows.net'.
Creating deployment plan
Initializing deployment
*** A project which specifies SQL Server 2022 or Azure SQL Database Managed Instance as the target platform may experience compatibility issues with Microsoft Azure SQL Database v12.
*** Error importing database:Could not import package.
Warning SQL0: A project which specifies SQL Server 2022 or Azure SQL Database Managed Instance as the target platform may experience compatibility issues with Microsoft Azure SQL Database v12.
Warning SQL72012: The object [data_0] exists in the target, but it will not be dropped even though you selected the 'Generate drop statements for objects that are in the target database but that are not in the source' check box.
Warning SQL72012: The object [log] exists in the target, but it will not be dropped even though you selected the 'Generate drop statements for objects that are in the target database but that are not in the source' check box.
Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 40515, Level 15, State 1, Procedure production_twohour_p, Line 16 Reference to database and/or server name in 'mgdw.Plex.Detailed_Production_History' is not supported in this version of SQL Server.
Error SQL72045: Script execution error.  The executed script:
CREATE PROCEDURE Plex.production_twohour_p
AS
BEGIN
    CREATE TABLE #casterrewq (
        part     INT,
        quantity INT
    );
    INSERT INTO #casterrewq (part, quantity)
    (SELECT   [Part_No],
              sum([Quantity])
     FROM     [mgdw].[Plex].[Detailed_Production_History]
     WHERE    [PCN] LIKE '295932'
              AND ([Record_Date] <= CURRENT_TIMESTAMP
                   AND [Record_Date] >= dateadd(hour, -2, CURRENT_TIMESTAMP))
              AND [Workcenter_Code] LIKE 'cast%'
     GROUP BY [Part_No]);
    CREATE TABLE #xrayrewq (
        part     INT,
        quantity INT
    );
    INSERT INTO #xrayrewq (part, quantity)
    (SELECT   [Part_No],
              sum([Quantity])
     FROM     [mgdw].[Plex].[Detailed_Production_History]
     WHERE    [PCN] LIKE '295932'
              AND ([Record_Date] <= CURRENT_TIMESTAMP
                   AND [Record_Date] >= dateadd(hour, -2, CURRENT_TIMESTAMP))
              AND [Workcenter_Code] LIKE 'x%ray%'
     GROUP BY [Part_No]);
    CREATE TABL

Time elapsed 0:01:23.50

Importing to database 'mgdw' on server 'tcp:mgsqlsvr.database.windows.net'.
Creating deployment plan
Initializing deployment
*** A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: TCP Provider, error: 35 - An internal exception was caught)

https://stackoverflow.com/questions/69410984/copy-data-from-azure-sql-managed-instance-db-to-azure-sql-server-db

SQL MI to a SQL DB
https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?view=azuresql
https://blog.devart.com/export-azure-sql-database.html#ssms
# Cant import MI bacpac to Azure SQL database because Azure SQL database does not accept 3 part-names generated by MI generated bacpac
sqlpackage /a:import /tsn:tcp:bgtest.database.windows.net /tdn:test /tu:mgadmin /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mi/script_history.bacpac 


# Azure SQL database bacpac to Another Azure SQL database
# Attempt: Did not create database
# result copied mgdw from mgsqlsvr to bgtest without problem
# the whole database was imported although I thought I only backed up the Import schema?
sqlpackage /a:import /tsn:tcp:bgtest.database.windows.net /tdn:mgdw /tu:mgadmin /tp:WeDontSharePasswords1! /sf:/home/brent/backups/mydw/import.bacpac 

Importing to database 'mgdw' on server 'tcp:bgtest.database.windows.net'.
Creating deployment plan
Initializing deployment
Verifying deployment plan
Analyzing deployment plan
Importing package schema and data into database
Updating database
Importing data
Processing Import.
Disabling indexes.
Processing Table '[AlbSPS].[Import]'.
Processing Table '[AlbSPS].[Jobs]'.
Processing Table '[AlbSPS].[TransactionLog]'.
Processing Table '[btl].[btJobsIn9B]'.
Processing Table '[btl].[btJobsIn9BBak]'.
Processing Table '[Kors].[email_hours]'.
Processing Table '[Kors].[notification]'.
Processing Table '[Kors].[notification_09_30]'.
Processing Table '[Kors].[notification_subset]'.
Processing Table '[Kors].[notification_test1]'.
Processing Table '[Kors].[recipient]'.
Processing Table '[Kors].[recipient0921]'.
Processing Table '[Kors].[shift]'.
Processing Table '[MSC].[btJobsIn9BBak]'.
Processing Table '[MSC].[Import]'.
Processing Table '[MSC].[ItemSummary]'.
Processing Table '[MSC].[ItemSummaryBak]'.
Processing Table '[MSC].[Jobs]'.
Processing Table '[MSC].[Restrictions2]'.
Processing Table '[MSC].[TransactionLog]'.
Processing Table '[Plex].[Account_Balances_by_Periods]'.
Processing Table '[Plex].[accounting_account]'.
Processing Table '[Plex].[campfire_extract]'.
Processing Table '[Plex].[Customer_Release_Due_WIP_Ready_Loaded]'.
Processing Table '[Plex].[GL_Account_Activity_Summary]'.
Processing Table '[Plex].[part_op_with_tool_list]'.
Processing Table '[Plex].[part_tool_assembly]'.
Processing Table '[Plex].[part_tool_BOM]'.
Processing Table '[Plex].[PRP_Screen]'.
Processing Table '[Plex].[PrpScreen]'.
Processing Table '[Plex].[purchasing_item_summary]'.
Processing Table '[ssis].[ScriptComplete]'.
Enabling indexes.
Successfully imported database.
Changes to connection setting default values were incorporated in a recent release.  More information is available at https://aka.ms/dacfx-connection
Time elapsed 0:02:44.16

https://techcommunity.microsoft.com/t5/azure-database-support-blog/lesson-learned-307-reference-to-database-and-or-server-name-is/ba-p/3726508

qlpackage.exe /a:import /tcs:"Data Source=abc.database.windows.net;Initial Catalog=clientdbname;User Id=admin;Password=abc@123" /sf:"C:\Users\User\Downloads\clientdb.bacpac" /p:DatabaseEdition=Premium /p:DatabaseServiceObjective=P6

*** Error importing database:Could not import package.
Warning SQL0: A project which specifies SQL Server 2022 or Azure SQL Database Managed Instance as the target platform may experience compatibility issues with Microsoft Azure SQL Database v12.
Warning SQL72012: The object [data_0] exists in the target, but it will not be dropped even though you selected the 'Generate drop statements for objects that are in the target database but that are not in the source' check box.
Warning SQL72012: The object [log] exists in the target, but it will not be dropped even though you selected the 'Generate drop statements for objects that are in the target database but that are not in the source' check box.
Error SQL72014: Core Microsoft SqlClient Data Provider: Msg 40515, Level 15, State 1, Procedure production_twohour_p, Line 16 Reference to database and/or server name in 'mgdw.Plex.Detailed_Production_History' is not supported in this version of SQL Server.
Error SQL72045: Script execution error.  The executed script:
CREATE PROCEDURE Plex.production_twohour_p
AS
BEGIN
    CREATE TABLE #casterrewq (
        part     INT,
        quantity INT
    );
    INSERT INTO #casterrewq (part, quantity)
    (SELECT   [Part_No],
              sum([Quantity])
     FROM     [mgdw].[Plex].[Detailed_Production_History]
     WHERE    [PCN] LIKE '295932'
              AND ([Record_Date] <= CURRENT_TIMESTAMP
                   AND [Record_Date] >= dateadd(hour, -2, CURRENT_TIMESTAMP))
              AND [Workcenter_Code] LIKE 'cast%'
     GROUP BY [Part_No]);
    CREATE TABLE #xrayrewq (
        part     INT,
        quantity INT
    );
    INSERT INTO #xrayrewq (part, quantity)
    (SELECT   [Part_No],
              sum([Quantity])
     FROM     [mgdw].[Plex].[Detailed_Production_History]
     WHERE    [PCN] LIKE '295932'
              AND ([Record_Date] <= CURRENT_TIMESTAMP
                   AND [Record_Date] >= dateadd(hour, -2, CURRENT_TIMESTAMP))
              AND [Workcenter_Code] LIKE 'x%ray%'
     GROUP BY [Part_No]);
    CREATE TABL

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

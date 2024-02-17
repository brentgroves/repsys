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

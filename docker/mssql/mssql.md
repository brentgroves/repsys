# SQL Server in Docker

## references

<https://www.youtube.com/watch?v=fFpDf5si_Hw>
<https://hub.docker.com/_/microsoft-mssql-server>

## How to use this Image

Start a mssql-server instance for SQL Server 2022, which is now generally available (GA). These images are based on Ubuntu 20.04 and is fully supported for production workload.

Start a mssql-server instance for SQL Server 2022, which is now generally available (GA). These images are based on Ubuntu 20.04 and is fully supported for production workload.

**[Pull and connect](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&preserve-view=true&tabs=cli&pivots=cs1-bash)**

```bash
docker pull mcr.microsoft.com/mssql/server:2022-latest

# ~/src/secrets/namespaces/default/credentials.yaml
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=' \
   -p 1433:1433 --name sql1 --hostname sql1 \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest
```

## Connect to SQL Server

The following steps use the SQL Server command-line tool, sqlcmd utility, inside the container to connect to SQL Server.

Use the docker exec -it command to start an interactive bash shell inside your running container. In the following example, sql1 is name specified by the --name parameter when you created the container.

```Bash
sqlcmd -C -S localhost,1433 -U sa -P "" -d mgdw

docker exec -it sql1 "bash"
# Once inside the container, connect locally with sqlcmd, using its full path.
# ~/src/secrets/namespaces/default/credentials.yaml
sudo /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ""
# Create a new database
# The following steps create a new database named TestDB.
# From the sqlcmd command prompt, paste the following Transact-SQL command to create a test database:
CREATE DATABASE TestDB;
# On the next line, write a query to return the name of all of the databases on your server:
SELECT Name from sys.databases;
# The previous two commands weren't run immediately. Type GO on a new line to run the previous commands:
GO

(5 rows affected)
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT);
INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
```

## **[restore from backup](../../../backups/mssql/import_database.md)**

<!-- https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&preserve-view=true&tabs=cli&pivots=cs1-bash -->

```bash
sqlpackage /TargetTrustServerCertificate:True /a:Import /tsn:'localhost,1433' /tdn:mgdw /tu:sa /tp:'WeDontSharePasswords1!' /sf:'/home/brent/src/backups/azure_mi/mgdw/mgdw_2024_07_09.bacpac'
Importing to database 'mgdw' on server 'localhost,1433'.
Creating deployment plan
Initializing deployment
Verifying deployment plan
Analyzing deployment plan
Importing package schema and data into database
Updating database
Importing data
Processing Import.
Disabling indexes.
Disabling index 'UQ__accounti__22DAE7B5093D20D1'.
Disabling index 'IX_accounting_period_pcn_period_no_newest'.
Disabling index 'IX_Plex_Hourly_Workcenter_Status'.
Processing Table '[Archive].[account_balance_06_10]'.
Processing Table '[Archive].[account_balance_06_15_2022]'.
Processing Table '[Archive].[account_balance_06_22]'.
Processing Table '[Archive].[account_balance_12_21]'.
Processing Table '[Archive].[account_balance_12_24]'.
Processing Table '[Archive].[account_balance_2022_06_11]'.
...
Processing Table '[Wiki].[wiki]'.
Processing Table '[Wiki].[wiki_tag]'.
Enabling indexes.
Enabling index 'UQ__accounti__22DAE7B5093D20D1'.
Enabling index 'IX_accounting_period_pcn_period_no_newest'.
Enabling index 'IX_Plex_Hourly_Workcenter_Status'.
Successfully imported database.
Changes to connection setting default values were incorporated in a recent release.  More information is available at <https://aka.ms/dacfx-connection>
Time elapsed 0:23:17.27
```

## connect test

```bash
sqlcmd -C -S localhost,1433 -U sa -P "" -d mgdw
## test
select s.Name,sh.*
from ETL.script_history sh 
join ETL.script s 
on sh.script_key=s.Script_Key 
where sh.script_key in (1,3,4,5,6,7,8,9,10,11,116,117)
and start_time between '2024-07-05 00:00:00' and '2024-07-06 00:00:00' 
--and start_time between '2024-01-09 00:00:00' and '2024-01-10 00:00:00' 
order by script_history_key desc
```

# Meeting Notes

- We can use Adrian's K8s for production.
- Structures Avilla K8s for development.
- Transition from Azure SQL MI on Mobex tenant to Azure SQL database on Linamar tenant.

### brent

- change pointer from mobex to linamar tenant.

## Mobex Azure SQL MI to Linamar Azure SQL database migration

- Created a backup of Linamar's Azure SQL MI and imported it into an on-prem SQL Server database. Then, I created a backup of the OnPrem database and imported it into the Azure SQL database. Direct importing of a backup is not supported from Azure SQL MI to Azure SQL database. Done.
Connect to Plex using the OpenAccess data direct ODBC driver from the second system running a newer version of Ubuntu and OpenSSL, which does not support the preferred TLS 1.2 cipher suite that the DataDirect driver uses by default. Done.
- Create Linamar Azure SQL database DSN. Done.
- Run Southfield's Trial Balance ETL scripts pointing to Mobex Azure SQL MI as usual. Next.
- Run Southfield's Trial Balance ETL scripts pointing to the Linamar Azure SQL database. Not Done.
- Compare rowcounts and a few values of all 5 work tables in Mobex Azure SQL MI to the same tables in Linamar's Azure SQL database. Not Done.
- Import the Mobex Azure SQL MI Trial Balance result into Linamar's Azure SQL database and compare the result set using SQL. Not Done.
- Run Southfield's Trial Balance Power BI report pointing to Linamar's Azure SQL database result set, export Excel for the last 13 periods, and send to Dan Martin for verification. Not Done.
What:

- Moving from Azure SQL Managed Instance to Azure SQL database.
  - Save money, easily managed, and supported by Microsoft Fabric. Although we may have to recreate the Azure SQL database from the Fabric console.
  
- Pointing scripts to Linamar tenant's Azure SQL database
- Comparing Mobex against Linamar script results to make sure they are the same.

### steps

- install Plex ODBC driver on new SSL systems.
  - Newer systems default to higher security level and five cipher suites.  Configure SSL system to work at a lower security level and cipher suites supported by Plex data direct ODBC open access driver.

### terek

Cody Hudson
set up a folder

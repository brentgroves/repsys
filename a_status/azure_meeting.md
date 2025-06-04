# Meeting Notes

- We can use Adrian's K8s for production.
- Structures Avilla K8s for development.
- Transition from Azure SQL MI on Mobex tenant to Azure SQL database on Linamar tenant.

### brent

- change pointer from mobex to linamar tenant.

### status

Mobex Azure SQL MI to Linamar Azure SQL database
Status,

- Got new development system's ODBC data direct driver  connected to Plex by using the lowest possible security level and outdate cipher suite. Had to do this so that I could run the Mobex scripts on the old system and run the Linamar scripts on the new system. This way I can compare the results to verify the Linamar tenant scripts are ok.
- 8 scripts to go.

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

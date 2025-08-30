### Structures Azure SQL database

The Structures Azure SQL database is the Structures data warehouse.

- Structures ETL service destination for the following data sources:
  - Non-Microsoft ODBC connections to Plex Cloud ERP
  - SOAP and RESTful API live access to Plex ERP
  - **[Mach2 Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** reportable events.
  - **[Serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** CNC data.

## Azure SQL database

- Single Database, DTU Purchase Model, Standard Tier, S1: 20 DTUs, 250 GB included storage per DB, 1 Database(s) x 730 Hours, 250 GB Storage, RA-GRS Backup Storage Redundancy,  3 x 20 GB Long Term Retention
- There is a good chance we will move the Structures Azure SQL database to Microsoft Fabric soon. Tarek Mohamed, Data and Analytics IT, Supervisor.
- **[Geo-redundant storage (GRS)](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql#backup-storage-redundancy)**
- **[Point-In-Time Restore](https://learn.microsoft.com/en-us/azure/azure-sql/database/recovery-using-backups?view=azuresql&tabs=azure-portal#point-in-time-restore)**

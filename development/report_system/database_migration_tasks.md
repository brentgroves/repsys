# Database Migration Tasks

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

- Deploy the MySQL 8.0 server and import mydw.  Later recreate mydw in the MySQL InnoDB Cluster. You should make a copy of each table and give it a primary key then copy the mydw non-keyed data into it.
- Recreate our data warehouse residing in an Azure SQL MI to an Azure SQL DB.

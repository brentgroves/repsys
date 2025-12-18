# Structures Azure SQL database

The Structures Azure SQL database is the Structures data warehouse.

- Structures ETL service destination for the following data sources:
  - Non-Microsoft ODBC connections to Plex Cloud ERP
  - SOAP and RESTful API live access to Plex ERP
  - **[Mach2 Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** reportable events.
  - **[Serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** CNC data.

The Structures Azure SQL database and Kubernetes Cluster (AKS) will be used to run the production versions of Structures software such as the Automated **[ETL](https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/etl)** and Reporting System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These software projects are in development. The Azure resources are for all of Linamar Structures, but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

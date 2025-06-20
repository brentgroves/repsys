# **[Database Mirroring is Back in Azure SQL Database](https://stackoverflow.com/questions/69410984/copy-data-from-azure-sql-managed-instance-db-to-azure-sql-server-db)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

**[Database mirroring](https://learn.microsoft.com/en-us/sql/database-engine/database-mirroring/database-mirroring-sql-server?view=sql-server-ver16)** was a cool feature in SQL Server 2005. I guess it's still a feature, though it's listed as deprecated in the documentation. There is still a mirroring dialog in the SSMS database properties dialog in more recent versions of SQL Server, but I don't know if there is a good reason to use mirroring over Availability Groups.

That's why I was surprised to see a public preview announcement of **[Azure SQL Database Mirroring to Microsoft Fabric](https://azure.microsoft.com/en-us/updates/public-preview-azure-sql-database-mirroring-in-microsoft-fabric/)** announcement. Apparently you can easily move Azure SQL Database data to Fabric and have it written to Delta Parquet tables in OneLake. No ETL, no need to do the data conversion yourself, or at least not much of an effort. I suspect you still need to understand this and do some configuration for how your Parquet files will get written.

We are excited to announce the general availability of Mirroring Azure SQL Database in Fabric. Mirroring is a simple, free, and frictionless way to replicate a snapshot of incremental data changes in Azure SQL Database to Fabric OneLake. Delta tables keep your data in sync in near-real time. Mirroring is a low-cost, zero-code, zero-ETL solution that brings data together, driving faster time to insight.

# **[What is Mirroring in Fabric?](https://blog.fabric.microsoft.com/en-us/blog/announcing-mirroring-azure-sql-database-in-fabric-now-generally-available-ga)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

We are thrilled to announce the General Availability of Mirroring for Azure SQL Database in Fabric. This milestone marks a significant step forward in our mission to provide seamless, near-real time data replication and integration capabilities for our users.

## What is Mirroring in Fabric?

Mirroring in Fabric is a powerful feature that allows you to replicate your Azure SQL Database to Fabric’s OneLake. This ensures that your data is always up-to-date and readily available for advanced analytics, AI, and data science without the need for complex ETL processes. Setting up mirroring is simple, watch the video below.

**[Mirroring Demo: Setup, monitor, and seamless schema changes in Fabric](https://youtu.be/9PsOwT2phVE)**

## Key GA Features

Below are some of the key features as part of the general availability release:

Seamless Data Definition Language (DDL) support: Alter/Drop/Rename tables/column and yes, now you can Truncate tables in the source databases while mirroring is active. Learn more **[here](https://aka.ms/mirroring-sqldb-updates)**

Programmatic Mirroring APIs: Easily set up and manage mirroring through APIs, providing greater flexibility and automation. Learn more **[Fabric mirroring public REST API](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/mirrored-database-rest-api)**

Support source Schema hierarchy: Source schema hierarchy is now fully supported in the Data Warehouse object explorer experiences.

Firewall Connectivity: This capability is currently in private preview to mirror an Azure SQL Database behind a firewall using either On-Premises Data Gateway. Click here to signup

We are also excited to announce the public preview of Mirroring Azure SQL Managed Instance as well as announcement of **[Open Mirroring](https://aka.ms/mirroring/intro-open-mirroring)**.

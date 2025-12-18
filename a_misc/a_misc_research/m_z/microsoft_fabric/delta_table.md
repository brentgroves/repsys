# **[Understand storage for Direct Lake semantic models](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-understand-storage)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

This article introduces **[Direct Lake](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-overview)** storage concepts. It describes Delta tables and Parquet files. It also describes how you can optimize Delta tables for Direct Lake semantic models, and how you can maintain them to help deliver reliable, fast query performance.

## Delta tables

Delta tables exist in OneLake. They organize file-based data into rows and columns and are available to Microsoft Fabric compute engines such as **[notebooks](https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook)**, **[Kusto](https://learn.microsoft.com/en-us/fabric/real-time-analytics/kusto-query-set?tabs=kql-database&preserve-view=true)**, and the **[lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-overview)** and **[warehouse](https://learn.microsoft.com/en-us/fabric/data-warehouse/data-warehousing)**. You can query Delta tables by using Data Analysis Expressions (DAX), Multidimensional Expressions (MDX), T-SQL (Transact-SQL), Spark SQL, and even Python.

Note

Delta—or Delta Lake—is an open-source storage format. That means Fabric can also query Delta tables created by other tools and vendors.

Delta tables store their data in Parquet files, which are typically stored in a lakehouse that a Direct Lake semantic model uses to load data. However, Parquet files can also be stored externally. External Parquet files can be referenced by using a OneLake shortcut, which points to a specific storage location, such as Azure Data Lake Storage (ADLS) Gen2, Amazon S3 storage accounts, or Dataverse. In almost all cases, compute engines access the Parquet files by querying Delta tables. However, typically Direct Lake semantic models load column data directly from optimized Parquet files in OneLake by using a process known as transcoding.

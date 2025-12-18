# **[Azure Data Lake Storage (ADLS)]()**

A Hyperscale Distributed File Service for Big Data Analytics

Yes, Azure Data Lake Storage is essentially a distributed file system. Specifically, it's built on top of Azure Blob Storage and designed to be compatible with the Apache Hadoop Distributed File System (HDFS). This compatibility allows it to be used with various big data analytics frameworks that rely on HDFS, such as Apache Spark and Presto.

Logical vs. Physical Storage:
OneLake is a logical data lake, meaning it presents a unified view of data across different locations and formats. However, the actual data is physically stored in ADLS Gen2.

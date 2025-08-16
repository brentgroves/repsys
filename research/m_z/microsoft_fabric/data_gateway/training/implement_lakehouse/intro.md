# **[](https://learn.microsoft.com/training/paths/implement-lakehouse-microsoft-fabric/)**

Introduction
Completed
100 XP
1 minute
The foundation of Microsoft Fabric is a lakehouse, which is built on top of the OneLake scalable storage layer and uses Apache Spark and SQL compute engines for big data processing. A lakehouse is a unified platform that combines:

- The flexible and scalable storage of a data lake
- The ability to query and analyze data of a data warehouse

Imagine your company has been using a data warehouse to store structured data from its transactional systems, such as order history, inventory levels, and customer information. You collect unstructured data from social media, website logs, and external sources that are difficult to manage and analyze using the existing data warehouse infrastructure. **Your company's new directive is to improve its decision-making capabilities by analyzing data in various formats across multiple sources, so the company chooses Microsoft Fabric**.

In this module, we explore how a lakehouse in Microsoft Fabric provides a scalable and flexible data store for files and tables that you can query using SQL.

## lakehouse

A lakehouse presents as a database and is built on top of a data lake using Delta format tables. Lakehouses combine the SQL-based analytical capabilities of a relational data warehouse and the flexibility and scalability of a data lake. Lakehouses store all data formats and can be used with various analytics tools and programming languages. As cloud-based solutions, lakehouses can scale automatically and provide high availability and disaster recovery.

## Delta format tables

Delta format tables, also known as Delta tables, are a table format designed for cloud object storage, providing ACID (Atomicity, Consistency, Isolation, Durability) transactions, schema enforcement, and data versioning. They build upon existing storage formats like Parquet and leverage a transaction log to ensure reliability and efficiency in data management

Parquet is an open-source, columnar storage file format designed for efficient data storage and retrieval, particularly in big data processing environments. It is widely used in analytical workloads due to its performance benefits.

![i1](https://learn.microsoft.com/en-us/training/wwl/get-started-lakehouses/media/lakehouse-components.png)

Some benefits of a lakehouse include:

- Lakehouses use Spark and SQL engines to process large-scale data and support machine learning or predictive modeling analytics.
- Lakehouse data is organized in a **schema-on-read** format, which means you define the schema as needed rather than having a predefined schema.

**Apache Spark** has its architectural foundation in the resilient distributed dataset (RDD), a read-only multiset of data items distributed over a cluster of machines, that is maintained in a fault-tolerant way.[2] The Dataframe API was released as an abstraction on top of the RDD, followed by the Dataset API. In Spark 1.x, the RDD was the primary application programming interface (API), but as of Spark 2.x use of the Dataset API is encouraged[3] even though the RDD API is not deprecated.[4][5] The RDD technology still underlies the Dataset API.[6][7]

- Lakehouses support ACID (Atomicity, Consistency, Isolation, Durability) transactions through Delta Lake formatted tables for data consistency and integrity.
- Lakehouses are a single location for data engineers, data scientists, and data analysts to access and use data.

A lakehouse is a great option if you want a scalable analytics solution that maintains data consistency. It's important to evaluate your specific requirements to determine which solution is the best fit.

## Load data into a lakehouse

Fabric lakehouses are a central element for your analytics solution. You can follow the ETL (Extract, Transform, Load) process to ingest and transform data before loading to the lakehouse.

You can ingest data in many common formats from various sources, including local files, databases, or APIs. You can also create Fabric shortcuts to data in external sources, such as Azure Data Lake Store Gen2 or OneLake. Use the Lakehouse explorer to browse files, folders, shortcuts, and tables and view their contents within the Fabric platform.

Ingested data can be transformed and then loaded using either Apache Spark with notebooks or Dataflows Gen2. Use Data Factory pipelines to orchestrate your different ETL activities and land the prepared data into your lakehouse.

 Note

Dataflows Gen2 are based on Power Query - a familiar tool to data analysts using Excel or Power BI that provides visual representation of transformations as an alternative to traditional programming.

You can use your lakehouse for many reasons, including:

Analyze using SQL.
Train machine learning models.
Perform analytics on real-time data.
Develop reports in Power BI.

## Secure a lakehouse

Lakehouse access is managed either through the workspace or item-level sharing. Workspaces roles should be used for collaborators because these roles grant access to all items within the workspace. Item-level sharing is best used for granting access for read-only needs, such as analytics or Power BI report development.

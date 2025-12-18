# **[OneLake, the OneDrive for data](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

OneLake is a single, unified, logical data lake for your whole organization. A data lake processes large volumes of data from various sources. Like OneDrive, OneLake comes automatically with every Microsoft Fabric tenant and is designed to be the single place for all your analytics data. OneLake brings customers:

- One data lake for the entire organization
- One copy of data for use with multiple analytical engines

## One data lake for the entire organization

Before OneLake, it was easier for customers to create multiple lakes for different business groups rather than collaborating on a single lake, even with the extra overhead of managing multiple resources. OneLake focuses on removing these challenges by improving collaboration. Every customer tenant has exactly one OneLake. There can never be more than one and if you have Fabric, there can never be zero. Every Fabric tenant automatically provisions OneLake, with no extra resources to set up or manage.

## Governed by default with distributed ownership for collaboration

The concept of a tenant is a unique benefit of a SaaS service. Knowing where a customer’s organization begins and ends provides a natural governance and compliance boundary, which is under the control of a tenant admin. Any data that lands in OneLake is governed by default. While all data is within the boundaries set by the tenant admin, it's important that this admin doesn't become a central gatekeeper preventing other parts of the organization from contributing to OneLake.

Within a tenant, you can create any number of workspaces. Workspaces enable different parts of the organization to distribute ownership and access policies. Each workspace is part of a capacity that is tied to a specific region and is billed separately.

![i1](https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-overview/onelake-foundation-for-fabric.png)

Within a workspace, you can create data items and you access all data in OneLake through data items. Similar to how Office stores Word, Excel, and PowerPoint files in OneDrive, Fabric stores lakehouses, warehouses, and other items in OneLake. Items can give tailored experiences for each persona, such the Apache Spark developer experience in a lakehouse.

## Open at every level

OneLake is open at every level. OneLake is built on top of **[Azure Data Lake Storage (ADLS) Gen2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)** and can support any type of file, structured or unstructured. All Fabric data items like data warehouses and lakehouses store their data automatically in OneLake in Delta Parquet format. If a data engineer loads data into a lakehouse using Apache Spark, and then a SQL developer uses T-SQL to load data in a fully transactional data warehouse, both are contributing to the same data lake. OneLake stores all tabular data in Delta Parquet format.

OneLake supports the same ADLS Gen2 APIs and SDKs to be compatible with existing ADLS Gen2 applications, including Azure Databricks. You can address data in OneLake as if it's one big ADLS storage account for the entire organization. Every workspace appears as a container within that storage account, and different data items appear as folders within those containers.

![i2](https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-overview/access-onelake-data-other-tools.png)

For more information on APIs and endpoints, see OneLake access and APIs. For examples of OneLake integrations with Azure, see Azure Synapse Analytics, Azure storage explorer, Azure Databricks, and Azure HDInsight articles.

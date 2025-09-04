# **[Microsoft Fabric: A Game-Changer in the New Data Era](https://medium.com/@uzuntasgokberk/new-era-microsoft-fabric-e5b752d547f0)**

Explore Microsoft Fabric and its key components, including Lakehouse, Warehouse, and Direct Lake. Learn how these elements revolutionize data management and analytics, providing robust solutions for large-scale data operations. Gain comprehensive insights into Microsoft Fabric’s capabilities and transform your data strategy.

## Introduction

In this Medium post, I will introduce Microsoft Fabric step by step, delving into its various components. Special emphasis will be placed on Lakehouse, Warehouse, and Direct Lake, which will be explained in greater detail. These elements are crucial for understanding how Microsoft Fabric transforms data management and analytics, providing robust solutions for handling large-scale data operations efficiently. By the end of this post, you’ll have a comprehensive understanding of Microsoft Fabric’s capabilities and how it can revolutionize your data strategy.

## Scope of Microsoft Fabric

Microsoft Fabric have data movement to data science, Real-Time Analytics, and Business Intelligence with the right scale needed to build a complete end-to-end analytics system and all-in-once analytics solutions for enterprises. Fabric provides a set of integrated services that enable you to ingest, store, process and analyze data in a single environment.

Press enter or click to view image in full size

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*ynzjJ3UjyL33onOJ7K5v9Q.png)

Microsoft Fabric is built on a SaaS foundation, integrated experience without the need for access to Azure resources as it brings together new and existing components from Power BI, Azure Synapse and Azure Data Factory into a single integrated environment. With Microsoft Fabric, you don’t have to spend all of your time combining various services from different vendors.

- **Synapse Data Engineering:** Offers a robust Spark platform tailored for large-scale data transformations and democratization via Lakehouse. Integration with Data Factory simplifies scheduling and orchestration of notebooks and Spark jobs.

- **Synapse Data Warehouse:** Delivers top-tier SQL performance and scalability with distinct compute and storage components, utilizing the open Delta Lake format for data storage.

- **Synapse Data Science:** Facilitates easy building, deployment, and management of machine learning models within Fabric, enhanced by Azure Machine Learning’s experiment tracking and model registry capabilities.

- **Synapse Real-Time Analytics:** Optimized for analyzing observational data from various sources like applications and IoT devices, it efficiently handles high-volume, semi-structured data with dynamic schemas.
- **Data Factory:** Merges the user-friendly Power Query interface with the scalability of Azure Data Factory, supporting over 200 native connectors for both on-premises and cloud data sources.
- **Power BI:** A premier Business Intelligence tool that allows for quick and intuitive access to data within Fabric, enabling data-driven decision-making.

## Significant note

Software as a service (SaaS) allows users to connect and to use cloud-based apps over the Internet. In a SaaS environment you’re responsible for the data that you’re in data centers system, the devices that you allow to connect to the system, and the users that have access. Nearly everything else falls to the cloud provider. The cloud provider is responsible for physical security of the datacenters, power, network connectivity, and application development and patching.

Press enter or click to view image in full size

![i2](https://miro.medium.com/v2/resize:fit:720/format:webp/1*QEnVm-2tXO5QswAWCfEEpw.png)

Synapse prefix is not the same as Azure Synapse Analytics. The technology is built on top of the existing technology of Synapse but there are a lot of significant changes / improvements to the architecture / functionality that makes it a revolutionized version that the technology / functionality is significantly improved and optimized.

## Scope of OneLake

OneLake combines storage locations across different regions, clouds and all the compute engines automatically into a single logical lake without moving or duplicating data. OneLake is built on top of ADLS(azure Data Lake Storage) Gen2 and services as the tenant-wide store for data and can support any type of file, structured or unstructured and can be stored in any format, including Delta, Parquet, CSV, Json and more.

Press enter or click to view image in full size

![i4](https://miro.medium.com/v2/resize:fit:720/format:webp/1*A67BHFEKTnFH-l_BIFzPQw.png)

## Scope of Delta-Parquet Format

Central to Fabric’s capabilities is the Delta-Parquet storage format a groundbreaking technology that elevates data storage and analytics to a new level. Built upon Apache Spark a leading data processing engine Delta-Parquet offers a unified data layer, making it equally effective for various data operations, from analytics to machine learning and even business reporting.

Being ACID (Atomicity, Consistency, Isolation, Durability) compliant allows for the best data integrity and reliability possible by never allowing your data to be in an inconsistent state.

ACID stands for:

Atomicity: Each statement in a transaction is treated as a single unit. Either the entire transaction is executed or none of it is.
Ex. a bank transfer deducting money from your account and transferring it to the other account. Without atomicity, you can deduct money from your account without it reaching the other account.
Consistency: Transactional consistency. Requiring the changes made in a transaction are consistent with any constraints. Prevents any of these errors or corruption from entering your data.
Ex. You try to withdraw more money from an ATM than is in your account. Transaction fails since it prevents an overdraft, violating a constraint.
Isolation: All transactions are run in isolation without interfering with each other. If there are multiple transactions applying changes to the same source, then they will occur one by one.
Ex. You have $1,000 in a bank account. You send 2 simultaneous withdrawals for $500 each. If these happen at the same time, then your ending balance would be $500. But with isolation, the ending balance would be $0 since each transaction impacted the other.
Durability: Ensuring that the changes made to the data persist. Whether this is writing to a database, saving a file, etc. Just that the changes are available in case of a crash or system failure.

Delta-Parquet brings to the table a suite of features designed for flexibility, robustness, and scalability:

ACID Transactions: The crux of data reliability and integrity. With ACID support, Delta-Parquet ensures that database operations are atomic, consistent, isolated, and durable.
Scalable Metadata Handling: With exploding data volumes, effective metadata management becomes a challenge. Delta-Parquet makes this manageable, even at scale.
Unified Data Processing: Whether your data is streaming in real-time or gathered in batches, Delta-Parquet can handle both, eliminating the need for multiple storage solutions.
Version Control and Lineage Tracking: This feature is invaluable for businesses that need to comply with various data governance and compliance regulations. It allows you to track changes, revert them, and maintain an audit trail.
Multi-Platform Support: An important benefit is its compatibility with various storage platforms, including but not limited to Microsoft’s Fabric OneLake, Azure Data Lake Storage, and Amazon S3.

There are 3 options to convert files to the Delta Parquet Format in Microsoft Fabric:

- **Dataflows (Gen2):** Import and transform data from a range of sources using Power Query Online, and load it directly into a table in the lakehouse.
- **Notebooks:** Use notebooks in Fabric to ingest and transform data, and load it into tables or files in the lakehouse.
- **Data Factory pipelines:** Copy data and orchestrate data processing activities, loading the results into tables or files in the lakehouse.

## Scope of Serverless Compute

Serverless computing provides inbuilt infrastructures and a runtime environment to develop applications rapidly. It is the next-generation evolution of Platform as a Service that have infrastructure, scaling, management, and provisioning at all. Serverless Computing helps users directly focus on the development part of the application rather than worrying about the infrastructure. Developers can innovatively code for the application, whereas serverless computing can take care of the server-related requirements with flexibility.

## Explore Microsoft Fabric

Normally, you can create Microsoft Fabric “<https://azure.microsoft.com/en-us/”>. The following picture how you can create Fabric.

![i5](https://miro.medium.com/v2/resize:fit:720/format:webp/1*AGFZ92yjynXGrxsXagiOtw.png)

However, ın this series Fabric trial licence have been used in Fabric. So that, the following steps created with F64 fabric trial licence.

You can access the Admin center from the Settings menu in the upper right corner of the Power BI service. From here, you enable Fabric in the Tenant settings.

Press enter or click to view image in full size

![i6](https://miro.medium.com/v2/resize:fit:720/format:webp/1*ScqxNmRhaE_VHFlgjMdZ8w.png)

Fabric workloads refer to the different capabilities included in Fabric. You can switch between workloads using the workload switcher in the bottom left corner of the navigation pane.

Press enter or click to view image in full size

![i7](https://miro.medium.com/v2/resize:fit:720/format:webp/1*WAcU9STbOP7SRxU7rcrZLQ.png)

## Scope of Lakehouse

Microsoft Fabric Lakehouse is a data architecture platform for storing, managing and analyzing structured and unstructured data in a single location. A Lakehouse present as a database and is built on top of a data lake using default file format delta parquet. Two pysical locations can be stored data that are provisioned automatically, files(unmanaged) or table(managed delta tables).

Lakehouse end point detail:
SQL Analytics Endpoint of the Lakehouse endpoint provides a SQL-Based experience for the Lakehouse delta tables. “Tables” section of the Lakehouse and “Files” section are not readable/discoverable through the SQL Endpoint. T-SQL, save functions, generate views, and apply SQL object level security. A SQL Analytics Endpoint is automatically created when you create a Lakehouse. Each Lakehouse has only one SQL Endpoint. You can connect to this endpoint outside of Fabric as well with tools such as SSMS or Azure data Studio by supplying your authentication.

Press enter or click to view image in full size

![i6](https://miro.medium.com/v2/resize:fit:720/format:webp/1*I-lZNmBPS8Q1F_A4rnB8uw.png)

## Notes of Lakehouse

- Non-Delta Tables, all other files will not have ACID support in the Lakehouse organized by folders and files, lake databases and delta tables.
- Key skills include Spark (Scala, PySpark, Spark SQL, R)
- T-SQL for read-only operations and limited in SQL Analytics Endpoint on the Lakehouse
- Interaction with data will mainly through via Spark notebooks and Spark job definitions.
- Connect to over 100 data sources and apply transformations using Dataflows gen2
- Use the copy activity in pipelines to replicate large-scale lakes
- Ingest data from multiple sources and store it in an open format.
- ACID transaction capabilities are only for Delta formatted tables.
- Delta tables extend parquet files with a file-based transaction log for ACID transactions
- You can interact ACID support for Delta Tables with Spark or SQL engine
Non-Delta Tables, all other files will not have ACID support in the Lakehouse
- Data Masking supported only through the SQL analytics endpoint of the Lakehouse. Files or engines other than SQL (Ex. Spark) will not be able to use Dynamic Data Masking.
- Each Lakehouse has an autogenerated SQL analytics endpoint that can be leveraged through familiar SQL tools such as SQL Server Management Studio, Azure Data Studio or Microsoft Fabric SQL Query Editor.
- Lakehouse can serve Power BI with same Direct Lake mode semantic model capability. Or using import or Direct Query mode through the SQL Analytics Endpoint of the Lakehouse

# **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

## In this article

- Why use SQL database in Fabric?
- Sharing
- Connect
- Cross-database queries
- Data Engineering with your SQL database in Fabric
- Data Science with your SQL database in Fabric
- Database portability and deployments with SqlPackage
- Integration with Fabric source control
- Create GraphQL API from Fabric portal
- Capacity management
- Mirroring for Azure SQL Database
- Elastic pools
- Next step
- Related content

SQL database in Microsoft Fabric is a developer-friendly transactional database, based on Azure SQL Database, that allows you to easily create your operational database in Fabric. A SQL database in Fabric uses the same SQL Database Engine as Azure SQL Database.

To learn more about SQL database in Fabric, watch a Data Exposed episode introducing on the **[SQL database in Microsoft Fabric public preview](https://learn.microsoft.com/en-us/shows/data-exposed/announcing-sql-database-in-microsoft-fabric-public-preview-data-exposed)**.

To get started with a full walkthrough, see the tutorial to **[Create a SQL database in the Fabric portal](https://learn.microsoft.com/en-us/fabric/database/sql/create)**. If you want help with a particular task, visit the Get started section

SQL database in Fabric is:

- The home in Fabric for OLTP workloads
- Easy to configure and manage
- Set up for analytics by automatically replicating the data into OneLake near real time
- Integrated with development frameworks and analytics
- Based on the underlying technology of Mirroring in Fabric
- Queried in all the same ways as Azure SQL Database, plus a web-based editor in the Fabric portal.
- Intelligent performance features from Azure SQL Database are enabled by default in SQL database in Fabric, including:

  - Automatic index creation with Automatic Tuning

OLTP, or Online Transaction Processing, is a type of data processing that focuses on managing and executing a high volume of concurrent transactions in real-time. These transactions are typically short and simple, such as online banking, order entry, or inventory updates. OLTP systems are designed for speed and efficiency in handling these transactions, ensuring data integrity and reliability.

## Why use SQL database in Fabric?

SQL database in Fabric is part of the Database workload, and the data is accessible from other items in Fabric. Your SQL database data is also kept up-to-date in a queryable format in OneLake, so you can use all the different services in Fabric, such as running analytics with Spark, executing notebooks, data engineering, visualizing through Power BI Reports, and more.

![i1](https://learn.microsoft.com/en-us/fabric/database/sql/media/overview/sql-database.png)

With your SQL database in Fabric, you don't need to piece together different services from multiple vendors. Instead, you can enjoy a highly integrated, end-to-end, and easy-to-use product that is designed to simplify your analytics needs, and built for openness and collaboration between technology solutions that can read the open-source Delta Lake table format. The Delta tables can then be used everywhere in Fabric, allowing users to accelerate their journey into Fabric.

The Microsoft Fabric platform is built on a foundation of Software as a Service (SaaS). To learn more about Microsoft Fabric, see **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**

SQL database in Fabric creates three items in your Fabric workspace:

Data in your SQL database is automatically replicated of into the OneLake and converted to Parquet, in an analytics-ready format. This enables downstream scenarios like data engineering, data science, and more.

A SQL analytics endpoint

A default semantic model

In addition to the Fabric SQL database Query Editor, there's a broad ecosystem of tooling including SQL Server Management Studio, the **[mssql extension with Visual Studio Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code/mssql-extensions?view=fabric&preserve-view=true)**, and even GitHub Copilot.

## Sharing

Sharing enables ease of access control and management, while security controls like row level security (RLS) and object level security (OLS), and more make sure you can control access to sensitive information. Sharing also enables secure and democratized decision-making across your organization.

By sharing your SQL database, you can grant other users or a group of users access to a database without giving access to the workspace and the rest of its items. When someone shares a database, they also grant access to the SQL analytics endpoint and associated default semantic model.

Access the Sharing dialog with the Share button next to the database name in the Workspace view. Shared databases can be found through OneLake Data Hub or the Shared with Me section in Microsoft Fabric.

For more information, see Share data and manage access to your SQL database in Microsoft Fabric.

# **[What is Mirroring in Fabric?](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/overview)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Mirroring in Fabric is a low-cost and low-latency solution to bring data from various systems together into a single analytics platform. You can continuously replicate your existing data estate directly into Fabric's OneLake from a variety of Azure databases and external data sources.

With the most up-to-date data in a queryable format in OneLake, you can now use all the different services in Fabric, such as running analytics with Spark, executing notebooks, data engineering, visualizing through Power BI Reports, and more.

Mirroring in Fabric allows users to enjoy a highly integrated, end-to-end, and easy-to-use product that is designed to simplify your analytics needs. Built for openness and collaboration between Microsoft, and technology solutions that can read the open-source Delta Lake table format, Mirroring is a low-cost and low-latency turnkey solution that allows you to create a replica of your data in OneLake which can be used for all your analytical needs.

The Delta tables can then be used everywhere Fabric, allowing users to accelerate their journey into Fabric.

## Why use Mirroring in Fabric?

Today many organizations have mission critical operational or analytical data sitting in silos.

Accessing and working with this data today requires complex ETL (Extract Transform Load) pipelines, business processes, and decision silos, creating:

- Restricted and limited access to important, ever changing, data
- Friction between people, process, and technology
- Long wait times to create data pipelines and processes to critically important data
- No freedom to use the tools you need to analyze and share insights comfortably
- Lack of a proper foundation for folks to share and collaborate on data
- No common, open data formats for all analytical scenarios - BI, AI, Integration, Engineering, and even Apps

Mirroring in Fabric provides an easy experience to speed the time-to-value for insights and decisions, and to break down data silos between technology solutions:

- Near real time replication of data and metadata into a SaaS data-lake, with built-in analytics built-in for BI and AI
The Microsoft Fabric platform is built on a foundation of Software as a Service (SaaS), which takes simplicity and integration to a whole new level. To learn more about Microsoft Fabric, see What is Microsoft Fabric?

Mirroring creates three items in your Fabric workspace:

- Mirroring manages the replication of data and metadata into **[OneLake](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview)** and conversion to Parquet, in an analytics-ready format. This enables downstream scenarios like data engineering, data science, and more.
- A SQL analytics endpoint
- A Default semantic model

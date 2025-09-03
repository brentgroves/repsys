# **[Understanding Data Mart & Data Flow Gen 1 in Power BI Experience](https://medium.com/@uzuntasgokberk/data-mart-data-flow-gen-1-bbbaf7eabe07)**

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*6R0ePf5D7Pdh5aZIypLaiA.png)

Explore the concepts of Data Mart and Data Flow Gen 1 within Power BI experience. Learn how these components are applied with a PBI license to streamline data management and analysis. Enhance your understanding of creating efficient data pipelines and optimizing your business intelligence workflows.

## Introduction Data Mart

Data Mart are self-service analytics solutions, enabling users to store and explore data that is loaded in a fully managed database. Data Marts provide a simple and optionally no-code experience to ingest data from different data sources, extract transform and load (ETL) the data using Power Query, then load it into an Azure SQL database that’s fully managed and requires no tuning or optimization.

## Data Mart benefits and features

Self-service users can easily perform relational database analytics, without the need for a database administrator
Datamarts provide end-to-end data ingestion, preparation and exploration with SQL, including no-code experiences
Enable building semantic models and reports within one holistic experience
100% web-based, no other software required
A no-code experience resulting in a fully managed datamart
Automated performance tuning
Built-in visual and SQL Query editor for ad-hoc analysis
Support for SQL and other popular client tools
Native integration with Power BI, Microsoft Office and other Microsoft analytics offerings
Press enter or click to view image in full size

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*3zaG2M2nlrNxNR8k9tcvDw.png)

In this architecture, the data source is csv file in local. Before beginning this architecture in PBI that the workspace must be created as premium workspace.

In the workspace Data Mart is created.

![i2](https://miro.medium.com/v2/resize:fit:640/format:webp/1*-T5pk4ArTmlhkYuWhRcCVg.png)

When Data Mart is created. This is the visualization how the screen is shown. There are lots of option in the Data Mart.

Press enter or click to view image in full size

![i3](https://miro.medium.com/v2/resize:fit:720/format:webp/1*dkiDEcOs13s6vxKopP_kWA.png)

“Refresh Icon” (Refresh data)
“Get Data” (Take datas from different sources)
“Transform Data” (This is the Power Query editor that you can develop ETL process)
“New SQL Query” (Ad-hoc Analysis with SQL)
“New Visual Query” (Ad-hoc Analysis with Diagram Power Query), “New Report” (Creating a report that you can visualize)
“New Report” (Creating a report that you can visualize)
“New Measure” (Creating a measure that you can use in your reports)
“Manage Roles & View As” (RLS-Row Level Security)

![i4](https://miro.medium.com/v2/resize:fit:640/format:webp/1*DD6zEDmNeQFEz7BpEaJ4cg.png)

“Data” (collection of discrete or continuous values that convey information)
“Query” (a question or request for data)
“Model” (Define the relationship between the data sources)
Press enter or click to view image in full size

![i5](https://miro.medium.com/v2/resize:fit:720/format:webp/1*JtcPtZCW6Am_jPxGMAqFnw.png)

Clicking Get Data → New Source → Text/CSV.

Press enter or click to view image in full size

![i6](https://miro.medium.com/v2/resize:fit:720/format:webp/1*5DnPZClCfxynHMxdGyybTA.png)

Upload the Case Death CSV file.

Press enter or click to view image in full size

![i7](https://miro.medium.com/v2/resize:fit:720/format:webp/1*34NQ8_xHbVMc3OlEFE0bgg.png)

When confirms the upload file this is the transform side which means Power Query side. This is the Power Query of case death csv file.

Press enter or click to view image in full size

![i8](https://miro.medium.com/v2/resize:fit:720/format:webp/1*7vuPUGrq_8CjN0cdyUQAUw.png)

Upload Dim Date CSV file.

Press enter or click to view image in full size

![i9](https://miro.medium.com/v2/resize:fit:720/format:webp/1*gdafHM3ZodlFqJznZskpMg.png)

Power Query of dim date csv file. Needing to match dim date to Case Death date to find week, month information etc.

Press enter or click to view image in full size

![i10](https://miro.medium.com/v2/resize:fit:720/format:webp/1*Aw3_hFo8xSCWUhEwb-Uhbw.png)

Example of some transform process.

Press enter or click to view image in full size

![i11](https://miro.medium.com/v2/resize:fit:720/format:webp/1*vjvUraBCcwYZblx_owaoWw.png)

There is 2 option to use Dim Date datas that are Merge Queries or ModelLing. In this one shown Merge Query.

Press enter or click to view image in full size

![i12](https://miro.medium.com/v2/resize:fit:720/format:webp/1*9nIDNFKK6jgVSKX14_KqyQ.png)

Clicking Merge Queries as New that created a new table with merged.

![i13](https://miro.medium.com/v2/resize:fit:640/format:webp/1*f0kKZ7Gv35BZLfEIBlNfpg.png)

Merged Case_w_date table.

Press enter or click to view image in full size

![i14](https://miro.medium.com/v2/resize:fit:720/format:webp/1*eRPAfF1MVo4ZUqpQJTO2QQ.png)

dim_date must be expanded to observe the data with merged table.

Press enter or click to view image in full size

![i15](https://miro.medium.com/v2/resize:fit:720/format:webp/1*lWa5I6aJl7bZIJtEI5n1cg.png)

With Query Setting that the lineage visualization can be seen that what have been done so far.

![i16](https://miro.medium.com/v2/resize:fit:720/format:webp/1*hjhlZHEfMpm5TjVNbKU3QA.png)

After clicking save button. In Data can be observed with details.

![i17](https://miro.medium.com/v2/resize:fit:720/format:webp/1*flXNNQ7u5I3ralPgfTFI6g.png)

Navigating Ad-hoc analysis with SQL.

![i18](https://miro.medium.com/v2/resize:fit:720/format:webp/1*YlPJt3UnYNjvfYzJAT1m0Q.png)

With Query tab, example for Ad-Hoc Analyzing Spain of count number.

![i19](https://miro.medium.com/v2/resize:fit:720/format:webp/1*2mPEnLqj7lEpH7moD23Ptg.png)

With Model tab that can be defined the relationship between the data sources.

![i20](https://miro.medium.com/v2/resize:fit:720/format:webp/1*p_FIUuBYajm6ep1FiM2Smg.png)

As explained before the second option without merge is that can be used make relationship between tables.

![i21](https://miro.medium.com/v2/resize:fit:720/format:webp/1*axv_eBOSG5zcitXCnEjUHA.png)

Example of make relationship with tables. Also there ise option “New Visual query” that can be used Ad-hoc Analysis with Diagram Power Query.

![i22](https://miro.medium.com/v2/resize:fit:720/format:webp/1*YIvqYVZv4QpfnUvQGJ_mUw.png)

Option to observe Cases_w_date merged table with filter.

![i23](https://miro.medium.com/v2/resize:fit:720/format:webp/1*WFO3rei4logS10ARF-V3Pw.png)

Data Mart Limitation:
When Data Mart refresh, all data in data Mart will be refreshed.
SQL DML / DDL Command is not available
Data Mart Data Store Properties
Data Volume: Up to 100GB
Type of data: Structured
Primary developer skill set: No code, SQL
Data organized by: Database, tables, queries
Read operations: T-SQL, Power BI
Write operations: Dataflows, T-SQL
Multi-table transactions: No
Primary development interface: Power BI
Security: Built-in RLS editor
Access data via shortcuts: No
Can be a source for shortcuts: No
Query across items: No

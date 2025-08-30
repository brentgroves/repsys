# Current Tasks

Team:

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas.Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Carlos Morales, IT Administrator, Muscle Shoals
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
David Maitner,  Desktop and System Support Technician, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje

<brent.groves@linamar.com>
<https://accounts.sap.com/ui/onbehalfupdate/submit>

- charmed kubernetes  <https://ubuntu.com/kubernetes/charmed-k8s/docs/install-local>
- <https://ubuntu.com/kubernetes/charmed-k8s/docs/quickstart>
- Encryption with Ceph/Bitlocker

## Aug 25th

- Setup Fabric Gateway for data sources not accessible from Fabric directly.
- Research managing/publishing Power BI reports.
- HA Storage to include object storage.
-

## Aug 16th

- If you filter columns and records in CTEs prior to the final select statement no noticable change in run time is noticed.  If you run queries several times a huge performance increase occurs.
- Foriegn key constraints prevent records from being deleted that are referenced in tables. Many foriegn key constraints are missing in Plex, so be careful to use outer joins so you do not drop records.
- Using a virtual router using the VRRP protocol allows us to keep network sessions alive during reboots of storage clusters and microservices.

## Aug 4th

- Setup Fabric Gateway Windows Server with 64GB ram with ODBC connection to Plex.
- Fabric Directory Structure

## July 31

Check if Plex supports **[OData](https://www.odata.org/)**
developers.plex.com
email,password

## July 23

Check if Plex supports **[OData](https://www.odata.org/)**
developers.plex.com
email,password

Semantic models hide the complex technical details behind reports so that both technical and non-technical users can concentrate on analyzing the data and answering business questions. Sharing and reusability are two stand-out features of semantic models.

## What Makes Up a Semantic Model?

Semantic models consist of several different elements:

Data connections to one or more data sources, either imported, through DirectQuery, or as part of a composite model.
Transformations that clean and prepare the data for reporting.
Defined calculations and metrics based on business rules to ensure consistent reports built from the semantic model. This ensures clarity and avoids discrepancies between analyses and reports.
Defined relationships between tables allow users to focus on designing reports without knowing the underlying database structures and data models beforehand.

## power bi semantic models with stored procedures

**[stored procedures](https://www.youtube.com/watch?v=N1En6_NB_dY)**
**[call sprocs from power bi](https://www.youtube.com/watch?v=-GS3Kxvxm7A&t=247s)**
Options:

1. Allow the ETL system call stored procedures to load and transform you data and use Power BI to connect to the ETL systems result sets and use **[star schema best practices](https://www.owox.com/blog/articles/star-schema-explained)**
2. Use Power BI direct query mode to retrieve only data needed for complete transformation. Don't know if this mode is compatible with Power Query M language and DAX functions

## DirectQuery and Dynamic Parameters

When you need to pass dynamic parameters (user inputs) to a stored procedure, DirectQuery mode is typically required.
This allows for interactive reports where user selections in the report UI are passed as parameters to the stored procedure in the database.
Example: You might have a stored procedure that filters data based on a date range selected by the user in the report.

## Links

- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)** workshop is a free, hands-on training designed for analysts working with Power BI and Microsoft Fabric. You can get hands-on experience on how to analyze data, build reports, using Fabric. It covers key concepts like working with lakehouses, creating reports, and analyzing data in the Fabric environment.

Join our new Microsoft Fabric user panel to share your feedback and help shape Fabric and Power BI. Participate in surveys and 1:1 sessions with the product team. Learn more and sign up **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**.

- Help access APIs from Plex
  - <https://plex.my.site.com/community/s/question/0D52T00005b6l1YSAQ/calling-a-plex-http-api-from-powerbi-pure-mquery>
  - <https://plex.my.site.com/community/s/question/0D52T00005wznVcSAI/how-to-integrate-plex-with-power-bi>

- **[Data Pipeline](https://cloud.google.com/dataflow/docs/quickstarts/create-pipeline-go)**
  - Go's best feature is handling concurency. Use it to manage our Python ETL scripts.

- **[Real-time data warehousing with Apache Spark and Delta Lake](https://www.sigmoid.com/blogs/near-real-time-finance-data-warehousing-using-apache-spark-and-delta-lake/)**
  - Reporting values over time

1. collect data periodically
2. Make quantity used set by calculating difference between consecutive values of periodic data.
3. Make quantity used change per period set by calculating difference between consecutive quantity used values.

In data analysis, "direction fields" (also called slope fields) are a visual representation of the solutions to a differential equation. They help understand the behavior of the equation by showing the direction (slope) of the solutions at various points on a graph.
OData
<https://stackoverflow.com/questions/9084761/how-to-calculate-the-slope-in-sql>

```sql
SELECT
    Scores.Date, Scores.Keyword, Scores.Score,
    (N * Sum_XY - Sum_X * Sum_Y)/(N * Sum_X2 - Sum_X * Sum_X) AS Slope
FROM Scores
INNER JOIN (
    SELECT
        Keyword,
        COUNT(*) AS N,
        SUM(CAST(Date as float)) AS Sum_X,
        SUM(CAST(Date as float) * CAST(Date as float)) AS Sum_X2,
        SUM(Score) AS Sum_Y,
        SUM(CAST(Date as float) * Score) AS Sum_XY
    FROM Scores
    GROUP BY Keyword
) G ON G.Keyword = Scores.Keyword;
It uses Simple Linear Regression to calculate the slope.

Result:

Date         Keyword        Score         Slope
2012-01-22   water bottle   0,010885442   0,000334784345222076
2012-01-23   water bottle   0,011203949   0,000334784345222076
2012-01-24   water bottle   0,008460835   0,000334784345222076
2012-01-25   water bottle   0,010363991   0,000334784345222076
2012-01-26   water bottle   0,011800716   0,000334784345222076
2012-01-27   water bottle   0,012948411   0,000334784345222076
2012-01-28   water bottle   0,012732459   0,000334784345222076
2012-01-29   water bottle   0,011682568   0,000334784345222076
Every database system seems to have a different approach to converting dates to numbers:

MySQL: TO_SECONDS(date) or TO_DAYS(date)
Oracle: TO_NUMBER(TO_CHAR(date, 'J')) or date - TO_DATE('1','yyyy')
MS SQL Server: CAST(date AS float) (or equivalent CONVERT)
```

- EntraID access to Azure SQL db for Sam.
- Python uv ODBC test. Don't know the ODBC state of the laptop before I started. I know 32-bit libraries had not been installed because ./rcshell reported unknown file but I could have just removed them after the last install. Create a Python self-installing file with pyodbc in the top dependancies section.

- Providing support to Jared EikenBerry in Fruitport for running ETL scripts for Power BI. His scripts will be automated by the ETL report system.
- Jared EikenBerry Admin privileges.

- Create InnoDB scripts
  - make Reporting4 from Reporting which has the mysql and azure sql scripts.
  - Install IAzure Data Studio officially retires on February 28, 2026. You should migrate to Visual Studio Code. This change aims to consolidate SQL development tools and provide a more robust and feature-rich environment for the developer community.nnoDB on K8s
  - Create InnoDB Schema from Mysql schema
  - populate InnoDB database with records from Mysql.
- SystemD socket activation unit listens for connection and then start a one-shot unit. The one-shot unit runs many tasks consequatively such as those in an ETL pipeline. Test it on Linamar Azure SQL TB.
- Suggested Mach2 Linux GW on server VLAN using Netfilter port forwarding and Natting features. mTLS option requires proxy.
- Run TB script from **[Linamar Azure SQL DB](./b_platform_engineering/database/azuresqldb/run_tb_from_azure_sql_db.md)** tennant.
- SystemD vs Kubernetes
  - SystemD is better at starting programs after other programs.
  - Kubernetes uses yaml SystemD used TOML.
  - Kubernetes manages scalability of services.
  
- Make GoLang and Python dev container to create base docker image for ETL scripts.
- Compare mail service options.
  You might wonder, “Why go through the effort when third-party services exist?” The answer lies in control. Self-hosting lets you tailor spam filters, encrypt communications your way, and ensure compliance with regional data laws.

  - Postfix with public key security and Amazon programmatic DNS txt record creation.
  - Mailtrap service.

## info

- Azure Data Studio officially retires on February 28, 2026. You should migrate to Visual Studio Code. This change aims to consolidate SQL development tools and provide a more robust and feature-rich environment for the developer community.
- was able to access plex without config request from desktop server vlan.
- All the knowledge of programmers who made the software in the lifecycle API.
- OpenStack uses JuJu.
- Does Nutanix use OpenStack?

Yes, Nutanix integrates with OpenStack. Nutanix provides drivers for core OpenStack services like Nova, Cinder, Glance, and Neutron, allowing users to easily connect their Nutanix infrastructure to OpenStack. This integration enables organizations to leverage the benefits of both platforms, including Nutanix's hyperconverged infrastructure and OpenStack's cloud management capabilities?

- **[file descriptors](https://copyconstruct.medium.com/bash-redirection-fun-with-descriptors-e799ec5a3c16)**

## Misc

- Migrate from MSC to new vending machines.
- Muscle Shoals thin client certificates.
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## Questions

- Can setup HyperV Ubuntu 24.04 server VM in 50 and 1220 VLans on core server. To access Albion subnets from R620s using port forwarding.
- Ask for Plex web service account from Sam or Kevin
- Does any location besides Indiana have vending machines?

## **[Research](../research/research_list.md)**

- port forwarding with OVS
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## **[Data Analysis](./a_data_analysis/is_data_analysis.md)**

- days on hand formula

## **[Automated Certificate Management System](./a_certificate_management/certificate_management_status.md)**

- Add Nancy Swank and Jamie Pyle computers to PKI GPO.

## Automated ETL and Report System

- Python base data source docker image.
- Move schema and ETL scripts from Mobex Azure SQL MI to the Linamar Azure SQL DB and Avilla K8s servers.
- Write scripts to compare Mobex Azure SQL result sets to Linamar Azure SQL DB result set.

## Tool Management System

- Access to vending machine schema

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- Jared made config request to move Dell R620s to core server using link aggregation and 10 GP SPF+ modules.
- **[Access VLAN 1220](../research/m_z/virtualization/networking/linamar/avilla/isdev/vlan1220/edge/try2.md)** to check Albion Mach2 certificate chain.

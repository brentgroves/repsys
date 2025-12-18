# **[SQL Server Integrates Hadoop and Spark out-of-the box: The Why?](https://www.sqlservercentral.com/articles/sql-server-integrates-hadoop-and-spark-out-of-the-box-the-why)**

## Security issue

Apache Log4j SEoL (<= 1.x) (182252)
IP Address: 10.188.50.13 ( TCP )
DNS: pd-avi-sql01.linamar.com
Steps to Remediate
Upgrade to a version of Apache Log4j that is currently supported:

Microsoft announced in September 2018 that SQL Server 2019, which is now in preview, will have a Big Data Cluster deployment option. This is a Big-Data-capable SQL Server with elastic scale and extended Artificial Intelligence (AI) capabilities, mostly as a result of deep integration of Hadoop and Spark out-of-the-box.  The new SQL Server Big Data Cluster is expected to yield a lot more than the ability to employ Hadoop and Spark directly from a SQL Server environment. This managed ecosystem particularly presents new approaches to data virtualization that allows one to easily integrate data across multiple data sources without needing to move data by ETL processes. It also enables Modern and Logical Data Warehouses with Polyglot Persistence architecture and designs that employs multiple data storage technologies, for e.g. via a data lake.

In a later article we will take a comprehensive and practical look at the pros and cons  of SQL Server Big Data Cluster architecture. In this article however, we will try to understand the importance and benefits of Hadoop and Spark specifically, and why it was important for SQL Server to be a platform tightly knitted to these two technologies.

If you are particularly new to Hadoop and Spark, you are probably wondering what they are. If you are quite familiar with them, you could be wondering why the need to integrate them with SQL Server. Well, the major importance of this marriage, in my opinion, has to do with the importance of Structured Query Language (SQL) and the value it brings to Big Data related processing, analytics and application work-flows. Fortunately I chronicled some of these Big Data technological trends and evolution in various articles on this forum since 2013. These articles, some of which are listed below explores the technological journey that culminated to what SQL Server Big Data Cluster is today.

- **[Big Data for SQL folks: The Technologies (Part I) (2013)](https://www.sqlservercentral.com/steps/big-data-for-sql-folks-the-technologies-part-i)**
- **[Hadoop For SQL Folks: Architecture, MapReduce and Powering IoT (2015)](https://www.sqlservercentral.com/articles/hadoop-for-sql-folks-architecture-mapreduce-and-powering-iot)**
- **[Distributed Computing Principles and SQL-on-Hadoop Systems (2017)](https://www.sqlservercentral.com/articles/distributed-computing-principles-and-sql-on-hadoop-systems)**
- **[SQL-On-Hadoop: Hive  (2017)](https://www.sqlservercentral.com/articles/sql-on-hadoop-hive-part-i)**

In these past articles, I touched on trends and also the importance and evolution of various technologies, including: Big Data, Distributed Systems, Hadoop, SQL-on-Hadoop, NoSQL, PolyBase, Spark, Data Virtualization, Lambda architecture, Polyglot Persistence etc. These are trends, technologies and data architecture designs that helped shape or forms part of the SQL Server unified Data platform today.

## The SQL and Big Data Saga

During the advent of the Big Data challenges, a lot of new technologies emerged to try to address the capacity to store, process and derive value from the available huge datasets. These datasets often consisted in large portions of unstructured and semi-structured data. This led to the emergence of NoSQL (not only SQL) non-relational databases with a lot of proponents even suggesting that Relational Database Management Systems (RDBMS) and Structured Query Language (SQL) will become obsolete. To the contrary SQL has emerged stronger and so has RDBMS like SQL Server that kept pace with the challenges that Big Data presented.

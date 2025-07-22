# **[Open Source OLAP databases that support separation of compute and storage](https://atwong.medium.com/open-source-olap-databases-that-supported-separation-of-compute-and-storage-d49f3bd2df74)**

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*EXdv9_O7t9Tbz0nIxfv-gA.png)

So why would you want to use a database with separation of compute and storage?

Let’s rewind and ask, what is the separation of compute and storage? The separation of compute and storage for OLAP databases is an architectural choice that allows the compute and storage resources of a database to be scaled independently. This can provide a number of benefits, including:

Improved performance: By separating compute and storage, it is possible to optimize each resource for its specific purpose. For example, compute resources can be optimized for speed, while storage resources can be optimized for capacity and cost.
Increased scalability: By scaling compute and storage independently, it is possible to scale the database to meet the needs of even the most demanding workloads.
Reduced costs: By separating compute and storage, it is possible to avoid paying for unused resources. For example, if you need to scale up your compute resources to handle a spike in workload, you do not need to scale up your storage resources as well.
Some of the most well known OLAP databases that support the separation of compute and storage are Snowflake, Big Query, and more recently a variant of RedShift called RedShift Spectrum.

Some of the popular Open Source OLAP databases that support the separation of compute and storage are:

StarRocks: Yes. StarRocks is a Linux Foundation project and one of the 2023 winner of best open source project by InfoWorld. It aims to be fastest OLAP database. Read more at <http://starrocks.io>
Clickhouse: Yes. ClickHouse is an open-source column-oriented database management system (DBMS) for online analytical processing (OLAP). It is designed for real-time analytics and can handle large volumes of data with high performance. ClickHouse is used by a number of companies, including Netflix, Airbnb, and Uber, to power their real-time analytics applications. Read more at <http://clickhouse.com>
Apache Druid: Yes. Apache Druid is a high-performance, open-source, distributed data store written in Java. It is designed to quickly ingest massive quantities of event data, and provide low-latency queries on top of the data. Druid is commonly used in business intelligence-OLAP applications to analyze high volumes of real-time and historical data. Read more at <http://druid.apache.org>
Zoom image will be displayed

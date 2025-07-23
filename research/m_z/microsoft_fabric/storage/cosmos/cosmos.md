# **[cosmos]()**

The Cosmos file system project at Microsoft began in 2006, after
GFS [11]. The Scope language [7] is a SQL dialect similar to Hive,
with support for parallelized user-code and a generalized group-by
feature supporting Map-Reduce. Cosmos and Scope (often referred
to jointly as “Cosmos”) are operated as a service—users companywide create files and submit jobs, and the Big Data team operates
the clusters that store data and process the jobs. Virtually all groups
across the company, including Ad platforms, Bing, Halo, Office,
Skype, Windows and XBOX, store many exabytes of
heterogeneous data in Cosmos, doing everything from exploratory
analysis and stream processing to production workflows.
While Cosmos was becoming a foundational Big Data service
within Microsoft, Hadoop emerged meantime as a widely used

open-source Big Data system, and the underlying file system HDFS
has become a de-facto standard [28]. Indeed, HDInsight is a
Microsoft Azure service for creating and using Hadoop clusters.
ADLS is the successor to Cosmos, and we are in the midst of
migrating Cosmos data and workloads to it. It unifies the Cosmos
and Hadoop ecosystems as an HDFS compatible service that
supports both Cosmos and Hadoop workloads with full fidelity.
It is important to note that the current form of the external ADL
service may not reflect all the features discussed here since our goal
is to discuss the underlying architecture and the requirements that
informed key design decisions.

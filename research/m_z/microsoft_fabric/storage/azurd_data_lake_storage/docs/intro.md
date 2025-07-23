# **[]()**

Introduction to Azure Data Lake Storage
12/09/2024
Azure Data Lake Storage is a set of capabilities dedicated to big data analytics, built on Azure Blob Storage.

Data Lake Storage makes Azure Storage the foundation for building enterprise data lakes on Azure. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput, Data Lake Storage allows you to easily manage massive amounts of data.

What is a Data Lake?
A data lake is a single, centralized repository where you can store all your data, both structured and unstructured. A data lake enables your organization to quickly and more easily store, access, and analyze a wide variety of data in a single location. With a data lake, you don't need to conform your data to fit an existing structure. Instead, you can store your data in its raw or native format, usually as files or as binary large objects (blobs).

Azure Data Lake Storage is a cloud-based, enterprise data lake solution. It's engineered to store massive amounts of data in any format, and to facilitate big data analytical workloads. You use it to capture data of any type and ingestion speed in a single location for easy access and analysis using various frameworks.

Hadoop-compatible access
Azure Data Lake Storage is primarily designed to work with Hadoop and all frameworks that use the Apache Hadoop Distributed File System (HDFS) as their data access layer. Hadoop distributions include the Azure Blob File System (ABFS) driver, which enables many applications and frameworks to access Azure Blob Storage data directly. The ABFS driver is optimized specifically for big data analytics. The corresponding REST APIs are surfaced through the endpoint dfs.core.chinacloudapi.cn.

Data analysis frameworks that use HDFS as their data access layer can directly access Azure Data Lake Storage data through ABFS. The Apache Spark analytics engine and the Presto SQL query engine are examples of such frameworks.

For more information about supported services and platforms, see Azure services that support Azure Data Lake Storage and Open source platforms that support Azure Data Lake Storage.

Hierarchical directory structure
The hierarchical namespace is a key feature that enables Azure Data Lake Storage to provide high-performance data access at object storage scale and price. You can use this feature to organize all the objects and files within your storage account into a hierarchy of directories and nested subdirectories. In other words, your Azure Data Lake Storage data is organized in much the same way that files are organized on your computer.

Operations such as renaming or deleting a directory, become single atomic metadata operations on the directory. There's no need to enumerate and process all objects that share the name prefix of the directory.

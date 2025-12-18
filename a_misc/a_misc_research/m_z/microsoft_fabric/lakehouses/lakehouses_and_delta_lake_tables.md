# **[Lakehouse and Delta Lake tables](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables)

Microsoft Fabric Lakehouse is a data architecture platform for storing, managing, and analyzing structured and unstructured data in a single location. In order to achieve seamless data access across all compute engines in Microsoft Fabric, Delta Lake is chosen as the unified table format.

When you save data in a lakehouse using capabilities such as Load to Table or methods described in **[Options to get data into the Fabric Lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/load-data-lakehouse)**, all data is saved in Delta format.

For a more comprehensive introduction to the Delta Lake table format, follow the Related content links at the end of this article.

Big data, Apache Spark, and legacy table formats
Microsoft Fabric Runtime for Apache Spark uses the same foundation as Azure Synapse Analytics Runtime for Apache Spark, but contains key differences to provide a more streamlined behavior across all engines in the Microsoft Fabric service. In Microsoft Fabric, key performance features are turned on by default. Advanced Apache Spark users may revert configurations to previous values to better align with specific scenarios.

Microsoft Fabric Lakehouse and the Apache Spark engine support all table types, both managed and unmanaged; this includes views and regular non-Delta Hive table formats. Tables defined using PARQUET, CSV, AVRO, JSON, and any Apache Hive-compatible file format work as expected.

The Lakehouse explorer user interface experience varies depending on table type. Currently, the Lakehouse explorer only renders table objects.

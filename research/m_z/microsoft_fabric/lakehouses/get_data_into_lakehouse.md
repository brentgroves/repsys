# **[Options to get data into the Fabric Lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/load-data-lakehouse)**

The get data experience covers all user scenarios for bringing data into the lakehouse, like:

- Connecting to existing SQL Server and copying data into Delta table on the lakehouse.
- Uploading files from your computer.
- Copying and merging multiple tables from other lakehouses into a new Delta table.
- Connecting to a streaming source to land data in a lakehouse.
- Referencing data without copying it from other internal lakehouses or external sources.

Different ways to load data into a lakehouse
In Microsoft Fabric, there are a few ways you can get data into a lakehouse:

- File upload from local computer
- Run a copy tool in pipelines
- Set up a dataflow
- Apache Spark libraries in notebook code
- Stream real-time events with Eventstream
- Get data from Eventhouse

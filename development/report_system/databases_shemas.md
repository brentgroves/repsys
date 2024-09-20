# Databases and Shemas

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## MySQL

- An InnoDB Cluster will be used for HA.
- There is a schema for each report's work area. These work areas will contain all database objects necessary for the ETL scripts to produce the result set.
- There is one report work area for each report runner pod to provide for scalability. Each report runner pod is initialized with the schema it will be using to create its result set.
- Format for work schema name: r9w1, reportID 9, work area 1.
- Format for current report schema: r9u1, reportID 9, userID 1

## MSSQL

MSSQL takes alot of memory and there is no operator for it so I want to isolate it by creating a single node cluster only for it.

- Only use MSSQL when necessary since it does not have a K8s operator and does not have a Linux HA configuration option.
- Format schema like r9u1 for reportID 9 and userID 1.
- Only use for PowerBI reports.

## MongoDB

- Store every report run in a MongoDB object for later retrieval or comparison reports.
- Format the object like r9u1i12 for reportID 9, userID 1, and runID 12.
- Also create a table that describes each report run so it can be used to index all report objects.

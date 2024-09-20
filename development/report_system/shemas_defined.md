# Shemas Defined

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## MySQL

- An InnoDB Cluster will be used for HA.
- There is a schema for each report's work area. These work areas will contain all database objects necessary for the ETL scripts to produce the result set.
- There is one report work area for each report runner pod to provide for scalability. Each report runner pod is initialized with the schema it will be using to create its result set.

## MSSQL

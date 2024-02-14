# Azure database copy between subscriptions

I am going to use SqlPackage instead because we are going from an Azure SQL Mangaged Instance to an Azure SQL database SAS.

## prelim work

- identify database in Azure SQL managed instance to copy
- Get database stats

## source database

## **[Get size of source database](https://learn.microsoft.com/en-us/azure/azure-sql/database/file-space-manage?view=azuresql-db)**

```sql
SELECT file_id, type_desc,
       CAST(FILEPROPERTY(name, 'SpaceUsed') AS decimal(19,4)) * 8 / 1024. AS space_used_mb,
       CAST(size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS decimal(19,4)) AS space_unused_mb,
       CAST(size AS decimal(19,4)) * 8 / 1024. AS space_allocated_mb,
       CAST(max_size AS decimal(19,4)) * 8 / 1024. AS max_size_mb
FROM sys.database_files;
```

|file_id|type_desc|space_used_mb|space_unused_mb|space_allocated_mb|max_size_mb|
|-------|---------|-------------|---------------|------------------|-----------|
|1|ROWS|8243.437500000|60.5625|8304.000000000|131072.000000000|
|2|LOG|13.945312500|634.0547|648.000000000|1048576.000000000|
|65537|FILESTREAM|||0.000000000|-0.007812500|

## **[How to copy Azure SQL database to a different subscription and different tenant](https://techcommunity.microsoft.com/t5/azure-database-support-blog/how-to-copy-azure-sql-database-to-a-different-subscription-and/ba-p/3965985)**

- Enable public IP access to both source and destination servers

## Next

- <https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/database-copy-move-how-to?view=azuresql&tabs=azure-portal>

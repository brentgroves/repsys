# **[Copy data from Azure SQL Managed Instance DB to Azure SQL Server DB](https://stackoverflow.com/questions/69410984/copy-data-from-azure-sql-managed-instance-db-to-azure-sql-server-db)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Note

This only copies 1 table at a time.

You can use the Azure Data Factory pipeline to copy data from Azure SQL Managed Instance DB to Azure SQL Server DB.

1. Create **[Azure data factory](https://learn.microsoft.com/en-us/azure/data-factory/quickstart-create-data-factory-portal#:%7E:text=Azure%20Create%20Data%20Factory%201%20Launch%20Microsoft%20Edge,want%20to%20create%20the%20data%20factory.%20See%20More.)** resource.

2. Select Launch Studio to open Azure Data Factory Studio to start the Azure Data Factory user interface (UI) application on a separate browser tab.

![ls](https://learn.microsoft.com/en-us/azure/data-factory/media/quickstart-create-data-factory/azure-data-factory-launch-studio.png)

## 3. Click on orchestrate

## 4. Create Azure SQL Managed Instance linked service for source dataset connection

![l](https://i.sstatic.net/AnQQ2.png)

## 5. Provide Azure subscription and SQL Managed instance details in linked service connection

## 6. You can select different types of authentication methods in the connection

![smi](https://i.sstatic.net/zcDSK.png)

## 7. Create Azure SQL Database linked service for Sink (destination) dataset connection

![sdb](https://i.sstatic.net/6N5HZ.png)

## 8. Provide your Azure SQL database details in the connection

![sdbd](https://i.sstatic.net/LjTki.png)

## 9. Create a new pipeline and select Copy data activity from Activities

## 10. Create Source and sink datasets with database table details in Copy data activity and select source linked service and sink linked service respectively in Source and Sink settings

![sss](https://i.sstatic.net/eU9bU.png)

You can go through these MS documents for more details on **[Source](https://learn.microsoft.com/en-us/azure/data-factory/connector-azure-sql-managed-instance?tabs=data-factory#create-a-linked-service-to-an-azure-sql-managed-instance-using-ui)** and Sink dataset.

Thanks. I am somewhat familiar with pipeline, have tested it doing a Managed inst to mang inst DB. We would rather not use pipeline method. Also We need to copy all tables in a database initially and then changes from Managed Inst DB to SQL Server DB. Also Pipeline source asks for table we have hundreds. –
Amommy
 CommentedOct 13, 2021 at 16:01
I went back into datafactory after reading your post again last week and there is a workaround for multiple tables but ran into problems if a new column or table table on source. Probably need to add more to the script to create the tables if it doesn't exist. Used instructions here learn.microsoft.com/en-us/azure/data-factory/… substituting the dw part with sql server/MI and no storage account. Another problem is constraints and large tables. It was at almost 8 hour runtime when I cancelled it. Also needs a work around, staging or something. –
Amommy
 CommentedNov 4, 2021 at 14:31
Should not be this difficult. Sql Server has a sync feature but not Mang Inst. hopefully this new feature will help and be available to all soon. learn.microsoft.com/en-us/azure/azure-sql/managed-instance/…

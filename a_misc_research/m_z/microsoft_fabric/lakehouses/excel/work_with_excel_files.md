# how to work with excel file in microsoft fabric

- **[options](https://www.youtube.com/watch?v=Pi5IvkHxJBs)**

To work with an Excel file in Microsoft Fabric, upload the file to a Lakehouse, and then use a Fabric Notebook to read the data with Python's Pandas library or a Data pipeline to load it into a delta table. Alternatively, you can connect Excel directly to your Fabric Lakehouse's SQL endpoint using the "Get Data from SQL Server" feature in Excel to query and analyze the data without moving it.

## Method 1: Upload and Analyze in Fabric

1. Upload the Excel file:
.
Go to your Lakehouse in Microsoft Fabric and upload the Excel file into the Files section.
2. Convert to a table:
.
After uploading, you can convert the file into a delta table within the Lakehouse.

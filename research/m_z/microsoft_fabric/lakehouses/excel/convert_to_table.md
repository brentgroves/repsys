# Convert to a table

- **[create a table](https://learn.microsoft.com/en-us/fabric/data-warehouse/create-table)**
- **[csv file upload to delta table](https://learn.microsoft.com/en-us/fabric/data-engineering/get-started-csv-upload#:~:text=Right%2Dclick%20or%20use%20the,with%20the%20suggested%20table%20name.)**

To convert data to a table in Microsoft Fabric, you can use the SQL Query Editor's CREATE TABLE template to define and create a new table, use the Visual Query Editor's "Save as table" option to store query results into a table, or load a CSV file directly into a new Delta table using the Data Engineering UI.

## Using the SQL Query Editor (Warehouse)

This method is for creating a table from scratch in your data warehouse.
Navigate: to your data warehouse in Microsoft Fabric.
Open: the SQL query editor and find the SQL templates dropdown list.
Select: New table to get a CREATE TABLE script template.
Modify: the template to define your table's columns, data types, and other properties.
Run: the query to create the table.

https://www.mssqltips.com/sqlservertip/7233/sql-pivot-sql-unpivot-examples-transform-data/

SQL PIVOT diagram
You can use PIVOT to rotate rows in a table by turning row values into multiple columns. The following diagram illustrates what PIVOT can do where we take 4 rows of data and turn this into 1 row with 4 columns. As you can see, the PIVOT process converts rows into columns by pivoting the table.

![](https://www.mssqltips.com/tipimages2/7233_sql-pivot-unpivot-examples.001.png)

```sql
Using PIVOT we will use the following code. As you will see we have to know ahead of time what columns we want to pivot on. In the example below we specify [Europe], [North America], [Pacific]. There is no simple way to use PIVOT without knowing the values ahead of time.

SELECT 'SalesYTD' AS SalesYTD, [Europe], [North America], [Pacific]
FROM  
(
  SELECT SalesYTD, [Group]   
  FROM [Sales].[SalesTerritory]
) AS TableToPivot 
PIVOT  
(  
  SUM(SalesYTD)  
  FOR [Group] IN ([Europe], [North America], [Pacific])  
) AS PivotTable; 
```

![](https://www.mssqltips.com/tipimages2/7233_sql-pivot-unpivot-examples.007.png)
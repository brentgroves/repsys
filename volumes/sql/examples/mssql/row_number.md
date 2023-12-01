# Self join techniques

## References

https://www.sqlshack.com/overview-of-the-sql-row-number-function/

## Row number function

The most commonly used function in SQL Server is the SQL ROW_NUMBER function. The SQL ROW_NUMBER function is available from SQL Server 2005 and later versions.

ROW_NUMBER adds a unique incrementing number to the results grid. The order, in which the row numbers are applied, is determined by the ORDER BY expression. Most of the time, one or more columns are specified in the ORDER BY expression, but it’s possible to use more complex expressions or even a sub-query. So, it creates an ever-increasing integral value and it always starts off at 1 and subsequent rows get the next higher value.

You can also use it with a PARTITION BY clause. But when it crosses a partition limit or boundary, it resets the counter and starts from 1. So, the partition may have values 1, 2, 3, and so on and the second partitions again start the counter from 1, 2, 3… and so on, and so forth.

## Example

```sql
USE AdventureWorks2016;
GO
SELECT ROW_NUMBER() OVER(PARTITION BY CustomerID, 
                                      DATEADD(MONTH, DATEDIFF(MONTH, 0, OrderDate), 0)
       ORDER BY SubTotal DESC) AS MonthlyOrders, 
       CustomerID, 
       SalesOrderID, 
       OrderDate, 
       SalesOrderNumber, 
       SubTotal, 
       TotalDue
FROM Sales.SalesOrderHeader;


```

![row_number](https://s33046.pcdn.co/wp-content/uploads/2018/11/word-image-145.png)

How to return a subset of rows using CTE and ROW_NUMBER

The following example we are going to analyze SalesOrderHeader to display the top five largest orders placed by each customer every month. Using the Month function, the orderDate columns is manipulated to fetch the month part. In this way, the sales corresponding to specific month (OrderDate) along with customer (CustomerID) is partitioned.

To list the five largest orders in each month for each customer, a CTE is used. A window is created on the partition data and it is assigned with the values and then the CTE is being called to fetch the largest orders.

```sql
WITH   cte
          AS ( SELECT    ROW_NUMBER OVER ( PARTITION BY customerID,MONTH(OrderDate) ORDER BY SubTotal DESC, TotalDue DESC ) AS ROW_NUM,
            CustomerID,
             MONTH(OrderDate) Month,
                        SubTotal ,
                        TotalDue ,
            OrderDate                    
               FROM     Sales.SalesOrderHeader
             )
    SELECT  *
    FROM    cte
    WHERE   ROW_NUM <= 5
```

![cte](https://s33046.pcdn.co/wp-content/uploads/2018/11/word-image-146.png)
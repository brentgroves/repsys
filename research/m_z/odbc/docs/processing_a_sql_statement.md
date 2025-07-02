# **[Processing a SQL Statement](https://learn.microsoft.com/en-us/sql/odbc/reference/processing-a-sql-statement?view=sql-server-ver17)**

10/17/2024
Before discussing the techniques for using SQL programmatically, it is necessary to discuss how a SQL statement is processed. The steps involved are common to all three techniques, although each technique performs them at different times. The following illustration shows the steps involved in processing a SQL statement, which are discussed throughout the rest of this section.

![i1](https://learn.microsoft.com/en-us/sql/odbc/reference/media/pr01.gif?view=sql-server-ver17)

To process a SQL statement, a DBMS performs the following five steps:

The DBMS first parses the SQL statement. It breaks the statement up into individual words, called tokens, makes sure that the statement has a valid verb and valid clauses, and so on. Syntax errors and misspellings can be detected in this step.

The DBMS validates the statement. It checks the statement against the system catalog. Do all the tables named in the statement exist in the database? Do all of the columns exist and are the column names unambiguous? Does the user have the required privileges to execute the statement? Certain semantic errors can be detected in this step.

The DBMS generates an access plan for the statement. The access plan is a binary representation of the steps that are required to carry out the statement; it is the DBMS equivalent of executable code.

The DBMS optimizes the access plan. It explores various ways to carry out the access plan. Can an index be used to speed a search? Should the DBMS first apply a search condition to Table A and then join it to Table B, or should it begin with the join and use the search condition afterward? Can a sequential search through a table be avoided or reduced to a subset of the table? After exploring the alternatives, the DBMS chooses one of them.

The DBMS executes the statement by running the access plan.

The steps used to process a SQL statement vary in the amount of database access they require and the amount of time they take. Parsing a SQL statement does not require access to the database and can be done very quickly. Optimization, on the other hand, is a very CPU-intensive process and requires access to the system catalog. For a complex, multitable query, the optimizer may explore thousands of different ways of carrying out the same query. However, the cost of executing the query inefficiently is usually so high that the time spent in optimization is more than regained in increased query execution speed. This is even more significant if the same optimized access plan can be used over and over to perform repetitive queries.

The access plan
Last Updated
: 2025-06-21
The way that the optimizer chooses to read a table is called an access plan. The simplest method to access a table is to read it sequentially, which is called a table scan. The optimizer chooses a table scan when most of the table must be read or the table does not have an index that is useful for the query.

The optimizer can also choose to access the table by an index. If the column in the index is the same as a column in a filter of the query, the optimizer can use the index to retrieve only the rows that the query requires. The optimizer can use a key-only index scan if the columns requested are within one index on the table. The database server retrieves the needed data from the index and does not access the associated table.
Important: The optimizer does not choose a key-only scan for a VARCHAR column. If you want to take advantage of key-only scans, use the ALTER TABLE with the MODIFY clause to change the column to a CHAR data type.
The optimizer compares the cost of each plan to determine the best one. The database server derives cost from estimates of the number of I/O operations required, calculations to produce the results, rows accessed, sorting, and so forth.

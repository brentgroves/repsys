# CTE

A Common Table Expression (CTE) in SQL is a temporary, named result set that you can reference within a single SQL statement, such as a SELECT, INSERT, UPDATE, or DELETE statement. CTEs are defined using the WITH clause.

## Key characteristics of CTEs

- **Temporary:** CTEs exist only for the duration of the query in which they are defined and are not stored permanently in the database.
- **Named:** They are given a name, allowing you to refer to them multiple times within the same query.
- **Improve Readability:** CTEs help break down complex queries into smaller, more manageable, and understandable logical units.
- **Support Recursion:** Recursive CTEs are used to query hierarchical data, such as organizational charts or bill-of-materials structures.
- **Avoid Subquery Duplication:** They can prevent the need to write the same subquery multiple times within a larger query, leading to cleaner code.

## test

- Create a CTE for each table/view.
- In each CTE filter by columns and needed records.
- In your final SQL statement use only CTEs.

Since your CTEs have only the columns and records you need there is less data for the SQL engine to process.

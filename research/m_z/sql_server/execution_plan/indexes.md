# **[SQL Server Indexes](https://hasura.io/learn/database/microsoft-sql-server/indexes/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## References

- **[How to use index in select statement?](https://stackoverflow.com/questions/6593765/how-to-use-index-in-select-statement)**
- **[SQL Server Indexes](https://learn.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-ver16)**

## SQL Server Indexes

An index in a table improves the query performance by speeding up the data lookup. By default, a query analyzer does a sequential scan on every row in a table until it finds the searched result. An index scan is much faster because an index acts as a pointer reference to the rows address in a table.

## Types of Indexes

Indexes are classified as primary, clustered, and secondary indexes.

## Clustered Index

A clustered index determines the physical order of data in a table. In other words, an index decides the sequence in which the data gets stored in that table. When you create a primary key, a default clustered index is created on the column, and all the rows get sorted based on the primary key column. There can only be one clustered index in a table.

## Execution Plan

Open XML and search for:

- IndexScan ordered
- EstimatedRowsRead
- ActualRowsRead

## What is an Index

An index is an on-disk structure associated with a table or view that speeds retrieval of rows from the table or view. An index contains keys built from one or more columns in the table or view. These keys are stored in a structure (B-tree) that enables SQL Server to find the row or rows associated with the key values quickly and efficiently.

## **[What is a B-tree](https://www.geeksforgeeks.org/introduction-of-b-tree-2/)**

The limitations of traditional binary search trees can be frustrating. Meet the B-Tree, the multi-talented data structure that can handle massive amounts of data with ease. When it comes to storing and searching large amounts of data, traditional binary search trees can become impractical due to their poor performance and high memory usage. B-Trees, also known as B-Tree or Balanced Tree, are a type of self-balancing tree that was specifically designed to overcome these limitations.

Unlike traditional binary search trees, B-Trees are characterized by the large number of keys that they can store in a single node, which is why they are also known as “large key” trees. Each node in a B-Tree can contain multiple keys, which allows the tree to have a larger branching factor and thus a shallower height. This shallow height leads to less disk I/O, which results in faster search and insertion operations. B-Trees are particularly well suited for storage systems that have slow, bulky data access such as hard drives, flash memory, and CD-ROMs.

B-Trees maintains balance by ensuring that each node has a minimum number of keys, so the tree is always balanced. This balance guarantees that the time complexity for operations such as insertion, deletion, and searching is always O(log n), regardless of the initial shape of the tree.

Time Complexity of B-Tree:

| Sr. No. | Algorithm | Time Complexity |
|:-------:|:---------:|:---------------:|
|    1.   |   Search  |     O(log n)    |
|    2.   |   Insert  |     O(log n)    |
|    3.   |   Delete  |     O(log n)    |

Note: “n” is the total number of elements in the B-tree

## Properties of B-Tree

- All leaves are at the same level.
- B-Tree is defined by the term minimum degree ‘t‘. The value of ‘t‘ depends upon disk block size.
- Every node except the root must contain at least t-1 keys. The root may contain a minimum of 1 key.
- All nodes (including root) may contain at most (2*t – 1) keys.
- Number of children of a node is equal to the number of keys in it plus 1.
- All keys of a node are sorted in increasing order. The child between two keys k1 and k2 contains all keys in the range from k1 and k2.
- B-Tree grows and shrinks from the root which is unlike Binary Search Tree. Binary Search Trees grow downward and also shrink from downward.
- Like other balanced Binary Search Trees, the time complexity to search, insert, and delete is O(log n).
- Insertion of a Node in B-Tree happens only at Leaf Node.

Following is an example of a B-Tree of minimum order 5

Note: that in practical B-Trees, the value of the minimum order is much more than 5.

![](https://media.geeksforgeeks.org/wp-content/uploads/20200506235136/output253.png)

We can see in the above diagram that all the leaf nodes are at the same level and all non-leafs have no empty sub-tree and have keys one less than the number of their children.

## 2 common types of Microsoft SQL indexes

| Clustered    | A clustered index sorts and stores the data rows of the table or view in order based on the clustered index key. The clustered index is implemented as a B-tree index structure that supports fast retrieval of the rows, based on their clustered index key values.                                                                                                                                                                                                             | Clustered and Nonclustered Indexes Described  Create Clustered Indexes  Clustered Index Design Guidelines       |
|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| Nonclustered | A nonclustered index can be defined on a table or view with a clustered index or on a heap. Each index row in the nonclustered index contains the nonclustered key value and a row locator. This locator points to the data row in the clustered index or heap having the key value. The rows in the index are stored in the order of the index key values, but the data rows are not guaranteed to be in any particular order unless a clustered index is created on the table. | Clustered and Nonclustered Indexes Described  Create Nonclustered Indexes  Nonclustered Index Design Guidelines |

## question

Lets say in the employee table, I have created an index(idx_name) on the emp_name column of the table.

Do I need to explicitly specify the index name in select clause or it will automatically used to speed up queries.

If it is required to be specified in the select clause, What is the syntax for using index in select query ?

## answerer

## test the index to see if it works

```sql

SELECT *
FROM Table WITH(INDEX(Index_Name))
```

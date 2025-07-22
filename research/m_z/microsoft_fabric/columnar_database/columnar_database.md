# **[](https://www.techtarget.com/searchdatamanagement/definition/columnar-database)**

Columnar database vs. row-oriented database
Column-oriented databases and row-oriented databases are both methods for storing data in data warehouses. They both use tables with rows containing entries and columns for the data about the entry. However, they have different approaches to how the data is stored on disk: Row-oriented databases store the data for each row together, while columnar databases store the data for each column together.

The primary limiting factor in large modern databases is not the speed of the processor, it is how fast data can be read off the disk. Many databases are terabytes of data, with some large ones reaching into the petabyte range. Databases this large are impossible to keep in any computer's random access memory (RAM), so they need to be read off the disk. Even extremely fast NVMe solid-state drives cannot keep up with the speed of processors, making the disk access the limiting factor in databases.

It is also true that sequential reads from disks are faster than random or partial reads; this is especially true for spinning platter hard drives, but also applies to solid-state storage devices. Therefore, how the data is arranged and stored on a disk will have a massive impact on the overall database performance.

The main benefit of a columnar database is faster read and query performance for analytics and big data compared to a row-oriented one. That's because most queries use column data more than row data, requiring less data to be read off a disk. Also, because the initial data retrieval is done on a column-by-column basis, only the columns that need to be used are retrieved. This makes it possible for a columnar database to scale efficiently and handle large amounts of data.

In extremely large, clustered servers and hyperconverged databases, the issue of how data is stored is compounded. A database at these scales needs to be split (sharding) between many servers, with each server only having portions of the total data. These servers are also connected through relatively slow network links. Columnar databases are well suited for scaling across several servers. Storing the same type of data together can make optimizing and finding the data easier.

The same types of operations can be performed on both row-oriented and column-oriented databases. While some may classify columnar databases as NoSQL, they can typically run SQL quires.

To understand the possible performance improvement of a columnar database versus a row-based one, imagine needing to create a pie chart based on the total sales data in a billion-row database with each row representing a single sale. In a row-oriented database, it would need to read every row to find the sale value and add it to the totals; so, it would need to read almost the entire database or perform random reads. In a columnar database, it would only need to read the sale value column which is all stored together.

Some databases use a hybrid approach. It may store the data as both column and row oriented and use a cost-based optimizer to decide which to use based on the query type. Others may store some tables by row and others by column.

![i1](https://www.techtarget.com/rms/onlineimages/ess-column_vs_row_oriented_database-f.png)

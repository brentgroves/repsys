# **[Introduction to InnoDB](https://dev.mysql.com/doc/refman/8.4/en/innodb-introduction.html)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

InnoDB is a general-purpose storage engine that balances high reliability and high performance. In MySQL 8.4, InnoDB is the default MySQL storage engine. Unless you have configured a different default storage engine, issuing a CREATE TABLE statement without an ENGINE clause creates an InnoDB table.

## Key Advantages of InnoDB

- Its DML operations follow the ACID model, with transactions featuring commit, rollback, and crash-recovery capabilities to protect user data. See Section 17.2, “InnoDB and the ACID Model”.
- Row-level locking and Oracle-style consistent reads increase multi-user concurrency and performance. See Section 17.7, “InnoDB Locking and Transaction Model”.
- InnoDB tables arrange your data on disk to optimize queries based on primary keys. - Each InnoDB table has a primary key index called the clustered index that organizes the data to minimize I/O for primary key lookups. See Section 17.6.2.1, “Clustered and Secondary Indexes”.
- To maintain data integrity, InnoDB supports FOREIGN KEY constraints. With foreign keys, inserts, updates, and deletes are checked to ensure they do not result in inconsistencies across related tables. See Section 15.1.20.5, “FOREIGN KEY Constraints”.

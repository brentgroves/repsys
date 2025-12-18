# **[ALTER ROLE (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/statements/alter-role-transact-sql?view=azuresqldb-current)**

## In this article

Syntax
Arguments
Permissions
Limitations and restrictions
Metadata
Examples
See Also

## Syntax

Syntax for SQL Server (starting with 2012), Azure SQL Managed Instance, Azure SQL Database, and Microsoft Fabric.

syntaxsql

```sql
ALTER ROLE  role_name  
{  
       ADD MEMBER database_principal  
    |  DROP MEMBER database_principal  
    |  WITH NAME = new_name  
}  
[;]  
```

## Arguments

role_name
Applies to: SQL Server (starting with 2008), Azure SQL Database, Azure SQL Managed Instance

Specifies the database role to change.

ADD MEMBER database_principal
Applies to: SQL Server (starting with 2012), Azure SQL Database, Azure SQL Managed Instance

Specifies to add the database principal to the membership of a database role.

database_principal is a database user or a user-defined database role.

database_principal can't be a fixed database role or a server principal.

DROP MEMBER database_principal
Applies to: SQL Server (starting with 2012), Azure SQL Database, Azure SQL Managed Instance

Specifies to remove a database principal from the membership of a database role.

database_principal is a database user or a user-defined database role.

database_principal can't be a fixed database role or a server principal.

WITH NAME = new_name
Applies to: SQL Server (starting with 2008), Azure SQL Database, Azure SQL Managed Instance

Specifies to change the name of a user-defined database role. The new name must not already exist in the database.

Changing the name of a database role doesn't change ID number, owner, or permissions of the role.

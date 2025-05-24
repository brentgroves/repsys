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

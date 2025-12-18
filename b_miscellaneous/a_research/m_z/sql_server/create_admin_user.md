# **[create login](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/create-a-login?view=sql-server-ver16)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[create login](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/create-a-login?view=sql-server-ver16)**
- **[create login tsql](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-login-transact-sql?view=sql-server-ver16)**
- **[create user](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver16)**
- **[permissions](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver16)**
- **[db roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16)**

## Complete Example

The following is an example of how to create an admin user.

```sql
-- Creates the login admin with password '340$Uuxwp7Mcxo7Khy' with default database master.
CREATE LOGIN admin
WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';

-- Creates a database user for the login created previously in the mgdw database.
use mgdw;
CREATE USER admin
FOR LOGIN admin;

-- Add a admin user to db_owner role
ALTER ROLE db_owner ADD MEMBER admin;

select s.Name,sh.*
from ETL.script_history sh 
join ETL.script s 
on sh.script_key=s.Script_Key 
where sh.script_key in (1,3,4,5,6,7,8,9,10,11,116,117)
and start_time between '2024-07-05 00:00:00' and '2024-08-08 00:00:00' 
--and start_time between '2024-01-09 00:00:00' and '2024-01-10 00:00:00' 
order by name,start_time desc


CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

select * from Persons;
```

## Background

A login is a security principal, or an entity that can be authenticated by a secure system. Users need a login to connect to SQL Server. You can create a login based on a Windows principal (such as a domain user or a Windows domain group) or you can create a login that isn't based on a Windows principal (such as an SQL Server login).

To use SQL Server Authentication, the Database Engine must use mixed mode authentication. For more information, see Choose an Authentication Mode.

Azure SQL has introduced Microsoft Entra server principals (logins) to be used to authenticate to Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics (dedicated SQL pools only).

SQL Server 2022 also introduces Microsoft Entra authentication for SQL Server.

As a security principal, permissions can be granted to logins. The scope of a login is the whole Database Engine. To connect to a specific database on the instance of SQL Server, a login must be mapped to a database user. Permissions inside the database are granted and denied to the database user, not the login. Permissions that have the scope of the whole instance of SQL Server (for example, the CREATE ENDPOINT permission) can be granted to a login.

When a login connects to SQL Server, the identity is validated at the master database. Use contained database users to authenticate SQL Server and SQL Database connections at the database level. When using contained database users, a login is not necessary. A contained database is a database that is isolated from other databases and from the instance of SQL Server or SQL Database (and the master database) that hosts the database. SQL Server supports contained database users for both Windows and SQL Server authentication. When using SQL Database, combine contained database users with database level firewall rules. For more information, see **[Contained Database Users - Making Your Database Portable](https://learn.microsoft.com/en-us/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver16)**.

## Permissions

SQL Server requires ALTER ANY LOGIN or ALTER LOGIN permission on the server, or the ##MS_LoginManager## fixed server role (SQL Server 2022 and later).

SQL Database requires membership in the loginmanager role or the fixed server role, ##MS_LoginManager##.

## Create a login using SQL Server authentication with T-SQL

In Object Explorer, connect to an instance of Database Engine.

On the Standard bar, select New Query.

Copy and paste the following example into the query window and select Execute.

```sql
-- Creates the login admin with password '340$Uuxwp7Mcxo7Khy' with default database master.
CREATE LOGIN admin
WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';
GO

-- Creates the login admin with password '340$Uuxwp7Mcxo7Khy' with default database mgdw.
CREATE LOGIN admin
   WITH PASSWORD = '340$Uuxwp7Mcxo7Khy',
   DEFAULT_DATABASE =mgdw

-- Creates the user "shcooper" for SQL Server using the security credential "RestrictedFaculty"
-- The user login starts with the password "Baz1nga," but that password must be changed after the first login.

CREATE LOGIN shcooper
   WITH PASSWORD = 'Baz1nga' MUST_CHANGE,
   CREDENTIAL = RestrictedFaculty;
GO
```

## **[create login tsql](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-login-transact-sql?view=sql-server-ver16)**

DEFAULT_DATABASE =database
Specifies the default database to be assigned to the login. If this option isn't included, the default database is set to master.

## After creating a login

After creating a login, the login can connect to SQL Server, but only has the permissions granted to the public role. Consider performing some of the following activities.

- To connect to a database, create a database user for the login. For more information, see **[CREATE USER](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver16)**.
- Create a user-defined server role by using CREATE SERVER ROLE. Use ALTER SERVER ROLE ... ADD MEMBER to add the new login to the user-defined server role. For more information, see CREATE SERVER ROLE and ALTER SERVER ROLE.
- Use sp_addsrvrolemember to add the login to a fixed server role. For more information, see Server-Level Roles and sp_addsrvrolemember.
- Use the GRANT statement, to grant server-level permissions to the new login or to a role containing the login. For more information, see GRANT.

## create user

```sql
-- Change to a user database. For example, in SQL Server use the USE mgdw.
-- Creates a database user for the login created previously.
use mgdw;
CREATE USER admin
FOR LOGIN admin;
GO
```

## **[add db_owner role](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver16)**

**db_owner**\
Members of the db_owner fixed database role can perform all configuration and maintenance activities on the database, and can also DROP the database in SQL Server. (In SQL Database and Azure Synapse, some maintenance activities require server-level permissions and can't be performed by db_owners.)

```sql
-- Add a User to a database-level role
-- The following example adds the User 'Ben' to the fixed database-level role db_datareader.

ALTER ROLE db_datareader ADD MEMBER Ben;
```

## example

```sql
-- Creates the login admin with password '340$Uuxwp7Mcxo7Khy' with default database master.
CREATE LOGIN admin
WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';

-- Creates a database user for the login created previously in the mgdw database.
use mgdw;
CREATE USER admin
FOR LOGIN admin;

-- Add a admin user to db_owner role
ALTER ROLE db_owner ADD MEMBER admin;

select s.Name,sh.*
from ETL.script_history sh 
join ETL.script s 
on sh.script_key=s.Script_Key 
where sh.script_key in (1,3,4,5,6,7,8,9,10,11,116,117)
and start_time between '2024-07-05 00:00:00' and '2024-08-08 00:00:00' 
--and start_time between '2024-01-09 00:00:00' and '2024-01-10 00:00:00' 
order by name,start_time desc


CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

select * from Persons;
```

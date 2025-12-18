# **[Database-level roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=azuresqldb-current&preserve-view=true#special-roles-for-azure-sql-database-and-azure-synapse)**

In this article
Fixed database roles
Special roles for Azure SQL Database and Azure Synapse
Roles in msdb database
Work with database-level roles
Public database role
Examples
Related content

To easily manage the permissions in your databases, SQL Server provides several roles that are security principals that group other principals. They are like groups in the Windows operating system. Database-level roles are database-wide in their permissions scope.

To add and remove users to a database role, use the ADD MEMBER and DROP MEMBER options of the ALTER ROLE statement. Analytics Platform System (PDW) and Azure Synapse Analytics doesn't support the use of ALTER ROLE. Use the older sp_addrolemember and sp_droprolemember procedures instead.

There are two types of database-level roles: fixed database roles that are predefined in the database and user-defined database roles that you can create.

Fixed database roles are defined at the database-level and exist in each database. Members of the db_owner database role can manage fixed database role membership. There are also some special-purpose database roles in the msdb database.

You can add any database account and other SQL Server roles into database-level roles.

Don't add user-defined database roles as members of fixed roles. This could enable unintended privilege escalation.

The permissions of user-defined database roles can be customized by using the GRANT, DENY, and REVOKE statements. For more information, see Permissions (Database Engine).

For a list of all the permissions, see the **[Database Engine Permissions poster](https://aka.ms/sql-permissions-poster)**. Server-level permissions can't be granted to database roles. Logins and other server-level principals (such as server roles) can't be added to database roles. For server-level security in SQL Server, use server roles instead. Server-level permissions can't be granted through roles in Azure SQL Database and Azure Synapse Analytics.

## **[Fixed database roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=azuresqldb-current&preserve-view=true#fixed-database-roles)**

The following table shows the fixed database roles and their capabilities. These roles exist in all databases. Except for the public database role, the permissions assigned to the fixed database roles can't be changed.

| Fixed database role name | Description                                                                                                                                                                                                                                                                                                |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| db_owner                 | Members of the db_owner fixed database role can perform all configuration and maintenance activities on the database, and can also DROP the database in SQL Server. (In SQL Database and Azure Synapse, some maintenance activities require server-level permissions and can't be performed by db_owners.) |
| db_securityadmin         | Members of the db_securityadmin fixed database role can modify role membership for custom roles only and manage permissions. Members of this role can potentially elevate their privileges and their actions should be monitored.                                                                          |
| db_accessadmin           | Members of the db_accessadmin fixed database role can add or remove access to the database for Windows logins, Windows groups, and SQL Server logins.                                                                                                                                                      |
| db_backupoperator        | Members of the db_backupoperator fixed database role can back up the database.                                                                                                                                                                                                                             |
| db_ddladmin              | Members of the db_ddladmin fixed database role can run any Data Definition Language (DDL) command in a database. Members of this role can potentially elevate their privileges by manipulating code that might get executed under high privileges and their actions should be monitored.                   |
| db_datawriter            | Members of the db_datawriter fixed database role can add, delete, or change data in all user tables. In most use cases, this role is combined with db_datareader membership to allow reading the data that is to be modified.                                                                              |
| db_datareader            | Members of the db_datareader fixed database role can read all data from all user tables and views. User objects can exist in any schema except sys and INFORMATION_SCHEMA.                                                                                                                                 |
| db_denydatawriter        | Members of the db_denydatawriter fixed database role can't add, modify, or delete any data in the user tables within a database.                                                                                                                                                                           |
| db_denydatareader        | Members of the db_denydatareader fixed database role can't read any data from the user tables and views within a database.                                                                                                                                                                                 |

## Permissions

To run this command you need one or more of these permissions or memberships:

ALTER permission on the role
ALTER ANY ROLE permission on the database
Membership in the db_securityadmin fixed database role
Additionally, to change the membership in a fixed database role you need:

Membership in the db_owner fixed database role

## A. Change the name of a database role

Applies to: SQL Server (starting with 2008), Azure SQL Database, Azure SQL Managed Instance

The following example changes the name of role buyers to purchasing. This example can be executed in the AdventureWorks sample database.

```sql
ALTER ROLE buyers WITH NAME = purchasing;  
```

## B. Add or remove role members

Applies to: SQL Server (starting with 2012), Azure SQL Database, Azure SQL Managed Instance

This example creates a database role named Sales. It adds a database user named Barry to the membership, and then shows how to remove the member Barry. This example can be executed in the AdventureWorks sample database.

```sql
CREATE ROLE Sales;  
ALTER ROLE Sales ADD MEMBER Barry;  
ALTER ROLE Sales DROP MEMBER Barry;  

-- To add and remove users to a database role, use the ADD MEMBER and DROP MEMBER options of the ALTER ROLE statement.
ALTER ROLE db_owner ADD MEMBER [sJackson@linamar.com];  

```bash
db_owner
```

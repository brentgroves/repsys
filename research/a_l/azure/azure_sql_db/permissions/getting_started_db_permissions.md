# **[Get started with Database Engine permissions](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-ver17)**

## In this article

- Security principals
- Typical scenario
- Assign permissions
- Permission hierarchy
- Grant the least permission
- Diagram of permissions
- Permissions vs. fixed server and fixed database roles
- Monitor permissions
- Examples
- Related content

This article reviews some basic security concepts and then describes a typical implementation of permissions. Permissions in the Database Engine are managed at the server level through logins and server roles, and at the database level through database users and database roles.

SQL Database and SQL database in Microsoft Fabric provide the same options within each database, but the server level permissions aren't available.

**Microsoft Fabric** is a unified, cloud-based data platform that provides end-to-end data analytics capabilities. It integrates various tools and services like Data Factory, Synapse Analytics, and Power BI into a single, scalable ecosystem. It aims to simplify data management, analytics, and AI capabilities for organizations.

In SQL Database, refer to Tutorial: Secure a database in Azure SQL Database. Microsoft Entra ID authentication is recommended. For more information, see Tutorial: Create Microsoft Entra users using Microsoft Entra applications.

In SQL database in Microsoft Fabric, the only supported authentication method for database users is Microsoft Entra ID. Server-level roles and permissions aren't available. For more information, see **[Authorization in SQL database in Microsoft Fabric](https://learn.microsoft.com/en-us/azure/azure-sql/database/secure-database-tutorial?view=azuresql-db&preserve-view=true)**.

Microsoft Entra ID was previously known as Azure Active Directory (Azure AD).

## Security principals

A security principal is the identity that SQL Server uses, which can be assigned permission to take actions. Security principals are usually people, or groups of people, but can be other entities that pretend to be people. Security principals can be created and managed using the Transact-SQL examples shown in this article, or by using SQL Server Management Studio.

## Logins

Logins are individual user accounts for signing in to the SQL Server Database Engine. SQL Server and SQL Database support logins based on Windows authentication, and logins based on SQL Server authentication. For information about the two types of logins, see **[Choose an authentication mode](https://learn.microsoft.com/en-us/sql/relational-databases/security/choose-an-authentication-mode?view=sql-server-ver17)**.

## Fixed server roles

In SQL Server, fixed server roles are a set of preconfigured roles that provide convenient group of server-level permissions. Logins can be added to the roles using the ALTER SERVER ROLE ... ADD MEMBER statement. For more information, see ALTER SERVER ROLE. SQL Database doesn't support the fixed server roles, but has two roles in the master database (dbmanager and loginmanager) that act like server roles.

## User-defined server roles

In SQL Server, you can create your own server roles and assign server-level permissions to them. Logins can be added to the server roles using the ALTER SERVER ROLE ... ADD MEMBER statement. For more information, see ALTER SERVER ROLE. SQL Database doesn't support the user-defined server roles.

## Database users

To grant access for a login to a database, you create a database user in that database, and map the database user to a login. The database user name is usually the same as the login name by convention, though it doesn't have to be the same. Each database user maps to a single login. A login can be mapped to only one user in a database, but it can be mapped as a database user in several different databases.

Database users can also be created that don't have a corresponding login. These users are called contained database users. Microsoft encourages the use of contained database users, because it makes it easier to move your database to a different server. Like a login, a contained database user can use either Windows authentication or SQL Server authentication. For more information, see **[Make your database portable by using contained databases](https://learn.microsoft.com/en-us/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver17)**.

There are 12 types of users with slight differences in how they authenticate, and who they represent. To see a list of users, see **[CREATE USER](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver17)**.

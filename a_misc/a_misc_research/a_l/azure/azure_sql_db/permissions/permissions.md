# **[Permissions (Database Engine)](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver17)**

## In this article

- Permissions naming conventions
- Chart of SQL Server permissions
- Permissions applicable to specific securables
- SQL Server permissions

Every SQL Server securable has associated permissions that can be granted to a principal. Permissions in the Database Engine are managed at the server level assigned to logins and server roles, and at the database level assigned to database users and database roles. The model for Azure SQL Database has the same system for the database permissions, but the **server level permissions aren't available**. This article contains the complete list of permissions. For a typical implementation of the permissions, see **[Getting Started with Database Engine Permissions](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-ver17)**.

In SQL database in Microsoft Fabric, only database-level users and roles are supported. Server-level logins, roles, and the sa account are not available. In SQL database in Microsoft Fabric, Microsoft Entra ID for database users is the only supported authentication method. For more information, see Authorization in SQL database in Microsoft Fabric.

Once you understand the permissions required, you can apply server level permissions to logins or server roles, and database level permissions to users or database roles, by using the GRANT, REVOKE, and DENY statements. For example:

```bash
GRANT SELECT ON SCHEMA::HumanResources TO role_HumanResourcesDept;
REVOKE SELECT ON SCHEMA::HumanResources TO role_HumanResourcesDept;
```

For tips on planning a permissions system, see **[Getting Started with Database Engine Permissions](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/getting-started-with-database-engine-permissions?view=sql-server-ver17)**.

## Permissions naming conventions

The following describes the general conventions that are followed for naming permissions:

## CONTROL

Confers ownership-like capabilities on the grantee. The grantee effectively has all defined permissions on the securable. A principal that has been granted CONTROL can also grant permissions on the securable. Because the SQL Server security model is hierarchical, CONTROL at a particular scope implicitly includes CONTROL on all the securables under that scope. For example, CONTROL on a database implies all permissions on the database, all permissions on all assemblies in the database, all permissions on all schemas in the database, and all permissions on objects within all schemas within the database.

ALTER

Confers the ability to change the properties, except ownership, of a particular securable. When granted on a scope, ALTER also bestows the ability to alter, create, or drop any securable that is contained within that scope. For example, ALTER permission on a schema includes the ability to create, alter, and drop objects from the schema.

ALTER ANY <Server Securable>, where Server Securable can be any server securable.

Confers the ability to create, alter, or drop individual instances of the Server Securable. For example, ALTER ANY LOGIN confers the ability to create, alter, or drop any login in the instance.

ALTER ANY <Database Securable>, where Database Securable can be any securable at the database level.

Confers the ability to CREATE, ALTER, or DROP individual instances of the Database Securable. For example, ALTER ANY SCHEMA confers the ability to create, alter, or drop any schema in the database.

TAKE OWNERSHIP

Enables the grantee to take ownership of the securable on which it is granted.

IMPERSONATE <Login>

Enables the grantee to impersonate the login.

IMPERSONATE <User>

Enables the grantee to impersonate the user.

CREATE <Server Securable>

Confers to the grantee the ability to create the Server Securable.

CREATE <Database Securable>

Confers to the grantee the ability to create the Database Securable.

CREATE <Schema-contained Securable>

Confers the ability to create the schema-contained securable. However, ALTER permission on the schema is required to create the securable in a particular schema.

VIEW DEFINITION

Enables the grantee to access metadata.

REFERENCES

The REFERENCES permission on a table is needed to create a FOREIGN KEY constraint that references that table.

The REFERENCES permission is needed on an object to create a FUNCTION or VIEW with the WITH SCHEMABINDING clause that references that object.

## Chart of SQL Server permissions

The following image shows the permissions and their relationships to each other. Some of the higher level permissions (such as CONTROL SERVER) are listed many times. In this article, the poster is far too small to read. You can download the full-sized **[Database Engine Permissions Poster](https://aka.ms/sql-permissions-poster)** in PDF format.

![i1](https://learn.microsoft.com/en-us/sql/includes/media/database-engine-permissions/database-engine-permissions-small.png?view=sql-server-ver17)

Permissions applicable to specific securables
The following table lists major classes of permissions and the kinds of securables to which they might be applied.

| Permission           | Applies to                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ALTER                | All classes of objects except TYPE.                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| CONTROL              | All classes of objects:  AGGREGATE, APPLICATION ROLE, ASSEMBLY, ASYMMETRIC KEY, AVAILABILITY GROUP, CERTIFICATE, CONTRACT, CREDENTIALS, DATABASE, DATABASE SCOPED CREDENTIAL, DEFAULT, ENDPOINT, FULLTEXT CATALOG, FULLTEXT STOPLIST, FUNCTION, LOGIN, MESSAGE TYPE, PROCEDURE, QUEUE, REMOTE SERVICE BINDING, ROLE, ROUTE, RULE, SCHEMA, SEARCH PROPERTY LIST, SERVER, SERVER ROLE, SERVICE, SYMMETRIC KEY, SYNONYM, TABLE, TYPE, USER, VIEW, and XML SCHEMA COLLECTION |
| DELETE               | All classes of objects except DATABASE SCOPED CONFIGURATION, SERVER, and TYPE.                                                                                                                                                                                                                                                                                                                                                                                           |
| EXECUTE              | CLR types, external scripts, procedures (Transact-SQL and CLR), scalar and aggregate functions (Transact-SQL and CLR), and synonyms                                                                                                                                                                                                                                                                                                                                      |
| IMPERSONATE          | Logins and users                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| INSERT               | Synonyms, tables and columns, views and columns. Permission can be granted at the database, schema, or object level.                                                                                                                                                                                                                                                                                                                                                     |
| RECEIVE              | Service Broker queues                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| REFERENCES           | AGGREGATE, ASSEMBLY, ASYMMETRIC KEY, CERTIFICATE, CONTRACT, CREDENTIAL (applies to SQL Server 2022 (16.x) and later), DATABASE, DATABASE SCOPED CREDENTIAL, FULLTEXT CATALOG, FULLTEXT STOPLIST, FUNCTION, MESSAGE TYPE, PROCEDURE, QUEUE, RULE, SCHEMA, SEARCH PROPERTY LIST, SEQUENCE OBJECT, SYMMETRIC KEY, TABLE, TYPE, VIEW, and XML SCHEMA COLLECTION                                                                                                              |
| SELECT               | Synonyms, tables and columns, views and columns. Permission can be granted at the database, schema, or object level.                                                                                                                                                                                                                                                                                                                                                     |
| TAKE OWNERSHIP       | All classes of objects except DATABASE SCOPED CONFIGURATION, LOGIN, SERVER, and USER.                                                                                                                                                                                                                                                                                                                                                                                    |
| UPDATE               | Synonyms, tables and columns, views and columns. Permission can be granted at the database, schema, or object level.                                                                                                                                                                                                                                                                                                                                                     |
| VIEW CHANGE TRACKING | Schemas and tables                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| VIEW DEFINITION      | All classes of objects except DATABASE SCOPED CONFIGURATION, and SERVER.                                                                                                                                                                                                                                                                                                                                                                                                 |

The default permissions that are granted to system objects at the time of setup are carefully evaluated against possible threats and need not be altered as part of hardening the SQL Server installation. Any changes to the permissions on the system objects could limit or break the functionality and could potentially leave your SQL Server installation in an unsupported state

## SQL Server permissions

The following table provides a complete list of SQL Server permissions. Azure SQL Database permissions are only available for base securables that are supported. Server level permissions can't be granted in Azure SQL Database, however in some cases database permissions are available instead.

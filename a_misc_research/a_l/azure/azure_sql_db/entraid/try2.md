# **[Microsoft Entra authentication for Azure SQL](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql)**

```bash
azuredatastudio --password-store="basic"
# or
code --password-store="basic"
```

<!-- https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql#login-based-users -->
```sql
-- delete contained db user
ALTER ROLE  role_name  
{  
       ADD MEMBER database_principal  
    |  DROP MEMBER database_principal  
    |  WITH NAME = new_name  
}  
[;]  
alter role db_owerner drop 

-- Create login based user
CREATE LOGIN [sJackson@linamar.com] FROM EXTERNAL PROVIDER
CREATE USER [sJackson@linamar.com] FROM LOGIN [sJackson@linamar.com]

select name as username,
       create_date,
       modify_date,
       type_desc as type,
       authentication_type_desc as authentication_type
from sys.database_principals
where type not in ('A', 'G', 'R', 'X')
      and sid is not null
      and name != 'guest'
order by username;
```

This article provides an in depth overview of using Microsoft Entra authentication with Azure SQL Database, Azure SQL Managed Instance, SQL Server on Azure VMs, Synapse SQL in Azure Synapse Analytics and SQL Server for Windows and Linux.

If you want to configure Microsoft Entra authentication, review:

**[Azure SQL Database and Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql)**
SQL Server on Azure VMs

## Overview

Microsoft Entra ID allows you to centrally manage the identities of humans and services in your data estate. By integrating Microsoft Entra with Azure SQL for authentication, you can simplify identity and permission management while also enabling detailed conditional access and governance over all connections to your data.

Using Microsoft Entra authentication includes the following benefits:

Replaces less secure authentication methods like usernames and passwords.
Eliminates, or helps stop, the proliferation of user identities across servers.
Microsoft Entra groups enable database permission management to be abstracted away from individual accounts and into operational groups.
Allows password rotation in a single place.
Microsoft Entra-only authentication provides a complete alternative to SQL authentication.
Managed identities for Azure resources eliminate the need to store passwords for services that connect to your databases, and connections from your databases to other Azure resources.
Enables modern security controls including strong multifactor authentication with a range of easy verification options, such as a phone call, text message, smart card with pin, or mobile app notification.
Microsoft Entra ID enables integration with many modern authentication protocols, including OpenID Connect, OAuth2.0, Kerberos Constrained Delegation, and more.
Enables centralized monitoring of connections to data sources.
Enables conditional access controls, such as requiring compliant devices or authentication methods for successful connections.
Centrally manage and monitor authentication with Azure Policies.

Microsoft Entra authentication only supports access tokens that originated from Microsoft Entra ID, and not third-party access tokens. Microsoft Entra ID also doesn't support redirecting Microsoft Entra ID queries to third-party endpoints. This applies to all SQL platforms and all operating systems that support Microsoft Entra authentication.

## Configuration steps

The general steps to configure Microsoft Entra authentication are:

Create and populate a Microsoft Entra tenant.
Create a logical server or instance in Azure.
Assign a Microsoft Entra administrator to the server or instance.
Create SQL principals in your database that are mapped to Microsoft Entra identities.
Configure your client applications to connect using Azure Identity libraries and authentication methods.
Connect to your database with Microsoft Entra identities.

## Supported identities and authentication methods

Azure SQL supports using the following Microsoft Entra identities as logins and users (principals) in your servers and databases:

- Microsoft Entra users: Any type of user in a Microsoft Entra tenant, which includes internal users, external users, guests, and members. Members of an Active Directory domain federated with Microsoft Entra ID are also supported, and can be configured for seamless single sign-on.
- Applications: applications that exist in Azure can use service principals or managed identities to authenticate directly to Azure SQL. Using managed identities is preferable since authentication is passwordless and eliminates the need for developer-managed credentials.
- Microsoft Entra groups, which can simplify access management across your organization by managing user and application access based on group membership.

For user identities, the following authentication methods are supported:

- Microsoft Entra Integrated (Windows Authentication) supported by Microsoft Entra Hybrid Identities with Active Directory [federation].
- Microsoft Entra MFA, or multifactor authentication, which requires additional security checks beyond the user's knowledge.
- Microsoft Entra Password authentication, which uses user credentials stored and managed in Microsoft Entra ID.
- Microsoft Entra Default authentication, which scans various credential caches on the application's machine, and can use user tokens to authenticate to SQL.

For service or workload identities, the following authentication methods are supported:

- Managed identities for Azure resources, both user-assigned and system-assigned. Managed identity authentication is token-based, in which the identity is assigned to the resource that wants to authenticate using it. The Azure Identity platform validates that relationship, which enables passwordless authentication.
- Microsoft Entra service principal name and application (client) secret. This authentication method isn't recommended because of the risk associated with passwords that can be guessed and leaked.
- Microsoft Entra Default authentication, which scans various credential caches on the application's machine, and can use application tokens to authenticate to SQL.

## Microsoft Entra administrator

To enable Microsoft Entra authentication, a Microsoft Entra administrator has to be set for your logical server or managed instance. This admin exists alongside the SQL Server administrator (SA). The Microsoft Entra admin can be any one security object in your Azure tenant, including Microsoft Entra users, groups, service principals, and managed identities. The Microsoft Entra administrator is a singular property, not a list, meaning only one identity can be configured at any time. Removing the Microsoft Entra admin from the server disables all Microsoft Entra authentication-based connections, even for existing Microsoft Entra users with permissions in a database.

Microsoft Entra groups enables multiple identities to act as the Microsoft Entra administrator on the server. When the administrator is set to a group, all group members inherit the Microsoft Entra administrator role. A Microsoft Entra group admin enhances manageability by shifting admin management from server data plane actions into Microsoft Entra ID and the hands of the group owners. Groups can be used for all Microsoft Entra identities that connect to SQL, allowing for onetime user and permission configuration in the server and databases, leaving all user management to the groups.

The Microsoft Entra admin plays a special role: it's the first account that can create other Microsoft Entra logins (in preview in SQL Database) and users, collectively referred to as principals. The admin is a contained database user in the master database of the server. Administrator accounts are members of the db_owner role in every user database, and each user database is entered as the dbo user. For more information about administrator accounts, see Managing Databases and Logins.

Microsoft Entra principals
 Note

**[Microsoft Entra server principals (logins)](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-azure-ad-logins?view=azuresql)** are currently in public preview for Azure SQL Database and Azure Synapse Analytics. Microsoft Entra logins are generally available for Azure SQL Managed Instance and SQL Server 2022.

Microsoft Entra identities can be created as principals in Azure SQL in three ways:

- as server principals or logins (in preview for Azure SQL Database)
- as login-based users (a type of database principal)
- as contained database users

## Important

Microsoft Entra authentication for Azure SQL doesn't integrate with Azure RBAC. Using Microsoft Entra identities to connect to Azure SQL and execute queries requires those identities to be created as Microsoft Entra principals in the database(s) they need to access. The SQL Server Contributor and SQL DB Contributor roles are used to secure management-related deployment operations, not database connectivity access.

## Logins (server principals)

Server principals (logins) for Microsoft Entra identities are generally available for Azure SQL Managed Instance, SQL Server 2022, and SQL Server on Azure VMs. Microsoft Entra logins are in preview for Azure SQL Database.

The following T-SQL shows how to create a Microsoft Entra login:

```sql
CREATE LOGIN [MSEntraUser] FROM EXTERNAL PROVIDER
```

A Microsoft Entra login has the following property values in sys.server_principals:

| Property                  | Value                                                                                                |
|---------------------------|------------------------------------------------------------------------------------------------------|
| SID (Security Identifier) | Binary representation of the Microsoft Entra identity's object ID                                    |
| type                      | E = External login or application from Microsoft Entra ID X = External group from Microsoft Entra ID |
| type_desc                 | EXTERNAL_LOGIN for Microsoft Entra login or app EXTERNAL_GROUP for Microsoft Entra group             |

## Login-based users

Login-based users inherit the server-level roles and permissions assigned to its Microsoft Entra login. Microsoft Entra login-based users are in preview for Azure SQL Database.

The following T-SQL shows how to create a login-based user for a Microsoft Entra identity:

```sql
CREATE USER [MSEntraUser] FROM LOGIN [MSEntraUser]
```

The following table details the Microsoft Entra login-based user property values in sys.database_principals:

| Property                  | Value                                                                                                |
|---------------------------|------------------------------------------------------------------------------------------------------|
| SID (Security Identifier) | Binary representation of the Microsoft Entra identity's object ID, plus 'AADE'                       |
| type                      | E = External login or application from Microsoft Entra ID X = External group from Microsoft Entra ID |
| type_desc                 | EXTERNAL_LOGIN for Microsoft Entra login or app EXTERNAL_GROUP for Microsoft Entra group             |

## Contained database users

Contained database users are portable with the database. They have no connections to identities defined in the server or instance, and thus can be easily moved along with the database from one server or instance to another without disruption.

The following T-SQL shows how to create a contained database user for a Microsoft Entra identity:

```sql
CREATE USER [MSEntraUser] FROM EXTERNAL PROVIDER
```

A Microsoft Entra database-based user has the same property values as login-based users in **[sys.database_principals](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-principals-transact-sql)**, except for how the SID is constructed:

To get the original Microsoft Entra GUID that the SID is based on, use the following T-SQL conversion:

```sql
SELECT CAST(sid AS UNIQUEIDENTIFIER) AS EntraID FROM sys.database_principals
```

 Caution

It's possible to unintentionally create a contained Microsoft Entra database user with the same name as a Microsoft Entra login at the server or instance level. Since the principals aren't connected to each other, the database user doesn't inherit permissions from the server login, and identities can become conflated in connection requests, resulting in undefined behavior.

Use the following T-SQL query to determine if a database user is a login-based user or a contained database user:

```sql
SELECT CASE
    WHEN CONVERT(VARCHAR(100), sid, 2) LIKE '%AADE' AND len(sid) = 18 THEN 'login-based user'
    ELSE 'contained database user'
    END AS user_type,
    *
FROM sys.database_principals WHERE TYPE = 'E' OR TYPE = 'X'
```

Use the following T-SQL query to view all Microsoft Entra principals in a database:

```sql
SELECT
  name,
  CAST(sid AS UNIQUEIDENTIFIER) AS EntraID,
  CASE WHEN TYPE = 'E' THEN 'App/User' ELSE 'Group' AS user_type,
  sid
FROM sys.database_principals WHERE TYPE = 'E' OR TYPE = 'X'
```

## Microsoft Entra-only authentication

With Microsoft Entra-only authentication enabled, all other authentication methods are disabled and can't be used to connect to the server, instance, or database - which includes SA and all other SQL authentication-based accounts for Azure SQL, as well as Windows authentication for Azure SQL Managed Instance.

To get started, review Configure Microsoft Entra-only authentication.

## Multifactor authentication (MFA)

Microsoft Entra multifactor authentication is a security feature provided by Microsoft's cloud-based identity and access management service. Multifactor authentication enhances the security of user sign-ins by requiring users to provide extra verification steps beyond a password.

Microsoft Entra multifactor authentication helps safeguard access to data and applications while meeting user demand for a simple sign-in process. MFA adds an extra layer of security to user sign-ins by requiring users to provide two or more authentication factors. These factors typically include something the user knows (password), something the user possesses (smartphone or hardware token), and/or something the user is (biometric data). By combining multiple factors, MFA significantly reduces the likelihood of unauthorized access.

Multifactor authentication is a supported authentication method for Azure SQL Database, Azure SQL Managed Instance, Azure Synapse Analytics, and SQL Server 2022 (16.x) and later versions.

To get started, review Configure Microsoft Entra multifactor authentication.

<https://learn.microsoft.com/en-us/azure/azure-sql/database/conditional-access-configure?view=azuresql>

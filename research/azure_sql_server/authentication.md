# Authentication

## references

<https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?view=azuresql>

## Auth

Databases in Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse are referred to collectively in the remainder of this article as databases, and the server is referring to the logical server that manages databases for Azure SQL Database and Azure Synapse.

Authentication and authorization
Authentication is the process of proving the user is who they claim to be. A user connects to a database using a user account. When a user attempts to connect to a database, they provide a user account and authentication information. The user is authenticated using one of the following two authentication methods:

- SQL authentication.

With this authentication method, the user submits a user account name and associated password to establish a connection. This password is stored in the master database for user accounts linked to a login or stored in the database containing the user accounts not linked to a login.

- Microsoft Entra authentication

With this authentication method, the user submits a user account name and requests that the service use the credential information stored in Microsoft Entra ID (formerly Azure Active Directory).

Logins and users: A user account in a database can be associated with a login that is stored in the master database or can be a user name that is stored in an individual database.

- A login is an individual account in the master database, to which a user account in one or more databases can be linked. With a login, the credential information for the user account is stored with the login.
- A user account is an individual account in any database that may be, but does not have to be, linked to a login. With a user account that is not linked to a login, the credential information is stored with the user account.

Authorization to access data and perform various actions are managed using database roles and explicit permissions. Authorization refers to the permissions assigned to a user, and determines what that user is allowed to do. Authorization is controlled by your user account's database role memberships and object-level permissions. As a best practice, you should grant users the least privileges necessary.

Existing logins and user accounts after creating a new database
When you first deploy Azure SQL, you can specify a login name and a password for a special type of administrative login, the Server admin. The following configuration of logins and users in the master and user databases occurs during deployment:

- A SQL login with administrative privileges is created using the login name you specified. A login is an individual account for logging in to SQL Database, SQL Managed Instance, and Azure Synapse.
- This login is granted full administrative permissions on all databases as a server-level principal. The login has all available permissions and can't be limited. In a SQL Managed Instance, this login is added to the sysadmin fixed server role (this role does not exist in Azure SQL Database).
- When this account signs into a database, they are matched to the special user account dbo (user account, which exists in each user database. The dbo user has all database permissions in the database and is member of the db_owner fixed database role. Additional fixed database roles are discussed later in this article.

To identify the Server admin account for a logical server, open the Azure portal, and navigate to the Properties tab of your server or managed instance.

![alt](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/logins-create-manage/sql-admins.png?view=azuresql)

The name of the Server admin account can't be changed after it has been created. To reset the password for the server admin, go to the Azure portal, click SQL Servers, select the server from the list, and then click Reset Password. To reset the password for the SQL Managed Instance, go to the Azure portal, click the instance, and click Reset password. You can also use PowerShell or the Azure CLI.

## Create additional logins and users having administrative permissions

At this point, your server or managed instance is only configured for access using a single SQL login and user account. To create additional logins with full or partial administrative permissions, you have the following options (depending on your deployment mode):

Create a Microsoft Entra administrator account with full administrative permissions

Enable Microsoft Entra authentication and add a Microsoft Entra admin. One Microsoft Entra account can be configured as an administrator of the Azure SQL deployment with full administrative permissions. This account can be either an individual or security group account. A Microsoft Entra admin must be configured if you want to use Microsoft Entra accounts to connect to SQL Database, SQL Managed Instance, or Azure Synapse. For detailed information on enabling Microsoft Entra authentication for all Azure SQL deployment types, see the following articles:

Use Microsoft Entra authentication with SQL
Configure and manage Microsoft Entra authentication with SQL
In SQL Managed Instance, create SQL logins with full administrative permissions

Create an additional SQL login in the master database.
Add the login to the sysadmin fixed server role using the ALTER SERVER ROLE statement. This login will have full administrative permissions.
Alternatively, create a Microsoft Entra login using the CREATE LOGIN syntax.

- In SQL Database, create SQL logins with limited administrative permissions
  - Create an additional SQL login in the master database.
    - Add the Login to the ##MS_DatabaseManager##, ##MS_LoginManager## and ##MS_DatabaseConnector## server level roles using the ALTER SERVER ROLE statement.

Members of special master database roles for Azure SQL Database have authority to create and manage databases or to create and manage logins. In databases created by a user that is a member of the dbmanager role, the member is mapped to the db_owner fixed database role and can log into and manage that database using the dbo user account. These roles have no explicit permissions outside of the master database.

Create a login

Create a SQL login in the master database. Then create a user account in each database to which that user needs access and associate the user account with that login. This approach is preferred when the user must access multiple databases and you wish to keep the passwords synchronized. However, this approach has complexities when used with geo-replication as the login must be created on both the primary server and the secondary server(s). For more information, see Configure and manage Azure SQL Database security for geo-restore or failover.

Create a user account

Create a user account in the database to which a user needs access (also called a contained user).

With SQL Database, you can always create this type of user account.
With SQL Managed Instance supporting Microsoft Entra server principals, you can create user accounts to authenticate to the SQL Managed Instance without requiring database users to be created as a contained database user.
With this approach, the user authentication information is stored in each database, and replicated to geo-replicated databases automatically. However, if the same account exists in multiple databases and you are using SQL authentication, you must keep the passwords synchronized manually. Additionally, if a user has an account in different databases with different passwords, remembering those passwords can become a problem.

# **[Create a Microsoft Entra user from a Microsoft Entra login in Azure SQL](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-user-transact-sql?view=sql-server-ver17#i-create-a-microsoft-entra-user-from-a-microsoft-entra-login-in-azure-sql)**

To create a Microsoft Entra user from a Microsoft Entra login, use the following syntax.

Sign in to your logical server in Azure or SQL Managed Instance using a Microsoft Entra login granted the sysadmin role in SQL Managed Instance, or loginmanager role in SQL Database. The following T-SQL script creates a Microsoft Entra user <bob@contoso.com>, from the login <bob@contoso.com>. This login was created in the CREATE LOGIN example.

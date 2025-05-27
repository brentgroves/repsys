# **[can i connect to azure sql database using my entra id user account](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql)**

**[](https://learn.microsoft.com/en-us/answers/questions/1527042/how-to-give-entra-id-access-to-azure-sql-database#:~:text=Connect%20to%20the%20SQL%20database,Run%20the%20below%20command.&text=CREATE%20USER%20%5B%5D,assign%20role%20to%20the%20user.)**

**[](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql#:~:text=Microsoft%20Entra%20identities.-,Supported%20identities%20and%20authentication%20methods,access%20based%20on%20group%20membership.)**

## AI Overview

Yes, you can connect to an Azure SQL Database using your Microsoft Entra ID user account. Microsoft Entra authentication allows you to use your Microsoft Entra ID credentials to access Azure SQL Database. To do this, you'll need to configure Microsoft Entra authentication for your Azure SQL Database and ensure your user has the necessary permissions.

Here's how it works:

1. Enable Microsoft Entra authentication:
.
This can be done in the Azure portal by navigating to your Azure SQL server and selecting "Microsoft Entra ID" under "Security".

Microsoft Entra admin
Microsoft Entra authentication allows you to centrally manage identity and access to your Azure SQL Database. Learn more
Admin name:  Brent Groves (Admin Object/App ID: 175774d2-02a8-459c-9570-8ad0ec49ea7c)

2. Set a Microsoft Entra admin:
.
You'll need to designate a Microsoft Entra user or group as the administrator for your Azure SQL server. This user will have full administrative permissions.

```yaml
Authentication method: AAD & SQL
SQL admin: repsys1
AAD admin: Brent Groves
```

3. Grant database access:
.
You'll need to create a database user in your Azure SQL database that is mapped to your Microsoft Entra ID user.

4. Connect using Microsoft Entra credentials:
.
When connecting to your database, you'll use your Microsoft Entra ID credentials (username and password).

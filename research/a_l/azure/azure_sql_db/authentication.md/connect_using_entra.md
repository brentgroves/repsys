# **[Connect to Azure SQL resource with Microsoft Entra authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-microsoft-entra-connect-to-azure-sql?view=azuresql)**

<!-- https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-cli -->

This article shows you how to use Microsoft Entra authentication to connect to Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics.

## Prerequisites

To connect to your Azure SQL resource, you need to have **[configured Microsoft Entra authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql)** for your resource.

To confirm the Microsoft Entra administrator is properly set up, connect to the master database using the Microsoft Entra administrator account. To create a Microsoft Entra-based contained database user, connect to the database with a Microsoft Entra identity with access to the database and at least the ALTER ANY USER permission.

## Connect with Azure Data Studio or SSMS or SSDT

**[Microsoft Entra MFA](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-microsoft-entra-connect-to-azure-sql?view=azuresql#microsoft-entra-mfa)**

Fill the User name box with your Microsoft Entra credentials, in the format <user_name@domain.com>.

```bash
pushd .
cd ~/src/azure/linamar.com/sqldb
source set_vars.sh
```

## Microsoft Entra MFA

Use this method for interactive authentication with multifactor authentication (MFA), with the password being requested interactively. This method can be used to authenticate to databases in SQL Database, SQL Managed Instance, and Azure Synapse Analytics for Microsoft Entra cloud-only identity users, or those who use Microsoft Entra hybrid identities.

The following steps show how to connect using multifactor authentication in the latest version of SSMS.

To connect using MFA, on the Connect to Server dialog box in SSMS select Microsoft Entra MFA.

![i1](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-microsoft-entra-connect-to-azure-sql/1-mfa-connect-authentication-method-dropdown.png?view=azuresql)

Fill the Server name box with your server's name. Fill the User name box with your Microsoft Entra credentials, in the format <user_name@domain.com>

![i2](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-microsoft-entra-connect-to-azure-sql/2-mfa-connect-to-server.png?view=azuresql)

Select Connect.

When the Sign in to your account dialog box appears, it should be prepopulated with the User name you provided in step 2. No password is required if a user is part of a domain federated with Microsoft Entra ID.

![i3](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/authentication-microsoft-entra-connect-to-azure-sql/3-mfa-sign-in.png?view=azuresql)

You'll be prompted to authenticate using one of the methods configured based on the MFA administrator setting.

When verification is complete, SSMS connects normally, presuming valid credentials and firewall access.

Microsoft Entra Service Principal
Use this method to authenticate to the database in SQL Database or SQL Managed Instance with Microsoft Entra service principals (Microsoft Entra applications). For more information, see Microsoft Entra service principal with Azure SQL.

Microsoft Entra Managed Identity
Use this method to authenticate to the database in SQL Database or SQL Managed Instance with Microsoft Entra managed identities. For more information, see Managed identities in Microsoft Entra for Azure SQL.

Microsoft Entra Default
The Default authentication option with Microsoft Entra ID enables authentication that's performed through password-less and non-interactive mechanisms including managed identities.

Connect from a client application
The following procedures show you how to connect to a SQL Database with a Microsoft Entra identity from a client application. This isn't a comprehensive list of authentication methods when using a Microsoft Entra identity. For more information, see Connect to Azure SQL with Microsoft Entra authentication and SqlClient.

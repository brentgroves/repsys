# **[OAuth with Auth0 and Azure AD as identity provider](https://docs.planviewer.nl/api/oauth/azure-ad.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[Integrating AzureAD to Auth0](https://dev.to/olawde/integrating-azuread-to-auth0-1k3i)**
- **[Get access on behalf of a user](https://learn.microsoft.com/en-us/graph/auth-v2-user?tabs=http)**

## Azure Application Developer role

This is a privileged role. Users in this role can create application registrations when the "Users can register applications" setting is set to No. This role also grants permission to consent on one's own behalf when the "Users can consent to apps accessing company data on their behalf" setting is set to No. Users assigned to this role are added as owners when creating new application registrations.

To be able to use Azure Active Directory as an Identity Provider, we use Auth0 as middleware to connect to Azure Active Directory.
Your Planviewer API Application uses Auth0 as authorization server, wich in turn connects to Azure Active Directory to authenticate and authorize your users.

## Auth0 free account

domain: dev-gfcd1ld5m2jtz0m0.us.auth0.com
Region: US-4

users: 25,000
M2M Tokens: 1,000
Plan cost: $0/mo

## In this howto

- We configure an Auth0 “Microsoft Azure AD” connection and register that as “registered app” in your Azure Active Directory.
- We create an Auth0 Application and configure that to use the “Microsoft Azure AD” connection as Identity Provider
- We configure a Planviewer Application to use Auth0 as authorization server.

The “registered app” for the Auth0 “Microsoft Azure AD” connection, needs the following “Delegated permissions” for the “Microsoft Graph” API, to operate correctly.

| Microsoft API                | Delegated Permissions      |                                        |
|------------------------------|----------------------------|----------------------------------------|
| Microsoft Graph              | User.Read                  | Sign in and read user profile          |
| Microsoft Graph | Directory.AccessAsUser.All | Access directory as the signed in user |
| Microsoft Graph | Directory.Read.All         | Read directory data                    |

You need a (free) Auth0 account and an Azure portal administrative account to continue. You need an Auth0 Tenant and it’s Domain.

When you create an Auth0 account, you will also get a default Tenant,

## Prepare an app registration in Azure Active Directory

### Create a new Azure AD app registration

- go to Azure **[Active Directory registered apps](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps)**
- create a new registration.
- leave Redirect URI for now, we’ll create one later.

### Create a Client secret to authenticate your Auth0 connection with

- go to Azure **[Active Directory registered apps](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps)**
- select the app
- go to “Certificates & secrets”
- create a new Client Secret

### Warning

Copy the secret value, it is only shown once

### Grant the registered app API Permissions to access data in your directory

- go to Azure **[Active Directory registered apps](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps)**
- select the app
- go to “API permissions”

![api per](https://docs.planviewer.nl/_images/azure-api-permissions.png)

### Note

You need to have administrative permissions for this action, or have an admistrator grant the permissions. Even as administrator you need to grant the permissions.

| Microsoft API                | Delegated Permissions      |                                        |
|------------------------------|----------------------------|----------------------------------------|
| Microsoft Graph              | User.Read                  | Sign in and read user profile          |
| Microsoft Graph | Directory.AccessAsUser.All | Access directory as the signed in user |
| Microsoft Graph | Directory.Read.All         | Read directory data                    |

## Configure the registered app to accept Auth0 callback URL

- go to Azure **[Active Directory registered apps](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps)**
- Select the app
- Go to Authentication
- Create a new “Redirect URI”, type: Web, with value “<auth0-tenant-domain>/login/callback”

![cb](https://docs.planviewer.nl/_images/azure-authentication.png)

### Note 2

- The tenant can be found in Auth0.
- Your default tenant domain looks like your-tenant-name.eu.auth0.com
- If you have a custom domain, use that as <auth0-tenant-domain>
You can find your current domain under Tenant Settings - Custom Domains.

## NEXT AFTER PERMISSION CONSENT, Connect your Planviewer Application

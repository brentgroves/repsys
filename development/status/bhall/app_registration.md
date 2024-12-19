# **[OAuth with Auth0 and Azure AD as identity provider](https://docs.planviewer.nl/api/oauth/azure-ad.html)**

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/>.

## references

- **[OAuth with Auth0 and Azure AD as identity provider](https://docs.planviewer.nl/api/oauth/azure-ad.html)**
- **[Integrating AzureAD to Auth0](https://dev.to/olawde/integrating-azuread-to-auth0-1k3i)**

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
- Create a new “Redirect URI”, type: Web, with value `https://dev-gfcd1ld5m2jtz0m0.us.auth0.com/login/callback`

# **[Azure Data Studio - Azure connectivity](https://learn.microsoft.com/en-us/azure-data-studio/azure-connectivity)**

In this article
Azure: Authentication library
Azure authentication method
Azure cloud configuration
Azure resource configuration
Show 7 more
 Important

Azure Data Studio is retiring on February 28, 2026. We recommend that you use Visual Studio Code. For more information about migrating to Visual Studio Code, visit What's happening to Azure Data Studio?

Azure Data Studio uses the Microsoft Authentication Library (MSAL) by default to acquire an access token from Microsoft Entra ID. The settings that apply to Microsoft Entra authentication are discussed, along with commonly observed issues and their solutions.

 Note

While Microsoft Entra ID is the new name for Azure Active Directory (Azure AD), to prevent disrupting existing environments, Azure AD still remains in some hardcoded elements such as UI fields, connection providers, error codes, and cmdlets. In this article, the two names are interchangeable.

## Azure: Authentication library

This setting is only available in Azure Data Studio 1.41 through 1.45. It is no longer available in Azure Data Studio 1.46 and later versions.

This setting controls the authentication library used by Azure Data Studio when adding a Microsoft Entra account. Microsoft Authentication Library (MSAL) offers authentication and authorization services using standard-compliant implementations of OAuth 2.0 and OpenID Connect (OIDC) 1.0. Read more about Microsoft Authentication Library (MSAL). In Azure Data Studio 1.46 and later versions, MSAL is the only library in use, as ADAL (Active Directory Authentication Library) is deprecated.

## Azure authentication method

Azure Data Studio supports Microsoft Entra multifactor authentication (MFA) using the following modes:

Using Code Grant authentication (enabled by default)
Using Device Code authentication

The Authorization Code Grant flow in OAuth 2.0 is a widely used method for enabling secure authentication and authorization between a client application and a user's resources. It involves the user being redirected to an authorization server, where they can grant access to the client application. The client then uses a temporary authorization code to request an access token from the authorization server.

Accounts > Azure > Auth: Code Grant
Settings.json

`"accounts.azure.auth.codeGrant": true`

![i1](https://learn.microsoft.com/en-us/azure-data-studio/media/azure-connectivity/code-grant.png)

When Code Grant method is checked, users are prompted to authenticate with browser based authentication. This option is enabled by default.

Accounts > Azure > Auth: Device Code
Settings.json

`"accounts.azure.auth.deviceCode": true`

![i2](https://learn.microsoft.com/en-us/azure-data-studio/media/azure-connectivity/device-code.png)

When Device Code method is enabled, users are provided with a code and a URL to enter which can then be used to sign in.

When both options are checked, users are prompted to select one of the two authentication modes when adding a Microsoft Entra account.

## Azure cloud configuration

Azure Data Studio supports Microsoft Entra authentication with national clouds. Azure Public Cloud is enabled by default, but users can enable other national clouds as needed:

Settings.json

```bash
"accounts.azure.cloud.enableChinaCloud": false,
"accounts.azure.cloud.enablePublicCloud": true,
"accounts.azure.cloud.enableUsGovCloud": false
```

![i3](https://learn.microsoft.com/en-us/azure-data-studio/media/azure-connectivity/national-clouds.png)

Custom cloud endpoints can also be defined. See Configuring custom cloud endpoints.

## Azure resource configuration

These settings apply filters on Azure resources and tenants.

Resource Config filter: Applies inclusion filter to resources that should be displayed.
Tenant Config filter: Applies exclusion filter to tenants that should be ignored.
Settings.json

```json
"azure.resource.config.filter": [],
"azure.tenant.config.filter": [
    "313b5f9e-9b92-414c-8d87-a317e42d0222"
]
```

![i4](https://learn.microsoft.com/en-us/azure-data-studio/media/azure-connectivity/resource-config.png)

## Proxy setup for Microsoft Entra authentication

If using Azure Data Studio behind a proxy, users must specify proxy settings for Azure Data Studio to communicate with external endpoints. There are two ways to provide proxy settings for Azure Data Studio to use:

- Setting proxy configuration in the Azure Data Studio (Settings > Http: Proxy Settings)
- Setting environment variables for proxy configuration

Azure Data Studio settings take precedence over environment variables.

## Azure Data Studio proxy settings

The following settings are available in Azure Data Studio:

Settings.json

```json
"http.proxy": "https://userName@fqdn:yourPassword@yourProxyURL.com:8080",
"http.proxyStrictSSL": true,
"http.proxyAuthorization": "",
"http.proxySupport" : "override"
```

![i5](https://learn.microsoft.com/en-us/azure-data-studio/media/azure-connectivity/proxy-settings.png)

Supported environment variables for proxy

- 'HTTP_PROXY': '<http://userName@fqdn:yourPassword@yourProxyURL.com:8080>'
- 'HTTPS_PROXY': '<https://userName@fqdn:yourPassword@yourProxyURL.com:8080>'

## Allowlist URLs

In a proxy environment, user applications may need to allow specific domains used by Azure Data Studio. Hostnames through which you may need or want to allow communication are:

## Azure Public

<https://management.azure.com>
<https://login.microsoftonline.com/>
Azure (US Government)

<https://management.core.usgovcloudapi.net/>
<https://login.microsoftonline.us/>
Azure operated by 21Vianet

<https://management.core.chinacloudapi.cn/>
<https://login.partner.microsoftonline.cn/>

The URLs to allow can sometimes vary on a case-by-case basis. In order to verify you aren't blocking any URLs from going through, go to Help > Toggle Developer Tools and select the Network tab. Any URLs that are blocked are listed, and you may need to allow those URLs to successfully add your account.

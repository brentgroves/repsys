# Microsoft Identity Platform

## references

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc>

<https://github.com/Azure-Samples/ms-identity-python-webapp>

<https://learn.microsoft.com/en-us/entra/identity-platform/index-web-app?pivots=devlang-python>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc>

## OpenID Connect on the Microsoft identity platform

OpenID Connect (OIDC) extends the OAuth 2.0 authorization protocol for use as an additional authentication protocol. You can use OIDC to enable single sign-on (SSO) between your OAuth-enabled applications by using a security token called an ID token.

The full specification for OIDC is available on the OpenID Foundation's website at OpenID Connect Core 1.0 specification.

## Protocol flow: Sign-in

The following diagram shows the basic OpenID Connect sign-in flow. The steps in the flow are described in more detail in later sections of the article.

![](https://learn.microsoft.com/en-us/entra/identity-platform/media/v2-protocols-oidc/convergence-scenarios-webapp.svg)

 Tip

Try running this request in **[Postman](https://app.getpostman.com/run-collection/f77994d794bab767596d)**
Try executing this request and more in Postman -- don't forget to replace tokens and IDs!

## Enable ID tokens

The ID token introduced by OpenID Connect is issued by the authorization server, the Microsoft identity platform, when the client application requests one during user authentication. The ID token enables a client application to verify the identity of the user and to get other information (claims) about them.

ID tokens aren't issued by default for an application registered with the Microsoft identity platform. ID tokens for an application are enabled by using one of the following methods:

1. Sign in to the **[Microsoft Entra admin center](https://entra.microsoft.com/#home)** as at least a Cloud Application Administrator.
2. Browse to Identity > Applications > App registrations and select New registration.
3. Under Supported account types, select "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant)".
4. Enter a Name for your application, for example oidc_test.
5. Under Platform configurations, select Add a platform.
In the pane that opens, select the appropriate platform for your application. For example, select Web for a web application.
6. Under Redirect URIs, select Web for the platform.
Enter a redirect URI of <http://localhost:5000/getAToken>. This can be changed later.
7. Under Implicit grant and hybrid flows, select the ID tokens (used for implicit and hybrid flows) checkbox.
Or:
Select Identity > Applications > App registrations > oidc_test > Manifest.
Set oauth2AllowIdTokenImplicitFlow to true in the app registration's application manifest.
If ID tokens are not enabled for your app and one is requested, the Microsoft identity platform returns an unsupported_response error similar to:

Display name:oidc_test
Application (client) ID:2248d178-a9be-4ede-8bed-f1e72e381f59
Object ID:9eed2b39-d690-42b3-a6d2-36620c5b2f1a
Directory (tenant) ID:5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:Multiple organizations
Client credentials:Add a certificate or secret
Redirect URIs:1 web, 0 spa, 0 public client
<http://localhost:5000/getAToken>
Application ID URI:Add an Application ID URI
Managed application in local directory:oidc_test
ID tokens (used for implicit and hybrid flows)

## Add a client secret

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows>

- On the app Overview page, note the Application (client) ID value for later use. 2248d178-a9be-4ede-8bed-f1e72e381f59
- Under Manage, select the Certificates & secrets and from the Client secrets section, select New client secret.
- Enter a description for the client secret, leave the default expiration, and select Add.
Save the Value of the Client Secret in a safe location. You'll need it to configure the code, and you can't retrieve it later.

description: oidc_test
expires:12/29/2025
value: bQC8Q~u2PKduUfMBPZNIaubG14F6ZeXCL0u4Oa7O
       bQC8Q~u2PKduUfMBPZNIaubG14F6ZeXCL0u4Oa7O
secret id:ccdd3c2d-2837-4c42-bc7e-fc62e753999a
          ccdd3c2d-2837-4c42-bc7e-fc62e753999a

## Step 3: Add a scope

- Under Manage, select API permissions > Add a permission.
Ensure that the Microsoft APIs tab is selected.
- From the Commonly used Microsoft APIs section, select Microsoft Graph.
- From the Delegated permissions section, ensure that User.- ReadBasic.All is selected. Use the search box if necessary.
- Select Add permissions.

## Step 4: Download the sample app

Download the Python code sample or clone the repository:

```bash
pushd .
cd ~/src/repsys/research/api_management/openid_connect/oidc_azure/identity_platform
git clone https://github.com/Azure-Samples/ms-identity-python-webapp.git
```

## Next

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows#step-4-download-the-sample-app>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc#fetch-the-openid-configuration-document>

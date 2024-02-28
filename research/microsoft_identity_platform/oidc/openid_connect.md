# **[OpenID Connect on the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc)**

Do this when you have a web app that needs to identify a user. If you want a web api to have access to azure services such as sending email then go to **[expose web api](../../registration/expose_web_api.md)** or just and/or use a library such as masl.

OpenID Connect (OIDC) extends the OAuth 2.0 authorization protocol for use as an additional authentication protocol. You can use OIDC to enable single sign-on (SSO) between your OAuth-enabled applications by using a security token called an ID token.

The full specification for OIDC is available on the OpenID Foundation's website at **[OpenID Connect Core 1.0 specification](https://openid.net/specs/openid-connect-core-1_0.html)**.

## Protocol flow: Sign-in

The following diagram shows the basic OpenID Connect sign-in flow. The steps in the flow are described in more detail in later sections of the article.

![alt](https://learn.microsoft.com/en-us/entra/identity-platform/media/v2-protocols-oidc/convergence-scenarios-webapp.svg)

## Try running this request in **[Postman](https://app.getpostman.com/run-collection/f77994d794bab767596d)**

Try executing this request and more in Postman -- don't forget to replace tokens and IDs!

## Enable ID tokens

The ID token introduced by OpenID Connect is issued by the authorization server, the Microsoft identity platform, when the client application requests one during user authentication. The ID token enables a client application to verify the identity of the user and to get other information (claims) about them.

ID tokens aren't issued by default for an application registered with the Microsoft identity platform. ID tokens for an application are enabled by using one of the following methods:

- Sign in to the Microsoft Entra admin center.
- Browse to Identity > Applications > App registrations > <your application> > Authentication.
- Under Platform configurations, select Add a platform.
- In the pane that opens, select the appropriate platform for your application. For example, select Web for a web application.
- Under Redirect URIs, add the redirect URI of your application. For example, <https://localhost:8080/>.
- Under Implicit grant and hybrid flows, select the ID tokens (used for implicit and hybrid flows) checkbox.
Or:
Select Identity > Applications > App registrations > <your application> > Manifest.
Set oauth2AllowIdTokenImplicitFlow to true in the app registration's application manifest.

If ID tokens are not enabled for your app and one is requested, the Microsoft identity platform returns an unsupported_response error similar to:

The provided value for the input parameter 'response_type' isn't allowed for this client. Expected value is 'code'.

Requesting an ID token by specifying a response_type of id_token is explained in Send the sign-in request later in the article.

## Fetch the OpenID configuration document

OpenID providers like the Microsoft identity platform provide an **[OpenID Provider Configuration Document](https://openid.net/specs/openid-connect-discovery-1_0.html)** at a publicly accessible endpoint containing the provider's OIDC endpoints, supported claims, and other metadata. Client applications can use the metadata to discover the URLs to use for authentication and the authentication service's public signing keys.

Authentication libraries are the most common consumers of the OpenID configuration document, which they use for discovery of authentication URLs, the provider's public signing keys, and other service metadata. If an authentication library is used in your app, you likely won't need to hand-code requests to and responses from the OpenID configuration document endpoint.

## Find your app's OpenID configuration document URI

Every app registration in Microsoft Entra ID is provided a publicly accessible endpoint that serves its OpenID configuration document. To determine the URI of the configuration document's endpoint for your app, append the well-known OpenID configuration path to your app registration's authority URL.

- Well-known configuration document path: /.well-known/openid-configuration
- Authority URL: <https://login.microsoftonline.com/{tenant}/v2.0>

The value of {tenant} varies based on the application's sign-in audience as shown in the following table. The authority URL also varies by cloud instance.

| Value                                                           | Description                                                                                                                                                                                                                                                                                                                                                                                        |
|-----------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| common                                                          | Users with both a personal Microsoft account and a work or school account from Microsoft Entra ID can sign in to the application.                                                                                                                                                                                                                                                                  |
| organizations                                                   | Only users with work or school accounts from Microsoft Entra ID can sign in to the application.                                                                                                                                                                                                                                                                                                    |
| consumers                                                       | Only users with a personal Microsoft account can sign in to the application.                                                                                                                                                                                                                                                                                                                       |
| 8eaef023-2b34-4da1-9baa-8bc8c9d6a490 or contoso.onmicrosoft.com | Only users from a specific Microsoft Entra tenant (directory members with a work or school account or directory guests with a personal Microsoft account) can sign in to the application.  The value can be the domain name of the Microsoft Entra tenant or the tenant ID in GUID format. You can also use the consumer tenant GUID, 9188040d-6c67-4c5b-b112-36a304b66dad, in place of consumers. |

Note that when using the common or consumers authority for personal Microsoft accounts, the consuming resource application must be configured to support such type of accounts in accordance with signInAudience.

To find the OIDC configuration document in the Microsoft Entra admin center, sign in to the Microsoft Entra admin center and then:

Browse to Identity > Applications > App registrations > <your application> > Endpoints.
Locate the URI under OpenID Connect metadata document.

Sample request
The following request gets the OpenID configuration metadata from the common authority's OpenID configuration document endpoint on the Azure public cloud:

```http
GET /common/v2.0/.well-known/openid-configuration
Host: login.microsoftonline.com
HTTP/1.1 302 Found
Content-Length: 0
Date: Wed, 28 Feb 2024 21:37:31 GMT
Location: https://login.microsoftonline.com:443/common/v2.0/.well-known/openid-configuration
Set-Cookie: stsservicecookie=estsfd; path=/; secure; samesite=none; httponly
client-request-id: d4ed38c9-0e57-4bba-b626-3df65348dfdf
x-ms-httpver: 1.1
```

Try it! To see the OpenID configuration document for an application's common authority, navigate to <https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration>

## Sample response

The configuration metadata is returned in JSON format as shown in the following example (truncated for brevity). The metadata returned in the JSON response is described in detail in the OpenID Connect 1.0 discovery specification.

```json
{
  "authorization_endpoint": "<https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize>",
  "token_endpoint": "<https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token>",
  "token_endpoint_auth_methods_supported": [
    "client_secret_post",
    "private_key_jwt"
  ],
  "jwks_uri": "<https://login.microsoftonline.com/{tenant}/discovery/v2.0/keys>",
  "userinfo_endpoint": "<https://graph.microsoft.com/oidc/userinfo>",
  "subject_types_supported": [
      "pairwise"
  ],
  ...
}
```

## Send the sign-in request

To authenticate a user and request an ID token for use in your application, direct their user-agent to the Microsoft identity platform's /authorize endpoint. The request is similar to the first leg of the OAuth 2.0 authorization code flow but with these distinctions:

- Include the openid scope in the scope parameter.
- Specify id_token in the response_type parameter.
- Include the nonce parameter.

## Example sign-in request (line breaks included only for readability)

```http
GET https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/oauth2/v2.0/authorize?
client_id=3d156079-1781-42d2-9ba1-ee541109edca
&response_type=id_token
&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect
&response_mode=form_post
&scope=openid
&state=12345
&nonce=678910


GET https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?
client_id=d6b668c7-e181-4415-b6fe-fb7a76d48d4a
&response_type=id_token
&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect
&response_mode=form_post
&scope=openid
&state=12345
&nonce=678910

<!-- Permissions requested
repsys requestor
App info
This application is not published by Microsoft.
This app would like to:

View your basic profile

Maintain access to data you have given it access to
Consent on behalf of your organization
Accepting these permissions means that you allow this app to use your data as specified in their terms of service and privacy statement. You can change these permissions at https://myapps.microsoft.com. Show details
Does this app look suspicious? Report it here -->
```

## Dev Account

openid config document: <https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0/.well-known/openid-configuration>

repsys requestor
Secret/Client Id: c5b8ce87-0941-464a-aa0c-b531d8d835f6
Secret value: sxE8Q~Sf6kH~2oZZEpoFL7v27E_HFZtNAIkCQaZa
Application (client) Id: d6b668c7-e181-4415-b6fe-fb7a76d48d4a
Object Id: a9251d7f-ad2a-4d38-8540-1999682ff935
Directory (tenant) Id: 5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:My organization only
platform: web
OpenID Connect metadata document
api://d6b668c7-e181-4415-b6fe-fb7a76d48d4a

## Personal Account

openid config document: <https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/v2.0/.well-known/openid-configuration>

repsys requestor
Application (client) Id: 3d156079-1781-42d2-9ba1-ee541109edca
Object Id: 26d30dca-23e8-471c-b4f0-5377cf2844be
Directory (tenant) Id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
Supported account types:My organization only
platform: web

Dev Account Client Application
secret/client id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
expires: 8/21/2024
Application:b08211fd-0bcf-4700-a70a-e600bc0bcf77
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: MSFT
domain: 1hkt5t.onmicrosoft.com
directory id:5269b021-533e-4702-b9d9-72acbc852c97
tenant: 5269b021-533e-4702-b9d9-72acbc852c97

Outlook Client Application
secret/client id:2e2f796f-09ce-4800-8267-3c5a2d85ec78
value:t4U8Q~Pvrih6CSyS_CX1ztrVzdeuWevudbvycdk7
expires: 8/21/2024
Application ID:4c914e6c-f56e-4a77-a59f-733d6d37942e
Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: default directory
domain: brentgrovesoutlook.onmicrosoft.com
directory id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
tenant: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a

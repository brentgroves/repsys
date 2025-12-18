# **[OpenID Connect on the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc)**

## references

<https://github.com/MicahParks/keyfunc>
<https://stackoverflow.com/questions/48786606/oid-claim-is-missing-in-microsoft-id-token-claims>

## **[Important Claim note](https://stackoverflow.com/questions/48786606/oid-claim-is-missing-in-microsoft-id-token-claims)**

You must request the profile scope to see the oid claim

```http
href="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?
client_id=d6b668c7-e181-4415-b6fe-fb7a76d48d4a
&response_type=id_token
&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect
&response_mode=form_post
&scope=openid profile
&state=12345
&nonce=678910
```

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/keys>
<https://learn.microsoft.com/en-us/answers/questions/1359059/signature-validation-of-my-access-token-private-key>

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/keys?appid=d6b668c7-e181-4415-b6fe-fb7a76d48d4a>
 "appId": "d6b668c7-e181-4415-b6fe-fb7a76d48d4a",

## OpenID Connect

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

| Parameter     | Condition   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|---------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| tenant        | Required    | You can use the {tenant} value in the path of the request to control who can sign in to the application. The allowed values are common, organizations, consumers, and tenant identifiers. For more information, see protocol basics. Critically, for guest scenarios where you sign a user from one tenant into another tenant, you must provide the tenant identifier to correctly sign them into the resource tenant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| client_id     | Required    | The Application (client) ID that the Microsoft Entra admin center – App registrations experience assigned to your app.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| response_type | Required    | Must include id_token for OpenID Connect sign-in.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| redirect_uri  | Recommended | The redirect URI of your app, where authentication responses can be sent and received by your app. It must exactly match one of the redirect URIs you registered in the portal, except that it must be URL-encoded. If not present, the endpoint will pick one registered redirect_uri at random to send the user back to.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| scope         | Required    | A space-separated list of scopes. For OpenID Connect, it must include the scope openid, which translates to the Sign you in permission in the consent UI. You might also include other scopes in this request for requesting consent.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| nonce         | Required    | A value generated and sent by your app in its request for an ID token. The same nonce value is included in the ID token returned to your app by the Microsoft identity platform. To mitigate token replay attacks, your app should verify the nonce value in the ID token is the same value it sent when requesting the token. The value is typically a unique, random string.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| response_mode | Recommended | Specifies the method that should be used to send the resulting authorization code back to your app. Can be form_post or fragment. For web applications, we recommend using response_mode=form_post, to ensure the most secure transfer of tokens to your application.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| state         | Recommended | A value included in the request that also will be returned in the token response. It can be a string of any content you want. A randomly generated unique value typically is used to prevent cross-site request forgery attacks. The state also is used to encode information about the user's state in the app before the authentication request occurred, such as the page or view the user was on.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| prompt        | Optional    | Indicates the type of user interaction that is required. The only valid values at this time are login, none, consent, and select_account. The prompt=login claim forces the user to enter their credentials on that request, which negates single sign-on. The prompt=none parameter is the opposite, and should be paired with a login_hint to indicate which user must be signed in. These parameters ensure that the user isn't presented with any interactive prompt at all. If the request can't be completed silently via single sign-on, the Microsoft identity platform returns an error. Causes include no signed-in user, the hinted user isn't signed in, or multiple users are signed in but no hint was provided. The prompt=consent claim triggers the OAuth consent dialog after the user signs in. The dialog asks the user to grant permissions to the app. Finally, select_account shows the user an account selector, negating silent SSO but allowing the user to pick which account they intend to sign in with, without requiring credential entry. You can't use both login_hint and select_account. |
| login_hint    | Optional    | You can use this parameter to pre-fill the username and email address field of the sign-in page for the user, if you know the username ahead of time. Often, apps use this parameter during reauthentication, after already extracting the login_hint optional claim from an earlier sign-in.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| domain_hint   | Optional    | The realm of the user in a federated directory. This skips the email-based discovery process that the user goes through on the sign-in page, for a slightly more streamlined user experience. For tenants that are federated through an on-premises directory like AD FS, this often results in a seamless sign-in because of the existing login session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

At this point, the user is prompted to enter their credentials and complete the authentication. The Microsoft identity platform verifies that the user has consented to the permissions indicated in the scope query parameter. If the user hasn't consented to any of those permissions, the Microsoft identity platform prompts the user to consent to the required permissions. You can read more about **[permissions, consent, and multi-tenant apps](https://learn.microsoft.com/en-us/entra/identity-platform/permissions-consent-overview)**.

After the user authenticates and grants consent, the Microsoft identity platform returns a response to your app at the indicated redirect URI by using the method specified in the response_mode parameter.

## Successful response

A successful response when you use response_mode=form_post is similar to:

```http
POST /myapp/ HTTP/1.1
Host: localhost
Content-Type: application/x-www-form-urlencoded

id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik1uQ19WWmNB...&state=12345
```

| Parameter | Description                                                                                                                                                                                                                   |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| id_token  | The ID token that the app requested. You can use the id_token parameter to verify the user's identity and begin a session with the user. For more information about ID tokens and their contents, see the **[ID token reference](https://learn.microsoft.com/en-us/entra/identity-platform/id-token-claims-reference)**. |
| state     | If a state parameter is included in the request, the same value should appear in the response. The app should verify that the state values in the request and response are identical.                                         |

## Dev Account

openid config document: <https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0/.well-known/openid-configuration>

repsys requestor
Application (client) Id: d6b668c7-e181-4415-b6fe-fb7a76d48d4a
Object Id: a9251d7f-ad2a-4d38-8540-1999682ff935
Directory (tenant) Id: 5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:My organization only
platform: web
OpenID Connect metadata document
api://d6b668c7-e181-4415-b6fe-fb7a76d48d4a
tenant: 5269b021-533e-4702-b9d9-72acbc852c97

## Personal Account

openid config document: <https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/v2.0/.well-known/openid-configuration>

repsys requestor
Application (client) Id: 3d156079-1781-42d2-9ba1-ee541109edca
Object Id: 26d30dca-23e8-471c-b4f0-5377cf2844be
Directory (tenant) Id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
Supported account types:My organization only
platform: web

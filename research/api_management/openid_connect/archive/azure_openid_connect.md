# Azure OpenID Connect

## references

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/openid-connect>

## Web sign in with OpenID Connect in Azure Active Directory B2C

OpenID Connect is an authentication protocol, built on top of OAuth 2.0, that can be used to securely sign users in to web applications. By using the Azure Active Directory B2C (Azure AD B2C) implementation of OpenID Connect, you can outsource sign-up, sign in, and other identity management experiences in your web applications to Microsoft Entra ID. This guide shows you how to do so in a language-independent manner. It describes how to send and receive HTTP messages without using any of our open-source libraries.

## Note 1

Most of the open-source authentication libraries acquire and validate the JWT tokens for your application. We recommend exploring those options, rather than implementing your own code. For more information, see Overview of the Microsoft Authentication Library (MSAL), and Microsoft Identity Web authentication library.

**[OpenID Connect](https://openid.net/specs/openid-connect-core-1_0.html)** extends the OAuth 2.0 authorization protocol for use as an authentication protocol. This authentication protocol allows you to perform single sign-on. It introduces the concept of an ID token, which allows the client to verify the identity of the user and obtain basic profile information about the user.

OpenID Connect also enables applications to securely acquire access **[tokens](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tokens-overview)**. You can use access tokens to access resources that the **[authorization server](https://learn.microsoft.com/en-us/azure/active-directory-b2c/protocols-overview)** secures. We recommend OpenID Connect if you're building a web application that you host on a server and accessed through a browser. For more information about tokens, see the Overview of tokens in Azure Active Directory B2C

Azure AD B2C extends the standard OpenID Connect protocol to do more than simple authentication and authorization. It introduces the **[user flow parameter](https://learn.microsoft.com/en-us/azure/active-directory-b2c/user-flow-overview)**, which enables you to use OpenID Connect to add user experiences to your application, such as sign up, sign in, and profile management.

## Send authentication requests

When your web application needs to authenticate the user and run a user flow, it can direct the user to the /authorize endpoint. The user takes action depending on the user flow.

In this request, the client indicates the permissions that it needs to acquire from the user in the scope parameter, and specifies the user flow to run. To get a feel of how the request works, paste the request into your browser and run it. Replace:

- {tenant} with the name of your tenant.
- 90c0fe63-bcf2-44d5-8fb7-b8bbc0b29dc6 with the app ID of an **[application you registered](https://learn.microsoft.com/en-us/azure/active-directory-b2c/tutorial-register-applications)** in your tenant.
- {policy} with the policy name that you have in your tenant, for example b2c_1_sign_in.

```bash
# generic
# https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure
# Did not set a policy
GET /{tenant}.onmicrosoft.com/{policy}/oauth2/v2.0/authorize?
Host: {tenant}.b2clogin.com

client_id=90c0fe63-bcf2-44d5-8fb7-b8bbc0b29dc6
&response_type=code+id_token
&redirect_uri=https%3A%2F%2Fjwt.ms%2F
&response_mode=fragment
&scope=openid%20offline_access%20{application-id-uri}/{scope-name}
&state=arbitrary_data_you_can_receive_in_the_response
&nonce=12345
```

## AzureTokenTest

<https://developer.microsoft.com/>

main account: <brentgroves@1hkt5t.onmicrosoft.com>
<AlexW@1hkt5t.onmicrosoft.com>
EAxejwisiakJip3

Display name:AzureTokenTest
Application (client) ID:29fa39d4-de57-4009-a46a-c561fa048562
Object ID:4661c182-ae5b-4e60-8064-834221d0b993
Directory (tenant) ID:5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:Multiple organizations
Client credentials:0 certificate, 1 secret
Redirect URIs:1 web, 0 spa, 0 public client
Application ID URI:api://29fa39d4-de57-4009-a46a-c561fa048562
Managed application in local directory:AzureTokenTest

```bash
# AzureTokenTest
# https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure
# Did not set a policy
GET /5269b021-533e-4702-b9d9-72acbc852c97.onmicrosoft.com/oauth2/v2.0/authorize?
Host: {tenant}.b2clogin.com

client_id=29fa39d4-de57-4009-a46a-c561fa048562
&response_type=code+id_token
&redirect_uri=https%3A%2F%2Fjwt.ms%2F
&response_mode=fragment
&scope=openid%20offline_access%20api://29fa39d4-de57-4009-a46a-c561fa048562/{scope-name}
&state=arbitrary_data_you_can_receive_in_the_response
&nonce=12345
```

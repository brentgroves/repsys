# Authorization Code Flow

## references

<https://www.linkedin.com/advice/0/what-trade-offs-between-implicit-grant-flow-authorization>

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/authorization-code-flow>

## Authorization Code Flow defined

The Authorization Code Flow (defined in OAuth 2.0 RFC 6749, section 4.1), involves exchanging an authorization code for a token.

This flow can only be used for confidential applications (such as Regular Web Applications) because the application's authentication methods are included in the exchange and must be kept secure.

## How Authorization Code Flow works

Authorization code flow is a more secure and robust way of obtaining an access token from an authorization server in OAuth 2.0. It is designed for applications that have a backend server, such as web apps or mobile apps, and that need a long-lived and broad scope of access to the protected resources. In authorization code flow, the application redirects the user to the authorization server, where the user authenticates and grants consent to the application. The authorization server then returns an authorization code to the application via the browser's URL query. The application then exchanges the authorization code for an access token and a refresh token using its client credentials. The application can use the access token to access the protected resources from the resource server, and use the refresh token to obtain a new access token when it expires.

## Advantages of authorization code flow

One of the main advantages of authorization code flow is that it is more secure and reliable. The access token and the refresh token are never exposed in the browser's URL, which reduces the risk of leakage or theft. The application can also use PKCE to prevent authorization code interception attacks, which enhances the security of the flow. Another advantage is that the application can obtain a refresh token, which allows it to maintain a long-term and uninterrupted access to the protected resources, without requiring the user to re-authenticate or re-consent.

## Disadvantages of authorization code flow

However, authorization code flow also has some drawbacks that increase its complexity and overhead. One of the main drawbacks is that the application needs to make an extra request to the authorization server to exchange the authorization code for an access token, which adds latency and network load. Another drawback is that the application needs to store and transmit its client credentials, which increases the risk of compromising them if the backend server is not secure. Authorization code flow also requires a backend server, which complicates the application architecture and deployment.

## OAuth 2.0 authorization code flow in Azure Active Directory B2C

You can use the OAuth 2.0 authorization code grant in apps installed on a device to gain access to protected resources, such as web APIs. By using the Azure Active Directory B2C (Azure AD B2C) implementation of OAuth 2.0, you can add sign-up, sign-in, and other identity management tasks to your single-page, mobile, and desktop apps. In this article, we describe how to send and receive HTTP messages without using any open-source libraries. This article is language-independent. When possible, we recommend you use the supported Microsoft Authentication Libraries (MSAL). Take a look at the sample apps that use MSAL.

## Implicit Grant Flow

<https://www.linkedin.com/advice/0/what-trade-offs-between-implicit-grant-flow-authorization>

## How implicit grant flow works

In implicit grant flow, the application redirects the user to the authorization server, where the user authenticates and grants consent to the application. The authorization server then returns an access token directly to the application via the browser's URL fragment. The application can use the access token to access the protected resources from the resource server. There is no intermediate step of exchanging an authorization code for an access token, as in authorization code flow.

## Disadvantages of implicit grant flow

However, implicit grant flow also has some significant disadvantages that limit its security and functionality. One of the main disadvantages is that the access token is exposed in the browser's URL fragment, which can be accessed by scripts, browser extensions, or other parties that can intercept the browser traffic. The access token can also be leaked through browser history, bookmarks, or referrer headers. Another disadvantage is that the access token cannot be refreshed, which means that the application has to request a new one when it expires, which can interrupt the user experience. Implicit grant flow also does not support PKCE (Proof Key for Code Exchange), which is a mechanism that prevents authorization code interception attacks.

## When to use implicit grant flow

Implicit grant flow is suitable for applications that have a short-lived and limited scope of access to the protected resources, and that do not handle sensitive or confidential data. For example, implicit grant flow can be used for applications that display public information from a third-party API, such as social media feeds or weather forecasts. Implicit grant flow is also compatible with older OAuth 2.0 implementations that do not support other flows.

# Microsoft identity platform and **[OAuth 2.0 authorization code flow](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow)**

The OAuth 2.0 authorization code grant type, or auth code flow, enables a client application to obtain authorized access to protected resources like web APIs. The auth code flow requires a user-agent that supports redirection from the authorization server (the Microsoft identity platform) back to your application. For example, a web browser, desktop, or mobile application operated by a user to sign in to your app and access their data.

This article describes low-level protocol details required only when manually crafting and issuing raw HTTP requests to execute the flow, which we do not recommend. Instead, use a Microsoft-built and supported authentication library to get security tokens and call protected web APIs in your apps.

Applications that support the auth code flow
Use the auth code flow paired with Proof Key for Code Exchange (PKCE) and OpenID Connect (OIDC) to get access tokens and ID tokens in these types of apps:

- Single-page web application (SPA)
- Standard (server-based) web application
- Desktop and mobile apps

## Protocol details

The OAuth 2.0 authorization code flow is described in section 4.1 of the OAuth 2.0 specification. Apps using the OAuth 2.0 authorization code flow acquire an access_token to include in requests to resources protected by the Microsoft identity platform (typically APIs). Apps can also request new ID and access tokens for previously authenticated entities by using a refresh mechanism.

## Try **[running this request in Postman](https://app.getpostman.com/run-collection/f77994d794bab767596d)**

Try executing this request and more in Postman -- don't forget to replace tokens and IDs!

This diagram shows a high-level view of the authentication flow:

![alt](https://learn.microsoft.com/en-us/entra/identity-platform/media/v2-oauth2-auth-code-flow/convergence-scenarios-native.svg)
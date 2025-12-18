# Implicit Grant Flow

## references

<https://www.linkedin.com/advice/0/what-trade-offs-between-implicit-grant-flow-authorization>

## How implicit grant flow works

In implicit grant flow, the application redirects the user to the authorization server, where the user authenticates and grants consent to the application. The authorization server then returns an access token directly to the application via the browser's URL fragment. The application can use the access token to access the protected resources from the resource server. There is no intermediate step of exchanging an authorization code for an access token, as in authorization code flow.

## Advantages of implicit grant flow

One of the main advantages of implicit grant flow is that it is simple and fast. The application does not need to make an extra request to the authorization server to obtain an access token, which reduces latency and network overhead. Another advantage is that the application does not need to store or transmit any client credentials, such as a client ID and secret, which reduces the risk of exposing them to third parties. Implicit grant flow also avoids the need for a backend server, which simplifies the application architecture and deployment.

## Disadvantages of implicit grant flow

However, implicit grant flow also has some significant disadvantages that limit its security and functionality. One of the main disadvantages is that the access token is exposed in the browser's URL fragment, which can be accessed by scripts, browser extensions, or other parties that can intercept the browser traffic. The access token can also be leaked through browser history, bookmarks, or referrer headers. Another disadvantage is that the access token cannot be refreshed, which means that the application has to request a new one when it expires, which can interrupt the user experience. Implicit grant flow also does not support PKCE (Proof Key for Code Exchange), which is a mechanism that prevents authorization code interception attacks.

## When to use implicit grant flow

Implicit grant flow is suitable for applications that have a short-lived and limited scope of access to the protected resources, and that do not handle sensitive or confidential data. For example, implicit grant flow can be used for applications that display public information from a third-party API, such as social media feeds or weather forecasts. Implicit grant flow is also compatible with older OAuth 2.0 implementations that do not support other flows.

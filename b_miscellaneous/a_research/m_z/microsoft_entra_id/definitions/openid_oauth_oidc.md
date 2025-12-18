# OpenID Connect vs OAuth2

## references

<https://konghq.com/blog/engineering/openid-vs-oauth-what-is-the-difference>

## Authentication and Authorization

- OpenID is an authentication protocol used for signing users into client applications. The purpose is user authentication.
- OAuth is an authorization protocol used for providing client applications delegated access to server resources on behalf of a user. The purpose is delegated authorization.

## Flow

- OpenID involves an authentication request that redirects the user to the OpenID provider for authentication. After signing in there, the user is redirected back.
- OAuth uses token exchange behind the scenes between the client, resource server, and authorization server. No redirection is involved.

## Scope

- OpenID verifies the end-user identity but provides no other user information. Its scope is restricted to authentication only.
- OAuth verifies and grants specific access to protected resources, with customizable scopes. The access is restricted to the delegated scope.

## Usage

- OpenID is commonly used for web single sign-on. Social sign-in via Google/Facebook/etc is based on OpenID.
- OAuth allows users to grant third-party applications access to their data on other sites like social media or cloud storage.

## Standard

- OpenID is an open standard specification. Multiple providers can offer OpenID identity services.
- OAuth is a framework with competing versions like 1.0, 2.0, and 3.0. It has multiple extension grant types.

## Complexity

- OpenID does not use tokens. The protocol flow is simpler to implement for developers.
- OAuth uses signed tokens and involves more steps of token exchange. It is more complex to implement.

## Customization

- OpenID offers little customization - it's designed for simple single sign-on use cases.
- OAuth allows extensive customization of token scope, endpoints, expiration, refresh, etc.

## Adoption

- OpenID lost traction as social login using Facebook, Google, etc. became popular.
- OAuth is widely adopted across the industry for mobile apps, web APIs, and third-party access to user data.

## OpenID Connect (OIDC): The Best of Both Worlds

OpenID Connect is an authentication protocol that extends OAuth 2.0 and can be utilized for sign-on purposes. It facilitates the verification of user identity by clients through an authorization server. OpenID Connect combines elements from both OpenID and OAuth:

It employs OAuth 2.0 flows for the authentication request and response enabling a seamless single sign-on experience similar to OpenID. Additionally, it incorporates an OAuth 2.0 token that allows clients to access APIs and retrieve user information.

Consequently, OpenID Connect offers both identity verification and delegated authorization capabilities enabling clients to securely access user data. By augmenting OAuth 2.0 with an identity layer featuring user profile claims OpenID Connect provides a means of achieving single sign-on functionality on top of the authorization framework offered by OAuth.

## Choosing Between OpenID OAuth, and OpenID Connect (OIDC)

When it comes to designing authentication and authorization for an application there are three used protocols; OpenID, OAuth, and OpenID Connect. It's crucial to understand the strengths of each protocol in order to make the choice as one becomes an API-first company

OpenID is ideal for scenarios where we need to verify a user's identity through single sign-on. If we want to integrate login or allow users to sign in easily across multiple sites OpenID is a straightforward option.

OAuth on the other hand is great when an application needs access to protected resources related to a user. It allows authorization by using tokens without exposing user credentials. OAuth is preferred when authorizing API access or enabling third-party apps.

OpenID Connect combines the identity verification capabilities of OpenID with the delegated access features of OAuth. It builds on top of OAuth 2.0. Offers both single sign on for users and authorized access to user data for clients. However, it also inherits the complexity associated with OAuth.

By evaluating specific use cases related to authentication API integration and user experience we can select the most suitable protocol that balances simplicity, security, and functionality. Understanding the core purposes of OpenID, OAuth, and OpenID Connect is essential in making a decision.

Conclusion
OpenID and OAuth are two common protocols used for online identity and API access control. While OpenID is focused on user authentication for single sign-on, OAuth enables delegated authorization for applications accessing user data. Understanding that OpenID verifies identity and OAuth grants limited access is crucial. Developers should also note differences in protocol flows, standardization, complexity, and customizability when selecting the right protocol. Overall, both OpenID and OAuth have their place in enabling secure digital identity and authorized access, with OAuth seeing wider adoption for APIs and third-party apps integration.

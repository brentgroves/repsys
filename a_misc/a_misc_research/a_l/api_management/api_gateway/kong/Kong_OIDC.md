# Kong OIDC

## references

<https://github.com/nokia/kong-oidc>

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>

<https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect>

## END USER AUTHENTICATION AND AUTORIZATION USING OPENID CONNECT

Modern APIs that rely on end user’s access rights typically uses OAuth 2.0 with OpenID Connect (OIDC) for authentication and authorization. Details about OAuth 2.0 and OIDC can be found in numerous blogs (see e.g. curity.io), so we won’t repeat that here. It is sufficient to say that a mechanism for enforcing OIDC-based authentication and authorization must be able to detect sessions that are not already authenticated, and redirect those users to an appropriate login mechanism. Once the user has authenticated, the resulting access token (and potentially also a corresponding refresh token) should be managed and forwarded to the underlying API. No API calls must be allowed without a valid access token.

In Kong Gateway, externalizing a cross-cutting concern such as this is done using a Plugin which is declaratively configured to be applied to one or more Services or Routes or globally. Plugins in Kong are normally written in Lua, and the different Kong editions comes with different subsets of standard plugins (see Kong Hub). While the official Kong openid-connect plugin is only available in the Kong Enterprise Edition, there is a lightweight and excellent OS alternative kong-oidc plugin maintained by Nokia which implements the OIDC Relying Party functionality.

kong-oidc is a plugin for Kong implementing the OpenID Connect Relying Party (RP) functionality.

It authenticates users against an OpenID Connect Provider using OpenID Connect Discovery and the Basic Client Profile (i.e. the Authorization Code flow).

It maintains sessions for authenticated users by leveraging lua-resty-openidc thus offering a configurable choice between storing the session state in a client-side browser cookie or use in of the server-side storage mechanisms shared-memory|memcache|redis.

It supports server-wide caching of resolved Discovery documents and validated Access Tokens.

It can be used as a reverse proxy terminating OAuth/OpenID Connect in front of an origin server so that the origin server/services can be protected with the relevant standards without implementing those on the server itself.

Introspection functionality add capability for already authenticated users and/or applications that already posses acces token to go through kong. The actual token verification is then done by Resource Server.

How does it work
The diagram below shows the message exchange between the involved parties.

![](https://github.com/nokia/kong-oidc/raw/master/docs/kong_oidc_flow.png)

The X-Userinfo header contains the payload from the Userinfo Endpoint

X-Userinfo: {"preferred_username":"alice","id":"60f65308-3510-40ca-83f0-e9c0151cc680","sub":"60f65308-3510-40ca-83f0-e9c0151cc680"}

<https://www.baeldung.com/cs/web-sessions>

In the context of web development, a session refers to a way of maintaining state information about a user’s interactions with a website or web application. When a user visits a website, the server can create a session for that user. Additionally, a session allows the server to keep track of information such as the user’s login status, preferences, and any data entered into forms.

The server typically initiates a session when a user logs in to a website. Furthermore, we can identify a session by a unique session ID. Generally, we pass the session IDs as a parameter in URLs or store them in the cookies. The session ID allows the server to associate the user’s requests with their specific session. Additionally, it also helps to retrieve and update the session data as needed.

We can use sessions to provide a personalized experience for each user. We can display a user’s name and preferences throughout the site. Furthermore, a website can use sessions to remember shopping cart contents between pages of a user. Moreover, sessions can also be used to implement security measures and perform certain actions.

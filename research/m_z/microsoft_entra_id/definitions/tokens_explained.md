# Token Types

## references

<https://thenewstack.io/the-different-token-types-and-formats-explained/>

## The Different Token Types and Formats Explained

Different tokens have different purposes and should be used appropriately for each use case.

When building security solutions using OAuth and OpenID Connect (OIDC), we frequently discuss tokens. Sometimes these systems are even referred to as token-based architectures.

Tokens play a core role in authorizing access to applications, services and APIs. They also enable secure, flexible and scalable access management. Using tokens means applications don’t have to maintain a static API key or, even worse, hold a username and password.

The type of token used in a given scenario is often not explicitly outlined, but more or less assumed. Different tokens have different purposes and should be used appropriately for each use case.

Let’s look at some of the different token formats and token types.

Types of Tokens

## Access Tokens

The access token (AT) is perhaps the most common token type. A user or a service authenticates in some way, and the authorization server (AS) issues an access token. Depending on the configuration of the AS, this token is typically an opaque token. Or, it could be a JSON Web Token (JWT).

The application typically uses the access token to identify the user or the service. The lifetime for these tokens generally is very short for security reasons. If an attacker obtains an access token, it could be used to gain access as the user or service for which it was issued. This could present challenges in specific architectures, such as a single-page application (SPA) that can’t adequately protect the token. An approach for solving this is the **[token handler](https://curity.io/resources/learn/token-handler-overview)** pattern.

## Bearer Tokens

The most common way that access tokens are used is as bearer tokens. This means that the bearer of the token will be granted access. With this type, there are no checks by the application or the API receiving the token that the correct sender presented the token. Therefore, a token could be hijacked by an attacker and used to gain access to an application. Using bearer tokens puts more requirements on the application to appropriately safeguard the token.

## Sender Constrained Tokens

The authorization server can use cryptographic information when issuing the token to bind the token to the application. This creates a coupling between something only the application knows (cryptographic keys) and the given token. Since the token is constrained to the sender, these are called sender-constrained tokens, also referred to as proof-of-possession tokens. The article **[“Mutual TLS Sender Constrained access tokens”](https://curity.io/resources/learn/oauth-certificate-bound-access-token)** outlines how these tokens are issued.

For example, when the application sends the token to an API, it also sends cryptographic key information. The API can then validate that the token presented is bound to the cryptographic key that is also given. This safeguards the token from being stolen and reused. Although sender-constrained tokens require additional configuration around cryptographic keys, they are certainly worth the effort.

## Refresh Tokens

When access tokens are issued to users, they require an authentication step. But, short-lived tokens could be a significant inconvenience for the user as they must constantly re-authenticate to obtain a new active token. This is where **[refresh tokens](https://curity.io/resources/learn/refresh-tokens)** can help.

At the time of issuing an access token, the authorization server can also issue a refresh token. When the AT has expired and a new one is needed, the application can invoke a refresh token flow and present the refresh token to obtain a new, refreshed AT. In this flow, there is no need for the user to re-authenticate.

## ID Tokens

In contrast to the access token and the refresh token, an ID token is always a JSON Web Token (JWT). The ID token represents the user identity or the user’s authentication information. It is issued as part of OIDC flows when the openid scope is requested.

The ID token can contain several properties associated with the user for which the token is issued. These properties and their values are defined and configured within the authorization server and can be consumed by the receiving API.

In addition to user-specific properties, the ID token also contains a set of standard properties or claims. These may identify, for example, who issued the token, who the token is intended for when it expires and other attributes.

## Token Formats

In many cases, the exact token format is not specified by the standard — instead, the authorization server dictates the format. Sometimes, this can be configured based on which application is requesting a token.

As mentioned earlier, the ID token format is a JWT defined by the OIDC standard.

## Opaque Tokens

Opaque tokens, also known as reference tokens, are unique random strings generated by the authorization server. Commonly, both access and refresh tokens are opaque and therefore don’t convey any data to the app or the API. This helps prevent public applications from potentially leaking information contained within the token. An opaque token can be passed around without the risk of revealing personally identifiable information (PII) about the user.

However, a system may require more detailed information to release data from an API or inform application behaviors. In this case, introspection must be performed against an opaque token. Introspection is a flow in which the token is sent to the authorization server’s introspection API. The API’s response then denotes if the token is still valid and additional data determined when the token was issued.

Example of an opaque token: 087258a5-ddb2-487e-a38e-071698896ff9

## JSON Web Tokens (JWT)

JSON Web Token (JWT) is a widespread token format. It consists of a header, a body and payload, and a signature. The base64-encoded JWT format separates the three pieces with a period. Here’s an example:

![](https://cdn.thenewstack.io/media/2022/09/8cc0ef7b-screen-shot-2022-09-07-at-10.26.56-am-e1662560878476.png)

The header contains metadata about the token and its crypto algorithms.

```header
{
 alg HS256
 typ JWT
}
```

The payload is the actual data and contains information about the issuer, the user and the user authorization.

```payload
{
 iss https://idsvr.example.com
 sub 11223344
 name Jane Doe
 iat 1660000022
 exp 1660080022
}
```

Finally, the signature is used to verify the token’s integrity and will ensure that the token has not been tampered with.

JWTs are great for holding data and, therefore, well-suited for ID tokens. Access tokens can also be issued as JWTs, but it depends on the use case whether it’s appropriate to do so. Remember that opaque tokens don’t expose any information and must be introspected to reveal their contents. JWTs, on the other hand, can hold a lot of data that is not hidden.

The downside is that JWTs might potentially contain PII that is easy to read. This holds true for the most basic usage of JWTs, where they are not encrypted and are simply protected from tampering. For example, you might be able to determine if the information in the JWT was changed. But to prevent data from being read, the JWT must be encrypted. Wherever JWTs are used, **[best practices around securing JWTs]** should be followed.

## The Best of Both Worlds

There are advantages and disadvantages to the different token formats. JWTs are great because they can potentially hold all the data required, but they run the risk of data leakage. Opaque tokens, on the other hand, hide that data, and the authorization server must introspect tokens to reveal data. The **[Phantom Token pattern](https://curity.io/resources/learn/phantom-token-pattern)** and **[Split Token pattern](https://curity.io/resources/learn/split-token-pattern)** combine these token formats and offer the best of both worlds.

## Phantom Tokens

The Phantom Token pattern combines a JWT and an opaque token issued to the (public) application. With the use of an API gateway or reverse proxy, the opaque token is then introspected (exchanged) for a JWT that can be passed on to the upstream API for consumption. With this approach, the API receives a JWT with all the data it needs to authorize the caller and what information to release. But the public application doesn’t get PII that can accidentally leak.

This process involves introspecting the opaque token, but the JWT in the response could be cached in the gateway for further use. This could help optimize performance, especially if several APIs are called.

![](https://cdn.thenewstack.io/media/2022/09/ca5fc0da-image1a-e1662487773124.jpg)

## Split Tokens

Split tokens are similar to Phantom Tokens in that they prevent the JWT from being available to a public client. However, the pattern adopts a different process. Instead of issuing an opaque token, the authorization server sends the signature of the JWT to the public client. This fills the purpose of the opaque token in the Phantom Token approach, and the client uses this as its access token.

When sending the signature to the client, the authorization server simultaneously hashes the signature and sends that together with the head and the body of the complete JWT to an API gateway cache. The hashed signature is stored as the key information to retrieve the rest of the token, the head and the body.

When the API gateway receives an incoming request where the signature is presented as the token, the API gateway hashes the signature. It looks up the rest of the token in its cache using the hashed signature as the key. It then assembles the complete token and passes that on to the API.

In this case, no introspection is needed. However, the authorization server must push the parts of the token to the cache fairly quickly so that the API gateway doesn’t encounter a cache miss when getting a request.

![](https://cdn.thenewstack.io/media/2022/09/4314c991-image2a-e1662487790910.jpg)

## Token Handler

Token handler is not specifically a token type, but is worth mentioning as it heavily relates to some of the more prevalent issues around protecting a token in single-page applications. Browsers are increasingly making it harder to handle third-party cookies due to tracking prevention. SPAs are also unable to securely protect a token in a way similar to **[secure cookies](https://en.wikipedia.org/wiki/Secure_cookie)**.

Instead of tokens being issued directly to the SPA, the token is issued to a token handler installed on a gateway/proxy. The token handler then sends a secure cookie to the SPA that can be used in place of a token. When the SPA needs to make an API call, it sends the secure cookie, and the token handler replaces that with the actual token when the request is forwarded to the API.

Refer to this **[“Token Handler Overview”](https://curity.io/resources/learn/token-handler-overview/)** for more details on this approach.

![](https://cdn.thenewstack.io/media/2022/09/2eb3e9a2-image3-e1662487804826.jpg)

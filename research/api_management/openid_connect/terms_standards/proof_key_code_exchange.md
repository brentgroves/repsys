# Proof Key Code Exchange

## references

<https://oauth.net/2/grant-types/authorization-code/>
<https://www.oauth.com/playground/authorization-code-with-pkce.html>

## OAuth 2.0 Authorization Code Grant

tools.ietf.org/html/rfc6749#section-1.3.1

The Authorization Code grant type is used by confidential and public clients to exchange an authorization code for an access token.

After the user returns to the client via the redirect URL, the application will get the authorization code from the URL and use it to request an access token.

It is recommended that all clients use the PKCE extension with this flow as well to provide better security.

## Proof Key for Code Exchange

PKCE (RFC 7636) is an extension to the Authorization Code flow to prevent CSRF and authorization code injection attacks.

PKCE is not a form of client authentication, and PKCE is not a replacement for a client secret or other client authentication. PKCE is recommended even if a client is using a client secret or other form of client authentication like private_key_jwt.

Note: Because PKCE is not a replacement for client authentication, it does not allow treating a public client as a confidential client.

PKCE was originally designed to protect the authorization code flow in mobile apps, but its ability to prevent authorization code injection makes it useful for every type of OAuth client, even web apps that use client authentication.

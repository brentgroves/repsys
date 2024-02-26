# Implicit Grant Type Response

With the Implicit grant (response_type=token) the authorization server generates an access token immediately and redirects to the callback URL with the token and other access token attributes in the fragment.

For example, the authorization server redirects the user by sending the following HTTP response (extra line breaks for display purposes).

```http
HTTP/1.1 302 Found
Location: https://example-app.com/redirect#access_token=MyMzFjNTk2NTk4ZTYyZGI3
 &state=dkZmYxMzE2
 &token_type=Bearer
 &expires_in=86400
```

You can see that this is much more dangerous than issuing a temporary one-time-use authorization code. Since there are many more ways an attacker can steal data out of an HTTP redirect compared to intercepting an HTTPS request, it’s much riskier using this option compared to the authorization code flow.

From the authorization server’s point of view, at the point it creates the access token and sends the HTTP redirect, it has no way of knowing whether or not the redirect was successful and the correct application has received the access token. It’s kind of tossing the access token up into the air and crossing its fingers that the app catches it. This is in contrast to the authorization code method, where even though the authorization server can’t guarantee the authorization code wasn’t stolen, it can at least prevent a stolen authorization code from being useful by requiring a client secret or the PKCE code verifier. This provides a much greater level of security since the authorization server can now be more confident that it won’t be giving access tokens away to attackers.

For these reasons as well as more documented in OAuth 2.0 for Browser-Based Apps, it is recommended that the Implicit flow no longer be used.

## Github

- https//github.com/login/oauth/authorize is the OAuth gateway for Github’s **OAuth flow**. All OAuth providers have a gateway URL that you have to send the user to in order to proceed.

- client_id=myclientid123 - this specifies the client ID of the application. This ID will tell Github about the identity of the consumer who is trying to use their OAuth service. Maybe the client_id is the id of the app registered with github.

  OAuth service providers normally have a portal in which you can register your consumer. On registration, you will receive a client ID (which we are using here as myclientid123), and a client secret (which we will use later on). For Github, the portal to register new applications can be found on <https://github.com/settings/applications/new>.

- redirect_uri=<http://localhost:8080/oauth/redirect> - specifies the URL to redirect to with the request token, once the user has been authenticated by the service provider. Normally, you will have to set this value on the registration portal as well, to prevent anyone from setting malicious callback URLs.

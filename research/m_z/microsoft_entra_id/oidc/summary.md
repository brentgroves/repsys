# OIDC Summary

1. register the app. You must create a scope such as api://guid.com and check the id token box.
2. web app redirected to oidc endpoint
3. user authenticates
4. OP returns id_token and state
5. verify the state
6. use go jwt and jwks_key lib to verify token signature.
7. pass the jws key set url to jwks_key lib.
8. jwks_key_set retrieves the keys used in recent JWT signings.
9. It matches the token headers kid field to key used from the jwks_key_set.
10. the x509c, x5c, field in the jwks JSON is downloaded
11. the public key of the x509c certificate is extracted.
12. The token signature is decode using the public key.
13. The header.payload of the base64 encoded token is compared to the decode token signature.
14. If they are equal the token has not been tampared with.

NEXT: Find out how to store the Claims on the server and in the browser maybe using cookies or session keys.
https://www.sohamkamani.com/golang/oauth/
Session Tokens
In this example, we passed the access token to the client so that it can make requests as the authorized user. To make your app more secure, the access token should not be passed directly to the user. Instead, create a session token that is sent to the user as a cookie.
https://www.sohamkamani.com/web-security-basics/#sessions-and-cookies
# **[https://auth0.com/docs/get-started/tenant-settings/signing-keys](https://auth0.com/docs/get-started/tenant-settings/signing-keys)**

## references

<https://auth0.com/docs/get-started/tenant-settings/signing-keys>

## Signing Keys

When you select our recommended signing algorithm (RS256), Auth0 uses public-key cryptography to establish trust with your applications. In more general terms, we use a signing key that consists of a public and private key pair.

Signing keys are used to sign ID tokens, access tokens, SAML assertions, and WS-Fed assertions sent to your application or API. The signing key is a JSON web key (JWK) that contains a well-known public key used to validate the signature of a signed JSON web token (JWT). A JSON web key set (JWKS) is a set of keys containing the public keys used to verify any JWT issued by the authorization server and signed using the RS256 signing algorithm. The service may only use one JWK for validating web tokens, however, the JWKS may contain multiple keys if the service rotated signing certificates.

## How it works

When a user signs in to your application, we create a token that contains information about the user and sign the token using its private key before we send it back to your application. Auth0 secures the private key, which is unique per tenant.

To verify that the token is valid and originated from Auth0, your application validates the token’s signature using the public key. We provide other application security key management capabilities through both our Dashboard and Management API.

Auth0 recommends that you rotate keys regularly to ensure you will be ready for action in case of a security breach.

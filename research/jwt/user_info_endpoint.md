# **Microsoft identity platform UserInfo endpoint](<https://learn.microsoft.com/en-us/entra/identity-platform/userinfo>)**

## Find the .well-known configuration endpoint

You can find the UserInfo endpoint programmatically by reading the userinfo_endpoint field of the OpenID configuration document at <https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration>. We don't recommend hard-coding the UserInfo endpoint in your applications. Instead, use the OIDC configuration document to find the endpoint at runtime.

The UserInfo endpoint is typically called automatically by OIDC-compliant libraries to get information about the user. From the list of claims identified in the OIDC standard, the Microsoft identity platform produces the name claims, subject claim, and email when available and consented to.

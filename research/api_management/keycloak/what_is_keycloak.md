# What is KeyCloak

## references

<https://www.keycloak.org/>
<https://www.keycloak.org/server/reverseproxy>
<https://discuss.istio.io/t/how-to-implement-istio-authorization-using-oauth2-and-keycloak/13707/4>
<https://medium.com/@robert.broeckelmann/authentication-vs-federation-vs-sso-9586b06b1380>

## Open Source Identity and Access Management

Add authentication to applications and secure services with minimum effort.
No need to deal with storing users or authenticating users.

Keycloak provides user federation, strong authentication, user management, fine-grained authorization, and more.

## Single-Sign On

Users authenticate with Keycloak rather than individual applications. This means that your applications don't have to deal with login forms, authenticating users, and storing users. Once logged-in to Keycloak, users don't have to login again to access a different application.

This also applies to logout. Keycloak provides single-sign out, which means users only have to logout once to be logged-out of all applications that use Keycloak.

# **[Keycloak](https://en.wikipedia.org/wiki/Keycloak)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

<https://www.keycloak.org/>

## Keycloak

Keycloak is an open source software product to allow single sign-on with identity and access management aimed at modern applications and services. Until April 2023, this WildFly community project was under the stewardship of Red Hat, who use it as the upstream project for their Red Hat build of Keycloak

## Open Source Identity and Access Management

Add authentication to applications and secure services with minimum effort.
No need to deal with storing users or authenticating users.

Keycloak provides **[user federation](https://www.okta.com/identity-101/what-is-federated-identity/)**, strong authentication, user management, fine-grained authorization, and more.

Federated identity is a method of linking a user's identity across multiple separate identity management systems.

## Single-Sign On

![](https://www.keycloak.org/resources/images/screen-login.png)

Users authenticate with Keycloak rather than individual applications. This means that your applications don't have to deal with login forms, authenticating users, and storing users. Once logged-in to Keycloak, users don't have to login again to access a different application.

This also applies to logout. Keycloak provides single-sign out, which means users only have to logout once to be logged-out of all applications that use Keycloak.

## Identity Brokering and Social Login

![](https://www.keycloak.org/resources/images/dia-identity-brokering.png)

Enabling login with social networks is easy to add through the admin console. It's just a matter of selecting the social network you want to add. No code or changes to your application is required.

Keycloak can also authenticate users with existing OpenID Connect or SAML 2.0 Identity Providers. Again, this is just a matter of configuring the Identity Provider through the admin console.

## **[User Federation](https://www.okta.com/identity-101/what-is-federated-identity/)**

Keycloak provides **[user federation](https://www.okta.com/identity-101/what-is-federated-identity/)**, strong authentication, user management, fine-grained authorization, and more.

Federated identity is a method of linking a user's identity across multiple separate identity management systems.

![](https://www.keycloak.org/resources/images/dia-user-fed.png)

Keycloak has built-in support to connect to existing LDAP or Active Directory servers. You can also implement your own provider if you have users in other stores, such as a relational database.

## Admin Console

![](https://www.keycloak.org/resources/images/screen-admin.png)

- Through the admin console administrators can centrally manage all aspects of the Keycloak server.
- They can enable and disable various features. They can configure identity brokering and user federation.
- They can create and manage applications and services, and define fine-grained authorization policies.
- They can also manage users, including permissions and sessions.

## Account Management Console

![](https://www.keycloak.org/resources/images/screen-account.png)

- Through the account management console users can manage their own accounts. They can update the profile, change passwords, and setup two-factor authentication.
- Users can also manage sessions as well as view history for the account.
- If you've enabled social login or identity brokering users can also link their accounts with additional providers to allow them to authenticate to the same account with different identity providers.

## Standard Protocols

![](https://www.keycloak.org/resources/images/dia-protocols.png)

Keycloak is based on standard protocols and provides support for OpenID Connect, OAuth 2.0, and SAML.

## Authorization Services

If role based authorization doesn't cover your needs, Keycloak provides fine-grained authorization services as well. This allows you to manage permissions for all your services from the Keycloak admin console and gives you the power to define exactly the policies you need.

- Single-Sign On
Login once to multiple applications
- Standard Protocols
OpenID Connect, OAuth 2.0 and SAML 2.0
- Centralized Management
For admins and users
- Adapters
Secure applications and services easily
 LDAP and Active Directory
Connect to existing user directories
- Social Login
Easily enable social login
- Identity Brokering
OpenID Connect or SAML 2.0 IdPs
- High Performance
Lightweight, fast and scalable
- Clustering
For scalability and availability
- Themes
Customize look and feel
- Extensible
Customize through code
- Password Policies
Customize password policies

Keycloak is a Cloud Native Computing Foundation incubation project

![](https://www.keycloak.org/resources/images/cncf_logo.png)

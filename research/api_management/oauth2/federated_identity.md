# Federated Identity

## references

<https://www.onelogin.com/learn/federated-identity#:~:text=Federated%20identity%20allows%20authorized%20users,different%20applications%20securely%20and%20efficiently>.

## What is Federated Identity

<https://www.onelogin.com/learn/federated-identity#:~:text=Federated%20identity%20allows%20authorized%20users,different%20applications%20securely%20and%20efficiently>.

How it Works and Benefits
Federated identity allows authorized users to access multiple applications and domains using a single set of credentials. It links a user’s identity across multiple identity management systems so they can access different applications securely and efficiently.

When organizations implement federated identity solutions, their users can access web applications, partner websites, Active Directory, and other applications without logging in separately every time.

## How Does Federated Identity Work?

SERVICE PROVIDERS AND IDENTITY PROVIDERS IN A FEDERATED SYSTEM

Federated identity – also known as Federated Identity Management (FIM) – works on the basis of mutual trust relationships between a Service Provider (SP) such as an application vendor and an external party or Identity Provider (IdP).

The IdP creates and manages user credentials and the SP and IdP agree on an authentication process. Multiple SPs can participate in a federated identity agreement with a single IdP. The IdP has mutual trust agreements with all these organizations.

## HOW FEDERATED IDENTITY WORKS

When the user tries to access an application or domain, they don’t have to provide their login credentials every time. Instead, these credentials are already stored in the IdP’s database.

The IdP confirms the user’s digital identity in its database, authenticates them and sends the user’s identity information to the SP. All of this allows the user to access multiple applications, systems, portals, websites, etc. without logging in again and again.

In short, here’s how federated identity works:

The user tries to log into a domain, application, or portal that uses federated identity.
The application requests federated authentication from the user’s authentication server.
The authentication server verifies the user’s access and permissions.
The server confirms the user’s identity to the application.
The user accesses the application.

## Technologies Used in Federated Identity

Federated identity works by using several standard protocols. These include:

- Security Assertion Markup Language (SAML). The SAML protocol simplifies password management and user authentication in a federated system. It uses Extensible Markup Language (XML) to standardize communications between multiple systems.
SAML enables IdPs to securely send users’ login information to SPs. SAML authorization authenticates a user and tells the SP what access togrant them, which allows users to access multiple domains using one set of credentials.
- Open Authentication (OAuth). The OAuth authorization protocol allows third-party services like websites and applications to exchange user information without the user needing to give away their password to these services. These different services trust each other, which allows them to share information while also protecting the user. For instance, a user can allow onelogin.com to access their Facebook profile without having to share their Facebook password.
OAuth will not share the user’s Facebook password with OneLogin. Rather, it uses authorization tokens to prove the user’s identity to OneLogin. This system allows users to securely connect with third-party services and approve one application interacting with another on the user’s behalf.
- OpenID Connect (OIDC). The OIDC authentication protocol adds an identity layer on top of the OAuth 2.0 protocol. It allows third-party applications to verify a user’s identity and give the user one login for multiple applications.

The basic login flow for OIDC and SAML is the same. However, SAML is a self-contained authentication and authorization protocol, while OIDC adds an authentication layer on top of an authorization protocol. OIDC is also gaining popularity over SAML, since it works for consumer and native mobile applications, e.g., gaming and productivity apps.

## Examples of Federated Identity

One example of federated identity is when a user logs into a third-party website by using their Gmail login credentials. With FIM, they don’t have to create new credentials to access multiple websites that have a federated agreement with Google, such as:

- YouTube
- Fitbit
- Waze
- Picasa
- Blogger

## Report System Authentication and Authorization system

Report System Federated with Microsoft Entra ID

Note: Azure Active Directory is now Microsoft Entra ID

## Is Federated Identity Secure?

FIM is a secure system for user authorization, authentication, and digital identity management. When a user tries to access an application, they don’t provide their credentials to the SP. Instead, the SP “trusts” the IdP to validate these credentials and authorize the user. Thus, the user never provides their credentials to anyone but the IdP who securely stores and maintains their credentials.

## Federated Identity vs Single Sign-on

FIM and Single Sign-on (SSO) enable organizations to minimize password-related risks and secure their data and improve user experiences. Both kinds of solutions require a single set of credentials to grant the user access to multiple applications. But despite this similarity, these systems operate differently.

With SSO, users can access multiple applications within the same organization or domain using a single set of credentials. Federated identity goes a step further. It enables users to access applications or platforms across multiple enterprise domains that are part of the federated configuration. Thus, FIM supports SSO and also extends SSO to multiple domains. Also, SSO is a function of FIM, but implementing it doesn’t necessarily allow for FIM.

## Benefits of Federated Identity

A federated identity management architecture like OneLogin offers numerous advantages over traditional authentication systems.

- Enhanced security. In non-federated systems, a user has to log into individual systems with a set of credentials. Each such login creates a point of vulnerability, which increases the risk of hacking attempts by unauthorized users. Federated identity, on the other hand, securely authenticates a user to grant access to applications in many domains. And, by reducing the number of logins to one, the system reduces hacking risks.
- Enhanced user experience. Users only have to provide their credentials once to access multiple applications across federated domains. This increases user convenience and efficiency, and improves user experiences.
- Single-point provisioning. Federated identity enables single-point provisioning, making it easier to provide access to users outside the traditional enterprise perimeter.
- Secure resource-sharing. Federated organizations can effectively share information and resources without risking user credentials or security. Easier data management. Organizations store user data with an IdP, which simplifies their data management processes.
- Cost savings. Organizations don’t have to manage multiple user identities or build their own SSO solutions, thus reducing their costs.

## Conclusion

The average person is expected to remember at least 100 passwords. To minimize password overload, most people reuse the same easy-to-remember password for multiple accounts. But this creates a huge security risk for the organization. Creating unique complex passwords for each account boosts enterprise security. However, it is less convenient and more tedious for users.

FIM provides a solution for both challenges. With federated identity, employees can access multiple accounts across different domains using a common set of credentials. This improves the user experience. Also, since the system is based on trust between federated organizations, it also minimizes security risks.

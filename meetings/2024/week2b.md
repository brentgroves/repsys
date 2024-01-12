# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear to be better than your neighbor.  I say help your neighbor and especially help the ones that are struggling.

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

**Last meeting summary**,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin what software and hardware is needed to virtualize graphics intense software. Something about Plex IAM.
- Brad how what software does Fruitport machines use?
- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent H. something about Azure tenant migration.
- Brent G. Plex and Report System Federated with Microsoft Entra ID

## What is **[IAM](https://www.techtarget.com/searchsecurity/definition/identity-access-management-IAM-system)**, Identity and Access management?

Identity and access management (IAM) is a framework of business processes, policies and technologies that facilitates the management of electronic or digital identities. With an IAM framework in place, information technology (IT) managers can control user access to critical information within their organizations. Systems used for IAM include single sign-on systems, two-factor authentication, multifactor authentication and privileged access management. These technologies also provide the ability to securely store identity and profile data as well as data governance functions to ensure that only data that is necessary and relevant is shared.

IAM systems can be deployed on premises, provided by a third-party vendor through a cloud-based subscription model or deployed in a hybrid model.

On a fundamental level, IAM encompasses the following components:

- how individuals are identified in a system (understand the difference between identity management and authentication);
- how roles are identified in a system and how they are assigned to individuals;
adding, removing and updating individuals and their roles in a system;
- assigning levels of access to individuals or groups of individuals; and
- protecting the sensitive data within the system and securing the system itself.

## **[API Gateways](https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/)**

An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented.

Whenever a customer accesses any Repsys software it will be routed through **[Microsoft EntraID identity](https://www.microsoft.com/en-us/security/business/identity-access/microsoft-entra-id)** (formerly Azure Active Directory).

## Repsys **[IAM](https://en.wikipedia.org/wiki/Identity_management)**, Identity and Access Management

- Secure Web App, REST API, and report notification webhook using the **[Kong API gateway](https://konghq.com/products/kong-gateway)**.
- Use **[Keycloak](https://www.keycloak.org/)** for IAM.  
- Use Microsoft EntraID as an Identity Provider to Keycloak IAM platform.
- Register in Microsoft EntraID with an **[OpenID Connect, OIDC](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc#:~:text=OpenID%20Connect%20(OIDC)%20is%20an,who%20they%20say%20they%20are.)** scope.

## What is **[Federated Identity](https://www.onelogin.com/learn/federated-identity#:~:text=Federated%20identity%20allows%20authorized%20users,different%20applications%20securely%20and%20efficiently)**

FIM is a secure system for user authorization, authentication, and digital identity management. When a user tries to access an application, they don’t provide their credentials to the SP. Instead, the SP “trusts” the IdP to validate these credentials and authorize the user. Thus, the user never provides their credentials to anyone but the IdP who securely stores and maintains their credentials.

Identity federation means being able to ingest identity credentials from external identity providers. This can be used to provide single sign-on (SSO) – a very useful capability. SSO allows a single authentication method to access different systems within external identity providers based on mutual trust.

## Active Directory B2C

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/overview>

Azure Active Directory B2C provides business-to-customer identity as a service.
Your customers can use their preferred social, enterprise, or local account identities to get single sign-on access to your applications and APIs.

- New customizable User Flows such as signup and signin.
- New portal with new user interface
- Features isolated people groups as described in newer identity platform documents, ie. b2b,b2e, and b2c.  
- New entity type, Active Directory B2C, with new capabilities such as various signin user flows with the new GUI.

Can not yet test this with Microsoft Development Account since it requires a new tenant type.

## **[OpenID](https://konghq.com/blog/engineering/openid-vs-oauth-what-is-the-difference)** Authentication

OpenID is an open standard that enables decentralized digital identity, allowing users to log into different websites using the same identity provider. For example, there are SSO options where you can use your Google or Facebook account to sign in to various sites across the web, without needing to create new usernames and passwords for each one.

## **[OAuth2](https://auth0.com/intro-to-iam/what-is-oauth-2#:~:text=OAuth%202.0%2C%20which%20stands%20for,industry%20standard%20for%20online%20authorization.)** Authorization

OAuth 2.0, which stands for “Open Authorization”, is a standard designed to allow a website or application to access resources hosted by other web apps on behalf of a user. It replaced OAuth 1.0 in 2012 and is now the de facto industry standard for online authorization.

## **[OpenID Connect](https://konghq.com/blog/engineering/openid-vs-oauth-what-is-the-difference)** (OIDC): The Best of Both Worlds

OpenID Connect is an authentication protocol that extends OAuth 2.0 and can be utilized for sign-on purposes. It facilitates the verification of user identity by clients through an authorization server. OpenID Connect combines elements from both OpenID and OAuth:

It employs OAuth 2.0 flows for the authentication request and response enabling a seamless single sign-on experience similar to OpenID. Additionally, it incorporates an OAuth 2.0 token that allows clients to access APIs and retrieve user information.

Consequently, OpenID Connect offers both identity verification and delegated authorization capabilities enabling clients to securely access user data. By augmenting OAuth 2.0 with an identity layer featuring user profile claims OpenID Connect provides a means of achieving single sign-on functionality on top of the authorization framework offered by OAuth.

# week2

## Report System IT Admin, Hardware, or Software Topics of Interest

This markdown file is located at: ~/src/repsys/meetings/2024/week2.md To get a fresh copy please run ~/freshstart.sh at a command prompt. It can be viewed by logging into devcon2 as bcieslik,bcook,sjackson,cstangland,rdecker,bhall,jdavis,or kyoung with password k8sAdmin1! and opening week45.md from visual studio code and pressing shift-ctrl-v

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

Last meeting summary,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent G. KeyCloak OpenID Connect Server

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

## **[API gateways](https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/)**

API gateways are becoming increasingly more popular, and for good reasons. As the number of APIs within an organisation grows, the amount of “plumbing” required to expose the APIs in a secure, efficient and maintainable way quickly becomes overwhelming. An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented.

**[Keycloak](https://en.wikipedia.org/wiki/Keycloak)** is an open source software product to allow single sign-on with identity and access management aimed at modern applications and services. As of March 2018 this WildFly community project is under the stewardship of Red Hat who use it as the upstream project for their Red Hat Single Sign-On product.

**[Relying Party](https://openid.net/developers/how-connect-works/)** (RP). RP stands for Relying Party, an application or website that outsources its user authentication function to an IDP.

Keycloak can be configured to rely on **[Microsoft's identity provider](https://www.hcl-software.com/blog/versionvault/how-to-configure-microsoft-azure-active-directory-as-keycloak-identity-provider-to-enable-single-sign-on-for-hcl-compass)**.


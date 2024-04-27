# week2

## Report System IT Admin, Hardware, or Software Topics of Interest

This markdown file is located at: ~/src/repsys/meetings/2024/week2.md To get a fresh copy please run ~/freshstart.sh at a command prompt. It can be viewed by logging into devcon2 as bcieslik,bcook,sjackson,cstangland,rdecker,bhall,jdavis,or kyoung with password k8sAdmin1! and opening week45.md from visual studio code and pressing shift-ctrl-v

## What is **[OpenStack](https://www.openstack.org/software/)**

OpenStack is a an open source cloud operating system managing compute, storage, and networking resources throughout a datacenter using APIs.

![](https://object-storage-ca-ymq-1.vexxhost.net/swift/v1/6e4619c416ff4bd19e1c087f27a43eea/www-images-prod/openstack-logo/2016R/OpenStack-Logo-Horizontal.SVG)

![](https://object-storage-ca-ymq-1.vexxhost.net/swift/v1/6e4619c416ff4bd19e1c087f27a43eea/www-assets-prod/learn/homepage-OpenStack-SFAs.svg)

## OpenStack Logical Diagram

![](https://docs.openstack.org/install-guide/_images/openstack_kilo_conceptual_arch.png)

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

Last meeting summary,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin what software and hardware is needed to virtualize graphics intense software.
- Brad how what software does Fruitport machines use?
- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent G. Plex and Report System Federated with Microsoft Entra ID

# IAM

## references

<https://www.techtarget.com/searchsecurity/definition/identity-access-management-IAM-system>

## What is identity and access management? Guide to IAM

By
Sandra GittlenLinda Rosencrance
Identity and access management (IAM) is a framework of business processes, policies and technologies that facilitates the management of electronic or digital identities. With an IAM framework in place, information technology (IT) managers can control user access to critical information within their organizations. Systems used for IAM include single sign-on systems, two-factor authentication, multifactor authentication and privileged access management. These technologies also provide the ability to securely store identity and profile data as well as data governance functions to ensure that only data that is necessary and relevant is shared.

IAM systems can be deployed on premises, provided by a third-party vendor through a cloud-based subscription model or deployed in a hybrid model.

On a fundamental level, IAM encompasses the following components:

- how individuals are identified in a system (understand the difference between identity management and authentication);
- how roles are identified in a system and how they are assigned to individuals;
adding, removing and updating individuals and their roles in a system;
- assigning levels of access to individuals or groups of individuals; and
- protecting the sensitive data within the system and securing the system itself.

Note: Azure Active Directory is now Microsoft Entra ID

## What is **[Federated Identity](https://www.onelogin.com/learn/federated-identity#:~:text=Federated%20identity%20allows%20authorized%20users,different%20applications%20securely%20and%20efficiently)**

FIM is a secure system for user authorization, authentication, and digital identity management. When a user tries to access an application, they don’t provide their credentials to the SP. Instead, the SP “trusts” the IdP to validate these credentials and authorize the user. Thus, the user never provides their credentials to anyone but the IdP who securely stores and maintains their credentials.

Identity federation means being able to ingest identity credentials from external identity providers. This can be used to provide single sign-on (SSO) – a very useful capability. SSO allows a single authentication method to access different systems within external identity providers based on mutual trust.

### How it Works and Benefits

Federated identity allows authorized users to access multiple applications and domains using a single set of credentials. It links a user’s identity across multiple identity management systems so they can access different applications securely and efficiently.

When organizations implement federated identity solutions, their users can access web applications, partner websites, Active Directory, and other applications without logging in separately every time.

## How Does Federated Identity Work?

SERVICE PROVIDERS AND IDENTITY PROVIDERS IN A FEDERATED SYSTEM

Federated identity – also known as Federated Identity Management (FIM) – works on the basis of mutual trust relationships between a Service Provider (SP) such as an application vendor and an external party or Identity Provider (IdP).

The IdP creates and manages user credentials and the SP and IdP agree on an authentication process. Multiple SPs can participate in a federated identity agreement with a single IdP. The IdP has mutual trust agreements with all these organizations.

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

Similarly, a user can use their Facebook credentials to log into many websites that are federated with Facebook, like:

- Instagram
- Netflix
- Disney+

## Is Federated Identity Secure?

FIM is a secure system for user authorization, authentication, and digital identity management. When a user tries to access an application, they don’t provide their credentials to the SP. Instead, the SP “trusts” the IdP to validate these credentials and authorize the user. Thus, the user never provides their credentials to anyone but the IdP who securely stores and maintains their credentials.

## Federated Identity vs Single Sign-on

FIM and Single Sign-on (SSO) enable organizations to minimize password-related risks and secure their data and improve user experiences. Both kinds of solutions require a single set of credentials to grant the user access to multiple applications. But despite this similarity, these systems operate differently.

With SSO, users can access multiple applications within the same organization or domain using a single set of credentials. Federated identity goes a step further. It enables users to access applications or platforms across multiple enterprise domains that are part of the federated configuration. Thus, FIM supports SSO and also extends SSO to multiple domains. Also, SSO is a function of FIM, but implementing it doesn’t necessarily allow for FIM.

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

## What is **[OpenStack](https://www.openstack.org/software/)**

OpenStack is a an open source cloud operating system managing compute, storage, and networking resources throughout a datacenter using APIs.

**[OpenStack](https://en.wikipedia.org/wiki/OpenStack)** is a free, open standard cloud computing platform. It is mostly deployed as infrastructure-as-a-service in both public and private clouds where virtual servers and other resources are made available to users.

## Open Stack History

<https://docs.openstack.org/project-team-guide/introduction.html>

<https://fedscoop.com/agencies-open-up-to-openstack/>

Three out of four government IT professionals in a new poll say their agencies are now using cloud computing services. The new survey also found that a significant portion of the respondents have favorable perceptions about the cost, security and ease of deploying the popular open source software platform, OpenStack, for their on-premises cloud computing initiatives.

How Governments Use **[OpenStack](https://vexxhost.com/blog/how-governments-use-openstack-around-the-world/
)
Governments all over the world have important priorities. Keep their citizens safe, keep law and order within their jurisdiction, and problem solve any issues that arise are just some of the issues that they face on a day to day basis. Although the way that they govern their countries the following countries have one thing in common: OpenStack.

**The United States Of America**
In the United States, the National Security Agency (NSA) utilizes the power of OpenStack to keep abreast of the high-security needs of the country. The implementation of OpenStack at the governmental level was such a success that the NSA plan on implementing OpenStack to all 16 agencies that make up the intelligence community in the United States. Considering the emphasis that the United States place on security, it is evident that OpenStack delivers where it matters most.

Moreover, the role of OpenStack in government security for the United States is good for OpenStack users. Why? Because the NSA has such strong security requirements, it developed systems to accommodate these requirements. From securing APIs and guest OSes to developing code to suit their needs, the OpenStack community can experience the security benefits for themselves.

## The NIST Cloud Federation Reference Architecture

The **[National Institute of Standards and Technology](https://www.nist.gov/)** is an agency of the United States Department of Commerce whose mission is to promote American innovation and industrial competitiveness.

This document presents the NIST Federated Cloud Reference Architecture model. This actor/role- based model used the guiding principles of the NIST Cloud Computing Reference Architecture to develop an eleven component model. This document describes these components individually and how they function as an ensemble. There are many possible deployments and governance options which lend themselves to create a suite of federation options from simple to complex. The basics of cloud federation can be described through the interactions of the actors in a layered three planes representation of trust, security, and resource sharing and usage. A discussion on possible future standards and use cases are also described in great detail.

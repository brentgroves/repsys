# API Management terms

## references

<https://medium.com/@robert.broeckelmann/authentication-vs-federation-vs-sso-9586b06b1380>

<https://medium.com/@robert.broeckelmann/keeping-your-apis-secure-for-multiple-user-types-d5c627793c4c>

## Multiple user communities at runtime

To that end, these systems must be able to securely support multiple user communities in a way that does not increase complexity while allowing for scalability, availability, reliability, and all those other words ending in “-ability” that are associated with robust IT systems.

Let’s use an API management platform as our target system of interest. Further, assume there is an internet-facing API gateway that handles the authentication and authorization requirements of the backend API providers — a fairly typical situation.

A user community could be defined in one of two ways:

- Business perspective: a group of users such as all internal employees, users that are part of B2B vendors/suppliers, or customers.
- Technology perspective: users within a single LDAP repository, active directory domain, or similar user repository.

Within an API management solution, the concepts of authentication and authorization come up in several contexts: developert portal (authentication of the developer populations, B2E and B2B), management portal (authentication of API gateway administrators and API developers), and runtime API traffic (the focus of what I’ve been writing much about lately). In this post, the primary use case is working with multiple user communities at runtime when APIs are being invoked.

I’ve used the terms identity provider, OAuth server, federation server, OAuth authorization server, and user repository many times while writing about identity concerns. Sometimes I’m not as disciplined as I should be in my use of these terms (I’ve used “identity provider and “federation server” interchangeably many times, for instance). For this conversation, more discipline is needed. To that end, let’s formally define:

- Identity provider: the combination of a federation server and user repository (and possibly other identity stack components needed to enable these two systems to function properly)

- Federation server: a service that can issue, validate, and invalidate security tokens. Security tokens are a collection of claims that are usually digitally signed (and, possibly, encrypted) such as SAML2 assertions or JWT tokens

- User repository: a system that stores user and group information such an LDAP server or active directory domain

- OAuth2 authorization server: a concept that is defined by the OAuth2 spec; an identity provider that supports the OAuth2 protocol

- OpenID (connect) provider: A concept that is defined by the OIDC spec; an identity provider that supports the OIDC protocol

- WS-Trust security token service: A concept that is defined by the WS-Trust spec; an identity provider that supports the WS-Trust protocol

## The preferred approach

Most enterprise identity and access management systems would not mix user communities inside the same LDAP repository, active directory domain, or similar user repository. There are security implications to doing this — if the B2C user repository is compromised, you don’t want the employee accounts to be in the same place and vice versa (for starters).

So, ideally, the same technology would be used to build the identity stack that supports these different user communities, but different instances of that technology would be used at the user repository layer. For example, maybe there is a separate active directory domain for each of the B2B, B2C, and B2E user communities. If this suggestion seems fuzzy or questionable, consider an online banking application that a financial institution provides to its customers, or any kind of online account access system. Where is the identity information for those customer accounts stored? Is it in the same LDAP repository as the internal employee accounts? Most of the time, the answer would be no.

If a common product stack can be used across all user communities, then a common federation server can be placed in front of all of them and used by other systems within the security realm to authenticate all users. Most likely, the user repository product vendor has a federation server that can be used. The ideal state of an organization’s identity stack is for a single vendor to be providing all the major components. This approach will often not be possible due to identity stack product constraints, differences in data sets, politics, or history.

Alternative approaches
The next-best approach would be to have a common identity provider that can communicate with multiple user repositories that may not be the same technology or from the same vendor. Systems within the trust realm (the group of all systems that trust a common identity provider) still have a single “front door” to use for communicating with identity systems; that door is well-defined and well-understood. Mixing and matching identity stack components from multiple vendors following a best-of-breed approach generally creates far more problems than it solves, but in a large, enterprise organization with a long history it is likely unavoidable.

The next approach, in order of preference, would be to have one master identity provider (for the API gateway’s concerns) that has federation relationships with other identity providers, which can then authenticate (and authorize) the desired user communities. For individual systems, there is still a single point of entry into the identity stack, but each system may have a different front door. The identity space will start to become complex quickly.

If none of those are possible, the next approach would be to use a product that can communicate with multiple LDAP servers or active directory domains at the same time; most products would have out-of-the-box capabilities to do something like this. I know WebSphere Application Server, JBoss EAP, DataPower, and Apigee Edge’s on-premises solution would all be able to do this. There are also LDAP virtualization products that can make a number of LDAP servers appear to be a single repository from the perspective of the LDAP client.

If the target platform does not have out-of-the-box functionality to accomplish the desired approach, something could almost always be written to accomplish the desired behavior. Treat this as a last resort. Using security features provided by a commonly used product is generally a safer approach than writing your own.

Coming up next, I’ll discuss design principles for seamless user authentication.

## Authentication vs Federation vs SSO

Authentication: process of an entity (the Principal) proving its identity to another entity (the System).

Single Sign On (SSO): characteristic of an authentication mechanism that relates to the user’s identity being used to provide access across multiple Service Providers.

Federation: common standards and protocols to manage and map user identities between Identity Providers across organizations (and security domains) via trust relationships (usually established via digital signatures, encryption, and PKI).

First, Identity and Access Management (IAM) is the management of identity concerns within an information technology organization. The term, IAM, can refer to the team or the responsibilities of the team. Ideally, IAM is a centralized team, but due to history, politics, or organizational structure that isn’t always possible. The next best option is to have a central team dedicated to each of Business-to-Business (B2B), Business-to-Consumer (B2C), and Business-to-Employee (B2E) concerns. All too often, every individual group handles their own IAM responsibilities — this creates additional hurdles to adopting Federation and SSO across an organization. IAM can include authentication of users and system, authorization of those users and systems, user provisioning, audit of identity systems, user repository management (think LDAP or Active Directory), password policies, and other concerns.

Authentication
Providing authentication services is a core responsibility of IAM. Authentication is the most generic of the three concepts mentioned in the post title. From an earlier post on thinkmiddleware.com, I gave the following as a definition of authentication. Authentication is the process of an entity (the Principal) proving its identity to another entity (the System). The Principal could be a computer program (a batch job, for example, running in the background), an end user (human), a computer system, a piece of hardware, mobile device, or other exotic things. The System, for our purposes, is any computer system that requires the caller to be identified before access is granted — often this system will be on server, sometimes it is on a device (cellphone, desktop, laptop, tablet), sometimes it will be in a browser. The Principal provides Credentials to the System that must be authenticated by the System using some type of identity system (including User Repository, Federation Server, or other). Credentials are sensitive information that positively identify the client and could come in many forms:

Userid and password
Digital Signature
X509v3 client certificate
pin # + random number from a FOB, Google Authenticate, or similar technology.

For completeness, a User Repository contains information about Users (Principals), their Credentials, Groups, group membership, and other user attributes. An LDAP Server or Active Directory is a typical example of a User Repository. More detailed descriptions of these concepts can be found here. I previously defined Federation Server and Identity Provider in a previous post

## Single Sign On

Single Sign On (SSO) is a characteristic of an authentication mechanism that relates to the user’s identity being used to provide access across multiple Service Provider. SSO allows a single authentication process (managed by a single Identity Provider, Directory Server, or other authentication mechanism) to be used across multiple systems (Service Providers) within a single organization or across multiple organizations. That single authentication mechanism could be:

- an LDAP server, Active Directory, database, or similar directory server
- a system that generates and passes a trusted token around to applications for the purposes of authentication.
- Sometimes, the term SSO is used to describe signing into applications with a password manager.
- Before 2005, SSO might have been used to mean a common set of credentials were used across multiple systems (probably with some type of asynchronous password synchronization system), but those credentials had to be provided by the user to log into each separate system — in some contexts, this is probably still the case.
- Federation as described below.

Single Sign On (SSO) deals with authentication and the technical interoperability of the actors involved to provide the common login credentials across systems.

A Directory Server-based SSO solution for multiple applications looks something like the following diagram.

![](https://miro.medium.com/v2/resize:fit:720/format:webp/1*ALkR_UAeylUfqOh-2kVbrg.jpeg)

SSO thru a common directory server

Another SSO example is N Service Providers (SPs) within an organization trusting a single Identity Provider (IdP) looks something like the following (this is actually identity federation, see next section).

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*3YtOQ_nk8K7sJvvp.)

## Federation

<https://medium.com/@robert.broeckelmann/authentication-vs-federation-vs-sso-9586b06b1380>

Federated Identity Management is a sub-discipline of IAM, but typically the same team(s) is involved in supporting it. Federation is a type of SSO where the actors span multiple organizations and security domains.

From the WS-Federation spec (one of numerous SSO protocols that enable federation) we have, “The goal of federation is to allow security principal identities and attributes to be shared across trust boundaries according to established policies.” This is a good description of federation in general; it involves having common standards and protocols to manage and map user identities between Identity Providers across organizations (and security domains) via trust relationships (usually established via digital signatures, encryption, and PKI). Federation is the trust relationship that exists between these organizations; it is concerned with where the user’s credentials are actually stored and how trusted third-parties can authenticate against those credentials without actually seeing them.

The federation relationship can be accomplished through one of several different protocols including (but, not limited to):

SAML1.1
SAML2
WS-Federation
OAuth2
OpenID Connect
WS-Trust
Various proprietary protocols

Federation can take many forms. Within an organization (departments, business units), the patterns could look like:

- N Service Providers (SPs) within an organization trusting a single Identity Provider (IdP) — see diagram in the last section.
- N SPs across multiple organizations trusting a single third-party IdP

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*MIQRD-2qBWymhNGH.)

- N IdPs within an organization trusted by one SP.

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*U_luEWMtav1awI-0.)

- N IdPs within an organization trusting a single IdP

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*vwyM2hveNsDHkLkh.)

- N SPs (let’s call them API Providers) across multiple organizations trusting a single IdP, which is then trusted by a common system (such as an API Gateway)

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/0*jyfFpqRwiFZq_rgc.)

- Identity Broker (IdP managing relationships between) with N SPs and N IdPs spanning multiple organizations with interrelated federation relationships.

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/0*19tAwa8YIaTNZyP7.)

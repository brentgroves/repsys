# Introduction to Keystone Federation

## references

<https://docs.openstack.org/keystone/latest/admin/federation/introduction.html>

<https://docs.openstack.org/keystone/latest/admin/federation/introduction.html#what-is-keystone-federation>

<https://diurnal.st/2021/07/17/openstack-keystone-federation-part-1.html#:~:text=Keycloak%20keeps%20track%20of%20all,about%20the%20user%20from%20Keycloak>.

## What is keystone federation?

Identity federation is the ability to share identity information across multiple identity management systems. In keystone, this is implemented as an authentication method that allows users to authenticate directly with another identity source and then provides keystone with a set of user attributes. This is useful if your organization already has a primary identity source since it means users don’t need a separate set of credentials for the cloud. It is also useful for connecting multiple clouds together, as we can use a keystone in another cloud as an identity source. Using LDAP as an identity backend is another way for keystone to obtain identity information from an external source, but it requires keystone to handle passwords directly rather than offloading authentication to the external source.

Keystone supports two configuration models for federated identity. The most common configuration is with keystone as a Service Provider (SP), using an external Identity Provider, such as a Keycloak or Google, as the identity source and authentication method. The second type of configuration is “Keystone to Keystone”, where two keystones are linked with one acting as the identity source.

This document discusses identity federation involving a secondary identity management that acts as the source of truth concerning the users it contains, specifically covering the SAML2.0 and OpenID Connect protocols, although keystone can work with other protocols. A similar concept is external authentication whereby keystone is still the source of truth about its users but authentication is handled externally. Yet another closely related topic is tokenless authentication which uses some of the same constructs as described here but allows services to validate users without using keystone tokens.

## **[keystone](https://www.reddit.com/r/openstack/comments/ml0oxe/keystone_as_a_standalone_identity_service/)**

- Definitely you should aim towards keycloak or dex. The first being more generalistic, the later made towards kubernetes.
OpenStack Keystone is less of an identity provider (like IAM) and was exclusively built to cater access in OpenStack. Some parts necessary to build an IAM are missing, hence why people rely on LDAP-like directories to cover those gaps.
However, if your goal is to secure services I would steer towards an API Gateway like Kong.
If you have a running OpenStack environment and want to interconnect it with external services, I would also suggest to rely on either of those solutions (or even a combination of both).

- re: "Authentication/Authorization solution"I've been using the RHEL/CentOS deploy of IPA (FreeIPA) for several years, and it's been rock-solid. There are ansible builds for it these days. I feed the LDAP hooks into keystone and manage identity for groups/projects in IPA.

- We use FreeIPA/LDAP for our own internal OpenStack and other systems as well! It has worked well for us as a source of truth for identities in OpenStack and other software and applications.
I don't have experience for how this applies to Kubernetes, but I agree it seems like the better approach is to use Keystone's federation features to use something else as your Identity Provider and have Keystone refer to it.

## Final design

Ultimately, we decided on a design that uses Keycloak as a central identity provider. Keycloak keeps track of all users, projects (groups) and the group memberships. From an application like Keystone’s perspective, Keycloak serves as the OpenID Provider (OP). The applications use standard OpenID Connect authentication flows to log in the user and obtain some claims about the user from Keycloak. Project memberships are included in claims so that at login time, the client application knows what projects the user belongs to. This is particularly important for Keystone, which has no support for fetching user information after login (via, e.g. OpenID’s UserInfo endpoint).

Keystone needed several adjustments to properly integrate with our design, which demanded more from the system than it could support by default. The rest of this post goes into detail about those modifications. OpenStack is open source, let’s take advantage of that fact!

## A brief guide to Keystone federation

**[Keystone’s](https://docs.openstack.org/keystone/latest/admin/federation/introduction.html#what-is-keystone-federation)** own documentation will do a far better job than I of explaining what federated identity is in general, and how Keystone supports it. The main thing to know is that Keystone supports registering a mapping, expressed as a JSON file following a defined schema, which describes how OpenID Connect (OIDC) or SAML claims should map to Keystone entities. A claim is some metadata that is attached to the authentication token generated by the identity provider, and typically has some basic information about the user, such as their username, email address, and possibly other contact details. The specifics are ultimately up to the identity provider. This means that if you control the identity provider implementation, you have a lot of options open to you. Claims for OIDC are encoded as JSON Web Tokens (JWTs), so they can look something like this:

{
  "FirstName": "James",
  "LastName": "Kirk",
  "Email": "<jameskirk@example.com>",
  "Groups": ["Staff", "Bridge"]
}

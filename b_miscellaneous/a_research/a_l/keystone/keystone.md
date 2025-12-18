# **[keystone](https://docs.openstack.org/keystone/latest/admin/federation/introduction.html)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## What is keystone federation?

Identity federation is the ability to share identity information across multiple identity management systems. In keystone, this is implemented as an authentication method that allows users to authenticate directly with another identity source and then provides keystone with a set of user attributes. This is useful if your organization already has a primary identity source since it means users don’t need a separate set of credentials for the cloud. It is also useful for connecting multiple clouds together, as we can use a keystone in another cloud as an identity source. Using LDAP as an identity backend is another way for keystone to obtain identity information from an external source, but it requires keystone to handle passwords directly rather than offloading authentication to the external source.

Keystone supports two configuration models for federated identity. The most common configuration is with keystone as a Service Provider (SP), using an external Identity Provider, such as a Keycloak or Google, as the identity source and authentication method. The second type of configuration is “Keystone to Keystone”, where two keystones are linked with one acting as the identity source.

This document discusses identity federation involving a secondary identity management that acts as the source of truth concerning the users it contains, specifically covering the SAML2.0 and OpenID Connect protocols, although keystone can work with other protocols. A similar concept is external authentication whereby keystone is still the source of truth about its users but authentication is handled externally. Yet another closely related topic is tokenless authentication which uses some of the same constructs as described here but allows services to validate users without using keystone tokens.

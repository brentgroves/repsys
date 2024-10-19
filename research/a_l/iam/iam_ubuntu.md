# **[Announcing Authd: OIDC authentication for Ubuntu Desktop and Server](https://ubuntu.com/blog/authd-oidc-authentication-for-ubuntu-desktop-server)**

**[Back to Go Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Today we are announcing the general availability of Authd, a new authentication daemon for Ubuntu that allows direct integration with cloud-based identity providers for both Ubuntu Desktop and Server. Authd is available free of charge on Ubuntu 24.04 LTS.

At launch, Authd supports Microsoft Entra ID (formerly Azure Active Directory) identity provider, with additional providers, including a white label OIDC provider, to be introduced in the future.

Bringing Ubuntu authentication to the cloud

![ca](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,c_fill,w_706,h_436/https://lh7-rt.googleusercontent.com/docsz/AD_4nXevBk70aC1lMKwx7y4BtGm5teiIamWwHEWKMKgMTsp1bFdGTgaDayWMVgX1ZZ4x5fzkxu5zkYiy2Ipw2maDrsJB6_3TatbCmTUtA_0HVmcAI60jJMJnYGcA667oEUJBA9_JlBnrPCiXhOvhKNNlhFHAuq-g?key=Prtis2qTky8oDWzzmW2Qdw)

Identity management is one of the most important control areas for any organisation and cloud based identity providers have seen a meteoric rise in popularity due to the ability to improve the strength and confidence of authentication events, while simultaneously decreasing the operational complexity, especially in remote working and hybrid cloud scenarios.

Linux workstations and servers have notoriously been one of the primary reasons why organisations hold back from completing a full transition to cloud based identity providers, and support for Entra ID, Okta and Google has constantly been one of the most requested enterprise features on both Ubuntu Desktop and Server.

Our first attempt at solving this issue was the AAD Auth package, which we released as part of Ubuntu Desktop 23.04. While the package allowed us to meet some of the intended use cases for Azure AD, we realised that its design was not compatible with Ubuntu Server, hampered the ability to use stronger authentication mechanisms and required significant effort to be extended to additional identity providers like Okta and Google.

When designing Authd it was very important for us to address the aforementioned shortcomings, while simultaneously providing a way for identity providers to extend our solution by supporting their platform-specific features. We achieved these goals by creating a modular solution, consisting of a daemon plus a series of brokers, which relies on the Oauth Device Authorisation Grant to obtain access tokens from the clouds.

## Oauth Device Authorisation Grant

The Oauth Device Authorization Grant (formerly known as the Device Flow) is an Oauth extension that was initially conceived to enable devices with no browser or limited input capability to obtain an access token. The Device Authorization Grant is commonly seen on TV streaming apps or smart appliances where the device instructs the user to open a URL on a secondary device such as a smartphone or computer in order to complete the authorization.

We decided to base our solution on the Oauth Device Authorization Grant because:

- It is an open standard (RFC 8628) that is supported by the vast majority of enterprise and consumer identity providers
- No direct communication channel is required between the Ubuntu machine and the user secondary device. When the authentication process is initiated the Ubuntu device begins polling the identity - provider Authorization Server for an Access Token
- It allows for a consistent user experience across Ubuntu Desktop (on GDM) and Server (on the CLI)
You can read more about the Oauth Device Authorization Grant on the Oauth website.

## What is Authd

Authd is an authentication daemon for cloud-based identity providers. It helps ensure the secure management of identity and access for Ubuntu machines anywhere in the world, on desktop and the server. Authd's modular design makes it a versatile authentication service that can integrate with multiple identity providers. MS Entra ID is currently supported and several other identity providers are under active development.

## Limitations

- Core directory services and application access management are missing from basic linux commands.

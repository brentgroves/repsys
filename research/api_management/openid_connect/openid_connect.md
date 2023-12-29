# OpenID Connect

## references

<https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect>

## OpenID Connect (OIDC): The Best of Both Worlds

OpenID Connect is an authentication protocol that extends OAuth 2.0 and can be utilized for sign-on purposes. It facilitates the verification of user identity by clients through an authorization server. OpenID Connect combines elements from both OpenID and OAuth:

It employs OAuth 2.0 flows for the authentication request and response enabling a seamless single sign-on experience similar to OpenID. Additionally, it incorporates an OAuth 2.0 token that allows clients to access APIs and retrieve user information.

Consequently, OpenID Connect offers both identity verification and delegated authorization capabilities enabling clients to securely access user data. By augmenting OAuth 2.0 with an identity layer featuring user profile claims OpenID Connect provides a means of achieving single sign-on functionality on top of the authorization framework offered by OAuth.

## About security hardening with OpenID Connect

In this article
Overview of OpenID Connect
Configuring the OIDC trust with the cloud
Updating your actions for OIDC
Customizing the token claims
Updating your workflows for OIDC
Enabling OpenID Connect for Python package publishing
Enabling OpenID Connect for your cloud provider

OpenID Connect allows your workflows to exchange short-lived tokens directly from your cloud provider.

## Overview of OpenID Connect

GitHub Actions workflows are often designed to access a cloud provider (such as AWS, Azure, GCP, or HashiCorp Vault) in order to deploy software or use the cloud's services. Before the workflow can access these resources, it will supply credentials, such as a password or token, to the cloud provider. These credentials are usually stored as a secret in GitHub, and the workflow presents this secret to the cloud provider every time it runs.

However, using hardcoded secrets requires you to create credentials in the cloud provider and then duplicate them in GitHub as a secret.

With OpenID Connect (OIDC), you can take a different approach by configuring your workflow to request a short-lived access token directly from the cloud provider. Your cloud provider also needs to support OIDC on their end, and you must configure a trust relationship that controls which workflows are able to request the access tokens. Providers that currently support OIDC include Amazon Web Services, Azure, Google Cloud Platform, and HashiCorp Vault, among others.

Benefits of using OIDC
By updating your workflows to use OIDC tokens, you can adopt the following good security practices:

No cloud secrets: You won't need to duplicate your cloud credentials as long-lived GitHub secrets. Instead, you can configure the OIDC trust on your cloud provider, and then update your workflows to request a short-lived access token from the cloud provider through OIDC.
Authentication and authorization management: You have more granular control over how workflows can use credentials, using your cloud provider's authentication (authN) and authorization (authZ) tools to control access to cloud resources.
Rotating credentials: With OIDC, your cloud provider issues a short-lived access token that is only valid for a single job, and then automatically expires.

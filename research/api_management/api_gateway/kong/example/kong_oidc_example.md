# Kong API Gateway Example

While the big Cloud vendors provide their own API Gateways as part of more ambitions API Management Platforms, there are several Open Source API Gateway alternatives that have the additional benefit of being cloud/on premise agnostic. One of the more popular Open Source choices is Kong Gateway. As with many OS products, the community edition is free for use but lacks some of the premium features found in the Enterprise edition. The community edition is however capable enough to be an excellent starting point for getting the toes wet with API Management.

## references

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>

<https://github.com/revomatico/docker-kong-oidc>
<https://github.com/revomatico/kong-oidc>

## AUTHENTICATION AND AUTHORIZATION USING KONG GATEWAY

In this first post, we’ll show how to use the Kong Gateway to enforce a couple of different authentication and authorization strategies:

- End user authentication and authorization using OpenID Connect.
- Server authentication and authorization using OAuth 2.0 Client Credentials.

As usual, we’ll use docker containers and docker compose to minimize the installation requirements while hiding irrelevant details to focus on the essential configuration required. The fully working example can be found in the Github repository. Note: Since the project uses Git submodules, it should be checked out with the --recursive flag to recursively also fetch the submodules:

```bash
git clone --recursive https://github.com/callistaenterprise/blog-api-gateway-kong
```

## END USER AUTHENTICATION AND AUTORIZATION USING OPENID CONNECT

Modern APIs that rely on end user’s access rights typically uses OAuth 2.0 with OpenID Connect (OIDC) for authentication and authorization. Details about OAuth 2.0 and OIDC can be found in numerous blogs (see e.g. **[curity.io](https://curity.io/resources/learn/openid-code-flow)** or **[OpenID Connect Authorization Code Flow](../../../openid_connect/authorization_code_flow.md)**), so we won’t repeat that here. It is sufficient to say that a mechanism for enforcing OIDC-based authentication and authorization must be able to detect sessions that are not already authenticated, and redirect those users to an appropriate login mechanism. Once the user has authenticated, the resulting access token (and potentially also a corresponding refresh token) should be managed and forwarded to the underlying API. No API calls must be allowed without a valid access token.

In Kong Gateway, externalizing a cross-cutting concern such as this is done using a Plugin which is declaratively configured to be applied to one or more Services or Routes or globally. Plugins in Kong are normally written in Lua, and the different Kong editions comes with different subsets of standard plugins (see Kong Hub). While the official Kong openid-connect plugin is only available in the Kong Enterprise Edition, there is a lightweight and excellent OS alternative kong-oidc plugin maintained by Nokia which implements the OIDC Relying Party functionality.

**[Relying Party](https://openid.net/developers/how-connect-works/)** (RP). RP stands for Relying Party, an application or website that outsources its user authentication function to an IDP.

## PRELIMINARY SETUP: AN EXAMPLE UPSTREAM API

For simplicity, we’ll use an existing docker image to simulate an upstream API, onto which we shall apply access control. The echo-server implements a generic http-based api, echoing request headers and body back to the caller:

```yaml
services:

  upstream:
    image: ealen/echo-server
```

The API is available on port 80, but we are not exposing this port on the host network. It should only be available via the Kong gateway that we are about to add soon (which will use the docker-internal upstream:80 address to proxy the API).

## PRELIMINARY SETUP: AN EXAMPLE OAUTH 2.0/OIDC SERVER

We’ll use a Keycloak docker container as OAuth 2.0/OIDC server.

<https://www.hcl-software.com/blog/versionvault/how-to-configure-microsoft-azure-active-directory-as-keycloak-identity-provider-to-enable-single-sign-on-for-hcl-compass>

<https://www.keycloak.org/2017/03/how-to-setup-ms-ad-fs-30-as-brokered>

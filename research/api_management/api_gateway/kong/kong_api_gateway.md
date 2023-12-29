# Kong API Gateway

## references

<https://www.predictiveanalyticstoday.com/kong/#:~:text=Kong%20Community%20Edition%20offers%20features,Health%20Checks%20and%20Community%20Support>.

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>

<https://github.com/nokia/kong-oidc>

## Kong Review

Kong is a most widely adopted open-source Microservice API gateway which makes securing, managing and orchestrating microservice APIs easier and faster than ever. Kong features Kong Community Edition which offers a blazingly fast open source microservice API gateway and Kong Enterprise Edition which is microservice API platform for large organizations.

Kong Community Edition offers features such as API & Microservices Gateway, Open-Source Plugins, Load Balancing, Service Discovery, Health Checks and Community Support. Kong Enterprise Edition offers features such as Powerful One-Click Operations, Manage Kong Cluster, Manage Kong Plugins, Manage APIs, Manage Consumers, Admin RBAC, Open ID Connect, Oauth 2.0 Introspection.

Interactive API Documentation, Developer Management, Flexible Customization, Import API Documentation, Data Backup, Real-Time Monitoring, Real-Time Data Visualization, API and Consumer Activity, Cache Utilization, Quota Metering, High Availability Rate Limiting, Advanced Service Routing, Edge Caching, Request Collapsing, Professional Support 24x7x365, Kong Success Engineer, Onsite Solution Architects, Migration Assistance and Custom Plugins.

Kong is built on top of NGINX so it can be fully operated with a simple and easy to use RESTful API. Tweaking the Nginx configuration is an essential part of setting up Kong instances since it allows the user to optimize its performance for the user’s infrastructure, or embed Kong in an already running OpenResty instance.

The user can put services behind Kong and add powerful functionality through Kong Plugins, in one command. Kong is available to install in multiple operating environments like docker, kubernetes, dc/os, amazon linux, centos, redhat, debian, Ubuntu, os x, awsmarketplace, aws cloudformation, Google cloud platform, vagrant and source.

## API GATEWAYS

An API Gateway product is a software component or framework that implements the API Gateway pattern. It acts as a common entry point for underlying APIs, and allows various common capabilities to be applied to the API interactions. By externalizing common, cross-cutting concerns (such as enforcing an autentication and authorization policy) a uniform and well tested implementation can be used for multiple APIs, while at the same time simplifying the underlying APIs. Technically, the API Gateway functions as a Reverse Proxy, and not surprisingly, several of the Open Source API Gateway products are built on top of a solid Reverse Proxy product.

![](https://i.ytimg.com/vi/4NB0NDtOwIQ/maxresdefault.jpg)

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>

While the big Cloud vendors provide their own API Gateways as part of more ambitions API Management Platforms, there are several Open Source API Gateway alternatives that have the additional benefit of being cloud/on premise agnostic. One of the more popular Open Source choices is Kong Gateway. As with many OS products, the community edition is free for use but lacks some of the premium features found in the Enterprise edition. The community edition is however capable enough to be an excellent starting point for getting the toes wet with API Management

AUTHENTICATION AND AUTHORIZATION USING KONG GATEWAY
In this first post, we’ll show how to use the Kong Gateway to enforce a couple of different authentication and authorization strategies:

- End user authentication and authorization using OpenID Connect.
- Server authentication and authorization using OAuth 2.0 Client Credentials.

As usual, we’ll use docker containers and docker compose to minimize the installation requirements while hiding irrelevant details to focus on the essential configuration required. The fully working example can be found in the Github repository. Note: Since the project uses Git submodules, it should be checked out with the --recursive flag to recursively also fetch the submodules:

```bash
git clone --recursive https://github.com/callistaenterprise/blog-api-gateway-kong
```

END USER AUTHENTICATION AND AUTORIZATION USING OPENID CONNECT
Modern APIs that rely on end user’s access rights typically uses OAuth 2.0 with OpenID Connect (OIDC) for authentication and authorization. Details about OAuth 2.0 and OIDC can be found in numerous blogs (see e.g. curity.io), so we won’t repeat that here. It is sufficient to say that a mechanism for enforcing OIDC-based authentication and authorization must be able to detect sessions that are not already authenticated, and redirect those users to an appropriate login mechanism. Once the user has authenticated, the resulting access token (and potentially also a corresponding refresh token) should be managed and forwarded to the underlying API. No API calls must be allowed without a valid access token.

In Kong Gateway, externalizing a cross-cutting concern such as this is done using a Plugin which is declaratively configured to be applied to one or more Services or Routes or globally. Plugins in Kong are normally written in Lua, and the different Kong editions comes with different subsets of standard plugins (see Kong Hub). While the official Kong openid-connect plugin is only available in the Kong Enterprise Edition, there is a lightweight and excellent OS alternative kong-oidc plugin maintained by Nokia which implements the OIDC Relying Party functionality.

<https://github.com/nokia/kong-oidc>

## PRELIMINARY SETUP: AN EXAMPLE UPSTREAM API

For simplicity, we’ll use an existing docker image to simulate an upstream API, onto which we shall apply access control. The echo-server implements a generic http-based api, echoing request headers and body back to the caller:

```yaml
services:

  upstream:
    image: ealen/echo-server

```

The API is available on port 80, but we are not exposing this port on the host network. It should only be available via the Kong gateway that we are about to add soon (which will use the docker-internal upstream:80 address to proxy the API).

PRELIMINARY SETUP: AN EXAMPLE OAUTH 2.0/OIDC SERVER
We’ll use a Keycloak docker container as OAuth 2.0/OIDC server.

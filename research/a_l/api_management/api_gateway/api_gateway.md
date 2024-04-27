# API Gateway

API gateways are becoming increasingly more popular, and for good reasons. As the number of APIs within an organisation grows, the amount of “plumbing” required to expose the APIs in a secure, efficient and maintainable way quickly becomes overwhelming. An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented. In this blog series, we’ll be demonstrating how to use Kong, one of the leading Open Source API Gateways, to add various common capabilities to an API.

API GATEWAYS
An API Gateway product is a software component or framework that implements the API Gateway pattern. It acts as a common entry point for underlying APIs, and allows various common capabilities to be applied to the API interactions. By externalizing common, cross-cutting concerns (such as enforcing an autentication and authorization policy) a uniform and well tested implementation can be used for multiple APIs, while at the same time simplifying the underlying APIs. Technically, the API Gateway functions as a Reverse Proxy, and not surprisingly, several of the Open Source API Gateway products are built on top of a solid Reverse Proxy product.

While the big Cloud vendors provide their own API Gateways as part of more ambitions API Management Platforms, there are several Open Source API Gateway alternatives that have the additional benefit of being cloud/on premise agnostic. One of the more popular Open Source choices is Kong Gateway. As with many OS products, the community edition is free for use but lacks some of the premium features found in the Enterprise edition. The community edition is however capable enough to be an excellent starting point for getting the toes wet with API Management.

## references

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>
<https://nordicapis.com/6-open-source-api-gateways/>

## Kong Gateway (Open Source)

Kong Gateway (OSS) is a popular open-source API gateway due to its slick interface, vibrant community, cloud-native architecture, and extensive features. It’s also extremely fast and lightweight. Kong also has ready-made deployments for many popular container and cloud-based environments, from Docker to Kubernetes to AWS. This allows you to easily integrate Kong into your existing workflow, making the learning curve much less steep.

Kong supports logging, authentication, rate limiting, failure detection, and much more. Even better, it has its own CLI, so you can manage and interact with Kong directly from the command line. You can install the open-source community Kong Gateway on various distributions. Basically, Kong has everything you could want from an API gateway.

## Tyk Open-Source API Gateway

<https://github.com/TykTechnologies/tyk#tyk-api-gateway>

Tyk has been called the “industry-best API gateway.” Unlike other API gateways on our list, Tyk is indeed open-source — not just open-core or freemium. It offers an impressive array of features and functions for an open-source solution. Like Kong, Tyk is also cloud-native and has many plugins available. Tyk can even be used to publish your own APIs in both REST and GraphQL formats.

Tyk has native support for many features, including various forms of authentication, quotas, rate limiting, and versioning. It can even generate API documentation. Most impressively of all, Tyk features an API developer portal that lets you publish managed APIs, so third parties can sign up for your APIs and even manage their API keys. It’s rather incredible how much Tyk offers with its open-source API gateway.

Tyk Gateway is the cloud-native, open source, API Gateway.
We support REST, GraphQL, TCP and gRPC protocols.

Built from the ground up, as the fastest API Gateway on the planet since 2014.

Tyk Gateway is provided ‘Batteries-included’, with no feature lockout. Enabling your organization to rate limit, auth, gather analytics, apply microservice patterns and more with ease.

Tyk runs natively on Kubernetes, if you prefer, thanks to the Tyk Kubernetes Operator

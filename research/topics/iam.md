# **[Is it a good idea to use Auth0 to authenticate and authorize report system users?](../a_l/istio/authentication_and_authorization.md)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## references

- **[Authenticating and Authorizing end-users with Istio and Auth0](https://auth0.com/blog/securing-kubernetes-clusters-with-istio-and-auth0/)**
- **[Istio Authentication and Authorization](../a_l/istio/authentication_and_authorization.md)**
- **[Authenticating and Authorizing end-users with Istio and Auth0 in Azure AKS](../../../azure/mobexglobal.com/aks/istio_auth0.md)**

## Preface

Security is the most crucial aspect to get right in every application. Failing to secure your apps and the identity of your users can be very expensive. Moreover, it can make customers and investors lose faith in your ability to deliver high-quality services. Therefore, it's of paramount importance to strictly follow standards and best practices when developing an application. Luckily, big vendors like Auth0, Microsoft, Facebook, and Google can simplify this task by working as the identity providers of your apps. These companies, alongside increased security, also enable users to quickly log in to your apps without having to create yet another set of credentials.

Authentication and authorization are more complex for microservice architectures, as they require implementation on every service. The scenario can become even more problematic if you use different stacks to build these microservices. For each stack, you would have a different set of best practices and libraries to use (probably even write), increasing the surface area of possible bugs and consuming company resources that could be invested in providing business value.

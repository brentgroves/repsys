# **[Request Level Authentication and Authorization with Istio and Keycloak](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[video](https://www.infracloud.io/cloud-native-talks/request-level-authentication-istio-keycloak/)**

Kubernetes has made it easier to manage containerized microservices at scale. However, you get a limited set of security features with Kubernetes. A key component of application security is the prevention of unauthorized access. Standards-based identity and access management (IAM) for user authentication, such as SAML, WS-Fed, or the OpenID Connect/OAuth2 standards have to be used to ensure secure access to the application. Multi-factor authentication (MFA) can also be implemented as an additional security measure.

Yet there is no native way to implement these security features in Kubernetes. Even crucial security aspects like request-level authentication and authorization are not supported out of the box.

This is where tools like service mesh help us. From routing, traffic shaping, observability, and security, a service mesh comes with many useful features that your developers can add to your application without building them from scratch. You can read our blog post to **[learn about service mesh](https://www.infracloud.io/blogs/service-mesh-101/)** and its features in detail.

In this blog post, we will talk about two security features of service mesh – request level authentication and authorization. Later in the article, we will implement request level authentication and authorization using Istio service mesh and Keycloak. If you prefer videos, you can watch our webinar with CNCF on securing requests with Keycloak and Istio through request-level authentication.

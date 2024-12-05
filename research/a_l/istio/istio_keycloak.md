# **[Request Level Authentication and Authorization with Istio and Keycloak](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/#:~:text=Istio%20performs%20request%20level%20authentication,accept%20the%20end%20user%20request.)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Kubernetes has made it easier to manage containerized microservices at scale. However, you get a limited set of security features with Kubernetes. A key component of application security is the prevention of unauthorized access. Standards-based identity and access management (IAM) for user authentication, such as SAML, WS-Fed, or the OpenID Connect/OAuth2 standards have to be used to ensure secure access to the application. Multi-factor authentication (MFA) can also be implemented as an additional security measure.

Yet there is no native way to implement these security features in Kubernetes. Even crucial security aspects like request-level authentication and authorization are not supported out of the box.

This is where tools like service mesh help us. From routing, traffic shaping, observability, and security, a service mesh comes with many useful features that your developers can add to your application without building them from scratch. You can read our blog post to **[learn about service mesh and its features in detail](https://www.infracloud.io/blogs/service-mesh-101/)**.

In this blog post, we will talk about two security features of service mesh – request level authentication and authorization. Later in the article, we will implement request level authentication and authorization using Istio service mesh and Keycloak. If you prefer videos, you can watch our webinar with CNCF on **[securing requests with Keycloak and Istio through request-level authentication](https://www.infracloud.io/cloud-native-talks/request-level-authentication-istio-keycloak/)**.

## **What is request level authentication and authorization?**

Most applications use a modern web framework and offer one or more API endpoints to allow users, programs, and other applications to access your application. These API endpoints provide the below functionalities:

- Allow your application users to access data on your server through a browser or a mobile app.
- End users and other programs can get programmatic access to data managed by your application.
- Enable & manage communication among different services of your application.

These API endpoints can be abused or misused if accessed by unauthorized users. Your application should have a mechanism in place to authenticate and authorize end users and allow access to authenticated requests only.

This process of validating the credentials each request carries is called request level authentication. Request level authorization is the process of allowing access to resources based on the legitimacy of credentials in the request.

One of the most popular methods for request level authentication and authorization is JWT (JSON Web Token) authentication.

## JWT(JSON Web Token) authentication

JSON Web Token (JWT) is a popular open source authentication standard, that defines a comprehensive way for transmitting data between parties securely in the form of a JSON object. This information shared between parties can be verified and trusted because it is signed digitally using a strong encryption mechanism.

JSON Web Tokens (JWT) are made up of three components:

- **Header:** It specifies the algorithm used for encrypting the token’s content.
- **Payload:** It contains information the token securely transmits, also known as claims.
- **Signature:** It is used to verify the authenticity of the payload.
You can read more about **[JWT tokens](https://jwt.io/introduction)**.

## Istio and JWT

**[Istio](https://istio.io/latest/about/service-mesh/)** is one of the most popular and widely used service mesh. It comes with many features that help you to efficiently monitor and secure your services. From a security point of view, one feature that plays a critical role is the ability to validate the JWT attached to the end-user requests.

Before end-user requests hit your application, Istio will:

- Validate and verify JWT attach to the end-user request.
- Forward only authenticated requests to the application.
- Deny access to unauthenticated requests.

This security feature of Istio is very useful in offloading authentication and authorization logic from your application code. You don’t have to worry about writing the authentication code yourself. Istio will manage the authentication part by validating the JWT token present in the request header.

## Popular authentication providers for JWT

There are many authentication providers available, and you can select any one of them depending on your project’s requirements. Here are the few popular authentication providers which support JWT.

- Auth0: Auth0 is the most popular and well-established authentication provider for integrating your application for authentication and authorization. Auth0 comes with a free tier as well which covers most of the things required for authentication and authorization for your application.

- **Firebase Auth:** Firebase Auth is another popular authentication service provider that allows you to add authentication and authorization to your application. Firebase allows you to add sign-in methods such as identity providers including Google, Facebook, email and password, and phone number.

- **Google Auth:** Google OIDC is one of the well-known authentication providers which you can use for both authentication and authorization.

- **KeyCloak:** Keycloak is a popular open source authentication service provider. Keycloak provides all the features that a typical authentication provider does. Setting up and using Keycloak is fairly straightforward, as we will see it in this blog post.

|               | Open Source | SSO Support | JWT Support |
|---------------|-------------|-------------|-------------|
| Auth0         | No          | Yes         | Yes         |
| Firebase Auth | No          | Yes         | Yes         |
| Google Auth   | No          | Yes         | Yes         |
| Keycloak      | Yes         | Yes         | Yes         |

## What is Keycloak?

Keycloak is an open source authentication service provider and identity and access management tool that lets you add authentication and authorization to applications. It provides all the native authentication features including user federation, SSO, OIDC, user management, and fine-grained authorization.

## Istio request authentication and authorization

In Istio, **[RequestAuthentication](https://istio.io/latest/docs/reference/config/security/request_authentication/)** is used for end-user authentication. It is a custom resource that defines methods for validating credentials attached to the requests. Istio performs request level authentication by validating JWT attached to the requests.

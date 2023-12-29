# What is API management

## references

<https://www.integrate.io/blog/api-management-tools/>

<https://medium.com/@robert.broeckelmann/keeping-your-apis-secure-for-multiple-user-types-d5c627793c4c>

## Keeping Your APIs Secure for Multiple User Types

<https://medium.com/@robert.broeckelmann/keeping-your-apis-secure-for-multiple-user-types-d5c627793c4c>

In an enterprise API management platform (or any enterprise platform, really), it’s likely that applications acting on behalf of customers and consumers (B2C), internal business units and employees (B2E), and external organizations and their employees (B2B), are functioning as both API providers and API consumers.

In many cases, applications acting at the behest of consumers will also represent the largest group of API consumers.

## Multiple user communities at runtime

To that end, these systems must be able to securely support multiple user communities in a way that does not increase complexity while allowing for scalability, availability, reliability, and all those other words ending in “-ability” that are associated with robust IT systems.

Let’s use an API management platform as our target system of interest. Further, assume there is an internet-facing API gateway that handles the authentication and authorization requirements of the backend API providers — a fairly typical situation.

## A user community could be defined in one of two ways

- Business perspective: a group of users such as all internal employees, users that are part of B2B vendors/suppliers, or customers.

- Technology perspective: users within a single LDAP repository, active directory domain, or similar user repository.

Within an API management solution, the concepts of authentication and authorization come up in several contexts: developert portal (authentication of the developer populations, B2E and B2B), management portal (authentication of API gateway administrators and API developers), and runtime API traffic (the focus of what I’ve been writing much about lately). In this post, the primary use case is working with multiple user communities at runtime when APIs are being invoked.

I’ve used the terms identity provider, OAuth server, federation server, OAuth authorization server, and user repository many times while writing about identity concerns. Sometimes I’m not as disciplined as I should be in my use of these terms (I’ve used “identity provider and “federation server” interchangeably many times, for instance). For this conversation, more discipline is needed. To that end, let’s formally define:

Identity provider: the combination of a federation server and user repository (and possibly other identity stack components needed to enable these two systems to function properly)

Federation server: a service that can issue, validate, and invalidate security tokens. Security tokens are a collection of claims that are usually digitally signed (and, possibly, encrypted) such as SAML2 assertions or JWT tokens

User repository: a system that stores user and group information such an LDAP server or active directory domain

OAuth2 authorization server: a concept that is defined by the OAuth2 spec; an identity provider that supports the OAuth2 protocol

OpenID (connect) provider: A concept that is defined by the OIDC spec; an identity provider that supports the OIDC protocol

## API Management Platforms

<https://www.integrate.io/blog/api-management-tools/>

Types of API Management Tools
When it comes to API management, there are several types of tools available. You may choose one or a combination of these tools depending on your business needs:

- API gateways: This type of tool can be used to manage authentication, authorization, and traffic routing to the appropriate backend services.
- API design and documentation tools: These tools help developers design, document, and test APIs before deploying them.
- API lifecycle management tools: These are complete tools that help manage the entire API lifecycle from design to retirement.
- API testing tools: Testing tools help developers test APIs for functionality, performance, and security. They can simulate user behavior, generate load, and detect bugs.

## 15 Top API Management Tools to Consider

Let’s explore some of the top API management tools available and how they can help you manage your APIs more efficiently.

1.Integrate.io
Rating: 4.3/5 (G2)

Key Features:

API generation
API customization
Custom scripting
Data mesh capabilities
Robust customer support
Integrate.io is a data pipeline platform with API generation and management capabilities that allow businesses to generate, manage, secure, and monitor their APIs to power their data products.

Its key features include automated API generation, complete customization, flexible authentication, simple custom scripting, and advanced data mesh capabilities.

Integrate.io also provides a comprehensive support system with resources like live chat and developer documentation. It is compatible with the most popular databases, including SQL Server, MySQL, Snowflake, or BigQuery.

The platform ensures data quality by providing total control over API design requirements while users can add modules/features as their projects grow. More than that, it provides scalability for small projects up to large-scale enterprise rollouts.

Integrate.io offers simple pricing. Plans start at $15,000 per year for a Starter plan and increase from there.

2.MuleSoft
Rating: 4.4/5 (G2)

Key Features:

Pre-built/custom security
Integrated access management
Service mesh for microservices
MuleSoft provides comprehensive API management capabilities that help organizations operate and scale their API programs efficiently. The platform offers an API gateway for unlocking and managing services securely, as well as a consistent management experience.

All of these features enable organizations to create an effective strategy for developing APIs with minimal effort while providing secure and high-performance management at scale.

MuleSoft pricing is complex. Pricing plans differ depending on your specific needs. For example, the Anypoint Flex Gateway cost will depend on the volume of API requests.

5.Microsoft Azure API Management
Rating: 4.2/5 (G2)

Key Features:

Authentication and other security features
Real-time data analytics
Simplified developer portal
Microsoft Azure API Management is a fully managed service that enables customers to publish, secure, transform, maintain, and monitor APIs. It helps in managing the full lifecycle of APIs from creation to consumption.

Some of Microsoft Azure API Management’s key features are related to:

Security: The platform includes security features such as authentication, authorization for every request, and rate-limiting capabilities.
Transformation: Azure API Management allows developers to transform web legacy services into powerful REST-based APIs.
Monitoring and analytics: The platform gives access to real-time analytics about usage patterns, traffic trends, error tracking, and more.  
Developer portal: The portal allows developers to register applications and get keys easily through an easy-to-use developer portal interface.

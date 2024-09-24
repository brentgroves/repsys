# **[Authentication](https://preliminary.istio.io/latest/docs/concepts/security/#authentication)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Authentication

Istio provides two types of authentication:

Peer authentication: used for service-to-service authentication to verify the client making the connection. Istio offers mutual TLS as a full stack solution for transport authentication, which can be enabled without requiring service code changes. This solution:

Provides each service with a strong identity representing its role to enable interoperability across clusters and clouds.
Secures service-to-service communication.
Provides a key management system to automate key and certificate generation, distribution, and rotation.
Request authentication: Used for end-user authentication to verify the credential attached to the request. Istio enables request-level authentication with JSON Web Token (JWT) validation and a streamlined developer experience using a custom authentication provider or any OpenID Connect providers, for example:

ORY Hydra
Keycloak
Auth0
Firebase Auth
Google Auth
In all cases, Istio stores the authentication policies in the Istio config store via a custom Kubernetes API. Istiod keeps them up-to-date for each proxy, along with the keys where appropriate. Additionally, Istio supports authentication in permissive mode to help you understand how a policy change can affect your security posture before it is enforced.

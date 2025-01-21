# Microsoft Entra group for AKS in the Azure resource group

The following is in markdown it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

## request

- **[Create a Microsoft Entra group called repsys](https://learn.microsoft.com/en-us/entra/fundamentals/groups-view-azure-portal#create-a-new-group)
- **[Add Brent Groves and Kevin Young to repsys group](https://learn.microsoft.com/en-us/entra/fundamentals/groups-view-azure-portal#add-a-group-member)**

## Reason

**[To enable Microsoft EntraID AKS authentication](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**

The AKS-managed Microsoft Entra integration simplifies the Microsoft Entra integration process. Previously, you were required to create a client and server app, and the Microsoft Entra tenant had to assign **[Directory Readers](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#directory-readers)** role permissions. Now, the AKS resource provider manages the client and server apps for you.

Cluster administrators can configure Kubernetes role-based access control (Kubernetes RBAC) based on a user's identity or directory group membership. Microsoft Entra authentication is provided to AKS clusters with OpenID Connect. OpenID Connect is an identity layer built on top of the OAuth 2.0 protocol. For more information on OpenID Connect, see the **[OpenID Connect documentation](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc)**.

Learn more about the Microsoft Entra integration flow in the **[Microsoft Entra documentation](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-ad-integration)**.

## Service Now Info

- Configuration Request
  - Corporate Technical Services - General
  - Submitted : 2025-01-21 14:46:51
  - Request Number : REQ0186265

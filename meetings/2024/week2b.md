# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear to be better than your neighbor.  I say help your neighbor and especially help the ones that are struggling.

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

**Last meeting summary**,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin what software and hardware is needed to virtualize graphics intense software.
- Brad how what software does Fruitport machines use?
- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent G. Plex and Report System Federated with Microsoft Entra ID

## What is **[IAM](https://www.techtarget.com/searchsecurity/definition/identity-access-management-IAM-system)**, Identity and Access management?

Identity and access management (IAM) is a framework of business processes, policies and technologies that facilitates the management of electronic or digital identities. With an IAM framework in place, information technology (IT) managers can control user access to critical information within their organizations. Systems used for IAM include single sign-on systems, two-factor authentication, multifactor authentication and privileged access management. These technologies also provide the ability to securely store identity and profile data as well as data governance functions to ensure that only data that is necessary and relevant is shared.

IAM systems can be deployed on premises, provided by a third-party vendor through a cloud-based subscription model or deployed in a hybrid model.

On a fundamental level, IAM encompasses the following components:

- how individuals are identified in a system (understand the difference between identity management and authentication);
- how roles are identified in a system and how they are assigned to individuals;
adding, removing and updating individuals and their roles in a system;
- assigning levels of access to individuals or groups of individuals; and
- protecting the sensitive data within the system and securing the system itself.

## **[API Gateways](https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/)**

An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented.

Whenever a customer accesses any Repsys software it will be routed through **[Microsoft EntraID identity](https://www.microsoft.com/en-us/security/business/identity-access/microsoft-entra-id)** (formerly Azure Active Directory).

## Repsys **[IAM](https://en.wikipedia.org/wiki/Identity_management)**, Identity and Access Management

- Secure Web App, REST API, and report notification webhook using the **[Kong API gateway](https://konghq.com/products/kong-gateway)**.
- Use **[Keycloak](https://www.keycloak.org/)** for IAM.  
- Use Microsoft EntraID as an Identity Provider to Keycloak IAM platform.
- Register in Microsoft EntraID with an **[OpenID Connect, OIDC](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc#:~:text=OpenID%20Connect%20(OIDC)%20is%20an,who%20they%20say%20they%20are.)** scope.

# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear to be better than your neighbor.  I say help your neighbor and especially help the ones that are struggling. Do not worry about your own status.  Do not promote yourself instead think of others and help them in their work.

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

**Last meeting summary**,

Mach2 rebranded to Automation and Orchestration.
Brent H. discussed his understanding of Mach2 and Mobex Azure requirements.
Kevin talked about Plex IAM and discussed Mach2.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin something about Plex IAM.
- Brad something about Fruitport casters or other machines if you want :-)
- Sam something about Mach2 or Kep ServerEx or Fruitport caster code if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent H. something about Azure tenant migration.
- Brent G. Report System API Gateway, Azure Bastion

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

## What is **[Federated Identity](https://www.onelogin.com/learn/federated-identity#:~:text=Federated%20identity%20allows%20authorized%20users,different%20applications%20securely%20and%20efficiently)**

FIM is a secure system for user authorization, authentication, and digital identity management. When a user tries to access an application, they don’t provide their credentials to the SP. Instead, the SP “trusts” the IdP to validate these credentials and authorize the user. Thus, the user never provides their credentials to anyone but the IdP who securely stores and maintains their credentials.

Identity federation means being able to ingest identity credentials from external identity providers. This can be used to provide single sign-on (SSO) – a very useful capability. SSO allows a single authentication method to access different systems within external identity providers based on mutual trust.

## Active Directory B2C

<https://learn.microsoft.com/en-us/azure/active-directory-b2c/overview>

Azure Active Directory B2C provides business-to-customer identity as a service.
Your customers can use their preferred social, enterprise, or local account identities to get single sign-on access to your applications and APIs.

- New customizable User Flows such as signup and signin.
- New portal with new user interface
- Features isolated people groups as described in newer identity platform documents, ie. b2b,b2e, and b2c.  
- New entity type, Active Directory B2C, with new capabilities such as various signin user flows with the new GUI.

Can not yet test this with Microsoft Development Account since it requires a new tenant type.

## **[OpenID](https://konghq.com/blog/engineering/openid-vs-oauth-what-is-the-difference)** Authentication

OpenID is an open standard that enables decentralized digital identity, allowing users to log into different websites using the same identity provider. For example, there are SSO options where you can use your Google or Facebook account to sign in to various sites across the web, without needing to create new usernames and passwords for each one.

## **[OAuth2](https://auth0.com/intro-to-iam/what-is-oauth-2#:~:text=OAuth%202.0%2C%20which%20stands%20for,industry%20standard%20for%20online%20authorization.)** Authorization

OAuth 2.0, which stands for “Open Authorization”, is a standard designed to allow a website or application to access resources hosted by other web apps on behalf of a user. It replaced OAuth 1.0 in 2012 and is now the de facto industry standard for online authorization.

## **[OpenID Connect](https://konghq.com/blog/engineering/openid-vs-oauth-what-is-the-difference)** (OIDC): The Best of Both Worlds

OpenID Connect is an authentication protocol that extends OAuth 2.0 and can be utilized for sign-on purposes. It facilitates the verification of user identity by clients through an authorization server. OpenID Connect combines elements from both OpenID and OAuth:

It employs OAuth 2.0 flows for the authentication request and response enabling a seamless single sign-on experience similar to OpenID. Additionally, it incorporates an OAuth 2.0 token that allows clients to access APIs and retrieve user information.

Consequently, OpenID Connect offers both identity verification and delegated authorization capabilities enabling clients to securely access user data. By augmenting OAuth 2.0 with an identity layer featuring user profile claims OpenID Connect provides a means of achieving single sign-on functionality on top of the authorization framework offered by OAuth.

## Azure Summary

The plan is to ask for space on an Azure SQL Managed Instance, Power BI, single node AKS cluster, app registration, and access to an Azure DevOps repository.  Hopefully, I am wrong, but I believe the Azure Bastion won't be able to provide a secure TCP connection to our on-premises API gateway which routes traffic to our report system UI and reporting micro-services.

I do not believe Azure Bastion is a **[SOCKs5 proxy server](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** which we could use to create a secure TCP connection to our API Gateway. Instead, it is only usable to create a secure RDP/SSH connection to an on-premise server.

- Azure SQL Server **[managed instance](https://intercept.cloud/en/news/azure-sql-sql-managed-instance-or-sql-server)**
- How to create **[Azure SQL Server managed instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/instance-create-quickstart?view=azuresql)**
- Azure **[Managed Kubernetes service](https://azure.microsoft.com/en-us/products/kubernetes-service)**
- How to deploy an **[AKS cluster](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli)**
- Azure **[App registration](../../linux/azure/app_registration/app_registration.md)** to enable our Apps to access the Azure API.
- How to register and **[app](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app)**
- Azure **[repos](https://azure.microsoft.com/en-us/products/devops/repos/)**
- How to create an Azure **[repo](https://learn.microsoft.com/en-us/azure/devops/repos/git/create-new-repo?view=azure-devops)**
- What are PowerBI paginated reports **[comparison](https://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-report-builder-power-bi)**
- **[When to use paginated reports](https://learn.microsoft.com/en-us/power-bi/guidance/report-paginated-or-power-bi)**
- License **[requirements](https://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-report-builder-power-bi#prerequisites)** to use PowerBI paginated reports

## What is a Bastion Host?

![](https://discover.strongdm.com/hs-fs/hubfs/Imported_Blog_Media/605d2e18679dad4a2e0b7df4_StrongDM-1-AWS-bastion-host-user-flow-3.jpg?width=780&height=438&name=605d2e18679dad4a2e0b7df4_StrongDM-1-AWS-bastion-host-user-flow-3.jpg)

A bastion host is a server used to manage access to an internal or private network from an external network - sometimes called a jump box or jump server. Because bastion hosts often sit on the Internet, they typically run a minimum amount of services to reduce their attack surface. They are also commonly used to proxy and log communications, such as SSH sessions.

<https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm#managingsessions>

Oracle Bastion allows connection to on-premises servers via a Sock5 dynamic port forwarding session, but I believe the Microsoft Azure Bastion is only meant for secure SSH/RDP sessions.

A **[SOCKs5 proxy server](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** creates a Transmission Control Protocol (TCP) connection to another server behind the firewall on the client’s behalf, then exchanges network packets between the client and the actual server. The SOCKS proxy server doesn’t interpret the network traffic between client and server in any way; it is often used because clients are behind a firewall and are not permitted to establish TCP connections to outside servers unless they do it through the SOCKS proxy server. Therefore, a SOCKS proxy relays a user’s TCP and User Datagram Protocol (UDP) session over a firewall.

SOCKS is a layer 5 protocol, and it doesn’t care about anything below that layer in the Open Systems Interconnection (OSI) model — meaning you can’t use it to tunnel protocols operating below layer 5. This includes ping, Address Resolution Protocol (ARP), etc. From a security perspective, it won’t allow attackers to perform scans using tools such as Nmap if they are scanning based on half-open connections because it works at layer 5.

![](https://www.imperva.com/learn/wp-content/uploads/sites/13/2020/02/OSI-vs.-TCPIP-models.jpg.webp)

Since SOCKS sits at layer 5, between SSL (layer 7) and TCP/UDP (layer 4), it can handle several request types, including HTTP, HTTPS, POP3, SMTP, and FTP. As a result, SOCKS can be used for email, web browsing, peer-to-peer sharing, file transfers, and more.

Other proxies built for specific protocols at layer 7, such as an HTTP proxy that is used to interpret and forward HTTP or HTTPS traffic between client and server, are often referred to as application proxies.

There are only two versions: SOCKS4 and SOCKs5. The main differences between SOCKs5 and SOCKS4 are:

- SOCKS4 doesn’t support authentication, while SOCKs5 supports a variety of authentication methods; and
- SOCKS4 doesn’t support UDP proxies, while SOCKs5 does.

## What is Azure Bastion?

I do not believe Azure Bastion is a **[SOCKs5 proxy server](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** which we could use to create a secure TCP connection to our API Gateway. Instead, it is only usable to create a secure RDP/SSH connection to an on-premise server.

Is our Bastion host configured to provide SSH tunneling (Dynamic Port Forwarding) from an Azure Public IP to a VM or computer within our company's network, remote port forwarding, taking care of TLS termination?

![](https://learn.microsoft.com/en-us/azure/bastion/media/connect-ip-address/ip-address.png)

<https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm#managingsessions>

## **[Azure Bastion Native Client Support](https://codyburkard.com/blog/bastionabuse/)**

Instead of logging in through the Azure Portal, Azure Bastion now allows users to connect using their native RDP or SSH clients.

If so I believe Bastion can be setup to route traffic to our K8s-hosted API gateway which has its own routing, throttling, TLS termination, and IAM authentication and authorization scheme.

If TLS termination is done by our Bastion host then we will probably need to pay for a Public IP and a TLS certificate. Once this is done I believe we will be able to access our data warehouse reporting UI and micro-services from a Microsoft Teams reporting app.

Azure Bastion is a fully managed PaaS service that you provision to securely connect to virtual machines via a private IP address. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal, or via the native SSH or RDP client already installed on your local computer. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network for which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

The following diagram shows connections to virtual machines via a Bastion deployment that uses a Basic or Standard SKU.

![](https://learn.microsoft.com/en-us/azure/bastion/media/bastion-overview/architecture.png)

# Father's will

Fear not my son.  I love you and am always with you.  It is me that controls every situation you face. Remember that every trouble that you go through is for your ultimate good. You must not stay as you are. There are things you must learn and the only way for that to happen is for you and I to face hardships together.  So do not fear when you face trials for this is necessary in order for you to grow into a kind and loving man full of hope in my love for you!

## week 3

Kevin: EDI, classic security confusing, deny first model in UX.
Sam: Caster interaction. no human interaction. use Mach2 screen.
Brad: OEE does not make sense in all cases. Could use Mach2 to toggle status changes.

## next

gage query
<https://gateway-api.sigs.k8s.io/guides/http-routing/>
<https://gateway-api.sigs.k8s.io/#whats-the-difference-between-gateway-api-and-an-api-gateway>

## Trial Balance

There was a bug in Plex.account_period_balance_recreate_period_range and Plex.account_period_balance_recreate_open_period_range having to do with a new account being added with debit and credit balances in December and January.

- changed mssql code first
- changing mysql code next
- review **[code change](../../volumes/sql/tbsql/issues/new_account/account_period_balance_recreate_period_range/mssql/recreate_fix.sql)**
- talk about SQL debugging in MSSQL, MySQL, and PostgreSQL

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

## What is **[OpenStack](https://www.openstack.org/software/)**

OpenStack is an open-source cloud operating system managing computing, storage, and networking resources throughout a data center using APIs.

![](https://object-storage-ca-ymq-1.vexxhost.net/swift/v1/6e4619c416ff4bd19e1c087f27a43eea/www-images-prod/openstack-logo/2016R/OpenStack-Logo-Horizontal.SVG)
![](https://object-storage-ca-ymq-1.vexxhost.net/swift/v1/6e4619c416ff4bd19e1c087f27a43eea/www-assets-prod/learn/homepage-OpenStack-SFAs.svg)

![](https://docs.openstack.org/install-guide/_images/openstack_kilo_conceptual_arch.png)

**[OpenStack](https://en.wikipedia.org/wiki/OpenStack)** is a free, open standard cloud computing platform. It is mostly deployed as infrastructure-as-a-service in both public and private clouds where virtual servers and other resources are made available to users.

## Open Stack History

<https://docs.openstack.org/project-team-guide/introduction.html>

<https://fedscoop.com/agencies-open-up-to-openstack/>

Three out of four government IT professionals in a new poll say their agencies are now using cloud computing services. The new survey also found that a significant portion of the respondents have favorable perceptions about the cost, security, and ease of deploying the popular open-source software platform, OpenStack, for their on-premises cloud computing initiatives.

How Governments Use **[OpenStack](https://vexxhost.com/blog/how-governments-use-openstack-around-the-world/
)
Governments all over the world have important priorities. Keep their citizens safe, keeping law and order within their jurisdiction, and problem-solving any issues that arise are just some of the issues that they face on a day-to-day basis. Although the way that they govern their countries the following countries have one thing in common: OpenStack.

**The United States Of America**
In the United States, the National Security Agency (NSA) utilizes the power of OpenStack to keep abreast of the high-security needs of the country. The implementation of OpenStack at the governmental level was such a success that the NSA planned to implement OpenStack in all 16 agencies that make up the intelligence community in the United States. Considering the emphasis that the United States places on security, it is evident that OpenStack delivers where it matters most.

Moreover, the role of OpenStack in government security in the United States is good for OpenStack users. Why? Because the NSA has such strong security requirements, it developed systems to accommodate these requirements. From securing APIs and guest OSes to developing code to suit their needs, the OpenStack community can experience the security benefits themselves.

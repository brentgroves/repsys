# **[Subscriptions, licenses, accounts, and tenants for Microsoft's cloud offerings](https://learn.microsoft.com/en-us/microsoft-365/enterprise/subscriptions-licenses-accounts-and-tenants-for-microsoft-cloud-offerings?view=o365-worldwide)**

## references

- **[](https://learn.microsoft.com/en-us/answers/questions/259366/pull-a-list-of-users-and-licenses-from-azure-ad)
- **[](https://learn.microsoft.com/en-us/microsoft-365/enterprise/view-account-license-and-service-details-with-microsoft-365-powershell?view=o365-worldwide)**

## Summary of the hierarchy

Here is a quick recap:

- An organization can have multiple subscriptions.
  - A subscription can have multiple licenses.
  - Licenses can be assigned to individual user accounts.
  - User accounts are stored in a Microsoft Entra tenant.

Here is an example of the relationship of organizations, subscriptions, licenses, and user accounts:

- An organization identified by its public domain name.
  - A Microsoft 365 E3 subscription with user licenses.
  - A Microsoft 365 E5 subscription with user licenses.
  - A Dynamics 365 subscription with user licenses.
  - Multiple Azure subscriptions.
  - The organization's user accounts in a common Microsoft Entra tenant.

Multiple Microsoft cloud offering subscriptions can use the same Microsoft Entra tenant that acts as a common identity provider. A central Microsoft Entra tenant that contains the synchronized accounts of your on-premises AD DS provides cloud-based Identity as a Service (IDaaS) for your organization.

Figure 4: Synchronized on-premises accounts and IDaaS for an organization

![](https://learn.microsoft.com/en-us/microsoft-365/media/subscriptions/subscriptions-fig4.png?view=o365-worldwide)

Figure 4 shows how a common Microsoft Entra tenant is used by Microsoft's SaaS cloud offerings, Azure PaaS apps, and virtual machines in Azure IaaS that use Microsoft Entra Domain Services. Microsoft Entra Connect synchronizes the on-premises AD DS forest with the Microsoft Entra tenant.

Microsoft provides a hierarchy of organizations, subscriptions, licenses, and user accounts for consistent use of identities and billing across its cloud offerings:

- Microsoft 365 and Microsoft Office 365
- Microsoft Azure
- Microsoft Dynamics 365

## Elements of the hierarchy

Here are the elements of the hierarchy:

## Organization

An organization represents a business entity that is using Microsoft cloud offerings, typically identified by one or more public Domain Name System (DNS) domain names, such as contoso.com. The organization is a container for subscriptions.

## Subscriptions

A subscription is an agreement with Microsoft to use one or more Microsoft cloud platforms or services, for which charges accrue based on either a per-user license fee or on cloud-based resource consumption.

- Microsoft's Software as a Service (SaaS)-based cloud offerings (Microsoft 365 and Dynamics 365) charge per-user license fees.
- Microsoft's Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) cloud offerings (Azure) charge based on cloud resource consumption.

You can also use a trial subscription, but the subscription expires after a specific amount of time or consumption charges. You can convert a trial subscription to a paid subscription.

Organizations can have multiple subscriptions for Microsoft's cloud offerings. Figure 1 shows a single organization that has multiple Microsoft 365 subscriptions, a Dynamics 365 subscription, and multiple Azure subscriptions.

Figure 1: Example of multiple subscriptions for an organization

![](https://learn.microsoft.com/en-us/microsoft-365/media/subscriptions/subscriptions-fig1.png?view=o365-worldwide)

## Licenses

For Microsoft's SaaS cloud offerings, a license allows a specific user account to use the services of the cloud offering. You are charged a fixed monthly fee as part of your subscription. Administrators assign licenses to individual user accounts in the subscription. For the example in Figure 2, the Contoso Corporation has a Microsoft 365 E5 subscription with 100 licenses, which allows to up to 100 individual user accounts to use Microsoft 365 E5 features and services.

Figure 2: Licenses within the SaaS-based subscriptions for an organization

![](https://learn.microsoft.com/en-us/microsoft-365/media/subscriptions/subscriptions-fig2.png?view=o365-worldwide)

A security best practice is to use separate user accounts that are assigned specific roles for administrative functions. These dedicated administrator accounts do not need to be assigned a license for the cloud services that they administer. For example, a SharePoint administrator account does not need to be assigned a Microsoft 365 license.

For Azure PaaS-based cloud services, software licenses are built into the service pricing.

For Azure IaaS-based virtual machines, additional licenses to use the software or application installed on a virtual machine image might be required. Some virtual machine images have licensed versions of software installed and the cost is included in the per-minute rate for the server. Examples are the virtual machine images for SQL Server 2014 and SQL Server 2016.

Some virtual machine images have trial versions of applications installed and need additional software application licenses for use beyond the trial period. For example, the SharePoint Server 2016 Trial virtual machine image includes a trial version of SharePoint Server 2016 pre-installed. To continue using SharePoint Server 2016 after the trial expiration date, you must purchase a SharePoint Server 2016 license and client licenses from Microsoft. These charges are separate from the Azure subscription and the per-minute rate to run the virtual machine still applies.

## User accounts

User accounts for all of Microsoft's cloud offerings are stored in a Microsoft Entra tenant, which contains user accounts and groups. A Microsoft Entra tenant can be synchronized with your existing Active Directory Domain Services (AD DS) accounts using Microsoft Entra Connect, a Windows server-based service. This is known as directory synchronization.

Figure 3 shows an example of multiple subscriptions of an organization using a common Microsoft Entra tenant that contains the organization's accounts.

Figure 3: Multiple subscriptions of an organization that use the same Microsoft Entra tenant

![](https://learn.microsoft.com/en-us/microsoft-365/media/subscriptions/subscriptions-fig3.png?view=o365-worldwide)

## Tenants

For SaaS cloud offerings, the tenant is the regional location that houses the servers providing cloud services. For example, the Contoso Corporation chose the European region to host its Microsoft 365, EMS, and Dynamics 365 subscriptions for the 15,000 workers in their Paris headquarters.

Azure PaaS services and virtual machine-based workloads hosted in Azure IaaS can have tenancy in any Azure datacenter across the world. You specify the Azure datacenter, known as the location, when you create the Azure PaaS app or service or element of an IaaS workload.

A Microsoft Entra tenant is a specific instance of Microsoft Entra ID containing accounts and groups. Paid or trial subscriptions of Microsoft 365 or Dynamics 365 include a free Microsoft Entra tenant. This Microsoft Entra tenant does not include other Azure services and is not the same as an Azure trial or paid subscription.

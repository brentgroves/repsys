# **[Understand the Fabric administrator role](https://learn.microsoft.com/en-us/training/modules/administer-fabric/3-admin-role-tools)**

Now that you understand the Fabric architecture and what you and your team might use Fabric for, let's look at the admin role and the tools used to manage the platform.

There are several roles that work together to administer Microsoft Fabric for your organization. If you're a Microsoft 365 admin, a Power Platform admin, or a Fabric capacity admin, you're involved in administering Fabric. The Fabric admin role was formerly known as Power BI admin.

As a Fabric admin, you work primarily in the Fabric admin portal. You might also need to familiarize yourself with the following tools:

Microsoft 365 admin center
Microsoft 365 Security & Microsoft Purview compliance portal
Microsoft Entra ID in the Azure portal
PowerShell cmdlets
Administrative APIs and SDK

## Describe admin tasks

As an admin, you might be responsible for a wide range of tasks to keep the Fabric platform running smoothly. These tasks include:

Security and access control: One of the most important aspects of Fabric administration is managing security and access control to ensure that only authorized users can access sensitive data. You can use role-based access control (RBAC) to:

- Define who can view and edit content.
- Set up data gateways to securely connect to on-premises data sources.
- Manage user access with Microsoft Entra ID.

Data governance: Effective Fabric administration requires a solid understanding of data governance principles. You should know how to secure inbound and outbound connectivity in your tenant and how to monitor usage and performance metrics. You should also know how to apply data governance policies to ensure data within your tenant is only accessible to authorized users.

Customization and configuration: Fabric administration also involves customizing and configuring the platform to meet the needs of your organization. You might configure private links to secure your tenant, define data classification policies, or adjust the look and feel of reports and dashboards.

Monitoring and optimization: As a Fabric admin, you need to know how to monitor the performance and usage of the platform, optimize resources, and troubleshoot issues. Examples include configuring monitoring and alerting settings, optimizing query performance, managing capacity and scaling, and troubleshooting data refresh and connectivity issues.

Specific tasks vary depending on the needs of your organization and the complexity of your Fabric implementation.

Describe admin tools
It's important to familiarize yourself with a few tools to effectively implement the tasks previously outlined. Fabric admins can perform most admin tasks using one or more of the following tools: the Fabric admin portal, PowerShell cmdlets, admin APIs and SDKs, and the admin monitoring workspace.

## **[Fabric admin portal](https://app.fabric.microsoft.com/)**

Fabric's admin portal is a web-based portal where you can manage all aspects of the platform. You can centrally manage, review, and apply settings for the entire tenant or by capacity in the admin portal. You can also manage users, admins and groups, access audit logs, and monitor usage and performance.

The admin portal enables you to turn settings on and off. There are many settings located in the admin portal. One noteworthy setting is the Fabric on/off switch, located in tenant settings that lets organizations that use Power BI opt into Fabric. Here, you can enable Fabric for your tenant or allow capacity admins to enable Fabric.

![i1](https://learn.microsoft.com/en-us/training/wwl/administer-fabric/media/admin-delegation.png)

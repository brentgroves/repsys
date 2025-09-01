# **[Understand the Fabric administrator role](https://learn.microsoft.com/en-us/training/modules/administer-fabric/3-admin-role-tools)**

Now that you understand the Fabric architecture and what you and your team might use Fabric for, let's look at the admin role and the tools used to manage the platform.

There are several roles that work together to administer Microsoft Fabric for your organization. If you're a Microsoft 365 admin, a Power Platform admin, or a Fabric capacity admin, you're involved in administering Fabric. The Fabric admin role was formerly known as Power BI admin.

As a Fabric admin, you work primarily in the Fabric admin portal. You might also need to familiarize yourself with the following tools:

- **[Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/admin/admin-overview/admin-center-overview)**
- **[Microsoft 365 Security & Microsoft Purview compliance portal](https://learn.microsoft.com/en-us/microsoft-365/compliance/microsoft-365-compliance-center)**
- **[Microsoft Entra ID in the Azure portal](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-whatis)**
- **[PowerShell cmdlets](https://learn.microsoft.com/en-us/powershell/power-bi/overview)**
- **[Administrative APIs and SDK](https://learn.microsoft.com/en-us/rest/api/power-bi/admin)**

## Describe admin tasks

As an admin, you might be responsible for a wide range of tasks to keep the Fabric platform running smoothly. These tasks include:

**Security and access control:** One of the most important aspects of Fabric administration is managing security and access control to ensure that only authorized users can access sensitive data. You can use role-based access control (RBAC) to:

- Define who can view and edit content.
- Set up data gateways to securely connect to on-premises data sources.
- Manage user access with Microsoft Entra ID.

**Data governance:** Effective Fabric administration requires a solid understanding of data governance principles. You should know how to secure inbound and outbound connectivity in your tenant and how to monitor usage and performance metrics. You should also know how to apply data governance policies to ensure data within your tenant is only accessible to authorized users.

**Customization and configuration:** Fabric administration also involves customizing and configuring the platform to meet the needs of your organization. You might configure private links to secure your tenant, define data classification policies, or adjust the look and feel of reports and dashboards.

Monitoring and optimization: As a Fabric admin, you need to know how to monitor the performance and usage of the platform, optimize resources, and troubleshoot issues. Examples include configuring monitoring and alerting settings, optimizing query performance, managing capacity and scaling, and troubleshooting data refresh and connectivity issues.

Specific tasks vary depending on the needs of your organization and the complexity of your Fabric implementation.

Describe admin tools
It's important to familiarize yourself with a few tools to effectively implement the tasks previously outlined. Fabric admins can perform most admin tasks using one or more of the following tools: the Fabric admin portal, PowerShell cmdlets, admin APIs and SDKs, and the admin monitoring workspace.

## **[Fabric admin portal](https://app.fabric.microsoft.com/)**

Fabric's admin portal is a web-based portal where you can manage all aspects of the platform. You can centrally manage, review, and apply settings for the entire tenant or by capacity in the admin portal. You can also manage users, admins and groups, access audit logs, and monitor usage and performance.

The admin portal enables you to turn settings on and off. There are many settings located in the admin portal. One noteworthy setting is the Fabric on/off switch, located in tenant settings that lets organizations that use Power BI opt into Fabric. Here, you can enable Fabric for your tenant or allow capacity admins to enable Fabric.

![i1](https://learn.microsoft.com/en-us/training/wwl/administer-fabric/media/admin-delegation.png)

PowerShell cmdlets
Fabric provides a set of **[PowerShell cmdlets](https://learn.microsoft.com/en-us/powershell/scripting/powershell-commands)** that you can use to automate common administrative tasks. A PowerShell cmdlet is a simple command that can be executed in PowerShell.

For example, you can use cmdlets in Fabric to systematically create and manage groups, configure data sources and gateways, and monitor usage and performance. You can also use the cmdlets to manage the Fabric admin APIs and SDKs.

 Note

See **[Microsoft Power BI Cmdlets for Windows PowerShell and PowerShell Core](https://learn.microsoft.com/en-us/powershell/power-bi/overview)** for more resources on PowerShell cmdlets that work with Fabric.

## Admin APIs and SDKs

An admin API and SDK are tools that allow developers to interact with a software system programmatically. An API (Application Programming Interface) is a set of protocols and tools that enable communication between different software applications. An SDK (Software Development Kit) is a set of tools and libraries that helps developers create software applications that can interact with a specific system or platform. You can use APIs and SDKs to automate common administrative tasks and integrate Fabric with other systems.

For example, you can use APIs and SDKs to create and manage groups, configure data sources and gateways, and monitor usage and performance. You can also use the APIs and SDKs to manage the Fabric admin APIs and SDKs.

You can make these requests using any HTTP client library that supports OAuth 2.0 authentication, such as Postman, or you can use PowerShell scripts to automate the process.

## Admin monitoring workspace

Fabric tenant admins have access to the admin monitoring workspace. You can choose to share access to the workspace or specific items within it with other users in your organization. The admin monitoring workspace includes the Feature Usage and Adoption dataset and report, which together provide insights on the usage and performance of your Fabric environment. You can use this information to identify trends and patterns, and troubleshoot issues.

![i1](https://learn.microsoft.com/en-us/training/wwl/administer-fabric/media/admin-monitoring-report.png)

 Note

For more information about what is included in the Admin Monitoring Workspace, see What is the **[Fabric admin monitoring workspace](https://learn.microsoft.com/en-us/fabric/admin/monitoring-workspace).

## Manage Fabric security

Completed
100 XP
5 minutes
As a Fabric admin, part of your role is to manage security for the Fabric environment, including managing users and groups, and how users share and distribute content in Fabric.

Manage users: assign and manage licenses
User licenses control the level of user access and functionality within the Fabric environment. Administrators ensure licensed users have the access they need to data and analytics to do their jobs effectively. They also limit access to sensitive data and ensure compliance with data protection laws and regulations.

Managing licenses allows administrators to monitor and control costs by ensuring that licenses are allocated efficiently and only to users who need them. This can help to prevent unnecessary expenses and ensure that the organization is utilizing its resources effectively.

Having the appropriate procedures in place to assign and manage licenses helps to control access to data and analytics, ensure compliance with regulations, and optimize costs.

License management for Fabric is handled in the Microsoft 365 admin center. For more information about managing licenses, see **[Assign licenses to users](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/assign-licenses-to-users?view=o365-worldwide&preserve-view=true)**.

## Manage items and sharing

As an admin, you can manage how users share and distribute content. You can manage how users share content with others, and how they distribute content to others. You can also manage how users interact with items, such as data warehouses, data pipelines, datasets, reports, and dashboards.

Items in workspaces are best distributed through a workspace app or the workspace directly. Granting the least permissive rights is the first step in securing the data. Share the read only app for access to the reports or grant access to the workspaces for collaboration and development. Another aspect of managing and distributing items is enforcing these types of best practices.

You can manage sharing and distribution both internally and outside of your organization, in compliance with your organization's policies and procedures.

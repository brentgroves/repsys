# **[Azure Virtual Desktop](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Securely deliver virtual desktops and applications remotely with maximum control to any device from a flexible cloud virtual desktop infrastructure (VDI) platform. Bring together Microsoft 365 and Azure to provide users with the only multi-session Windows 11 and Windows 10 experience, with exceptional scale and reduced IT costs.

## **What is Azure Virtual Desktop?**

Azure Virtual Desktop is a desktop and app virtualization service that runs on Azure. Here's some of the key highlights:

- Deliver a full Windows experience with Windows 11, Windows 10, or Windows Server. Use single-session to assign devices to a single user, or use multi-session for scalability.
- Offer full desktops or use RemoteApp to deliver individual apps.
- Present Microsoft 365 Apps for enterprise and optimize it to run in multi-user virtual scenarios.
- Install your line-of-business or custom apps you can run from anywhere, including apps in the formats Win32, MSIX, and Appx.
- Deliver Software-as-a-service (SaaS) for external usage.
- Replace existing Remote Desktop Services (RDS) deployments.
- Manage desktops and apps from different Windows and Windows Server operating systems with a unified management experience.
- Host desktops and apps on-premises in a hybrid configuration with Azure Local.

## Key capabilities

With Azure Virtual Desktop, you can set up a scalable and flexible environment:

- Create a full desktop virtualization environment in your Azure subscription without running any gateway servers.
- Flexible configurations to accommodate your diverse workloads.
- Bring your own image for production workloads or test from the Azure Gallery.
- Reduce costs with pooled, multi-session resources. With the new Windows 11 and Windows 10 Enterprise multi-session capability, exclusive to Azure Virtual Desktop, or Windows Server, you can greatly reduce the number of virtual machines and operating system overhead while still providing the same resources to your users.
- Provide individual ownership through personal (persistent) desktops.
- Automatically increase or decrease capacity based on time of day, specific days of the week, or as demand changes with autoscale, helping to manage cost.

## You can deploy and manage virtual desktops and applications

- Use the Azure portal, Azure CLI, PowerShell and REST API to create and configure host pools, application groups, workspaces, assign users, and publish resources.
- Publish a full desktop or individual applications from a single host pool, create individual application groups for different sets of users, or even assign users to multiple application groups to reduce the number of images.
- As you manage your environment, use built-in delegated access to assign roles and collect diagnostics to understand various configuration or user errors.
- Get key insights and metrics about your environment and the users connecting to it with Azure Virtual Desktop Insights.
- Only manage the image and virtual machines you use for the sessions in your Azure subscription, not the infrastructure. You don't need to personally manage the supporting infrastructure roles, such as a gateway or broker, like you do with Remote Desktop Services.

## Connect users

- Once assigned, users can connect to their published Windows desktops and applications using Windows App or the Remote Desktop client. Connect from any device through either a native application on your device or using a web browser with the HTML5 web client.
- Securely establish users through reverse connections to the service, so you don't need to open any inbound ports.

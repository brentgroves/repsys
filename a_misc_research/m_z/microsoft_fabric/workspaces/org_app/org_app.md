# **[Get started with org apps (preview)](https://learn.microsoft.com/en-us/power-bi/consumer/org-app-items/org-app-items)**

- **[good video](https://www.youtube.com/watch?v=7W3_9J0emKM&t=124s)**

<https://medium.com/microsoftazure/thoughts-on-workspace-design-in-microsoft-fabric-f99f79ac6f32>

01/30/2025
Welcome to the preview for org apps as items - Power BI workspace apps rebuilt for Fabric as a new item type. With org apps as items, you can create multiple org apps per workspace. And you can manage org apps the way you would any other item type - from creating a new org app, to managing access, to sharing the org app. All the things you find familiar and easy about managing other items, such as reports, are all familiar with org apps as items.

![i1](https://learn.microsoft.com/en-us/power-bi/consumer/org-app-items/media/org-app-items/org-app-item-management-collage.png)

Power BI workspace apps are a great way for content creators, like report authors, to craft secure, beautiful, customized data experiences for your colleagues and consumers. With org apps as items, you can create as many org apps as you need to ensure your team is working efficiently. And with org apps you can customize the consumer experience with any theme color, configure navigation, and build unique landing experiences.

![i2](https://learn.microsoft.com/en-us/power-bi/consumer/org-app-items/media/org-app-items/org-app-consumer-view.png)

Prerequisites for creating org app items
The preview for org apps is off by default for tenants. To enable the preview, you must be a Microsoft Fabric administrator. From Settings > Admin portal > Tenant settings a Microsoft Fabric administrator needs to enable the switch entitled Users can discover and create org apps (preview). Administrators can use security group inclusion/exclusion settings to control who can or can't create org apps.

Workspace license mode set to Pro, Fabric trial, or capacity
A workspace must be in a specific license mode to create an org app item: Pro, Fabric trial, Premium capacity, or Fabric capacity. To configure a workspace:

Create or open the workspace where you want to create org app items.
Select workspace settings.
Depending on your tenant, select the Premium tab or License info tab.
Select Edit to change the license mode for the workspace.
Select Pro, Trial, Premium capacity, or Fabric capacity (depending on what your tenant administrator configured).

## Workspace roles for creating an org app item

Users in the workspace with an admin, member, or contributor (with share permissions)* role can create and manage org app items, although contributors might not have full permissions for managing access on an org app. For more information, see org app access management. Workspace viewers can't create org app items.

See also Contributors and access management and sharing.

How org app items work, and how they're different from workspace apps
With org app items, you can create multiple org apps per workspace.

With org app items, you can package up items from the same workspace and share them with others in your organization who don't have access to the workspace.

Once you create an org app item, you can include Power BI reports, paginated reports, Fabric notebooks, and real-time dashboards in the org app. These items are referred to as included items.

When you give users access to the org app item, at a minimum they gain read access to the included items as well. For Power BI reports in an org app, users gain read access to the semantic models associated with the report. For new org apps in preview, even if a semantic model is in a different workspace users gain access to that model.

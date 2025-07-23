# **[concepts and licenses](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)**

Microsoft Fabric concepts and licenses
11/28/2024
Microsoft Fabric is a platform that allows users to get, create, share, and visualize data using an array of tools. To share content and collaborate in Microsoft Fabric, your organization needs to have an F or P capacity, and at least one per-user license.

A Microsoft Fabric deployment can be organized in various ways according to your organizational needs. This illustration shows two different ways of deploying Fabric in an organization. Retail company A has a single Microsoft Entra tenant for the entire company. Retail company B has two Microsoft Entra tenants, which have complete separation between them, one for military products and another for commercial products. Both companies deployed Fabric capacities according to their geographical location.

![i1](https://learn.microsoft.com/en-us/fabric/enterprise/media/licenses/tenants-capacities.png#lightbox)

## Microsoft Fabric concepts

This section describes tenants, capacities, and workspaces, which are helpful in understanding a Fabric deployment.

## Tenant

Microsoft Fabric is deployed to a Microsoft Entra tenant. Each tenant is tied to a specific Domain Name System (DNS) and other domains can be added to the tenant. If you don't already have a Microsoft Entra tenant, you can either add your domain to an existing tenant or a tenant is created for you when you acquire a free, trial, or paid license for a Microsoft online service. Once you have your tenant, you can add capacities to it. To create a tenant, see Quickstart: Create a new tenant in Microsoft Entra ID.

## Capacity

A Microsoft Fabric capacity resides on a tenant. Each capacity that sits under a specific tenant is a distinct pool of resources allocated to Microsoft Fabric. The size of the capacity determines the amount of computation power available.

Your capacity allows you to:

- Use all the Microsoft Fabric features licensed by capacity
- Create Microsoft Fabric items and connect to other Microsoft Fabric items
**Note**
To create Power BI items in workspaces that are not My workspace, you need a Pro license.
- Save your items to a workspace and share them with a user that has an appropriate license

Capacities are split into Stock Keeping Units (SKUs). Each SKU provides a set of Fabric resources for your organization. Your organization can have as many capacities as needed.

The capacity and SKUs table lists the Microsoft Fabric SKUs. Capacity Units (CU) are used to measure the compute power available for each SKU. For the benefit of customers that are familiar with Power BI, the table also includes Power BI Premium per capacity P SKUs and v-cores. Power BI Premium P SKUs support Microsoft Fabric. A and EM SKUs only support Power BI items.

| SKU*  | Capacity Units (CU) | Power BI SKU | Power BI v-cores |
|-------|---------------------|--------------|------------------|
| F2    | 2                   | -            | 0.25             |
| F4    | 4                   | -            | 0.5              |
| F8    | 8                   | EM/A1        | 1                |
| F16   | 16                  | EM2/A2       | 2                |
| F32   | 32                  | EM3/A3       | 4                |
| F64   | 64                  | P1/A4        | 8                |
| Trial | 64                  | -            | 8                |
| F128  | 128                 | P2/A5        | 16               |
| F256  | 256                 | P3/A6        | 32               |
| F512  | 512                 | P4/A7        | 64               |
| F1024 | 1024                | P5/A8        | 128              |
| F2048 | 2048                | -            | 256              |

*In the **[Power BI Embed for your organization](https://learn.microsoft.com/en-us/power-bi/developer/embedded/embedded-analytics-power-bi#embed-for-your-customers)** scenario, and Embedding in Microsoft 365 apps such as Sharepoint online and PowerPoint, SKUs smaller than F64 require a Pro or Premium Per User (PPU) license, or a Power BI individual trial to consume Power BI content.

# **[What is a resource group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to allocate resources to resource groups based on what makes the most sense for your organization. Generally, add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group.

The resource group scope is also used throughout the Azure portal to create views that span across multiple resources. For example:

- Metrics blade provides metrics information (CPU, resources) to users.
- Deployments blade shows the history of ARM Template or Bicep deployments targeted to that Resource Group (which includes Portal deployments).
- Policy blade provides information related to the policies enforced on the resource group.
- Diagnostics settings blade provides the ability to diagnose errors or review warnings.
T

The resource group stores metadata about the resources. Therefore, when you specify a location for the resource group, you're specifying where that metadata is stored. For compliance reasons, you might need to ensure that your data is stored in a particular region. **Note that resources inside a resource group can be of different regions.**

9

In order to find the Azure region closest to you, you can use this free tool:

<https://gyxi.com/which-azure-region-is-closest-to-me/>

For your convenience, here is the list of Azure regions with their actual (closest) major city.

+-------------+----------------------+---------------+
|   Region    |       Azure ▾        |     Area      |
+-------------+----------------------+---------------+
| Sao Paolo   | Brazil South         | South America |
| Quebec      | Canada East          | North America |
| Pune        | Central India        | Asia          |
| Iowa        | Central US           | North America |
| Hong Kong   | East Asia            | Asia          |
| Virginia    | East US              | North America |
| Ireland     | Europe North         | Europe        |
| Netherlands | Europe West          | Europe        |
| Paris       | France Central       | Europe        |
| Germany     | Germany West Central | Europe        |
| Tokyo       | Japan East           | Asia          |
| Osaka       | Japan West           | Asia          |
| Seoul       | Korea Central        | Asia          |
| Illinois    | North Central US     | North America |
| Texas       | South Central US     | North America |
| Singapore   | Southeast Asia       | Asia          |
| Zurich      | Switzerland North    | Europe        |
| Dubai       | UAE North            | Asia          |
| London      | UK South             | Europe        |
| Cardiff     | UK West              | Europe        |
| Mumbai      | West India           | Asia          |
| California  | West US              | North America |
| Washington  | West US 2            | North America |
+-------------+----------------------+---------------+
Only public regions that support Linux Consumption Plan are included in this table because those are the requirements of the latency tool.

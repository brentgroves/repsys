# IS Team Projects

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

![cp](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_4096,h_1377/https://assets.ubuntu.com/v1/e55cc8c0-wide-server.png)

Good Morning, Team,

This is a revised project summary and timeline for the Automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** Reporting System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** that the Structures Information System team is working on. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River. If it meets the approval of Kevin Young and other team members, I would like to add this timetable and summary, or a curtailed version, to the Structures IT Team Meetings and the Albion/Avilla project status tracking systems. Thank you.

Players:

- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Dan Martin, Plant Controller Southfield
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor

The following is in markdown format. It can be viewed better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

## CNC tool adjustment app

Purpose: To have an electronic alternate to color printer cmm reports.

### Process

- Send CMM output to database include CNC, feature, out of spec info.
- Tool Setter subscribes to CNC CMM reports from mobile app.
- Tool Setter updates the mobile app tool adjustments made.
- Since all CMM report data and tool adjustments are recorded in a database they are easily viewable.

### Feature Set

- tablet app contains cmm report data.
- tool setter updates app with offset made.

## Azure resources

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - ~ $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
  - Second resource group. When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - ~ $50/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

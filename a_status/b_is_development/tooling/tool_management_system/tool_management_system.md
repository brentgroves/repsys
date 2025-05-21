# Structures Information System Projects

Good Morning, Team,

This is a task list for the Structures Information System's tooling reporter project. It also contains a list of other IS projects to be completed. Currently, the only cost is from the cloud database, which is $50 per month.

## tasks

- Move job tooling from MSC to the new Vending Machine.
  - Nancy is doing this.
- Move legacy tooling to our cloud database.
- Move tooling in Excel to the cloud database.
- Point Busche Reporter to the cloud database.
- Excel template for new job tooling.
- Web app to enter new job tooling.
- Phase 2: Add additional tool management features in the legacy Busche Tool List system.

Team:

- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Ron James, Quality Manager
- Dan Martin, Plant Controller, Southfield
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor
- Stephen Strzalkowski, Tooling Engineer Supervisor

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Structures Information System Project Summary

## 1. Avilla Structures **[Kubernetes](https://www.turing.com/blog/importance-of-kubernetes-for-devops)**, K8s, On-Prem and Cloud Platform Services

Set up the cloud-based and low-cost Avilla Structures on-prem virtual machines to provide basic platform services needed by Information Systems projects.

## 2. Automated Report System

Software system to automate the creation of live or long-running reports, Power BI dashboards, and Excel in the Plex ERP and extended service platforms.

## 3. Tool Management System

Move from managing CNC tooling in Excel and the Legacy Busche Tool List system to a modern, more robust, and easy-to-use platform.

### Tool Management Users

- Albion MRP and Engineering
- Possibly Mills River

### Tool Management Status

- Time: 6 months
- Due date: Jun 2026

## 4. Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

### Tool Tracker Scope

Automatically collect and report on CNC, job, and start/end tool operation times for problematic tooling.

## 5. CNC tool adjustment app

Purpose: To have an electronic alternative to a color printer, cmm reports, and records of tool setter adjustments.

## Azure resources

- **[Azure AKS Entra ID managed cluster](https://learn.microsoft.com/en-us/azure/aks/enable-authentication-microsoft-entra-id)**
  - ~ $350/month
  - Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.
  - Second resource group. When you create a new cluster, AKS automatically creates a second resource group to store the AKS resources. For more information, see **[Why are two resource groups created with AKS?](https://learn.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)**

- **[Fully Mangaged Azure SQL Database](https://learn.microsoft.com/en-us/sql/sql-server/sql-docs-navigation-guide?view=sql-server-ver16#applies-to)**
  - ~ $50/month
  - Standard S1 service tier and 20 **[DTU](https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#database-transaction-units-dtus)** capacity.

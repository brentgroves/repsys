# **[report server](https://learn.microsoft.com/en-us/power-bi/report-server/get-started)**

Power BI Report Server is an on-premises report server with a web portal where you display and manage reports and KPIs. Along with it come the tools to create Power BI reports, paginated reports, mobile reports, and KPIs. Your users can access those reports in different ways: viewing them in a web browser or mobile device, or as an email in their in-box.

## Comparing Power BI Report Server

Power BI Report Server is similar to both SQL Server Reporting Services and the Power BI service, but in different ways. Like the Power BI service, Power BI Report Server hosts Power BI reports (.pbix), Excel files, and paginated reports (.rdl). Like Reporting Services, Power BI Report Server is on premises. Power BI Report Server features are a superset of Reporting Services: everything you can do in Reporting Services, you can do with Power BI Report Server, along with support for Power BI reports. See Comparing Power BI Report Server and the Power BI service for details. With an F64 reserved instance, you can create a hybrid deployment mixing cloud and on-premises.

## Licensing Power BI Report Server

 Note

Following the announcement that beginning with SQL Server 2025, we're consolidating on-premises reporting services under Power BI Report Server (PBIRS). Further information on PBIRS licensing will be provided when SQL Server reaches general availability (GA). For customers using SQL Server 2022 and earlier versions, the licensing details outlined below remain applicable.

Power BI Report Server operates on a core-based licensing model and is currently available through three different licenses: Fabric F64+ reserved instances, SQL Server Enterprise Edition with Software Assurance, or SQL Server Enterprise Subscriptions. See Microsoft Volume Licensing for SQL Server licensing details. Similar to SQL Server licensing, customers may run the Power BI Report Server software in a Physical or Virtual OSE with up to the number of cores included under their Fabric F64+ capacity. The number of Power BI v-cores available for each Fabric license can be found here.

If you purchase Fabric F64+ reserved instances, a Power BI Pro license is required to publish both paginated and Power BI reports in PBIRS. However, for SQL Server Enterprise Edition with Software Assurance or SQL Server Enterprise subscription, a Power BI Pro license is only required for publishing Power BI reports in PBIRS. You don't need a Power BI Pro license to view and interact with paginated and Power BI reports on Power BI Report Server.

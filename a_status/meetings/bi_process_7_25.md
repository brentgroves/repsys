# Fabric and Power BI

Hi Team,
I would like to discuss Power BI licenses, the move of the Azure SQL database to Microsoft Fabric, and the process of publishing visuals.

- Thank you

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## Microsoft Fabric Admins

- Acquire and work with capacities
- Ensure quality of service
- Manage workspaces
- Publish visuals
- Verify codes used to embed Microsoft Fabric in other applications
- Troubleshoot data access and other issues

## Admins

Sam Jackson and Brent Groves - **[Microsoft fabric admin rights](https://learn.microsoft.com/en-us/fabric/admin/microsoft-fabric-admin)**.

They have the right to:

- Perform administrative duties such as creating and managing Microsoft Fabric workspaces and apps to organize reports.
- Assign contributor roles to employees who need to publish and share reports.

Needed:

- Publishing reports requires a Power BI Pro license.

## Publish visuals flow

- Send the Power BI report to the Fabric Admin with a Power BI Pro license or someone with a Power BI Pro license who has been assigned the contributor role.
- The admin/contributor would publish and assign the report to an app.
- Whoever has access to the app could view the visual.

## Questions

- Do you know if the above process is correct?
- What workspace and app?
- Should there be multiple apps?

## Azure SQL database

The Structures ETL system loads data into an Azure SQL database from the following sources:

- Non-Microsoft ODBC driver to a snapshot of the Plex database.
- SOAP/REST for live Plex data.
- OPCUA client to **[KepserverEx](https://kepware-opc.cz/en/produkty/opc-server-pro-windows-kepserverex/)** for sensor data.
- MOXA serial device servers connected to Okuma CNC for start and end tool operation time and tool counts.

## Question

Should we move our Azure SQL database or mirror the existing one?

From a Microsoft meeting, we learned that Azure SQL database, rather than an Azure SQL data warehouse, supports all T-SQL features and would not require code rewrites. We could recreate the Azure SQL database within Fabric, and mirroring to **[OneLake](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview)** is automatic, but not live. We could also keep the Azure SQL database where it is and mirror it to OneLake.

Team:

Tarek Mohamed - Data and Analytics IT - Supervisor
Cody Hudson - Fabric Administrator
Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Jared Davis, IT Manager
Kevin Young, Information Systems Manager
Sam Jackson, Information Systems Developer, Southfield
Brad D. Cook, Quality Engineer, Fruitport
Jared Eikenberry, Quality Engineer, Fruitport
Emmanuel Munoz Diaz - Microsoft Data and AI specialist - <emunozdias@microsoft.com>

## Links

- - **[PowerBI](https://app.powerbi.com/)**
- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

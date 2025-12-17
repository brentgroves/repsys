# Structures Microsoft Fabric/Power BI Status

The following is in markdown format and can be viewed by copying and pasting the entire content of this email into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**

![i2](https://miro.medium.com/v2/resize:fit:786/format:webp/1*pRD0YDKxkwCiQ6S5bVv9cw.png)

Hi Team,

We are making progress on the Microsoft Fabric/PowerBI/Notebook/Datalake medallian workflow. We are now working the 'Silver' stage of the Medallian process. At this level data is to be cleaned. Our first project's, which reports on oil consumpution, data source is an Excel file.

**Cleaning** means making sure the data in the Excel file is valid before importing it into the Silver data lake.  For instance, if someone accidentally entered an 'S' instead of a '5' in a cell whose column is to be totalled, the calculation would fail.

Cleaning:

- Detect data entry errors such as a letter where there should be a number.
- Report the locations of these errors for correction.

## Marposs dimensional gage Cpk/Ppk

**[Marposs Visit Summary](./a_data_analysis/dimensional_guage/meetings/dec_15/summary.md)**

We started a Marposs dimensional gage project that will enable us to do a **[Process Capability Analysis Cp, Cpk, Pp, Ppk](https://www.1factory.com/quality-academy/guide-process-capability.html)** for JT Fronts. The Marposs rep has agreed to a visit but we have some prelim work:

## Q&A

- Can we display the parameters and dimensions collected on checksheet?
- Marposs gage network cable worked with the SDS, may need another cable to connect to the OT file server.
- The on-prem databases such as pd-avi-sql01 will need a service account or special username in order to be used as Power BI data sources through the data gateway.
- Can we find a rack location to setup 3 Dell R410 PowerEdge Servers for the MicroCloud/K8s disaster recovery and secondary data gateway. Approved by Jared to locate at Albion's server rack.

### Marposs gage program change

- Add traceability parameters to gage program

To ensure traceability we should add CNC and tool change parameters to the program.

**Ensure Traceability:** Make sure all measurements are traceable back to Man (Operator), Machine (Operation), Method, Material, Measurement System, and Environmental Conditions (5Ms, 1E) to enable process improvement. Record Unit Number or Serial Number for each part. I don't think we have serial numbers for each part but we can identify the CNC and tool changes.

## Questions/Answers

1. Are we recording the dimensions of left and right hand parts separately?
No. We are recording dimensions for two of the same part. The parts are identified as station 1 and 2 and from the same CNC.
2. Does Merlin support selecting parameters from a predefined list for the case of CNC#?
3. Does Merlin support selecting multiple items from a predefined set for the case of tool changes?
4. Can these parameters be exported along with dimensional values to the serial port and CSV file.
5. Who would modify the program? I believe Brian Segro or Bill Gstalder could help us to add CNC and tool change parameters. For advanced modifications Larry Becker from quality solutions could help us.

## Oil Consumption Report Workflow

Working on programmatically cleaning data in the Excel data source.

### Plan

- Use the easily updated "Oil adds to Machines.xlsx" spreadsheet with machine/oil_type/line and oil quantity for each day of the month.
- Clean the data and import into the Structures data lake.
- Create a Power BI report using the OAM schema of the Structures gold data lake table.
- Create Maintenance org app and add OAM report to it.

## Structures Microsoft Fabric Medallion Workflow

- Finished Bronze Layer and starting Silver Layer of Medallion workflow process.
- We noticed that requests are coming in for access appoval for the Structures Fabric workspace. We will start approving these requests when we finish creating the Fabric/PowerBI/Notebook/Datalake medallian workflow.
- Setup Microsoft **[data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)**.
- Connect to Plex from Windows Server using ODBC an access from Fabric using data gateway.
- Create chat or email group for each org app.
- Record Medallion workflow process for the team.

This is Structures Information Systems first time to use the Linamar Fabric workspace Org App feature to publish Power BI reports and Notebooks with a data lake data source, so please bear with us.

We will keep you posted as to our progress. Thank you for your patience.

Brent
Structures - Information Systems

## Fabric Team

- Tarek Mohamed, IT Supervisor - Data & Analytics
- Christian Trujillo, IT Structures Manager
- Jared Davis, IT Manager
- Kevin Young, Information Systems Manager
- Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
- Sam Jackson, Information Systems Developer, Southfield
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport
- Carl Stangland, Desktop and System Support Technician, Indiana
- Ricardo Baca, Sr. Manufacturing Engineer
- Beth Schaus, Accounting Finance
- Cody Hudson, Accounting Associate
- Katerina Lallouet, HR Manager, Corporate
- Vicente Ontiveros, Director, Program Management
Engineering, McLaren
- Jose Pardo, Maintainence Manager
- Mikael Boire, Operation Manager
- Ron James, Quality Manager, Quality
- Pat Baxter, General Manager
- Michael Percell, Manufacturing Engineering Manager
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Erin Williams, Manufacturing Engineer, Engineering
- April Sumner, Quality Engineer
- Nickolas Dekoninck, Quality Engineer
- Chelsea Prill, Quality Engineer

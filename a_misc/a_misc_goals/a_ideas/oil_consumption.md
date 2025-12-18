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

## Oil consumption report

Working on programmatically cleaning data in the Excel data source.

### Plan

- Use the easily updated "Oil adds to Machines.xlsx" spreadsheet with machine/oil_type/line and oil quantity for each day of the month.
- Clean the data and import into the Structures data lake.
- Create a Power BI report using the OAM schema of the Structures gold data lake table.
- Create Maintenance org app and add OAM report to it.

## Fabric/Power BI/Notebooks/Data Lake Medallion Workflow

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

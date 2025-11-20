# Structures Microsoft Fabric Status

Hi Team,
This is Structures Information Systems first time to use the Linamar Fabric workspace Org App feature to publish Power BI reports and Notebooks with a data lake data source, so please bear with us.

We noticed that requests are coming in for access appoval for the Structures Fabric workspace. We will start approving these requests when we finish creating the Fabric/PowerBI/Notebook/Datalake medallian workflow.

We started a Marposs dimensional gage project that will help doing a **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)** for JT Fronts.

We will keep you posted as to our progress. Thank you for your patience.

Brent
Structures - Information Systems

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Oil consumption report

Making good progress on this.

- Use the easily updated "Oil adds to Machines.xlsx" spreadsheet which has one row with machine/oil_type/line and oil quantity for each day of the month to  update the Structures OAM data lake table with a PySpark notebook.
- Create a Power BI report from OAM data lake table.
- Create Maintenance org app and add OAM report to it.

## Fabric/Power BI/Notebooks/Data Lake Medallion Workflow

- finished Bronze Layer and starting Silver Layer of Medallion workflow process
- receiving approval Fabric approval requests from Structures employees
- fabric gateway
  - **[lxd forwarder](../research/m_z/virtualization/hypervisor/lxd/network/forwarders/forwarders.md)** to wins22
  - connect to Plex from wins22
  - create chat or email group to keep team informed
  - Southfield, Cody Hudson, and other Plex reports.
  - Record Medallion workflow process for the team.

## Marposs gage project

- Marposs coming down soon to help
- Serial device server configured
- JT Front VLAN created
- Switch ports for JT Front VLAN configured
- 1 Network Cable ran probably need 2
- Data import to Minitab for CPK and PPK.
  - Instead of Minitab we can use a Fabric Notebook.
  - **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)**

![i](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1761677540/powerbi_workflow_qpbrid.jpg)

## **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**

![i2](https://miro.medium.com/v2/resize:fit:786/format:webp/1*pRD0YDKxkwCiQ6S5bVv9cw.png)

The next step in the medallion process is to convert the CSV file to a parquet file.

Benefits of using Parquet:

- **Improved Query Performance:** Columnar storage and predicate pushdown lead to faster query execution, especially for analytical workloads.
- **Reduced Storage Space:** Efficient compression and binary storage result in smaller file sizes and lower storage costs.
- **Enhanced Data Processing Efficiency:** Optimized for big data frameworks, Parquet facilitates faster data loading and processing.
- **Flexibility with Schema Evolution:** Allows for adaptability in data schemas without disrupting existing data.

## CSV creation overview

- Keep format of "Oil adds to Machines.xlsx" with these differences:
  - Rename to "OAMForMonth.xlsx"
  - Record only one months worth of oil adds.
  - Add date to top of the single sheet.
- Copy "OAMForMonth.xlsx" to Fabric data lake folder.
- Generate "OAMDataLakeSync.csv" using Notebook.
- Import monthly OAM data into data lake table using Notebook.
  - Read "OAMDataLakeSync.csv"
    - For each row
      - If date/machine/oil_type/line record exists in DataLake delete it.
      - Insert date/machine/oil_type/line record into DataLake table.

## Next

Further clean and refine silver layer data.

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

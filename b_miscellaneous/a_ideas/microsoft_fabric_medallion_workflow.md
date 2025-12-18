# Microsoft Fabric Medallion Workflow

Hi Team,

The Structures Information Systems group attended the Fabric roll-out meeting with Linamar's Data and Analytics Supervisor, Tarek Mohamad, and run by Microsoft's Software Architect, Oscar Zamora.  Oscar discussed high-level migration strategies to help each business unit transition to Microsoft Fabric and manage business unit data using modern techniques from one place.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**

- Microsoft Fabric provides Linamar's business units with the infrastructure to securely manage and report on any business data by storing it in one place and a common format.
- Departments have their software, databases, and Excel spreadsheets.  This does not change.  What changes is that we copy selected data to our Linamar data lake.
- Important data collected from our ERP, vending machines, PLC, CNC, CMM, etc., gets copied into Linamar's data lake.
- Data in our data warehouse and Excel spreadsheets is mirrored to the data lake.
- We don't have to change where or how we enter our data. We have to ensure it gets copied to Linamar's data lake.
- All the data collected is in a standard format in one place
- We can manage, store, link, and report our centralized data.
- Using modern tooling will enable us to gain new insights into our data that we never knew possible.
- In the past, we could report on static data from all of our departmental data sources, but by copying our data to the data lake, we will be able to store data indefinitely and see value changes over time.
- The data lake is managed through role, group, and individual permissions. One copy of our data is stored in a centralized location, but shortcuts to each data item can be made to other workspaces as needed.

![i2](https://miro.medium.com/v2/resize:fit:786/format:webp/1*pRD0YDKxkwCiQ6S5bVv9cw.png)

## Phase 1

- Move Southfields ERP account data into the data lake. Only Southfield will be able to view and work with this data item.
- Complete the Busche reporter project to manage tooling by job from Linamar's data lake.
- Collect CNC maintenance information from our ERP to produce mean time to failure and mean time to repair reports.
- Collect customer release data from our ERP and vending machines tooling data for material planning insights over time.
- Collect PLC pressure data into the data lake.
- Collect data from our CMM reports and tool offset changes.
- Collect CNC tool operation start and end times into the data lake.

## reference

- **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**
- **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**
- **[Power BI training resource](https://www.youtube.com/watch?v=vg5bwxhM2vs&list=PLtCzYvIWNgJE-NsGuUXbjYyJgQMSOFp3A)**

## Fabric Team

- Tarek Mohamed, IT Supervisor - Data & Analytics
- Christian Trujillo, IT Structures Manager
- Jared Davis, IT Manager
- Kevin Young, Information Systems Manager
- Sam Jackson, Information Systems Developer, Southfield
- Pat Baxter, General Manager
- Ron James, Quality Manager, Quality
- Michael Percell, Manufacturing Engineering Manager
- Heather Luttrell, Group Controller,Finance
- Jami Pyle, MP&L Manager
- Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
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
- Nancy Swank, Material Planner
- Erin Williams, Manufacturing Engineer, Engineering
- April Sumner, Quality Engineer
- Skippie Muehlfeld, Controls Engineer
- Josh Williams, Program Manager, Engineering
- Dennis Brach, Maintenance Manager
- Shawn Boyd, Controller, Group - LMGA - MBI, <Shawn.Boyd@Linamar.com>
- Chris McConville, IT Developer - IT, <Chris.Mcconville@Linamar.com>

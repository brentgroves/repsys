# Microsoft Fabric with Power BI

Hi Team,

The Structures Information Systems group is researching Microsoft Fabric. With it, we can mirror all our data to the cloud and write Power BI reports from one place, linking data together as needed. Any data from a PLC, database, or Excel spreadsheet can be put into Microsoft Fabric OneLake. Contact a Structures Information Systems team member for assistance.  

Thank you.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Why create and manage our **[SQL database in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/database/sql/overview)** inside the Fabric portal?

We currently use an Azure SQL database to collect PLC, non-Microsoft ODBC driver data, and API-accessible data.

If we migrate our current Azure SQL database to Microsoft Fabric, it will automatically mirror the data and create **[delta tables in OneLake](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-understand-storage)**

We can then query the **[delta tables](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-understand-storage)** with T-SQL (Transact-SQL), Spark SQL, and Python.

The advantage of doing this is that we can report on structured data linked to other structured and unstructured data.

Team:

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas.Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Carlos Morales, IT Administrator, Muscle Shoals
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
Kent Cook - IT Administrator
David Maitner,  Desktop and System Support Technician, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje
Pat Baxter, General Manager
Michael Percell, Manufacturing Engineering Manager
Dan Martin, Plant Controller Southfield
Jami Pyle, MP&L Manager
Nancy Swank, Material Planner
Skippie Muehlfeld, Controls Engineer

## Links

- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

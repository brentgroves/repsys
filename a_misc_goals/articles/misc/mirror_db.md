# Microsoft Fabric automatic mirroring

Hi Team,

The Structures Information Systems group is researching Microsoft Fabric.  Thank you, Tarek and Cody, for helping us get started. Here is some basic information that is probably old news to Tarek and Cody, but it could be useful to the rest of us.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Why create and manage our **[SQL database in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/database/sql/overview)** inside the Fabric portal?

We currently use an Azure SQL database to collect PLC data, non-Microsoft ODBC driver data, and API-accessible data.

If we migrate our current Azure SQL database to Microsoft Fabric, it will automatically mirror the data and create **[delta tables in OneLake](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-understand-storage)**

We can then query the **[delta tables](https://learn.microsoft.com/en-us/fabric/fundamentals/direct-lake-understand-storage)** with T-SQL (Transact-SQL), Spark SQL, and Python.

The advantage of doing this is that we can report on structured data linked to other structured and unstructured data.

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

- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

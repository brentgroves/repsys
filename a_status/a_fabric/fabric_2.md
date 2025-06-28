# Microsoft Fabric update

Hi Team,

The Structures Information Systems group was part of a meeting headed by Linamar's Tarek Mohamad and ran by Microsoft Software Architect Oscar.  Microsoft discussed high level migration strategies to help each business unit transition to Microsoft Fabric.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Microsoft Fabric

- Microsoft Fabric provides business units the infrastructure to securely manage data found in databases and excel and store it in one place.
- Departments have their own software, databases, and excel spreadsheets.  This does not change.  What changes is that we mirror selected data to a data lake.
- Important data collected from our ERP, vending machines, plc, cnc, cmm, etc. all goes into the data lake.
- Data in our data warehouse and excel spreadsheets also is mirrored to the data lake.
- We don't have to change where or how we currently enter our data.
- An ETL process is used to copy and transform the data to a common format that is more easily reported on.

## Phase 1

## **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**

Control software to manage structured, unstructured, and semi-structured data.  For unstructured and semi-structured data, it uses **[Azure Data Lake Storage (ADLS) Gen2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)**. For structured data, we can use **[SQL databases](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**.

The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**

## **[Data Lake](https://azure.microsoft.com/en-us/resources/cloud-computing-dictionary/what-is-a-data-lake)**

A data lake is where we collect our unstructured and semi-structured data.

## **[Structured Data](https://www.geeksforgeeks.org/dbms/what-is-structured-data/)**

Any data that is kept in a relational database. We use SQL to analyze this data.

## **[Unstructured data](https://www.geeksforgeeks.org/what-is-unstructured-data/)**

Unstructured data includes documents, web pages, emails, posts, sensor data, and images.

How to organize it:

- find patterns.
- Classify and group it.
- Label it with a tag.

## **[semi structured data](https://www.geeksforgeeks.org/what-is-semi-structured-data/)**

It is a mix of structured and unstructured data. It contains metadata that helps to identify the content. Examples of semi-structured data include an XML document containing tags, log files, and IoT data. This data is clear, but is not yet in a form we could directly report.

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

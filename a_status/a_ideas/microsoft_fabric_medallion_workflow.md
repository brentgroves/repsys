# Microsoft Fabric update

Hi Team,

The Structures Information Systems group attended the Fabric roll-out meeting with Linamar's Data and Analytics Supervisor, Tarek Mohamad, and run by Microsoft's Software Architect, Oscar Zamora.  Oscar discussed high-level migration strategies to help each business unit transition to Microsoft Fabric and manage business unit data using modern techniques from one place.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Microsoft Fabric

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

## **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**

## **[Power BI training resource](https://www.youtube.com/watch?v=vg5bwxhM2vs&list=PLtCzYvIWNgJE-NsGuUXbjYyJgQMSOFp3A)**

![i](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1761677540/powerbi_workflow_qpbrid.jpg)

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

## team

Tarek Mohamed, Data and Analytics IT, Supervisor
Cody Hudson, Fabric Administrator
Pat Baxter, General Manager
Michael Percell, Manufacturing Engineering Manager
Ron James, Quality Manager
Dan Martin, Plant Controller, Southfield
Jami Pyle, MP&L Manager
Nancy Swank, Material Planner
Christian Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
David Maitner,  Desktop and System Support Technician, Fruitport
Kent Cook, IT Administrator, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje

Victor Saavedra, LNA Application Architect IT, <Victor.Saavedra@Linamar.com>
Sadiq Basha, Data Engineer, Senior - IT - Data & Analytics, <Sadiq.Basha@Linamar.com>
Shawn Boyd, Controller, Group - LMGA - MBI, <Shawn.Boyd@Linamar.com>
Chris McConville, IT Developer - IT, <Chris.Mcconville@Linamar.com>
Emmanuel Munoz Diaz - Microsoft Data and AI specialist - <emunozdias@microsoft.com>
Oscar Zamora, <oszamora@microsoft.com>

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

# Microsoft Fabric, Structures Work Space, Storage, and Power BI

Hi Team,

I would like to discuss the Microsoft Fabric Architecture concepts and Structures implementation details for Domains, Workspaces, Items I would also like to discuss OneLake storage hierarchical namespace, Power BI reporting, as well as mirroring the Structures Azure SQL database to a Microsoft Fabric Item. There are several questions below I would like to pose to the group. Finally, a meeting has been scheduled for this Friday at 2 PM. I hope you can attend.

- Thank you

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## **[Understand the Fabric Architecture](https://learn.microsoft.com/en-us/training/modules/administer-fabric/2-fabric-architecture)**

- **Capacity** A Microsoft Fabric capacity resides on a tenant. Each capacity that sits under a specific tenant is a distinct pool of resources allocated to Microsoft Fabric. The size of the capacity determines the amount of computation power available.

- **Domain** is a logical grouping of workspaces. Domains are used to organize items in a way that makes sense for your organization. You can group things together in a way that makes it easier for the groups of people to have access to workspaces. For example, you might have a domain for sales, another for marketing, and another for finance.

- **Workspace** is a collection of items that brings together different functionality in a single tenant. It acts as a container that uses capacity for the work that is executed, and provides controls for who can access the items in it. For example, in a sales workspace, users associated with the sales organization can create a data warehouse, run notebooks, create datasets, create reports, and more.

- **Items** are the building blocks of the Fabric platform. They're the objects that you create and manage in Fabric. There are different types of items, such as data warehouses, data pipelines, datasets, reports, and dashboards.

Understanding Fabric concepts is important for you as an admin, because it helps you understand how to manage the Fabric environment.

- **Semantic models** hide the complex technical details behind reports so that both technical and non-technical users can concentrate on analyzing the data and answering business questions.
  - **Security:** Row-level security (RLS) rules that control which users can see specific data.

### Understand the Fabric Architecture Questions

- Is a semantic model required or optional?
- What is our Fabric capacity **[SKU](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)**?
- What is our domain, logical grouping of workspaces, structure?
- Does Structures have there own domain?
- Can Structures have multiple domains?

## Premium capacity workspace

### LS - Linamar Structures workspace

A Premium capacity workspace in Power BI is a dedicated server space, purchased by an organization, that allows for enhanced functionality and broader content sharing compared to standard workspaces. It enables users to access reports and dashboards without needing a Pro or Premium Per User (PPU) license, provided they have the necessary permissions. Premium capacities offer increased refresh rates, larger datasets, and the ability to share content with users who don't have a Pro license.

#### 1. Workspace questions

1. Is LS - Linamar Structures workspace changing to another name?
2. Is there a limit to the number of reports and shares?

## Power BI Pro License

Needed to publish reports.

### 2. Power BI Pro License questions

Should we limit Power BI Pro licenses or simply give each license owner the contributor role?

- Limited
  - Each fabric admin has one
  - Send reports to fabric admin to publish and share

- Contributor role
  - Any one with a Power BI Pro license is given the contributor role.
  - contributor can publish and share there own reports.

## **[Azure Data Lake Storage Gen2 (ADLS)](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction#:~:text=Azure%20Data%20Lake%20Storage%20offers,%2C%20account%2C%20and%20file%20levels.)**

- combines hierarchical and object storage
- built on Azure Blob Storage for object storage
- can store anything: data warehouse, plc data, excel file.
- connect to **[data lake file from excel](https://learn.microsoft.com/en-us/answers/questions/1817991/how-to-read-excel-file-data-(stored-in-adls-gen2-))**
- **[hierarchical namespace feature](https://docs.azure.cn/en-us/storage/blobs/data-lake-storage-namespace)**.
- **[Atomic directory manipulation](https://docs.azure.cn/en-us/storage/blobs/data-lake-storage-namespace#the-benefits-of-a-hierarchical-namespace)**
- **[OneLake is hierarchical in nature to simplify management across your organization.](https://learn.microsoft.com/en-us/training/modules/administer-fabric/2-fabric-architecture)**

## **[Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)**

- flat non-hierarchical
- provides object storage capabilities to Azure Data Lake Storage Gen2
- Used by One drive and Sharepoint.

## Windows file sharing

Windows file sharing primarily uses the Server Message Block (SMB) protocol to facilitate the sharing of files and folders over a network. This architecture allows multiple computers on a network to access and manage files stored on a central server, or on other individual computers. Windows also leverages NTFS permissions for granular access control to files and folders, complementing the share-level permissions for network access.

### 3. Storage questions

- Have we enabled **[hierarchical namespace in a storage account](https://docs.azure.cn/en-us/storage/blobs/create-data-lake-storage-account)**
- Is it feasible to move Window File shares to Linamar's OneLake?

## **[Azure SQL database to Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/database/sql/create)**

### **[How to connect to Azure SQL database in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/data-factory/connector-azure-sql-database)**

The most direct way to bring your Azure SQL Database into Microsoft Fabric is through Mirroring. This enables continuous replication of your existing Azure SQL Database data directly into Fabric's OneLake, enabling analysis and integration with other Fabric workloads.

### Prerequisites for mirroring Azure SQL Databases

Before mirroring, ensure you have an existing Azure SQL Database (single or elastic pool) with data to replicate, an active Fabric capacity or trial, enabled Fabric tenant settings ("Service principals can use Fabric APIs" and "Users can access data stored in OneLake with apps external to Fabric"), and a Member or Admin workspace role. You also need to configure network connectivity for Fabric to access your Azure SQL Database.

### Structures Azure SQL database

The Structures Azure SQL database is the Structures data warehouse.

- Structures ETL service destination for the following data sources:
  - Non-Microsoft ODBC connections to Plex Cloud ERP
  - SOAP and RESTful API live access to Plex ERP
  - **[Mach2 Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** reportable events.
  - **[Serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** CNC data.

### Azure SQL database to Microsoft Fabric Questions

Currently, structures has an Azure SQL database in a Structures resource group. What would be the cost impact if we moved it into Microsoft Fabric?

Team:

Tarek Mohamed - Data and Analytics IT - Supervisor
Cody Hudson - Fabric Administrator
Christian Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Jared Davis, IT Manager
Kevin Young, Information Systems Manager
Sam Jackson, Information Systems Developer, Southfield
Brad D. Cook, Quality Engineer, Fruitport
Jared Eikenberry, Quality Engineer, Fruitport
Ricardo Baca. Senior Manufacturing Eng, Southfield
Emmanuel Munoz Diaz - Microsoft Data and AI specialist - <emunozdias@microsoft.com>

## Links

- - **[PowerBI](https://app.powerbi.com/)**
- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

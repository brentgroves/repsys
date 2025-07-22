# Microsoft Fabric, Structures Work Space, Storage, and Power BI

Hi Team,

I would like to discuss some of the capabilites of Microsoft Fabric as it pertains to Structures file storage and Power BI reporting, as well as moving the Structures Azure SQL database to Microsoft Fabric. There are 3 questions below I would like to pose to the group. Finally, a meeting has been scheduled for this Friday at 2 PM. I hope you can attend.

- Thank you

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## Premium capacity workspace

### LS - Linamar Structures workspace

A Premium capacity workspace in Power BI is a dedicated server space, purchased by an organization, that allows for enhanced functionality and broader content sharing compared to standard workspaces. It enables users to access reports and dashboards without needing a Pro or Premium Per User (PPU) license, provided they have the necessary permissions. Premium capacities offer increased refresh rates, larger datasets, and the ability to share content with users who don't have a Pro license.

#### 1. Workspace questions

1. Is LS - Linamar Structures workspace changing to another name?

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

## **[Azure Data Lake Storage (ADLS)](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction#:~:text=Azure%20Data%20Lake%20Storage%20offers,%2C%20account%2C%20and%20file%20levels.)**

- hierarchical storage
- inexpensive
- can store anything: data warehouse, plc data, excel file.
- connect to **[data lake file from excel](https://learn.microsoft.com/en-us/answers/questions/1817991/how-to-read-excel-file-data-(stored-in-adls-gen2-))**

## **[Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)**

- flat non-hierarchical

## Windows file sharing

Windows file sharing primarily uses the Server Message Block (SMB) protocol to facilitate the sharing of files and folders over a network. This architecture allows multiple computers on a network to access and manage files stored on a central server, or on other individual computers. Windows also leverages NTFS permissions for granular access control to files and folders, complementing the share-level permissions for network access.

### 3. Storage questions

- Is it feasible to move Window File shares to Linamar's OneLake?

## **[Azure SQL database to Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/database/sql/create)**

**[How to connect to Azure SQL database in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/data-factory/connector-azure-sql-database)**

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

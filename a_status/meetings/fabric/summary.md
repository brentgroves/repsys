# Microsoft Fabric OneLake, Azure SQL database mirroring, Structures Work Space, Storage, and Power BI

## todo

### connect Plex to OneLake

From Azure Fabric we can connect to IFS through a RESTful API.  Find out the specifics.  Does it connect via **[OData](https://www.odata.org/)**?
From Azure Fabric can we connect to Plex ERP through its RESTful API like IFS?

### connect PLC sensors, scales, etc. to OneLake

### connect vending machines to OneLake

### Reports access OneLake. OneLake is the one data source we should use

Hi Team,

I would like to discuss OneLake, Azure SQL database mirroring, Fabric Workspaces and Items, Security, and Power BI report management. There are several questions below I would like to pose to the group. Finally, a meeting has been scheduled for this Friday at 2 PM. I hope you can attend.

- Thank you

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## OneLake

![i3](https://dataninjago.com/wp-content/uploads/2021/12/capture-1.png)

- Delta Parquet as its default format for storing all tabular data.
- Delta Lake builds upon the Parquet file format, adding features like transaction logs for managing data changes and versions, ensuring data integrity and enabling features like time travel.
- Parquet is a columnar storage file format designed for efficient data storage and retrieval, particularly in big data processing and analytics.

## Storage

![i1](https://docs.ceph.com/en/reef/_images/stack.png)

![i2](https://docs.ceph.com/en/reef/_images/ditaa-db39e087bb6fb671969d38bd44c9e71ff716334d.png)

- OneLake
Built on ADLS.
- Azure Data Lake Storage Gen2 (ADLS)
Adds Hierarchical and Object storage and HDFS drivers

- **[hierarchical namespace feature](https://docs.azure.cn/en-us/storage/blobs/data-lake-storage-namespace)**.
- **[Atomic directory manipulation](https://docs.azure.cn/en-us/storage/blobs/data-lake-storage-namespace#the-benefits-of-a-hierarchical-namespace)**
-  Azure Blob Storage
Object Storage for the Distributed storage cluster
-  Distributed Storage Cluster like Posix compliant Ceph
- Reads and Writes to disks
- snapshots
- replication

**[Azure Data Lake Storage Gen2 (ADLS)](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction#:~:text=Azure%20Data%20Lake%20Storage%20offers,%2C%20account%2C%20and%20file%20levels.)**

### Storage Questions

Have we enabled Hierarchical namespaces and are they easy to use?

## **[Azure SQL database to Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/database/sql/create)**

We have several schemas at present or coming shortly in our Azure SQL database such as Plex, Mach2, Tool Management, PLC data, and we want to take advantage of data analytic capabilities found in Fabric and star schemas.

The Structures Azure SQL database is the Structures data warehouse.

- Check if Plex supports **[OData](https://www.odata.org/)**
- Structures ETL service destination for the following data sources:
- Non-Microsoft ODBC connections to Plex Cloud ERP
- SOAP and RESTful API live access to Plex ERP
- **[Mach2 Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** reportable events.
- **[Serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** CNC data.

### **[Mirroring](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/azure-sql-database)**

The most direct way to bring your Azure SQL Database into Microsoft Fabric is through Mirroring. This enables continuous replication of your existing Azure SQL Database data directly into Fabric's OneLake, enabling analysis and integration with other Fabric workloads.

## features

- zero compute cost to mirror
- free storage based on your fabric capacity
- incremental replication of ddl changes and all inserts/update/deletes at near real-time
-  creates an analytics endpoint for queries against power bi, lake house, and all the other engines

### Prerequisites for mirroring Azure SQL Databases

Before mirroring, ensure you have an existing Azure SQL Database (single or elastic pool) with data to replicate, an active Fabric capacity or trial, enabled Fabric tenant settings ("Service principals can use Fabric APIs" and "Users can access data stored in OneLake with apps external to Fabric"), and a Member or Admin workspace role. You also need to configure network connectivity for Fabric to access your Azure SQL Database.

### Azure SQL database to Microsoft Fabric Questions

- Mirroring an Azure SQL database to Microsoft Fabric is free up to a certain capacity-based limit. Specifically, the compute used to replicate the data into OneLake is free, and so is the OneLake storage for the replica, up to a limit based on your purchased capacity,

- **[Mirroring](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/azure-sql-database)** Mirror happens in real time.

1. Would you allow Structures to do this and if so are Fabric Admin allowed to create data items like this?

**[how to mirror Azure SQL database](https://learn.microsoft.com/en-us/fabric/database/mirrored-database/azure-sql-database-tutorial)**

## **[Understand the Fabric Architecture](https://learn.microsoft.com/en-us/training/modules/administer-fabric/2-fabric-architecture)**

- **Capacity** A Microsoft Fabric capacity resides on a tenant. Each capacity that sits under a specific tenant is a distinct pool of resources allocated to Microsoft Fabric. The size of the capacity determines the amount of computation power available.
**f64**

- **Domain** is a logical grouping of workspaces. Domains are used to organize items in a way that makes sense for your organization. You can group things together in a way that makes it easier for the groups of people to have access to workspaces. For example, you might have a domain for sales, another for marketing, and another for finance.

- **Workspace** is a collection of items that brings together different functionality in a single tenant. It acts as a container that uses capacity for the work that is executed, and provides controls for who can access the items in it. For example, in a sales workspace, users associated with the sales organization can create a data warehouse, run notebooks, create datasets, create reports, and more.

**Access Control:** Workspaces have roles (Admin, Member, Contributor, Viewer) that define the level of access and permissions for users.

**Two Types:** There are "My Workspace" for personal use and "regular workspaces" for collaboration.

**LS - Linamar Structures workspace** A Premium capacity workspace in Power BI is a dedicated server space, purchased by an organization, that allows for enhanced functionality and broader content sharing compared to standard workspaces. It enables users to access reports and dashboards without needing a Pro or Premium Per User (PPU) license, provided they have the necessary permissions. Premium capacities offer increased refresh rates, larger datasets, and the ability to share content with users who don't have a Pro license.

- **Items** are the building blocks of the Fabric platform. They're the objects that you create and manage in Fabric. There are different types of items, such as data warehouses, data pipelines, datasets, reports, and dashboards.

- **Semantic models** hide the complex technical details behind reports so that both technical and non-technical users can concentrate on analyzing the data and answering business questions.
- **Security:** Row-level security (RLS) rules that control which users can see specific data.

### Understand the Fabric Architecture Questions

1. Is there any way to divide items in a workspace by locations?

  since premium capacity workspaces are expensive:
  A Microsoft Fabric Premium capacity workspace's cost is tied to the chosen capacity SKU, measured in Compute Units (CUs). For example, an F64 capacity SKU, which provides 64 CUs, costs approximately $8,410 USD per month on a pay-as-you-go basis. Premium capacity subscriptions start at $7,475 USD per month

2. Is the LS - Linamar Structures workspace going to change in the near future?
3. Is Row-level security managed by the Fabric Admin?
4. What is our Fabric capacity **[SKU](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)**?

## Power BI Pro License

Needed to publish and share reports.

### Power BI Pro License questions

Should we limit Power BI Pro licenses or simply give each license owner the contributor role?

- Limited
- Each fabric admin has one
- Send reports to fabric admin to publish and share
- Contributor role
- Anyone with a Power BI Pro license is given the contributor role.
- contributor can publish and share their own reports.

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
- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

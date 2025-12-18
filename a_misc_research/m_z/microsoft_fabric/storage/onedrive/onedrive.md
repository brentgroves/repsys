is onedrive made by azure blob storage

No, OneDrive is not made by Azure Blob Storage; rather, Azure Blob Storage is a service that OneDrive uses as part of its underlying infrastructure. OneDrive, which is part of Microsoft 365, relies on SharePoint, and SharePoint utilizes Azure Blob Storage for storing the actual file data. Azure provides the scalability and reliability for OneDrive's storage needs.
Here's a more detailed explanation:
OneDrive's core is SharePoint:
.
OneDrive is built on top of the SharePoint file platform.
Azure Blob Storage for file storage:
.
SharePoint (and therefore OneDrive) stores user content in Azure Blob Storage.
Azure provides the infrastructure:
.
Azure offers the scalability, redundancy, and durability needed for handling large volumes of user files securely.
Metadata in Azure SQL Database:
.
While the actual files are stored in Azure Blob Storage, metadata about those files (like file names, locations, and permissions) is stored in Azure SQL Database.
Microsoft 365 integration:
.
OneDrive is deeply integrated with Microsoft 365 apps like Word, Excel, and PowerPoint, allowing users to easily save and access files from these applications.

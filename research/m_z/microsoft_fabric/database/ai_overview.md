# how to create a azure sql database item in microsoft fabric

Creating an Azure SQL Database item in Microsoft Fabric
To create an Azure SQL Database item in Microsoft Fabric, follow these steps:
Access the Fabric Portal: Open the Microsoft Fabric portal and navigate to your preferred workspace or create a new one.
Select "Create": Locate and select the "Create" option within your workspace.
Choose "Mirrored Azure SQL Database": Scroll to the "Data Warehouse" section and select "Mirrored Azure SQL Database".
Enter Database Name and Create: Provide the name of the Azure SQL Database you wish to mirror and select "Create".

## Prerequisites for mirroring Azure SQL Databases

Before mirroring, ensure you have an existing Azure SQL Database (single or elastic pool) with data to replicate, an active Fabric capacity or trial, enabled Fabric tenant settings ("Service principals can use Fabric APIs" and "Users can access data stored in OneLake with apps external to Fabric"), and a Member or Admin workspace role. You also need to configure network connectivity for Fabric to access your Azure SQL Database.

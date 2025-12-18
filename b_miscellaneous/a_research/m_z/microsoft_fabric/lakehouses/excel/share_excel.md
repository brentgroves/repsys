# can i share an excel file in microsoft fabric

**[share](https://www.sqlservercentral.com/blogs/using-onelake-for-excel-files-in-microsoft-fabric#:~:text=So%20how%20did%20we%20do,been%20made%20to%20the%20file.)**

Hey data friends! This blog is to discuss an edge case I’ve run into in Microsoft Fabric. I won’t go into all the context, but the goal was to have an Excel file accessible to Microsoft Fabric without OneDrive, SharePoint, nor an on-premises data gateway. We also didn’t want a csv because we wanted to have multiple tabs and structured tables with formulas which won’t save properly in csv files.

So how did we do it? OneLake!

Lakehouses in Fabric can store data files very easily, including Excel files. It’s as simple as going to the Get data drop down in the lakehouse and selecting Upload files. However, you cannot edit the xlsx file nor view it from the Microsoft Fabric portal.

![i1](https://dataonwheels.wordpress.com/wp-content/uploads/2025/01/image-5.png)

If this sounds like a recipe for disaster with people overwriting each other’s information, you’re correct! But don’t worry, there’s a better way – the OneLake File Explorer! This tool will allow you to navigate through the files in Lakehouses in a OneDrive-like experience. From here, you can open and edit the Excel file locally and without having to redownload and upload the file from the online portal.

Yes, you can share an Excel file within Microsoft Fabric by uploading it to a Lakehouse or Warehouse and then sharing it using either item sharing with people in your organization or external data sharing for users in other tenants. You can also use the OneLake File Explorer to edit Excel files locally, which can then be synced back to Fabric. Alternatively, if the Excel file is already in a supported Microsoft 365 location like OneDrive, you can use the OneLake File Explorer to easily access it.

## Methods to Share Excel Files in Fabric

Share within your organization:

- Upload the Excel file to a Lakehouse or Warehouse.
- In the item list, or when viewing the item, select the Share button.
- Choose "People in your organization" and select your desired audience.

## Using OneLake File Explorer

- Install and use the OneLake File Explorer to view and edit files in your OneLake.
- You can open an Excel file from your local machine and edit it directly, then save to sync your changes to Fabric.

Connecting Excel to Fabric Data:
You can also connect Excel to data within Fabric by using the "Get Data" feature and the SQL Connection String for the Lakehouse or Warehouse.
This allows you to pull data from your Fabric environment into Excel for analysis.

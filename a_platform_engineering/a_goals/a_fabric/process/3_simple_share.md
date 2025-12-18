# Publish Power BI report

Ricardo,
This is my first time to publish a Power BI report in the Linamar Fabric workspace, so please bear with me. I will keep you posted as to my progress.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## 1. You could share this document in SharePoint or OneDrive

**[Share a document using SharePoint or OneDrive](https://support.microsoft.com/en-us/office/share-a-document-using-sharepoint-or-onedrive-807de6cf-1ece-41b9-a2b3-250d9a48f1e8)**

## 2. We could use OneLake but it is designed to move your data into the lakehouse and report on it using Power BI or other analytic tools

If we go this route the excel file would be formatted differently and it would just be used to sync data into a database. Also, a Power BI report and not an Excel file would be what we would share to Southfield employees.

**[Using OneLake for Excel Files in Microsoft Fabric](https://www.sqlservercentral.com/blogs/using-onelake-for-excel-files-in-microsoft-fabric#:~:text=So%20how%20did%20we%20do,been%20made%20to%20the%20file.)**

This involves getting the data into a database.

## step 1

Since the data contained in this Excel file is not in any database let's start by uploading it to our lakehouse file folder and creating a database schema for it.

## schema

One line has one or more machines.
One machine has one or more oils.
Each oils has a cost and the cost may change.
All date,line,machine,oils,costs should be reportable in any way desired.

## references

- **[Using OneLake for Excel Files in Microsoft Fabric](https://www.sqlservercentral.com/blogs/using-onelake-for-excel-files-in-microsoft-fabric#:~:text=So%20how%20did%20we%20do,been%20made%20to%20the%20file.)**
- **[OneLake file explorer](https://learn.microsoft.com/en-us/fabric/onelake/onelake-file-explorer)**
- **[new PBI mode in Fabric](https://data-mozart.com/what-do-allen-iverson-and-direct-lake-have-in-common/)**
- **[Lakehouse and Delta Lake tables](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables)**
- **[Options to get data into the Fabric Lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/load-data-lakehouse)**

- Thank you,

## team

Tarek Mohamed, Data and Analytics IT, Supervisor
Cody Hudson, Fabric Administrator
Mikael Boire, Operation Manager
Jose Pardo, Maintainence Manager
Ricardo Baca, Sr. Manufacturing Engineer, Southfield
Jose Pardo, Maintainence Manager
Jared Davis, IT Manager
Kevin Young, Information Systems Manager
Sam Jackson, Information Systems Developer, Southfield

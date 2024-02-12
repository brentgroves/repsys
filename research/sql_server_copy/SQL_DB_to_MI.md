# Export to a BACPAC file - Azure SQL Database and Azure SQL Managed Instance

When you need to export a database for archiving or for moving to another platform, you can export the database schema and data to a BACPAC file. A BACPAC file is a ZIP file with an extension of BACPAC containing the metadata and data from the database. A BACPAC file can be stored in Azure Blob storage or in local storage in an on-premises location and later imported back into Azure SQL Database, Azure SQL Managed Instance, or a SQL Server instance.

## references

<https://learn.microsoft.com/en-us/azure/azure-sql/database/database-export?view=azuresql>

When you need to export a database for archiving or for moving to another platform, you can export the database schema and data to a BACPAC file. A BACPAC file is a ZIP file with an extension of BACPAC containing the metadata and data from the database. A BACPAC file can be stored in Azure Blob storage or in local storage in an on-premises location and later imported back into Azure SQL Database, Azure SQL Managed Instance, or a SQL Server instance.

## Considerations

For an export to be transactionally consistent, you must ensure either that no write activity is occurring during the export, or that you're exporting from a transactionally consistent copy of your database.

If you're exporting to blob storage, the maximum size of a BACPAC file is 200 GB. To archive a larger BACPAC file, export to local storage with SqlPackage.

The Azure Storage file name can't end with . and can't contain special characters like a space character or <, >, *, %, &, :, \, /, ?. The file name should be fewer than 128 characters long.

If the export operation exceeds 20 hours, it might be canceled. To increase performance during export, you can:

Temporarily increase your compute size.
Cease all read and write activity during the export.
Use a clustered index with non-null values on all large tables. Without clustered indexes, an export might fail if it takes longer than 6-12 hours. This is because the export service needs to complete a table scan to try to export entire table. A good way to determine if your tables are optimized for export is to run DBCC SHOW_STATISTICS and make sure that the RANGE_HI_KEY isn't null and its value has good distribution. For details, see DBCC SHOW_STATISTICS.
For larger databases, BACPAC export/import might take a long time, and might fail for various reasons.

## note

BACPACs are not intended to be used for backup and restore operations. Azure automatically creates backups for every user database. For details, see business continuity overview and Automated backups in Azure SQL Database or Automated backups in Azure SQL Managed Instance.

## The Azure portal

Exporting a BACPAC of a database from Azure SQL Managed Instance using the Azure portal isn't currently supported.

## SQLPackage utility

We recommend the use of the SQLPackage utility for scale and performance in most production environments. You can run multiple SqlPackage commands in parallel for subsets of tables to speed up import/export operations.

To export a database in SQL Database using the SQLPackage command-line utility, see Export parameters and properties. The SQLPackage utility is available for Windows, macOS, and Linux.

This example shows how to export a database using SqlPackage with Active Directory Universal Authentication:

Windows Command Prompt

Copy
SqlPackage /a:Export /tf:testExport.BACPAC /scs:"Data Source=apptestserver.database.windows.net;Initial Catalog=MyDB;" /ua:True /tid:"apptest.onmicrosoft.com"

## Azure Data Studio

Azure Data Studio is a free, open-source tool and is available for Windows, Mac, and Linux. The "SQL Server dacpac" extension provides a wizard interface to SqlPackage operations including export and import. For more information on installing and using the extension, see SQL Server dacpac extension.

## Limitations

Exporting a BACPAC file to Azure premium storage using the methods discussed in this article isn't supported.

- Storage behind a firewall is currently not supported.
- Immutable storage is currently not supported.
- Azure SQL Managed Instance doesn't currently support exporting a database to a BACPAC file using the Azure portal or Azure PowerShell. To export a managed instance into a BACPAC file, use SQL Server Management Studio (SSMS) or SQLPackage.
- Currently, the Import/Export service does not support Microsoft Entra ID authentication when MFA is required.
- Import\Export services only support SQL authentication and Microsoft Entra ID. Import\Export is not compatible with Microsoft Identity application registration.

## next

<https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#installation-zip-download>

<https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16>

```bash
sudo apt update && sudo apt install -y dotnet-sdk-7.0
```

## Linux

Download **[SqlPackage for Linux](https://aka.ms/sqlpackage-linux)**.

To extract the file and launch SqlPackage, open a new Terminal window and type the following commands:

```bash
# sqlpackage-linux-x64-en-162.1.172.1
cd ~
mkdir sqlpackage
unzip ~/Downloads/sqlpackage-linux-x64-en-162.1.172.1.zip -d ~/sqlpackage 
echo "export PATH=\"\$PATH:$HOME/sqlpackage\"" >> ~/.bashrc
chmod a+x ~/sqlpackage/sqlpackage
source ~/.bashrc
sqlpackage
```

## NEXT

## **[SQL DB to MI data mobility with SqlPackage and BACPAC](https://www.youtube.com/watch?v=U7qTzwDVHHU)**

Recommended content:
What is SqlPackage: <https://learn.microsoft.com/sql/tools>...
Download and install SqlPackage: <https://learn.microsoft.com/sql/tools>...
Export to a BACPAC file: <https://learn.microsoft.com/azure/azu>...
BACPAC considerations: <https://learn.microsoft.com/azure/azu>...
Moving databases from Azure SQL Managed Instance to SQL Server: <https://techcommunity.microsoft.com/t>...
Restore a database to SQL Server from Azure SQL Managed Instance: <https://learn.microsoft.com/azure/azu>...
What is Azure SQL Managed Instance: <https://learn.microsoft.com/azure/azu>...
2022 – a year of unparalleled innovation in Azure SQL Managed Instance: <https://techcommunity.microsoft.com/t>...

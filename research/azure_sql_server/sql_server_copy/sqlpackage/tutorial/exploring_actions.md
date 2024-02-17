# Exploring sqlpackage actions

In this article, I am going to explain in detail about actions and tasks in the SQLPackage Utility. In my previous article, I have explained the overview of the SQLPackage utility. The SQLPackage utility is a command-line utility tool provided by Microsoft to automate SQL Server database deployments. Since this utility is cross-platform, you can easily install it on any operating system of your choice. SQLPackage actions are the types of functions that we can achieve with this utility. You can install this utility directly on any production server and it can be used as is. You can find more information about this utility and SQLPackage actions from the official documentation from Microsoft.

## references

<https://www.sqlshack.com/exploring-the-sqlpackage-actions/>

## Actions

In total, seven primary actions are provided in the SQLPackage utility:

- Extract – Used to create an extract from the database of a live SQL Server or Azure SQL Database
- Publish – Used to publish a DACPAC file from a local machine to the server
- Export – Exports a live database from the server with data to a BACPAC file
- Import – Used to import a BACPAC file to the SQL Server or Azure SQL Database
- DeployReport – Provides a list of changes in XML that are going to be applied once the database is published
- DriftReport – Provides a list of changes in XML that has been applied to a database after being registered
- Script – Generates a T-SQL script to incrementally update a database in SQL Server or Azure SQL Database

## Using Extract action

This action is used to create a DACPAC file from an existing database in the SQL Server or Azure SQL Database. Using this action, you can easily create a DACPAC file that will contain the schema and other objects in the database, but no data. The parameters for this action are as follows:

- Action – Extract
SourceDatabaseName – Name of the source database from which the DACPAC needs to be created
SourceServerName – The name of the server from which the DACPAC is to be created
- TargetFileName – Local path in which the DACPAC file is to be saved

```bash
sqlpackage
/action:Extract
/TargetFile:”C:\temp\SQLShackSnapshotExtract.dacpac”
/SourceDatabaseName:SQLShackSnapshot
/SourceServerName:”localhost”
```

## Using Publish action

As discussed above, the Publish action is used to deploy a DACPAC file incrementally to the database server. If the database does not exist, then a new database will be created. However, if the database already exists, then the utility will compare the differences between the source (DACPAC) and the destination (SQL Server Database) and generate the necessary scripts to update the database.

We can use the following parameters for this action to publish a DACPAC file:

- Action – Publish, since we are going to publish the DACPAC file to the database server
- SourceFile – The path of the source (DAPAC) file in the local machine
- TargetDatabaseName – The name of the database in the target server
- TargetServerName – The name of the target database server

```bash
sqlpackage
/action:Publish
/SourceFile:”C:\temp\SQLShackSnapshot.dacpac”
/TargetDatabaseName:SQLShackSnapshot
/TargetServerName:”localhost”


```

## Using Export action

The Export action is somewhat like the Extract function, except the fact that this action exports the data along with the schema of the database. The output file in case of the Export action is a BACPAC and not DACPAC. This file is usually bigger in size as the data is also exported in the file. The parameters for this action can be specified as follows:

- Action – Export. This is used to export the BACPAC file
- SourceDatabaseName – Name of the source database from which the BACPAC needs to be created
- SourceServerName – The name of the server from which the BACPAC is to be created
- TargetFileName – Local path in which the BACPAC file is to be saved

```bash
sqlpackage
/action:Export
/TargetFile:”C:\temp\SQLShackSnapshotExtract.bacpac”
/SourceDatabaseName:SQLShackSnapshot
/SourceServerName:”localhost”
```

## Using Import action

The Import action is just the opposite of the Export action. Using this action, you can easily restore a BACPAC file back to the database server in SQL Server or Azure SQL Database. This will restore the schema as well as the data which was exported while creating the BACPAC file. The parameters used to use the Import action are as follows:

- Action – Import, as the function is going to import a BACPAC file into the SQL Server
- SourceFile – The path of the source (BAPAC) file in the local machine
- TargetDatabaseName – The name of the database in the target server
- TargetServerName – The name of the target database server

```bash
sqlpackage
/action:Import
/SourceFile:”C:\temp\SQLShackSnapshotExtract.bacpac”
/TargetDatabaseName:SQLShackSnapshotImport
/TargetServerName:”localhost”


```

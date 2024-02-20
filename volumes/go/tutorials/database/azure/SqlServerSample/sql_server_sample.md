# Connect to Azure SQL

## references

<https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-go?view=azuresql>

## Connect to Azure SQL database

### Create a new folder for the Golang project and dependencies

From the terminal, create a new project folder called SqlServerSample.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/database/azure
mkdir SqlServerSample
cd SqlServerSample
```

### Create sample data

In a text editor, create a file called CreateTestData.sql in the SqlServerSample folder. In the file, paste this T-SQL code, which creates a schema, table, and inserts a few rows.

At the command prompt, navigate to SqlServerSample and use sqlcmd to connect to the database and run your newly created Azure SQL script. Replace the appropriate values for your server and database.

```bash
az login
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "isDefault": true,
    "managedByTenants": [],
    "name": "sub_mgmain_itservices",
    "state": "Enabled",
    "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "user": {
      "name": "bgroves@mobexglobal.com",
      "type": "user"
    }
  }
]
--Default Instance
sqlcmd -S mgsqlsrv.database.windows.net -U mgadmin -P WeDontSharePasswords1! -C -d mgdw2 
or
sqlcmd -S mgsqlsrv.database.windows.net -U mgadmin -P WeDontSharePasswords1! -C -d mgdw2 -i ./CreateTestData.sql
(3 rows affected)
Id          Name                                               Location                                          
----------- -------------------------------------------------- --------------------------------------------------
          1 Jared                                              Australia                                         
          2 Nikita                                             India                                             
          3 Astrid                                             Germany 

```

## Insert code to query the database

# sqlcmd

## references

<https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Clinux&pivots=cs1-bash>
[sqlcmd](https://www.mssqltips.com/sqlservertip/2478/connecting-to-sql-server-using-sqlcmd-utility/)
<https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Clinux&pivots=cs1-bash>

## connect

:Connect now has an optional -G parameter to select one of the authentication methods for Azure SQL Database - SqlAuthentication, ActiveDirectoryDefault, ActiveDirectoryIntegrated, ActiveDirectoryServicePrincipal, ActiveDirectoryManagedIdentity, ActiveDirectoryPassword. For more information, see Microsoft Entra authentication. If -G isn't provided, Integrated security or SQL Server authentication is used, depending on the presence of a -U user name parameter.

```bash
--Default Instance
sqlcmd -S mgsqlsrv.database.windows.net -U mgadmin -P WeDontSharePasswords1! -C -d mgdw2
sqlcmd -Q "SELECT * FROM AdventureWorks2022.Person.Person" -o MyOutput.txt

```

## Interactive sqlcmd example

```bash
sqlcmd
USE AdventureWorks2022;
GO
SELECT TOP (3) BusinessEntityID, FirstName, LastName
FROM Person.Person;
GO
```

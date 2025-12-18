# **[Connection Strings](https://learn.microsoft.com/en-us/sql/odbc/reference/develop-app/connection-strings?view=sql-server-ver17)**

06/25/2024
A connection string contains information used for establishing a connection. A complete connection string contains all the information needed to establish a connection. The connection string is a series of keyword/value pairs separated by semicolons. (For the complete syntax of a connection string, see the **[SQLDriverConnect](https://learn.microsoft.com/en-us/sql/odbc/reference/syntax/sqldriverconnect-function?view=sql-server-ver17)** function description.) The connection string is used by:

SQLDriverConnect, which completes the connection string by interaction with the user.

SQLBrowseConnect, which completes the connection string iteratively with the data source.

SQLConnect does not use a connection string; using SQLConnect is analogous to connecting using a connection string with exactly three keyword/value pairs (for data source name and, optionally, user ID and password).

## **[The Connection Strings Reference](https://www.connectionstrings.com/)**

## **[Azure SQL Database connection strings](https://www.connectionstrings.com/azure-sql-database/)**

```ini
Server=tcp:myserver.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=myPassword;Trusted_Connection=False;Encrypt=True;
```

## **[DSN connection strings](https://www.connectionstrings.com/dsn/)**

System DSN
`DSN=myDsn;Uid=myUsername;Pwd=;`

File DSN
`FILEDSN=c:\myDsnFile.dsn;Uid=myUsername;Pwd=;`

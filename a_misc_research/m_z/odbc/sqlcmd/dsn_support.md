# **[](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17&tabs=go%2Clinux%2Cwindows-support&pivots=cs1-bash#dsn-support-in-sqlcmd-and-bcp)**

## DSN support in sqlcmd and bcp

You can specify a data source name (DSN) instead of a server name in the sqlcmd or bcp -S option (or sqlcmd :Connect command) if you specify -D. -D causes sqlcmd or bcp to connect to the server specified in the DSN by the -S option.

System DSNs are stored in the odbc.ini file in the ODBC SysConfigDir directory (/etc/odbc.ini on standard installations). User DSNs are stored in .odbc.ini in a user's home directory (~/.odbc.ini).

On Windows systems, System and User DSNs are stored in the registry and managed via odbcad32.exe. bcp and sqlcmd don't support file DSNs.

See **[DSN and Connection String Keywords and Attributes](https://learn.microsoft.com/en-us/sql/connect/odbc/dsn-connection-string-attribute?view=sql-server-ver17)** for the list of entries that the driver supports.

In a DSN, only the DRIVER entry is required, but to connect to a remote server, sqlcmd or bcp needs a value in the SERVER element. If the SERVER element is empty or not present in the DSN, sqlcmd and bcp attempt to connect to the default instance on the local system.

When you use bcp on Windows systems, SQL Server 2017 (14.x) and earlier versions require the SQL Native Client 11 driver (sqlncli11.dll), while SQL Server 2019 (15.x) and later versions require the Microsoft ODBC Driver 17 for SQL Server driver (msodbcsql17.dll).

If the same option is specified in both the DSN and the sqlcmd or bcp command line, the command line option overrides the value used in the DSN. For example, if the DSN has a DATABASE entry and the sqlcmd command line includes -d, the value passed to -d is used. If Trusted_Connection=yes is specified in the DSN, Kerberos authentication is used; user name (-U) and password (-P), if provided, are ignored.

Existing scripts that invoke isql can be modified to use sqlcmd by defining the following alias: alias isql="sqlcmd -D".

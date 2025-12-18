# **[Microsoft SQL Server - Ubuntu based images](https://mcr.microsoft.com/product/mssql/server/about)**

About
Official Ubuntu based container images for Microsoft SQL Server for Docker Engine.

Featured tags
2022-latest
docker pull mcr.microsoft.com/mssql/server:2022-latest

2019-latest
docker pull mcr.microsoft.com/mssql/server:2019-latest

2017-latest
docker pull mcr.microsoft.com/mssql/server:2017-latest

Note: Starting with SQL Server 2022 (16.x) CU 14 and SQL Server 2019 (15.x) CU 28, container images include the new mssql-tools18 package. The previous directory /opt/mssql-tools/bin is being phased out. The new directory for Microsoft ODBC 18 tools is /opt/mssql-tools18/bin, aligning with the latest tools offering. For more information about changes and security enhancements, see ODBC Driver 18.0 for SQL Server Released. ODBC driver version 18 is designed with an encryption-first approach, ensuring that utilities like sqlcmd and bcp, which utilize the Microsoft ODBC driver, operate under the secure by default principle. Users who wish to disable encryption must do so explicitly.

For example when trying to connect using the sqlcmd tool, the -N option is available with [s|m|o] parameters, where 's' stands for strict, 'm' for mandatory, and 'o' for optional. The default setting is mandatory. For more information, see Connecting with sqlcmd - ODBC Driver for SQL Server. To connect without encryption, the sample command would be:

```bash
sqlcmd -S <ip address,port> -U <login_name> -P <yourpassword> -No
```

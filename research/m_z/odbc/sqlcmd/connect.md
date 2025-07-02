# **[Connect to SQL Server with sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-connect-database-engine?view=sql-server-ver17)**

## Overview

SQL Server supports client communication with the TCP/IP network protocol (the default), and the named pipes protocol. The shared memory protocol is also available if the client is connecting to an instance of the Database Engine on the same computer. There are three common methods of selecting the protocol. The protocol used by the sqlcmd utility is determined in the following order:

sqlcmd uses the protocol specified as part of the connection string, as described later in this article.

If no protocol is specified as part the connection string, sqlcmd uses the protocol defined as part of the alias that's connected. To configure sqlcmd to use a specific network protocol by creating an alias, see Create or delete a server alias for use by a client.

If the protocol isn't specified in some other way, sqlcmd uses the network protocol determined by the protocol order in SQL Server Configuration Manager.

The following examples show various ways of connecting to the default instance of Database Engine on port 1433, and named instances of Database Engine presumed to be listening on port 1691. Some of these examples use the IP address of the loopback adapter (127.0.0.1). Test using the IP address of your computer network interface card.

Connect to the Database Engine by specifying the instance name:

```bash
sqlcmd -D -S repsys1 -U repsys1 -P WeDontSharePasswords1!
select * from Plex.accounting_period_ranges
go
exit
sqlcmd -S ComputerA
sqlcmd -S ComputerA\instanceB
```

Connect to the Database Engine by specifying the IP address:

```BASH
sqlcmd -S 127.0.0.1
sqlcmd -S 127.0.0.1\instanceB
```

Connect to the Database Engine by specifying the TCP\IP port number:

```bash
sqlcmd -S ComputerA,1433
sqlcmd -S ComputerA,1691
sqlcmd -S 127.0.0.1,1433
sqlcmd -S 127.0.0.1,1691
```

Connect using TCP/IP
Connect using the following general syntax:

```bash
sqlcmd -S tcp:<computer name>,<port number>
```

Connect to the default instance:

```bash
sqlcmd -S tcp:ComputerA,1433
sqlcmd -S tcp:127.0.0.1,1433
```

```baah
sqlcmd -S tcp:ComputerA,1691
sqlcmd -S tcp:127.0.0.1,1691
```

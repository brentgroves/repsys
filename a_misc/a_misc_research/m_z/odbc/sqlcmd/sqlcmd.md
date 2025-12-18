# **[Use sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-use-utility?view=sql-server-ver17)**

sqlcmd is a command-line utility for ad hoc, interactive execution of Transact-SQL (T-SQL) statements and scripts and for automating T-SQL scripting tasks. To use sqlcmd interactively, or to build script files for sqlcmd, you should understand T-SQL. You can use sqlcmd in various ways. For example:

Enter T-SQL statements from the command prompt. The console returns the results. To open a Command Prompt window, enter cmd in the Windows search box and select Command Prompt to open. At the command prompt, type sqlcmd followed by a list of options that you want. For a complete list of the options that are supported by sqlcmd, see **[sqlcmd utility](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17)**.

Submit a sqlcmd job either by specifying a single T-SQL statement to execute, or by pointing the utility to a text file that contains T-SQL statements to execute. The output is directed to a text file, but can also be displayed at the command prompt.

SQLCMD mode in SQL Server Management Studio (SSMS) Query Editor.

SQL Server Management Objects (SMO).

SQL Server Agent CmdExec jobs.

```bash

Usage:
  sqlcmd [flags]
  sqlcmd [command]

Examples:
# Install/Create, Query, Uninstall SQL Server
  sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak
  sqlcmd open ads
  sqlcmd query "SELECT @@version"
  sqlcmd delete
# View configuration information and connection strings
  sqlcmd config view
  sqlcmd config cs

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  config      Modify sqlconfig files using subcommands like "sqlcmd config use-context mssql"
  create      Install/Create SQL Server, Azure SQL, and Tools
  delete      Uninstall/Delete the current context
  help        Help about any command
  open        Open tools (e.g ADS) for current context
  query       Run a query against the current context
  start       Start current context
  stop        Stop current context

Flags:
  -?, --?                  help for backwards compatibility flags (-S, -U, -E etc.)
  -h, --help               help for sqlcmd
      --sqlconfig string   configuration file (default "/Users/<currentUser>/.sqlcmd/sqlconfig")
      --verbosity int      log level, error=0, warn=1, info=2, debug=3, trace=4 (default 2)
      --version            print version of sqlcmd

Use "sqlcmd [command] --help" for more information about a command.
```

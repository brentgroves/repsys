# **[sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Clinux&pivots=cs1-bash)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

Installing sqlcmd (Go) via a package manager will replace sqlcmd (ODBC) with sqlcmd (Go) in your environment path. Any current command line sessions will need to be closed and reopened for this take to effect. sqlcmd (ODBC) won't be removed and can still be used by specifying the full path to the executable. You can also update your PATH variable to indicate which will take precedence.

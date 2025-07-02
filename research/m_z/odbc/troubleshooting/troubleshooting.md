# **[Troubleshooting connection problems](https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/known-issues-in-this-version-of-the-driver?view=sql-server-ver17&source=recommendations#connectivity)**

If you're unable to make a connection to SQL Server using the ODBC driver, use the following information to identify the problem.

The most common connection problem is to have two copies of the UnixODBC driver manager installed. Search /usr for libodbc*.so*. If you see more than one version of the file, you (possibly) have more than one driver manager installed. Your application might use the wrong version.

Enable the connection log by editing your /etc/odbcinst.ini file to contain the following section with these items:

```ini
[ODBC]
Trace = Yes
TraceFile = (path to log file, or /dev/stdout to output directly to the terminal)
```

If you get another connection failure and don't see a log file, there (possibly) are two copies of the driver manager on your computer. Otherwise, the log output should be similar to:

log

```bash
[ODBC][28783][1321576347.077780][SQLDriverConnectW.c][290]
        Entry:
            Connection = 0x17c858e0
            Window Hdl = (nil)
            Str In = [DRIVER={ODBC Driver 18 for SQL Server};SERVER={contoso.com};Trusted_Connection={YES};WSID={mydb.contoso.com};AP...][length = 139 (SQL_NTS)]
            Str Out = (nil)
            Str Out Max = 0
            Str Out Ptr = (nil)
            Completion = 0
        UNICODE Using encoding ASCII 'UTF8' and UNICODE 'UTF16LE'
```

If the ASCII character encoding isn't UTF-8, for example:

`UNICODE Using encoding ASCII 'ISO8859-1' and UNICODE 'UCS-2LE'`

There's more than one driver manager installed and your application is using the wrong one, or the driver manager wasn't built correctly.

Some macOS users encounter the following error with driver version 17.8 or older:
(This error has been resolved in driver version 17.9+)

```
[08001][Microsoft][ODBC Driver 17 for SQL Server]SSL Provider: [OpenSSL library could not be loaded, make sure OpenSSL 1.0 or 1.1 is installed]
[08001][Microsoft][ODBC Driver 17 for SQL Server]Client unable to establish connection (0) (SQLDriverConnect)
```

The error can happen when OpenSSL 3.0 is installed. OpenSSL typically is installed through Brew, and it contains the openssl, openssl@1.1, and openssl@3 binaries.

To resolve this error, change the symlink of the openssl binary to openssl@1.1:

```bash
rm -rf $(brew --prefix)/opt/openssl
version=$(ls $(brew --prefix)/Cellar/openssl@1.1 | grep "1.1")
ln -s $(brew --prefix)/Cellar/openssl@1.1/$version $(brew --prefix)/opt/openssl
```

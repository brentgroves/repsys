# ODBC Notes

## references

- **[plex drivers](https://www.revolutiongroup.com/wp-content/uploads/PSCC2102_UsingTodaysTechnologytoBetterServeYourPlex_TonyBrown.pdf)**
- **[personal access codes](../../../../secrets/plex/user_info.md)**
- **[dsn](../../../../odbc/odbc64.ini)**
- **[plex connection test](../../../../odbc/validation/odbc-dsn-plex.py)**
- **[drivers](https://viewers.plexonline.com/Plex_ODBC_v8_1_64_bit.zip)**
- **[Windows ODBC configuration](../../../../secrets/plex/windows_odbc_connection.md)**

- user 'mg.odbcalbion' has a personal access code which never expires.
- The **[plex connection test](../../../../odbc/validation/odbc-dsn-plex.py)** works from home on Linux.
- The **[plex connection test](../../../../odbc/validation/odbc-dsn-plex.py)** fails from work on Linux with the following error:

    ```bash
    Traceback (most recent call last):
    File "/home/brent/src/odbc/odbc-dsn-plextest.py", line 12, in <module>
        cnxn = pyodbc.connect('DSN=PlexTest;UID='+username+';PWD='+ password)
    pyodbc.OperationalError: ('08S01', '[08S01] [DataDirect][ODBC OpenAccess SDK driver][OpenAccess SDK Client]TCP/IP, connection reset by peer (2310) (SQLDriverConnect)')
  
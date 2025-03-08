# ODBC Notes

## references

- **[Best source Plex docs](https://docs.plex.com/pmc/en-us/integration/odbc/odbc.htm)**
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
  
- We will need a config request submitted with the **[firewall config form](https://linamarcorporation.sharepoint.com/:w:/r/sites/FITS/_layouts/15/Doc.aspx?sourcedoc=%7B4ECE7AB5-ABFD-4A82-9D68-3EFB22638688%7D&file=Firewall%20Config%20Request%20Form.docx&action=default&mobileredirect=true)** filled out. Make request to allow inbound/outbound connections to odbc.plex.com and test.odbc.plex.com on port 19995.

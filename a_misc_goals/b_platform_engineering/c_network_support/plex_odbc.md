# Plex ODBC connection from Linamar Networks Public IP

## **[Connection reset by peer (2310)](https://stackoverflow.com/questions/1434451/what-does-connection-reset-by-peer-mean)**

"Connection reset by peer (2310) (SQLDriverConnect)" indicates a network error where the connection to a SQL database was abruptly closed by the server, usually due to a network issue like a faulty connection, firewall blocking, or the server itself shutting down unexpectedly.

Note: If necessary, please ensure on your Firewall that both inbound and outbound communication on port 19995 is enabled as well as IP address 38.97.236.75 is whitelisted.  If you can do subnets in your firewall, please whitelist 38.97.236.0/24.  This is more scalable if additional IPs are added or changed in the future.

Plex does not have to whitelist our address, we may have to whitelist their address. I looked through all our previous Plex cases that have to do with ODBC and we never had to request an IP to be whitelisted.

Here’s the wiki article on connecting to ODBC

<https://www.plexonline.com/d388bb2f-9154-4807-9a53-39cf8b2911d0/Wiki/Wiki.asp?Wiki_Key=38640&ssAction=replace&FLH=&WikiButton=&WikiGraph=#658>

Our ODBC connection from Ligtel Avilla Public IP, 64.184.36.239, is not working.  ODBC connection from Ligtel Albion Public IP, 64.184.36.240 still works and should be kept.

Please Contact Plex Customer Care to request the IP addresses for ODBC.

64.184.36.239

<https://docs.plex.com/qms/en-us/integration/odbc/odbc.htm>

ODBC connection not working from Windows

Support No: 2920059

Our ODBC connection from Windows is no longer working.  Our ODBC connection still works from Linux.

Windows Driver from: progress_datadirect_oaodbc64_win_8_1_0_setup.exe
Data Source Name: Plex
Description: Plex ERP
Service Host: odbc.plex.com
Service Port: 19995
Service Data Source: ReportDataSource
Custom Properties:CompanyCode=BPG-IN;enableutf8=false

```
Data Source Name: Plex Test
Description: Plex ERP
Service Host: test.odbc.plex.com
Service Port: 19995
Service Data Source: ReportDataSource
Custom Properties:CompanyCode=BPG-IN;enableutf8=false

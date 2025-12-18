# **[GMicrosoft's official Go MSSQL driver](https://learn.microsoft.com/en-us/sql/connect/golang/microsoft-go-mssqldb-driver?view=sql-server-ver16)**

## reference

- **[driver page](https://github.com/microsoft/go-mssqldb#readme)**

## Install

Requires Go 1.17 or above.

Install with go install github.com/microsoft/go-mssqldb@latest.

## Connection Parameters and DSN

The recommended connection string uses a URL format: sqlserver://username:password@host/instance?param1=value&param2=value Other supported formats are listed below.

Common parameters

- user id - enter the SQL Server Authentication user id or the Windows Authentication user id in the DOMAIN\User format. On Windows, if user id is empty or missing Single-Sign-On is used. The user domain sensitive to the case which is defined in the connection string.
- password
- database
- connection timeout - in seconds (default is 0 for no timeout), set to 0 for no timeout. Recommended to set to 0 and use context to manage query and connection timeouts.
- dial timeout - in seconds (default is 15 times the number of registered protocols), set to 0 for no timeout.
- encrypt
  - strict - Data sent between client and server is encrypted E2E using TDS8.
  - disable - Data send between client and server is not encrypted.
  - false/optional/no/0/f - Data sent between client and server is not encrypted beyond the login packet. (Default)
  - true/mandatory/yes/1/t - Data sent between client and server is encrypted.

## Connection parameters for ODBC and ADO style connection strings

server - host or host\instance (default localhost)
port - specifies the host\instance port (default 1433). If instance name is provided but no port, the driver will use SQL Server Browser to discover the port.

## Less common parameters

keepAlive - in seconds; 0 to disable (default is 30)
failoverpartner - host or host\instance (default is no partner).
failoverport - used only when there is no instance in failoverpartner (default 1433)
packet size - in bytes; 512 to 32767 (default is 4096)
Encrypted connections have a maximum packet size of 16383 bytes
Further information on usage: <https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-network-packet-size-server-configuration-option>
log - logging flags (default 0/no logging, 255 for full logging)
1 log errors
2 log messages
4 log rows affected
8 trace sql statements
16 log statement parameters
32 log transaction begin/end
64 additional debug logs
128 log retries
TrustServerCertificate
false - Server certificate is checked. Default is false if encrypt is specified.
true - Server certificate is not checked. Default is true if encrypt is not specified. If trust server certificate is true, driver accepts any certificate presented by the server and any host name in that certificate. In this mode, TLS is susceptible to man-in-the-middle attacks. This should be used only for testing.
certificate - The file that contains the public key certificate of the CA that signed the SQL Server certificate. The specified certificate overrides the go platform specific CA certificates. Currently, certificates of PEM type are supported.
hostNameInCertificate - Specifies the Common Name (CN) in the server certificate. Default value is the server host.
tlsmin - Specifies the minimum TLS version for negotiating encryption with the server. Recognized values are 1.0, 1.1, 1.2, 1.3. If not set to a recognized value the default value for the tls package will be used. The default is currently 1.2.
ServerSPN - The kerberos SPN (Service Principal Name) for the server. Default is MSSQLSvc/host:port.
Workstation ID - The workstation name (default is the host name)
ApplicationIntent - Can be given the value ReadOnly to initiate a read-only connection to an Availability Group listener. The database must be specified when connecting with Application Intent set to ReadOnly.
protocol - forces use of a protocol. Make sure the corresponding package is imported.
columnencryption or column encryption setting - a boolean value indicating whether Always Encrypted should be enabled on the connection.
multisubnetfailover
true (Default) Client attempt to connect to all IPs simultaneously.
false Client attempts to connect to IPs in serial.

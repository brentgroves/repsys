# **[TDS 8.0](https://learn.microsoft.com/en-us/sql/relational-databases/security/networking/tds-8?view=sql-server-ver16)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

SQL Server 2022 (16.x), Azure SQL Database, and Azure SQL Managed Instance support Tabular Data Stream (TDS) 8.0.

The Tabular Data Stream (TDS) protocol is an application layer protocol used by clients to connect to SQL Server. SQL Server uses Transport Layer Security (TLS) to encrypt data that is transmitted across a network between an instance of SQL Server and a client application.

TDS is a secure protocol, but in previous versions of SQL Server, encryption could be turned off or not enabled. To meet the standards of mandatory encryption while using SQL Server, an iteration of the TDS protocol was introduced: TDS 8.0.

The TLS handshake now precedes any TDS messages, wrapping the TDS session in TLS to enforce encryption, making TDS 8.0 aligned with HTTPS and other web protocols. This significantly contributes to TDS traffic manageability, as standard network appliances are now able to filter and securely passthrough SQL queries.

Another benefit to TDS 8.0 compared to previous TDS versions is compatibility with TLS 1.3, and TLS standards to come. TDS 8.0 is also fully compatible with TLS 1.2 and previous TLS versions.

## How TDS works

The Tabular Data Stream (TDS) protocol is an application-level protocol used for the transfer of requests and responses between clients and database server systems. In such systems, the client typically establishes a long-lived connection with the server. Once the connection is established using a transport-level protocol, TDS messages are used to communicate between the client and the server.

During the TDS session lifespan, there are three phases:

- Initialization
- Authentication
- Data exchange

Encryption is negotiated during the initial phase, but TDS negotiation happens over an unencrypted connection. The SQL Server connection looks like this for prior versions to TDS 8.0:

TCP handshake ➡️ TDS prelogin (cleartext) and response (cleartext) ➡️ TLS handshake ➡️ authentication (encrypted) ➡️ data exchange (could be encrypted or unencrypted)

With the introduction of TDS 8.0, the SQL Server connections are as follows:

TCP handshake ➡️ TLS handshake ➡️ TDS prelogin (encrypted) and response (encrypted) ➡️ authentication (encrypted) ➡️ data exchange (encrypted)

## Strict connection encryption

To use TDS 8.0, SQL Server 2022 (16.x) added strict as an additional connection encryption type to SQL Server drivers (Encrypt=strict). To use the strict connection encryption type, download the latest version of the .NET, ODBC, OLE DB, JDBC, PHP, and Python drivers.

Microsoft ADO.NET for SQL Server and Azure SQL Database version 5.1 or higher
ODBC Driver for SQL Server version 18.1.2.1 or higher
OLE DB Driver for SQL Server version 19.2.0 or higher
Microsoft JDBC Driver for SQL Server version 11.2.0 or higher
Microsoft Drivers for PHP for SQL Server version 5.10 or higher
Python SQL Driver - pyodbc
In order to prevent a man-in-the-middle attack with strict connection encryption, users aren't able to set the TrustServerCertificate option to true and trust any certificate the server provided. Instead, users would use the HostNameInCertificate option to specify the certificate ServerName that should be trusted. The certificate supplied by the server would need to pass the certificate validation.

Additional changes to connection string encryption properties
The following additions are added to connection strings for encryption:

| Keyword                | Default | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|------------------------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Encrypt                | false   | Existing behavior When true, SQL Server uses TLS encryption for all data sent between the client and server if the server has a certificate installed. Recognized values are true, false, yes, and no. For more information, see Connection String Syntax.  Change of behavior When set to strict, SQL Server uses TDS 8.0 for all data sent between the client and server.  When set to mandatory, true, or yes, SQL Server uses TDS 7.x with TLS/SSL encryption for all data sent between the client and server if the server has a certificate installed.  When set to optional, false, or no, the connection uses TDS 7.x and would be encrypted only if required by the SQL Server.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| TrustServerCertificate | false   | Existing behavior Set to true to specify that the driver doesn't validate the server TLS/SSL certificate. If true, the server TLS/SSL certificate is automatically trusted when the communication layer is encrypted using TLS.  If false, the driver validates the server TLS/SSL certificate. If the server certificate validation fails, the driver raises an error and closes the connection. The default value is false. Make sure the value passed to serverName exactly matches the Common Name (CN) or DNS name in the Subject Alternate Name in the server certificate for a TLS/SSL connection to succeed.  Change of behavior for Microsoft ODBC Driver 18 for SQL Server If Encrypt is set to strict, this setting specifies the location of the certificate to be used for server certificate validation (exact match). The driver supports PEM, DER, and CER file extensions.  If Encrypt is set to true or false, and the TrustServerCertificate property is unspecified or set to null, true, or false, the driver uses the ServerName property value on the connection URL as the host name to validate the SQL Server TLS/SSL certificate. |
| HostNameInCertificate  | null    | The host name to be used in validating the SQL Server TLS/SSL certificate. If the HostNameInCertificate property is unspecified or set to null, the driver uses the ServerName property value as the host name to validate the SQL Server TLS/SSL certificate.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

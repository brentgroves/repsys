# **[ODBC SQL Server driver](https://learn.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server?view=sql-server-ver16)**

## Microsoft ODBC Driver for SQL Server

ODBC is the primary native data access API for applications written in C and C++ for SQL Server. There's an ODBC driver for most data sources. Other languages that can use ODBC include COBOL, Perl, PHP, and Python. ODBC is widely used in data integration scenarios.

The ODBC driver comes with tools such as sqlcmd and bcp. The sqlcmd utility lets you run Transact-SQL statements, system procedures, and SQL scripts. The bcp utility bulk copies data between an instance of Microsoft SQL Server and a data file in a format you choose. You can use bcp to import many new rows into SQL Server tables or to export data out of tables into data files.

Features

- Connection Resiliency
- Custom Keystore Providers
- Data Classification
- DSN and Connection String Keywords and Attributes

SQL Server Native Client (the features available also apply, without OLEDB, to the ODBC Driver for SQL Server)

Using Always Encrypted

Using Microsoft Entra ID (formerly Azure Active Directory)

Using Transparent Network IP Resolution

Using XA Transactions

Connection Troubleshooting

## **[DSN and Connection String Keywords and Attributes](https://learn.microsoft.com/en-us/sql/connect/odbc/dsn-connection-string-attribute?view=sql-server-ver16)**

This page lists the keywords for connection strings and DSNs, and connection attributes for SQLSetConnectAttr and SQLGetConnectAttr, available in the ODBC Driver for SQL Server.

### Supported DSN/Connection String Keywords and Connection Attributes

The following table lists the available keywords and the attributes for each platform (L: Linux; M: macOS; W: Windows). Select the keyword or attribute for more details.

## **[Data Classification](https://learn.microsoft.com/en-us/sql/connect/odbc/data-classification?view=sql-server-ver16)**

For managing sensitive data, SQL Server and Azure SQL Server introduced the ability to provide database columns with sensitivity metadata that allows the client application to handle different types of sensitive data (such as health, financial, etc.) in accordance with data protection policies.

For more information on how to assign classification to columns, see SQL Data Discovery and Classification.

Microsoft ODBC Driver 17.2 or later allows the retrieval of this metadata via SQLGetDescField using the SQL_CA_SS_DATA_CLASSIFICATION field identifier.

## **[Custom Keystore Providers](https://learn.microsoft.com/en-us/sql/connect/odbc/custom-keystore-providers?view=sql-server-ver16)**

The column encryption feature of SQL Server 2016 requires that the Encrypted Column Encryption Keys (ECEKs) stored on the server are retrieved by the client and then decrypted to Column Encryption Keys (CEKs) in order to access the data stored in encrypted columns. ECEKs are encrypted by Column Master Keys (CMKs), and the security of the CMK is important to the security of column encryption. Thus, the CMK should be stored in a secure location; the purpose of a Column Encryption Keystore Provider is to provide an interface to allow the ODBC driver to access these securely stored CMKs. For users with their own secure storage, the Custom Keystore Provider Interface provides a framework for implementing access to secure storage of the CMK for the ODBC driver, which can then be used to perform CEK encryption and decryption.

Each keystore provider contains and manages one or more CMKs, which are identified by key paths - strings of a format defined by the provider. This CMK, along with the encryption algorithm, also a string defined by the provider, can be used to perform the encryption of a CEK and the decryption of an ECEK. The algorithm, along with the ECEK and the name of the provider, are stored in the database's encryption metadata. For more information, see CREATE COLUMN MASTER KEY and CREATE COLUMN ENCRYPTION KEY. Thus, the two fundamental operations of key management are:

```bash
C++
CEK = DecryptViaCEKeystoreProvider(CEKeystoreProvider_name, Key_path, Key_algorithm, ECEK)

-and-

ECEK = EncryptViaCEKeystoreProvider(CEKeyStoreProvider_name, Key_path, Key_algorithm, CEK)
```

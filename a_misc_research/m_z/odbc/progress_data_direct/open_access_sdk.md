# **[OpenAccess SDK 8.1 (September 2016)](https://www.progress.com/open-access/release-history/openaccess-sdk-8.1-(september-2016))**

This new release is focused on security and performance for ever-growing data sets, as well as enhancing the experience of the ADO.NET provider. Key highlights of this release include:

OpenAccess SDK SQL Engine and IP SDK

Support for RIGHT OUTER JOIN operations
Improved support for nested join queries
Improved performance with indexed disk cache for nested query results
Improved calculation of precision of the scalar function result, based on precision of
input arguments
Support for configurable behavior to enforce an integrity constraint check when null
values are specified in non-nullable result columns with the IP_INFO_VALIDATE_NULL_CONSTRAINT ipGetinfo option
OpenAccess SDK Server

Support for service configurable option, ServiceNetworkBufferSize, to specify network
protocol buffer size
Support for service configurable option, ServiceSSLVersions, to specify the version of
cryptoprotocol to be used for encryption, when SSL is enabled
Upgrade of OpenSSL library to 1.0.2h

OpenAccess SDK Client for JDBC

Support for JDBC 4.0 specification
Support for the CryptoProtocolVersion connection option that specifies the version of the
SSL standard used for encryption, whenever SSL is enabled

## OpenAccess SDK Client for ODBC

Distribution of the sample Tableau TDC file with the OpenAccess ODBC client as a
standard component
Support for the CryptoProtocolVersion connection option that specifies the version of the
SSL standard that is used for encryption, whenever SSL is enabled
Upgrade of OpenSSL library to 1.0.2h

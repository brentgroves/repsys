# **[Encrypt connections to SQL Server on Linux](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-encrypted-connections?view=sql-server-ver16&tabs=client)**

SQL Server on Linux can use Transport Layer Security (TLS) to encrypt data that is transmitted across a network between a client application and an instance of SQL Server. SQL Server supports the same TLS protocols on both Windows and Linux: TLS 1.2, 1.1, and 1.0. However, the steps to configure TLS are specific to the operating system on which SQL Server is running.

Requirements for certificates
Before getting started, you need to make sure your certificates follow these requirements:

- The current system time must be after the Valid from property of the certificate and before the Valid to property of the certificate.

- The certificate must be meant for server authentication. This requires the Enhanced Key Usage property of the certificate to specify Server Authentication (1.3.6.1.5.5.7.3.1).

- The certificate must be created by using the KeySpec option of AT_KEYEXCHANGE. Usually, the certificate's key usage property (KEY_USAGE) also includes key encipherment (CERT_KEY_ENCIPHERMENT_KEY_USAGE).

- The Subject property of the certificate must indicate that the common name (CN) is the same as the host name or fully qualified domain name (FQDN) of the server computer.

Configure the OpenSSL libraries for use (optional)
You can create symbolic links in the /opt/mssql/lib/ directory that reference which libcrypto.so and libssl.so libraries should be used for encryption. This is useful if you want to force SQL Server to use a specific version of OpenSSL other than the default provided by the system. If these symbolic links aren't present, SQL Server loads the default configured OpenSSL libraries on the system.

These symbolic links should be named libcrypto.so and libssl.so and placed in the /opt/mssql/lib/ directory.

Ubuntu 20.04 and other recent Linux distribution releases
Symptom

When a SQL Server on Linux instance loads a certificate that was created with a signature algorithm using less than 112 bits of security (examples: MD5, SHA-1), you might observe a connection failure error, like this example:

A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.) (Microsoft SQL Server, Error: 10054)

The error is due to OpenSSL security level 2 being enabled by default on Ubuntu 20.04 and later versions. Security level 2 prohibits TLS connections that have less than 112 bits of security from being established.

Solution

Install a certificate with a signature algorithm using at least 112 bits of security. Signature algorithms that satisfy this requirement include SHA-224, SHA-256, SHA-384, and SHA-512.

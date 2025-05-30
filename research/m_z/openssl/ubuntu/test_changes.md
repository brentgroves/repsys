# **[Config file examples](https://documentation.ubuntu.com/server/explanation/crypto/openssl/#config-file-examples)**

## Let’s see some practical examples of how we can use the configuration file to tweak the default cryptographic settings of an application linked with OpenSSL

Note that applications can still override these settings: what is set in the configuration file merely acts as a default that is used when nothing else in the application command line or its own config says otherwise.

Only use TLSv1.3
To configure the OpenSSL library to consider TLSv1.3 as the minimum acceptable protocol, we add a MinProtocol parameter to the /etc/ssl/openssl.cnf configuration file like this:

```ini
[system_default_sect]
CipherString = DEFAULT:@SECLEVEL=2
MinProtocol = TLSv1.3
```

If you then try to connect securely to a server that only offers, say TLSv1.2, the connection will fail:

```bash
$ curl <https://j-server.lxd/stats>
curl: (35) error:0A00042E:SSL routines::tlsv1 alert protocol version

$ wget <https://j-server.lxd/stats>
--2023-01-06 13:41:50--  <https://j-server.lxd/stats>
Resolving j-server.lxd (j-server.lxd)... 10.0.100.87
Connecting to j-server.lxd (j-server.lxd)|10.0.100.87|:443... connected.
OpenSSL: error:0A00042E:SSL routines::tlsv1 alert protocol version
Unable to establish SSL connection.
```

## Use only AES256 with TLSv1.3

As an additional constraint, besides forcing TLSv1.3, let’s only allow AES256. This would do it for OpenSSL applications that do not override this elsewhere:

```ini
[system_default_sect]
CipherString = DEFAULT:@SECLEVEL=2
CipherSuites = TLS_AES_256_GCM_SHA384
MinProtocol = TLSv1.3
```

Since we are already forcing TLSv1.3, there is no need to tweak the CipherString list, since that applies only to TLSv1.2 and older.

The OpenSSL s_server command is very handy to test this (see the **[Troubleshooting](https://documentation.ubuntu.com/server/explanation/crypto/troubleshooting-tls-ssl/)** section for details on how to use it):

```bash
sudo openssl s_server -cert j-server.pem -key j-server.key -port 443 -www
```

Be sure to use another system for this server, or else it will be subject to the same /etc/ssl/openssl.cnf constraints you are testing on the client, and this can lead to very confusing results.

As expected, a client will end up selecting TLSv1.3 and the TLS_AES_256_GCM_SHA384 cipher suite:

```bash
$ wget <https://j-server.lxd/stats> -O /dev/stdout -q | grep Cipher -w
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
    Cipher    : TLS_AES_256_GCM_SHA384
```

To be sure, we can tweak the server to only offer TLS_CHACHA20_POLY1305_SHA256 for example:

```bash
sudo openssl s_server -cert j-server.pem -key j-server.key -port 443 -www -ciphersuites TLS_CHACHA20_POLY1305_SHA256
```

And now the client will fail:

```
wget <https://j-server.lxd/stats> -O /dev/stdout
--2023-01-06 14:20:55--  <https://j-server.lxd/stats>
Resolving j-server.lxd (j-server.lxd)... 10.0.100.87
Connecting to j-server.lxd (j-server.lxd)|10.0.100.87|:443... connected.
OpenSSL: error:0A000410:SSL routines::sslv3 alert handshake failure
Unable to establish SSL connection.
```

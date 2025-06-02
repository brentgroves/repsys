# **[](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/configuring-openssl-defaults.html)**

## 1.3.4 Configuring OpenSSL Defaults

Occasionally, you’ll run into a problem trying to configure some applications to use OpenSSL in a certain way, only to be frustrated if there are no configuration options to achieve what you need. In that situation, you can resort to changing the OpenSSL defaults.

On startup, OpenSSL will go through an initialization procedure that attempts to fetch the defaults from the filesystem. This procedure consists of the following steps:

1. Check the OPENSSL_CONF environment variable, which is expected to contain a path to the configuration file. This step is skipped if the binary has the setuid or setguid flag set.

2. Failing that, check the default system-wide location of the configuration directory specified at compile time. OpenSSL will look in this folder for a file called openssl.cnf.

This process ensures that there are a number of options available to control the defaults in a way that solves a particular need. We can change the default configuration of only one program or of all programs that run on the same server.

For the latter use case, use the version tool to determine the location of the default configuration file:

```bash
openssl version -d
OPENSSLDIR: "/usr/lib/ssl"
```

Now that we know how to change the defaults, the question instead becomes what to put into the configuration file. For the syntax of configuration files and detailed information, it’s best that you consult the official documentation.**[1](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/configuring-openssl-defaults.html#openssl-configuration_s4_para5_footnote1-fnote)** However, if you just need to reconfigure the cipher suite configuration, take a look at the following example that does just that:

```ini
[default_conf]
ssl_conf = ssl_section

[ssl_section]
system_default = system_default_section

[system_default_section]
MinProtocol = TLSv1.2
CipherString = DEFAULT:@SECLEVEL=2
Ciphersuites = TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256
Options = ServerPreference,PrioritizeChaCha
```

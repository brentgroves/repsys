# **[set lower security level](https://askubuntu.com/questions/1233186/ubuntu-20-04-how-to-set-lower-ssl-security-level)**

113

You don't have your config changes quite right. You need to add this to the beginning of your config file:

openssl_conf = default_conf
And then this to the end:

```ini
[ default_conf ]

ssl_conf = ssl_sect

[ssl_sect]

system_default = system_default_sect

[system_default_sect]
MinProtocol = TLSv1.2
CipherString = DEFAULT:@SECLEVEL=1
```

Note that if you prefer you can make changes to a local copy of the config file, and then ensure your process is started with the environment variable OPENSSL_CONF defined to point at the location of your config file:

export OPENSSL_CONF=/path/to/my/openssl.cnf
This way you can make changes without having to impact your entire system.

Note: To find the system's openssl.cnf file, run the following:

```bash
openssl version -d
```

the run ls -l on the directory outputted to see where the openssl.cnf file is via its symlink in that directory as needed.

## answer two

For any system add at the top of openssl.cnf:

```bash

openssl_conf = default_conf
and at end of openssl.cnf:

For Debian add:

[system_default_sect]
MinProtocol = TLSv1.0
CipherString = DEFAULT@SECLEVEL=2
For Ubuntu 20.04 add:

[system_default_sect]
MinProtocol = TLSv1    #important !
CipherString = DEFAULT@SECLEVEL=2 # in my case works good with very old software
```

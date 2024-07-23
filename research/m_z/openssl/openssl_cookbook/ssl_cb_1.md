# **[openssl cookbook](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/determine-version-and-configuration.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

The definitive guide to using the OpenSSL command line for configuration and testing. Topics covered in this book include key and certificate management, server configuration, a step by step guide to creating a private CA, and testing of online services. Written by Ivan Ristić.

## references

- **[man page](https://www.openssl.org/docs/manmaster/man3/SSL_CTX_get_security_level.html)**

## Determine OpenSSL Version and Configuration

Before you do any work, you should know which OpenSSL version you’ll be using. TLS and PKI continue to develop at a fairly rapid pace, and you may find that what you can do is limited if your version of OpenSSL doesn’t support them. Here’s what I get for version information with openssl version on Ubuntu 20.04 LTS, which is the system that I’ll be using for the examples in this chapter:

```bash
$ openssl version
OpenSSL 1.1.1f  31 Mar 2020
```

At the time of writing, OpenSSL 1.1.1 is the dominant branch used in production and has all the nice features. On older systems, you may find a release from the 1.1.0 branch, which is fine because it can be used securely with TLS 1.2, but it won’t support modern features, such as TLS 1.3. In the other direction is OpenSSL 3.0, which introduces a major update of the libraries, with substantial architectural changes and a switch to the Apache License 2.0 for better interoperability with other programs and libraries. The command-line tooling, which is what I am covering in this chapter and the next, should be pretty much the same. That said, every release—and especially the major ones—is very likely to change the tools’ behavior, often in subtle ways. When you’re changing from one branch to another, it’s worth going through the change documentation to understand what the differences might be.

Note\
Although you wouldn’t know it from looking at the version number, various operating systems often don’t actually ship the exact official OpenSSL releases. More often than not, they contain forks that are either customized for a specific platform or patched to address various known issues. However, the version number generally stays the same, and there is no indication that the code is a fork of the original project that may have different capabilities. Keep this in mind if you notice something unexpected.

To get complete version information, use the -a switch:

```bash
$ openssl version -a
OpenSSL 1.1.1f  31 Mar 2020
built on: Mon Apr 20 11:53:50 2020 UTC
platform: debian-amd64
options:  bn(64,64) rc4(16x,int) des(int) blowfish(ptr) 
compiler: gcc -fPIC -pthread -m64 -Wa,--noexecstack -Wall -Wa,--noexecstack -g -O2 -fdebug-prefix-map=/build/openssl-P_ODHM/openssl-1.1.1f=. -fstack-protector-strong -Wformat -Werror=format-security -DOPENSSL_TLS_SECURITY_LEVEL=2 -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM -DNDEBUG -Wdate-time -D_FORTIFY_SOURCE=2
OPENSSLDIR: "/usr/lib/ssl"
ENGINESDIR: "/usr/lib/x86_64-linux-gnu/engines-1.1"
Seeding source: os-specific

conda activate reports
openssl version -a    
OpenSSL 1.1.1v  1 Aug 2023
built on: Fri Aug  4 00:07:48 2023 UTC
platform: linux-x86_64
options:  bn(64,64) rc4(16x,int) des(int) idea(int) blowfish(ptr) 
compiler: /croot/openssl_1691107624243/_build_env/bin/x86_64-conda-linux-gnu-cc -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/miniconda3/envs/reports/include -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/miniconda3/envs/reports/include -fdebug-prefix-map=/croot/openssl_1691107624243/work=/usr/local/src/conda/openssl-1.1.1v -fdebug-prefix-map=/home/brent/miniconda3/envs/reports=/usr/local/src/conda-prefix -Wa,--noexecstack -fPIC -pthread -m64 -Wa,--noexecstack -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/brent/miniconda3/envs/reports/include -fdebug-prefix-map=/croot/openssl_1691107624243/work=/usr/local/src/conda/openssl-1.1.1v -fdebug-prefix-map=/home/brent/miniconda3/envs/reports=/usr/local/src/conda-prefix -Wa,--noexecstack -DOPENSSL_USE_NODELETE -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM -DNDEBUG -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/brent/miniconda3/envs/reports/include
OPENSSLDIR: "/home/brent/miniconda3/envs/reports/ssl"
ENGINESDIR: "/home/brent/miniconda3/envs/reports/lib/engines-1.1"
Seeding source: os-specific
```

I don’t suppose that you would find this output very interesting initially, but it’s useful to know where you can find out how your OpenSSL was compiled. Of special interest is the OPENSSLDIR setting, which in my example points to /usr/lib/ssl; it will tell you where OpenSSL looks for its default configuration and root certificates. On my system, that location is essentially an alias for /etc/ssl, Ubuntu’s main location for PKI-related files:

```bash
lrwxrwxrwx  1 root root   14 Apr 20 11:53 certs -> /etc/ssl/certs
drwxr-xr-x  2 root root 4096 May 14 21:38 misc
lrwxrwxrwx  1 root root   20 Apr 20 11:53 openssl.cnf -> /etc/ssl/openssl.cnf
lrwxrwxrwx  1 root root   16 Apr 20 11:53 private -> /etc/ssl/private
```

The misc/ folder contains a few supplementary scripts, the most interesting of which are the scripts that allow you to implement a private certification authority (CA). You may or may not end up using it, but later in this chapter I will show you how to do the equivalent work from scratch.

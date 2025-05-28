# **[1.1.2 Building OpenSSL](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/building-openssl.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

In most cases, you will be using the system-supplied version of OpenSSL, but sometimes there are good reasons to use a newer or indeed an older version. For example, if you have an older system, it may be stuck with a version of OpenSSL that does not support TLS 1.3. On the other side, newer OpenSSL versions might not support SSL 2 or SSL 3. Although this is the right thing to do in a general case, you’ll need support for these older features if your job is to test systems for security.

You can start by downloading the most recent version of OpenSSL (in my case, 1.1.1g):

`wget <https://www.openssl.org/source/openssl-1.1.1g.tar.gz>`

The next step is to configure OpenSSL before compilation. For this, you will usually use the config script, which first attempts to guess your architecture and then runs through the configuration process:

```bash
./config \
--prefix=/opt/openssl \
--openssldir=/opt/openssl \
no-shared \
-DOPENSSL_TLS_SECURITY_LEVEL=2 \
enable-ec_nistp_64_gcc_128
```

The automated architecture detection can sometimes fail (e.g., with older versions of OpenSSL on OS X), in which case you should instead invoke the Configure script with the explicit architecture string. The configuration syntax is otherwise the same.

Unless you’re sure you want to do otherwise, it is essential to use the --prefix option to install OpenSSL to a private location that doesn’t clash with the system-provided version. Getting this wrong may break your server. The other important option is no-shared, which forces static linking and makes self-contained command-line tools. If you don’t use this option, you’ll need to play with your LD_LIBRARY_PATH configuration to get your tools to work.

When compiling OpenSSL 1.1.0 or later, the OPENSSL_TLS_SECURITY_LEVEL option configures the default security level, which establishes default minimum security requirements for all library users. It’s very useful to set this value at compile time as it can be used to prevent configuration mistakes. I discuss security levels in more detail later in this chapter.

The enable-ec_nistp_64_gcc_128 parameter activates optimized versions of certain frequently used **[elliptic curves](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/)**. This optimization depends on a compiler feature that can’t be automatically detected, which is why it’s disabled by default. The complete set of configuration options is available on the **[OpenSSL wiki.1](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/building-openssl.html#building-openssl_para7_footnote1-fnote)**

An elliptic curve is the set of points that satisfy a specific mathematical equation. The equation for an elliptic curve looks something like this:

y2 = x3 + ax + b

That graphs to something that looks a bit like the Lululemon logo tipped on its side:

![i1](https://cf-assets.www.cloudflare.com/zkvhlag99gkb/7C9LODC0OpfZlr9E8kqrSP/4248aa3bd2bf09e9f2c5eb7073c8ccfe/image00.png)

There are other representations of elliptic curves, but technically an elliptic curve is the set points satisfying an equation in two variables with degree two in one of the variables and three in the other. An elliptic curve is not just a pretty picture, it also has some properties that make it a good setting for cryptography.

Note
When compiling software, it’s important to be familiar with the default configuration of your compiler. System-provided packages are usually compiled using various hardening options, but if you compile some software yourself there is no guarantee that the same options will be used.**[2](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/building-openssl.html#building-openssl_note1_para1_footnote1-fnote)**

If you’re compiling a version before 1.1.0, you’ll need to build the dependencies first:

`make depend`

OpenSSL 1.1.0 and above will do this automatically, so you can proceed to build the main package with the following:

```bash
make
make test
sudo make install
```

You’ll get the following in /opt/openssl:

```bash
drwxr-xr-x 2 root root  4096 Jun  3 08:49 bin
drwxr-xr-x 2 root root  4096 Jun  3 08:49 certs
drwxr-xr-x 3 root root  4096 Jun  3 08:49 include
drwxr-xr-x 4 root root  4096 Jun  3 08:49 lib
drwxr-xr-x 6 root root  4096 Jun  3 08:48 man
drwxr-xr-x 2 root root  4096 Jun  3 08:49 misc
-rw-r--r-- 1 root root 10835 Jun  3 08:49 openssl.cnf
drwxr-xr-x 2 root root  4096 Jun  3 08:49 private
```

The private/ folder is empty, but that’s normal; you do not yet have any private keys. On the other hand, you’ll probably be surprised to learn that the certs/ folder is empty too. OpenSSL does not include any root certificates; maintaining a trust store is considered outside the scope of the project. Luckily, your operating system probably already comes with a trust store that you can use immediately. The following worked on my server:

```bash
cd /opt/openssl
sudo rmdir certs
sudo ln -s /etc/ssl/certs
```

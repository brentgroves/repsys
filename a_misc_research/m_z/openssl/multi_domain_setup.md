# **[Multi-Domain SSL Setup with “Subject Alternative Names”](https://easyengine.io/wordpress-nginx/tutorials/ssl/multidomain-ssl-subject-alternative-names/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

SSL Setup for multiple domains/subdomains is different than single-domain or wildcard domain setup. There are 2-ways to setup this (as far as I know) – using **[Subject Alternative Names](https://en.wikipedia.org/wiki/SubjectAltName)** and **[Server Name Indication (SNI)](https://en.wikipedia.org/wiki/Server_Name_Indication)**

In this article, we will use “Subject Alternative Names” method.

## Use Cases

This tutorial is intended for following types of use case. If you are trying to setup something else, please ignore this.

- non-www and www version of your site
- example.com
- <www.example.com>

wildcard (all subdomains) and apex/root/naked domain

- example.com
- *.example.com

Please note that most wildcard SSL do not protect your root domain i.e. example.com

altogether different domains

- example.com
- example.net
- google.com
- rtcamp.com
- <www.example.com>

## Process

Different companies offers different type of SSL certificates. They have different type of interfaces for CSR signing and certificate generation. So we will outline process on your server-side only (which should remain common across all Ubuntu server)

OpenSSL Config File

Copy OpenSSL conf

By default, when you are are running OpenSSL commands, it is picking config from `/etc/ssl/openssl.cnf` file.

Unless you are configuring only one certificate on your server, it’s better to copy OpenSSL config file to website’s cert folder:

`cp /etc/ssl/openssl.cnf /var/www/example.com/cert/example.com.cnf`

## Editing Config File

Open `/var/www/example.com/cert/example.com.cnf`

Look for  [ req ] section. Find add uncomment following line:

`req_extensions = v3_req`

If you don’t find a line like above, you can add one.

This will make sure our next section [ v3_req ] is read/used.

In [ v3_req ] section, add following line:

`subjectAltName = @alt_names`

It will look like:

```bash
[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
```

Finally add a new section called [ alt_names ] towards end of file listing all domain variation you are planning to use.

```bash
[ alt_names ]
DNS.1 = www.example.com
DNS.2 = example.com
```

**Note:** I couldn’t  find out whether we need to add domain used in common-name field again here. So I added it again here. Now in common-field, we use `www.example.com` version – if SSL is for www and non-www versions of domains.

Now you have your OpenSSL config file ready.

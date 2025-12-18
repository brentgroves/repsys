# **[TLS Certificate Verification](https://curl.se/docs/sslcerts.html)**

## Native vs file based

If curl was built with Schannel or Secure Transport support, then curl uses the system native CA store for verification. All other TLS libraries use a file based CA store by default.

## Verification

Every trusted server certificate is digitally signed by a Certificate Authority, a CA.

In your local CA store you have a collection of certificates from trusted certificate authorities that TLS clients like curl use to verify servers.

curl does certificate verification by default. This is done by verifying the signature and making sure the certificate was crafted for the server name provided in the URL.

If you communicate with HTTPS, FTPS or other TLS-using servers using certificates signed by a CA whose certificate is present in the store, you can be sure that the remote server really is the one it claims to be.

If the remote server uses a self-signed certificate, if you do not install a CA cert store, if the server uses a certificate signed by a CA that is not included in the store you use or if the remote host is an impostor impersonating your favorite site, the certificate check fails and reports an error.

If you think it wrongly failed the verification, consider one of the following sections.

## Skip verification

Tell curl to not verify the peer with -k/--insecure.

We strongly recommend this is avoided and that even if you end up doing this for experimentation or development, never skip verification in production.

## Use a custom CA store

Get a CA certificate that can verify the remote server and use the proper option to point out this CA cert for verification when connecting - for this specific transfer only.

With the curl command line tool: --cacert [file]

If you use the curl command line tool without a native CA store, then you can specify your own CA cert file by setting the environment variable CURL_CA_BUNDLE to the path of your choice. SSL_CERT_FILE and SSL_CERT_DIR are also supported.

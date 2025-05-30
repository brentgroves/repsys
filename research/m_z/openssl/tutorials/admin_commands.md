# # **[6 OpenSSL command options that every sysadmin should know](https://www.redhat.com/en/blog/6-openssl-commands)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

Transport layer security (TLS) is an important part of any security strategy, and applications beyond web servers increasingly take advantage of the protections offered by public-key cryptography. The OpenSSL toolkit is the fundamental utility that any systems administrator must know if they are responsible for maintaining TLS-protected applications. In this article, I demonstrate some of the most common commands that I use daily. While many articles focus on the generation of certificate signing requests (CSRs) or self-signed certificates, this article will spend some time reviewing OpenSSL commands and one-liners beyond the certificate generation process.

[ You might also enjoy: Making CA certificates available to Linux command-line tools ]

## show certs

```bash
openssl s_client -showcerts -connect baeldung.com:443
```

## Checking certificate validity

One of the most common troubleshooting steps that you’ll take is checking the basic validity of a certificate chain sent by a server, which can be accomplished by the openssl s_client command. The example below shows a successfully verified certificate chain sent by a server (redhat.com) after a connection on port 443. The -brief flag excludes some of the more verbose output that OpenSSL would normally display. Note that the "Verification" is output as "OK."

By default, openssl s_client will read from standard input for data to send to the remote server. Appending an echo to the one-liner sends a newline and immediately terminates the connection. Without this, you would need to press Ctrl+C to quit the connection.

```bash
echo | openssl s_client -connect redhat.com:443 -brief
CONNECTION ESTABLISHED
Protocol version: TLSv1.3
Ciphersuite: TLS_AES_256_GCM_SHA384
Peer certificate: C = US, ST = North Carolina, L = Raleigh, O = "Red Hat, Inc.", CN = redhat.com
Hash used: SHA256
Signature type: RSA-PSS
Verification: OK
Server Temp Key: X25519, 253 bits
DONE
```

Contrast the above output with the example below. In this output, you can clearly see that the verification failed with an error: “self-signed certificate.”

```bash
echo | openssl s_client -connect self-signed.badssl.com:443 -brief
depth=0 C = US, ST = California, L = San Francisco, O = BadSSL, CN = *.badssl.com
verify error:num=18:self-signed certificate
CONNECTION ESTABLISHED
Protocol version: TLSv1.2
Ciphersuite: ECDHE-RSA-AES128-GCM-SHA256
Peer certificate: C = US, ST = California, L = San Francisco, O = BadSSL, CN = *.badssl.com
Hash used: SHA512
Signature type: RSA
Verification error: self-signed certificate
Supported Elliptic Curve Point Formats: uncompressed:ansiX962_compressed_prime:ansiX962_compressed_char2
Server Temp Key: ECDH, prime256v1, 256 bits
DONE
```

## Determining when a certificate expires

Every sysadmin has experienced the embarrassment that follows from allowing a certificate for a public-facing website to expire. There are plenty of monitoring tools to keep an eye on this and ensure that it doesn’t happen to you, but what if you just want to quickly check a certificate’s expiration date from the command line? OpenSSL has you covered.

Checking the expiration date of a certificate involves a one-liner composed of two OpenSSL commands: s_client and x509. You already saw how s_client establishes a connection to a server in the previous example. By piping the output into x509, you can obtain the certificate’s validity period by using the -dates flag. Below are examples for both a valid and an expired certificate.

```bash
# A valid certificate that hasn’t expired yet
echo | openssl s_client -connect redhat.com:443 2>/dev/null | openssl x509 -noout -dates
notBefore=Jul  9 00:00:00 2019 GMT
notAfter=Aug  2 12:00:00 2021 GMT

# A certificate that expired in 2015
echo | openssl s_client -connect expired.badssl.com:443 2>/dev/null | openssl x509 -noout -dates
notBefore=Apr  9 00:00:00 2015 GMT
notAfter=Apr 12 23:59:59 2015 GMT
```

Note: If you receive a default SSL certificate in place of the server certificate, check out this explanation of **[SNI (Server Name Indication)](https://major.io/2012/02/07/using-openssls-s_client-command-with-web-servers-using-server-name-indication-sni/)**.

## Checking certificate extensions

X509 extensions allow for additional fields to be added to a certificate. One of the most common is the subject alternative name (SAN). The SAN of a certificate allows multiple values (e.g., multiple FQDNs) to be associated with a single certificate. The SAN is even used when there aren’t multiple values because the use of a certificate’s common name for verification is deprecated.

Similar to the previous one-liner, piping output between multiple OpenSSL commands makes it easy to inspect specific certificate extensions and allows you to view the SANs associated with a certificate:

```bash
echo | openssl s_client -connect redhat.com:443 2>/dev/null | openssl x509 -noout -ext subjectAltName
X509v3 Subject Alternative Name:
    DNS:*.redhat.com, DNS:redhat.com
```

Another common set of extensions include the basic constraints and key usage of a certificate. Specifically, you might want to check if a certificate is allowed to be used as a certificate authority. Again, this can be done in the same way that you can check for a SAN:

```bash
openssl x509 -ext basicConstraints,keyUsage -noout -in /usr/share/ca-certificates/mozilla/VeriSign_Universal_Root_Certification_Authority.crt
X509v3 Basic Constraints: critical
    CA:TRUE
X509v3 Key Usage: critical
    Certificate Sign, CRL Sign
```

## Checking deprecated TLS ciphers or versions

Excellent web-based tools, such as **[Qualys SSL Lab](https://www.ssllabs.com/ssltest/)**, exist to provide you with a full report on the security of your TLS configuration. This includes alerting you to the use of insecure cipher suites and other configuration parameters that may weaken the security posture of a TLS-protected resource. However, you might just want to run a quick test from the command line, and OpenSSL makes this easy.

First, you can list the supported ciphers for a particular SSL/TLS version using the openssl ciphers command. Below, you can see that I have listed out the supported ciphers for TLS 1.3. The -s flag tells the ciphers command to only print those ciphers supported by the specified TLS version (-tls1_3):

```bash
openssl ciphers -s -tls1_3
TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256
```

The s_client command can then be used to test different TLS versions and cipher suites. The **[Ciphersuites.info](https://ciphersuite.info/)** website is a useful repository of information about the strength of various cipher suites. As an example, attempting to use the weak TLS_PSK_WITH_AES_128_CBC_SHA suite against a server that doesn’t support it will result in an error:

```BASH
openssl s_client -connect redhat.com:443 -cipher PSK-AES128-CBC-SHA -quiet -no_tls1_3
139963477378368:error:141A90B5:SSL routines:ssl_cipher_list_to_bytes:no ciphers available:../ssl/statem/statem_clnt.c:3794:No ciphers enabled for max supported SSL/TLS version
```

Similarly, you can specify the version of the TLS protocol used in the connection. The example below shows that TLS 1.1 isn’t supported by the server. Be sure to review the manpage to see a full list of options.

```bash
openssl s_client -connect redhat.com:443 -tls1_1 -quiet
139890998576448:error:141E70BF:SSL routines:tls_construct_client_hello:no protocols available:../ssl/statem/statem_clnt.c:1112:
```

## Inspecting a certificate

I’ve covered looking at particular parts of a certificate, such as validity dates or X509 extensions. Sometimes, you just want to see everything about a specific certificate. The X509 utility can be used with the -noout (to suppress printing the encoded certificate), -text (to print out text information about the certificate), and the -in (to specify the input file) flags to print out everything you’d want to know about a particular certificate. The example below uses a certificate file on my local system, but you could just as easily pipe the output from openssl s_client, as seen in the previous examples.

```bash
$ openssl x509 -text -noout -in /usr/share/ca-certificates/mozilla/VeriSign_Universal_Root_Certification_Authority.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            40:1a:c4:64:21:b3:13:21:03:0e:bb:e4:12:1a:c5:1d
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = US, O = "VeriSign, Inc.", OU = VeriSign Trust Network, OU = "(c) 2008 VeriSign, Inc. - For authorized use only", CN = VeriSign Universal Root Certification Authority
        Validity
            Not Before: Apr  2 00:00:00 2008 GMT
            Not After : Dec  1 23:59:59 2037 GMT
        Subject: C = US, O = "VeriSign, Inc.", OU = VeriSign Trust Network, OU = "(c) 2008 VeriSign, Inc. - For authorized use only", CN = VeriSign Universal Root Certification Authority
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c7:61:37:5e:b1:01:34:db:62:d7:15:9b:ff:58:
                    5a:8c:23:23:d6:60:8e:91:d7:90:98:83:7a:e6:58:
                    19:38:8c:c5:f6:e5:64:85:b4:a2:71:fb:ed:bd:b9:
                    da:cd:4d:00:b4:c8:2d:73:a5:c7:69:71:95:1f:39:
                    3c:b2:44:07:9c:e8:0e:fa:4d:4a:c4:21:df:29:61:
                    8f:32:22:61:82:c5:87:1f:6e:8c:7c:5f:16:20:51:
                    44:d1:70:4f:57:ea:e3:1c:e3:cc:79:ee:58:d8:0e:
                    c2:b3:45:93:c0:2c:e7:9a:17:2b:7b:00:37:7a:41:
                    33:78:e1:33:e2:f3:10:1a:7f:87:2c:be:f6:f5:f7:
                    42:e2:e5:bf:87:62:89:5f:00:4b:df:c5:dd:e4:75:
                    44:32:41:3a:1e:71:6e:69:cb:0b:75:46:08:d1:ca:
                    d2:2b:95:d0:cf:fb:b9:40:6b:64:8c:57:4d:fc:13:
                    11:79:84:ed:5e:54:f6:34:9f:08:01:f3:10:25:06:
                    17:4a:da:f1:1d:7a:66:6b:98:60:66:a4:d9:ef:d2:
                    2e:82:f1:f0:ef:09:ea:44:c9:15:6a:e2:03:6e:33:
                    d3:ac:9f:55:00:c7:f6:08:6a:94:b9:5f:dc:e0:33:
                    f1:84:60:f9:5b:27:11:b4:fc:16:f2:bb:56:6a:80:
                    25:8d
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Key Usage: critical
                Certificate Sign, CRL Sign
            1.3.6.1.5.5.7.1.12:
                0_.].[0Y0W0U..image/gif0!0.0...+..............k...j.H.,{..0%.#http://logo.verisign.com/vslogo.gif
            X509v3 Subject Key Identifier:
                B6:77:FA:69:48:47:9F:53:12:D5:C2:EA:07:32:76:07:D1:97:07:19
    Signature Algorithm: sha256WithRSAEncryption
         4a:f8:f8:b0:03:e6:2c:67:7b:e4:94:77:63:cc:6e:4c:f9:7d:
         0e:0d:dc:c8:b9:35:b9:70:4f:63:fa:24:fa:6c:83:8c:47:9d:
         3b:63:f3:9a:f9:76:32:95:91:b1:77:bc:ac:9a:be:b1:e4:31:
         21:c6:81:95:56:5a:0e:b1:c2:d4:b1:a6:59:ac:f1:63:cb:b8:
         4c:1d:59:90:4a:ef:90:16:28:1f:5a:ae:10:fb:81:50:38:0c:
         6c:cc:f1:3d:c3:f5:63:e3:b3:e3:21:c9:24:39:e9:fd:15:66:
         46:f4:1b:11:d0:4d:73:a3:7d:46:f9:3d:ed:a8:5f:62:d4:f1:
         3f:f8:e0:74:57:2b:18:9d:81:b4:c4:28:da:94:97:a5:70:eb:
         ac:1d:be:07:11:f0:d5:db:dd:e5:8c:f0:d5:32:b0:83:e6:57:
         e2:8f:bf:be:a1:aa:bf:3d:1d:b5:d4:38:ea:d7:b0:5c:3a:4f:
         6a:3f:8f:c0:66:6c:63:aa:e9:d9:a4:16:f4:81:d1:95:14:0e:
         7d:cd:95:34:d9:d2:8f:70:73:81:7b:9c:7e:bd:98:61:d8:45:
         87:98:90:c5:eb:86:30:c6:35:bf:f0:ff:c3:55:88:83:4b:ef:
         05:92:06:71:f2:b8:98:93:b7:ec:cd:82:61:f1:38:e6:4f:97:
         98:2a:5a:8d

```

## Generating some random data

At this point, you’ve become comfortable with connecting to servers and inspecting certificates. I’ll end with one final trick that frequently comes in handy for me. The openssl rand command can be used to generate pseudo-random bytes. The -base64 flag will base64 encode the output, providing you with a random string that can be used as a password or for other applications that require a random string. Just make sure that the number of bytes is divisible by three to avoid padding.

```bash
$  openssl rand -base64 9
Emo+xQINmYoU
```

[ Get this free book from Red Hat and O'Reilly - Kubernetes Operators: Automating the Container Orchestration Platform. ]

## Wrap up

In this article, you learned some basic OpenSSL commands that can make your daily life as a systems administrator easier. OpenSSL is a very powerful suite of tools (and software library), and this article only touched the surface of its functionality. However, these commands are both a good starting point for developing further knowledge of OpenSSL and a useful set of tools to have in the toolbox of any sysadmin who regularly works with TLS-protected servers.

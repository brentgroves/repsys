# # **[openssl-s_client - SSL/TLS client program](https://manpages.ubuntu.com/manpages/kinetic/en/man1/openssl-s_client.1ssl.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

## test azure sql db connection

```bash
echo | openssl s_client -connect repsys1.database.windows.net:1433
...
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 2048 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
...
```

## test plex odbc connection

```bash
echo | openssl s_client -connect odbc.plex.com:19995
...
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---

```

## try 2

```bash
echo | openssl s_client -connect odbc.plex.com:19995 -security_debug_verbose


echo | openssl s_client -connect odbc.plex.com:19995 -trace
CONNECTED(00000003)
Sent Record
Header:
  Version = TLS 1.0 (0x301)
  Content Type = Handshake (22)
  Length = 310
    ClientHello, Length=306
      client_version=0x303 (TLS 1.2)
      Random:
        gmt_unix_time=0x6E6AB17B
        random_bytes (len=28): 8BFB22E193FB66B24C716AC8FEAB2F00678DDE9C93F9D58301632676
      session_id (len=32): A5C35A331D0F84B917517A989D09FA741AB6E04831180624076A3BED7E4B0830
      cipher_suites (len=62)
        {0x13, 0x02} TLS_AES_256_GCM_SHA384
        {0x13, 0x03} TLS_CHACHA20_POLY1305_SHA256
        {0x13, 0x01} TLS_AES_128_GCM_SHA256
        {0xC0, 0x2C} TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        {0xC0, 0x30} TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        {0x00, 0x9F} TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
        {0xCC, 0xA9} TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
        {0xCC, 0xA8} TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        {0xCC, 0xAA} TLS_DHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        {0xC0, 0x2B} TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        {0xC0, 0x2F} TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        {0x00, 0x9E} TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
        {0xC0, 0x24} TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
        {0xC0, 0x28} TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        {0x00, 0x6B} TLS_DHE_RSA_WITH_AES_256_CBC_SHA256
        {0xC0, 0x23} TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
        {0xC0, 0x27} TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
        {0x00, 0x67} TLS_DHE_RSA_WITH_AES_128_CBC_SHA256
        {0xC0, 0x0A} TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
        {0xC0, 0x14} TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
        {0x00, 0x39} TLS_DHE_RSA_WITH_AES_256_CBC_SHA
        {0xC0, 0x09} TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
        {0xC0, 0x13} TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0x33} TLS_DHE_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0x9D} TLS_RSA_WITH_AES_256_GCM_SHA384
        {0x00, 0x9C} TLS_RSA_WITH_AES_128_GCM_SHA256
        {0x00, 0x3D} TLS_RSA_WITH_AES_256_CBC_SHA256
        {0x00, 0x3C} TLS_RSA_WITH_AES_128_CBC_SHA256
        {0x00, 0x35} TLS_RSA_WITH_AES_256_CBC_SHA
        {0x00, 0x2F} TLS_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0xFF} TLS_EMPTY_RENEGOTIATION_INFO_SCSV
      compression_methods (len=1)
        No Compression (0x00)
      extensions, length = 171
        extension_type=server_name(0), length=18
          0000 - 00 10 00 00 0d 6f 64 62-63 2e 70 6c 65 78 2e   .....odbc.plex.
          000f - 63 6f 6d                                       com
        extension_type=ec_point_formats(11), length=4
          uncompressed (0)
          ansiX962_compressed_prime (1)
          ansiX962_compressed_char2 (2)
        extension_type=supported_groups(10), length=22
          ecdh_x25519 (29)
          secp256r1 (P-256) (23)
          ecdh_x448 (30)
          secp521r1 (P-521) (25)
          secp384r1 (P-384) (24)
          ffdhe2048 (256)
          ffdhe3072 (257)
          ffdhe4096 (258)
          ffdhe6144 (259)
          ffdhe8192 (260)
        extension_type=session_ticket(35), length=0
        extension_type=encrypt_then_mac(22), length=0
        extension_type=extended_master_secret(23), length=0
        extension_type=signature_algorithms(13), length=42
          ecdsa_secp256r1_sha256 (0x0403)
          ecdsa_secp384r1_sha384 (0x0503)
          ecdsa_secp521r1_sha512 (0x0603)
          ed25519 (0x0807)
          ed448 (0x0808)
          rsa_pss_pss_sha256 (0x0809)
          rsa_pss_pss_sha384 (0x080a)
          rsa_pss_pss_sha512 (0x080b)
          rsa_pss_rsae_sha256 (0x0804)
          rsa_pss_rsae_sha384 (0x0805)
          rsa_pss_rsae_sha512 (0x0806)
          rsa_pkcs1_sha256 (0x0401)
          rsa_pkcs1_sha384 (0x0501)
          rsa_pkcs1_sha512 (0x0601)
          ecdsa_sha224 (0x0303)
          rsa_pkcs1_sha224 (0x0301)
          dsa_sha224 (0x0302)
          dsa_sha256 (0x0402)
          dsa_sha384 (0x0502)
          dsa_sha512 (0x0602)
        extension_type=supported_versions(43), length=5
          TLS 1.3 (772)
          TLS 1.2 (771)
        extension_type=psk_key_exchange_modes(45), length=2
          psk_dhe_ke (1)
        extension_type=key_share(51), length=38
            NamedGroup: ecdh_x25519 (29)
            key_exchange:  (len=32): 87B3B61A48050196FA5E11762B3933191FDBC9DA00CDA16DF684225C622DB15D

Received Record
Header:
  Version = TLS 1.2 (0x303)
  Content Type = Alert (21)
  Length = 2
    Level=fatal(2), description=handshake failure(40)

805B55960B7A0000:error:0A000410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure:../ssl/record/rec_layer_s3.c:1599:SSL alert number 40
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 7 bytes and written 315 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
 ✘ bre
```

-cipher cipherlist
This allows the TLSv1.2 and below cipher list sent by the client to be modified.  This
list will be combined with any TLSv1.3 ciphersuites that have been configured.
Although the server determines which ciphersuite is used it should take the first
supported cipher in the list sent by the client. See openssl-ciphers(1) for more
information.

-ciphersuites val
This allows the TLSv1.3 ciphersuites sent by the client to be modified. This list will be combined with any TLSv1.2 and below ciphersuites that have been configured.
Although the server determines which cipher suite is used it should take the first
supported cipher in the list sent by the client. See openssl-ciphers(1) for more
information. The format for this list is a simple colon (":") separated list of
TLSv1.3 ciphersuite names.

## CONNECTED COMMANDS

       If a connection is established with an SSL server then any data received from the server
       is displayed and any key presses will be sent to the server. If end of file is reached
       then the connection will be closed down. When used interactively (which means neither
       -quiet nor -ign_eof have been given), then certain commands are also recognized which
       perform special operations. These commands are a letter which must appear at the start of
       a line. They are listed below.

       Q   End the current SSL connection and exit.

       R   Renegotiate the SSL session (TLSv1.2 and below only).

       k   Send a key update message to the server (TLSv1.3 only)

       K   Send a key update message to the server and request one back (TLSv1.3 only)

## This command can be used to debug SSL servers. To connect to an SSL HTTP server the

       command:

        openssl s_client -connect servername:443

       would typically be used (https uses port 443). If the connection succeeds then an HTTP
       command can be given such as "GET /" to retrieve a web page.

       If the handshake fails then there are several possible causes, if it is nothing obvious
       like no client certificate then the -bugs, -ssl3, -tls1, -no_ssl3, -no_tls1 options can be
       tried in case it is a buggy server. In particular you should play with these options
       before submitting a bug report to an OpenSSL mailing list.

```bash
echo | openssl s_client -connect odbc.plex.com:19995 -tls1_2 -trace
CONNECTED(00000003)
Sent Record
Header:
  Version = TLS 1.0 (0x301)
  Content Type = Handshake (22)
  Length = 205
    ClientHello, Length=201
      client_version=0x303 (TLS 1.2)
      Random:
        gmt_unix_time=0xE6F788A2
        random_bytes (len=28): 6C4E0180A90798A4DB542F98C2EE0F80AD81062521173379795E63A6
      session_id (len=0): 
      cipher_suites (len=56)
        {0xC0, 0x2C} TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        {0xC0, 0x30} TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        {0x00, 0x9F} TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
        {0xCC, 0xA9} TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
        {0xCC, 0xA8} TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        {0xCC, 0xAA} TLS_DHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        {0xC0, 0x2B} TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        {0xC0, 0x2F} TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        {0x00, 0x9E} TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
        {0xC0, 0x24} TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
        {0xC0, 0x28} TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        {0x00, 0x6B} TLS_DHE_RSA_WITH_AES_256_CBC_SHA256
        {0xC0, 0x23} TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
        {0xC0, 0x27} TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
        {0x00, 0x67} TLS_DHE_RSA_WITH_AES_128_CBC_SHA256
        {0xC0, 0x0A} TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
        {0xC0, 0x14} TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
        {0x00, 0x39} TLS_DHE_RSA_WITH_AES_256_CBC_SHA
        {0xC0, 0x09} TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
        {0xC0, 0x13} TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0x33} TLS_DHE_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0x9D} TLS_RSA_WITH_AES_256_GCM_SHA384
        {0x00, 0x9C} TLS_RSA_WITH_AES_128_GCM_SHA256
        {0x00, 0x3D} TLS_RSA_WITH_AES_256_CBC_SHA256
        {0x00, 0x3C} TLS_RSA_WITH_AES_128_CBC_SHA256
        {0x00, 0x35} TLS_RSA_WITH_AES_256_CBC_SHA
        {0x00, 0x2F} TLS_RSA_WITH_AES_128_CBC_SHA
        {0x00, 0xFF} TLS_EMPTY_RENEGOTIATION_INFO_SCSV
      compression_methods (len=1)
        No Compression (0x00)
      extensions, length = 104
        extension_type=server_name(0), length=18
          0000 - 00 10 00 00 0d 6f 64 62-63 2e 70 6c 65 78 2e   .....odbc.plex.
          000f - 63 6f 6d                                       com
        extension_type=ec_point_formats(11), length=4
          uncompressed (0)
          ansiX962_compressed_prime (1)
          ansiX962_compressed_char2 (2)
        extension_type=supported_groups(10), length=12
          ecdh_x25519 (29)
          secp256r1 (P-256) (23)
          ecdh_x448 (30)
          secp521r1 (P-521) (25)
          secp384r1 (P-384) (24)
        extension_type=session_ticket(35), length=0
        extension_type=encrypt_then_mac(22), length=0
        extension_type=extended_master_secret(23), length=0
        extension_type=signature_algorithms(13), length=42
          ecdsa_secp256r1_sha256 (0x0403)
          ecdsa_secp384r1_sha384 (0x0503)
          ecdsa_secp521r1_sha512 (0x0603)
          ed25519 (0x0807)
          ed448 (0x0808)
          rsa_pss_pss_sha256 (0x0809)
          rsa_pss_pss_sha384 (0x080a)
          rsa_pss_pss_sha512 (0x080b)
          rsa_pss_rsae_sha256 (0x0804)
          rsa_pss_rsae_sha384 (0x0805)
          rsa_pss_rsae_sha512 (0x0806)
          rsa_pkcs1_sha256 (0x0401)
          rsa_pkcs1_sha384 (0x0501)
          rsa_pkcs1_sha512 (0x0601)
          ecdsa_sha224 (0x0303)
          rsa_pkcs1_sha224 (0x0301)
          dsa_sha224 (0x0302)
          dsa_sha256 (0x0402)
          dsa_sha384 (0x0502)
          dsa_sha512 (0x0602)

Received Record
Header:
  Version = TLS 1.2 (0x303)
  Content Type = Alert (21)
  Length = 2
    Level=fatal(2), description=handshake failure(40)

802B1EF18B7B0000:error:0A000410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure:../ssl/record/rec_layer_s3.c:1599:SSL alert number 40
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 7 bytes and written 210 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : 0000
    Session-ID: 
    Session-ID-ctx: 
    Master-Key: 
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1748644757
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
---

# tls1_1
echo | openssl s_client -connect odbc.plex.com:19995 -tls1_1 

CONNECTED(00000003)
801BEC2F5D7C0000:error:0A0000BF:SSL routines:tls_setup_handshake:no protocols available:../ssl/statem/statem_lib.c:104:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 0 bytes and written 7 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---

# use specific cipher

openssl s_client -cipher 'ADH@SECLEVEL=0' -tls1_2 -connect odbc.plex.com:19995
CONNECTED(00000003)
---
no peer certificate available
---
No client certificate CA names sent
Server Temp Key: DH, 1024 bits
---
SSL handshake has read 605 bytes and written 372 bytes
Verification: OK
---
New, SSLv3, Cipher is ADH-AES128-SHA
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ADH-AES128-SHA
    Session-ID: 18B59FD94C99352751D5918411CEFA32B0054D79B2C6C5BA40383659C0E29379
    Session-ID-ctx: 
    Master-Key: 7540705F45FBAC9D16FBDB177EC5771CE305D4F3AAE292F23B013519AA24174331A6B80833F2551976E6CC40838C0A69
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 1440 (seconds)
    TLS session ticket:
    0000 - c7 89 f2 8e db cb 15 e1-e5 e1 45 53 93 2b 38 11   ..........ES.+8.
    0010 - 8e 0f 68 4c 76 b4 68 dc-04 b6 a0 ea 3d d8 81 1a   ..hLv.h.....=...
    0020 - 65 b4 88 5c 43 74 f5 3b-ba d5 7a eb e8 df 4f d8   e..\Ct.;..z...O.
    0030 - 61 67 01 61 6f 71 73 61-bd 2c 8e d0 ae e5 f3 42   ag.aoqsa.,.....B
    0040 - ca d5 36 a1 7e 80 d8 f7-d0 9d 09 f9 30 a2 f6 da   ..6.~.......0...
    0050 - 06 12 19 e3 d2 1c e6 8b-9a 0d 77 1d df 5b 6c d3   ..........w..[l.
    0060 - 19 9f 44 ec 52 12 30 5a-45 b3 8c 6c f4 63 96 41   ..D.R.0ZE..l.c.A
    0070 - a0 0d 00 64 af 38 ed 09-3f 7d a9 d1 44 7f 46 2c   ...d.8..?}..D.F,
    0080 - 7e d6 b8 37 df 7d 87 3e-54 64 61 0f e8 1d c5 87   ~..7.}.>Tda.....
    0090 - c2 1c 7c e3 33 21 06 ad-f5 f0 8e d5 0a 6a d7 67   ..|.3!.......j.g
    00a0 - 59 86 41 82 68 2f 89 41-98 20 4e 47 a3 6f 86 df   Y.A.h/.A. NG.o..

    Start Time: 1748645375
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
---
GIOP    803BE0CFB0730000:error:0A000126:SSL routines:ssl3_read_n:unexpected eof while reading:../ssl/record/rec_layer_s3.c:316:

# specific cipher suite from sslscan
# works
openssl s_client -cipher 'ADH-AES128-SHA:@SECLEVEL=0' -tls1_2 -connect odbc.plex.com:19995

# works
openssl s_client -cipher 'ALL:@SECLEVEL=0' -tls1_2 -connect odbc.plex.com:19995

# works
openssl s_client -cipher 'ALL:@SECLEVEL=0' -connect odbc.plex.com:19995

openssl s_client -cipher 'ALL:@SECLEVEL=0' -connect odbc.plex.com:19995

```

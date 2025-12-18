# How to connect to Plex ODBC

```bash
openssl ciphers -s -v 'TLSv1.2'
openssl ciphers -s -v 'DEFAULT:@SECLEVEL=0'
TLS_AES_256_GCM_SHA384         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(256)            Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256   TLSv1.3 Kx=any      Au=any   Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(128)            Mac=AEAD
ECDHE-ECDSA-AES256-GCM-SHA384  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(256)            Mac=AEAD
ECDHE-RSA-AES256-GCM-SHA384    TLSv1.2 Kx=ECDH     Au=RSA   Enc=AESGCM(256)            Mac=AEAD
DHE-RSA-AES256-GCM-SHA384      TLSv1.2 Kx=DH       Au=RSA   Enc=AESGCM(256)            Mac=AEAD
ECDHE-ECDSA-CHACHA20-POLY1305  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=CHACHA20/POLY1305(256) Mac=AEAD
ECDHE-RSA-CHACHA20-POLY1305    TLSv1.2 Kx=ECDH     Au=RSA   Enc=CHACHA20/POLY1305(256) Mac=AEAD
DHE-RSA-CHACHA20-POLY1305      TLSv1.2 Kx=DH       Au=RSA   Enc=CHACHA20/POLY1305(256) Mac=AEAD
ECDHE-ECDSA-AES128-GCM-SHA256  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(128)            Mac=AEAD
ECDHE-RSA-AES128-GCM-SHA256    TLSv1.2 Kx=ECDH     Au=RSA   Enc=AESGCM(128)            Mac=AEAD
DHE-RSA-AES128-GCM-SHA256      TLSv1.2 Kx=DH       Au=RSA   Enc=AESGCM(128)            Mac=AEAD
ECDHE-ECDSA-AES256-SHA384      TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AES(256)               Mac=SHA384
ECDHE-RSA-AES256-SHA384        TLSv1.2 Kx=ECDH     Au=RSA   Enc=AES(256)               Mac=SHA384
DHE-RSA-AES256-SHA256          TLSv1.2 Kx=DH       Au=RSA   Enc=AES(256)               Mac=SHA256
ECDHE-ECDSA-AES128-SHA256      TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AES(128)               Mac=SHA256
ECDHE-RSA-AES128-SHA256        TLSv1.2 Kx=ECDH     Au=RSA   Enc=AES(128)               Mac=SHA256
DHE-RSA-AES128-SHA256          TLSv1.2 Kx=DH       Au=RSA   Enc=AES(128)               Mac=SHA256
ECDHE-ECDSA-AES256-SHA         TLSv1   Kx=ECDH     Au=ECDSA Enc=AES(256)               Mac=SHA1
ECDHE-RSA-AES256-SHA           TLSv1   Kx=ECDH     Au=RSA   Enc=AES(256)               Mac=SHA1
DHE-RSA-AES256-SHA             SSLv3   Kx=DH       Au=RSA   Enc=AES(256)               Mac=SHA1
ECDHE-ECDSA-AES128-SHA         TLSv1   Kx=ECDH     Au=ECDSA Enc=AES(128)               Mac=SHA1
ECDHE-RSA-AES128-SHA           TLSv1   Kx=ECDH     Au=RSA   Enc=AES(128)               Mac=SHA1
DHE-RSA-AES128-SHA             SSLv3   Kx=DH       Au=RSA   Enc=AES(128)               Mac=SHA1
AES256-GCM-SHA384              TLSv1.2 Kx=RSA      Au=RSA   Enc=AESGCM(256)            Mac=AEAD
AES128-GCM-SHA256              TLSv1.2 Kx=RSA      Au=RSA   Enc=AESGCM(128)            Mac=AEAD
AES256-SHA256                  TLSv1.2 Kx=RSA      Au=RSA   Enc=AES(256)               Mac=SHA256
AES128-SHA256                  TLSv1.2 Kx=RSA      Au=RSA   Enc=AES(128)               Mac=SHA256
AES256-SHA                     SSLv3   Kx=RSA      Au=RSA   Enc=AES(256)               Mac=SHA1
AES128-SHA                     SSLv3   Kx=RSA      Au=RSA   Enc=AES(128)               Mac=SHA1
```

## plex preferred ciphers

```bash
sslscan odbc.plex.com:19995
...
  SSL/TLS Protocols:
SSLv2     disabled
SSLv3     disabled
TLSv1.0   disabled
TLSv1.1   disabled
TLSv1.2   enabled
TLSv1.3   disabled
...
  Supported Server Cipher(s):
Preferred TLSv1.2  128 bits  ADH-AES128-SHA                DHE 1024 bits
```

## research11

```bash
# openssl ciphers -s -v 'DEFAULT:@SECLEVEL=0'
# openssl ciphers -s -v ':@SECLEVEL=0+ADH'
openssl ciphers -s -V -stdname -tls1_2 'ADH-AES128-SHA:@SECLEVEL=0'    

          0x00,0x34 - TLS_DH_anon_WITH_AES_128_CBC_SHA              - ADH-AES128-SHA                 SSLv3   Kx=DH       Au=None  Enc=AES(128)               Mac=SHA1

# does not work
openssl s_client -cipher 'DEFAULT:@SECLEVEL=0' -connect odbc.plex.com:19995

openssl s_client -cipher 'ALL:@SECLEVEL=0' -connect odbc.plex.com:19995

CONNECTED(00000003)
---
no peer certificate available
---
No client certificate CA names sent
Server Temp Key: DH, 1024 bits
---
SSL handshake has read 605 bytes and written 651 bytes
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
    Session-ID: A1B70DA36046D25383346F3660A2ADAAC82B2076B1E54FDD4DCC1D6897E26285
    Session-ID-ctx: 
    Master-Key: DC8F212B87E7225C2C56787497437A1547D16E7C215B99E197BC0C080ED8982D9ED7B4F4D091275C44948D708AE1A89C
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 1440 (seconds)
    TLS session ticket:
    0000 - ef 9d 79 a1 d7 97 59 bf-6d 6f 98 05 41 9e 53 90   ..y...Y.mo..A.S.
    0010 - 9c 6a 38 6c ce 29 ba 5d-2d ba 98 22 49 e1 1d 89   .j8l.).]-.."I...
    0020 - cc 05 fe 23 00 cd 6a 81-7a 06 58 c3 6d 76 f4 4a   ...#..j.z.X.mv.J
    0030 - 28 96 d6 ab 09 72 26 d8-9f 25 b7 73 ee 6a 16 a9   (....r&..%.s.j..
    0040 - 8b 68 49 61 aa 2f bc c9-99 5b b6 d3 cd 76 05 4e   .hIa./...[...v.N
    0050 - 08 10 17 3f ea 9e 62 c3-5d ac 3f 9b cd 6c 29 d1   ...?..b.].?..l).
    0060 - 89 a2 b7 cc 74 24 df 40-32 5f 7d e5 67 cb 1f 74   ....t$.@2_}.g..t
    0070 - bf 73 08 af 9c 06 7e 76-59 b4 63 cd c5 ce d3 e5   .s....~vY.c.....
    0080 - 30 0a 3c b5 f9 40 de e6-ea 23 b6 c7 01 70 aa 16   0.<..@...#...p..
    0090 - 35 6a 9d 57 c6 8e 2b 0a-0d b6 dd 94 9a bf eb 01   5j.W..+.........
    00a0 - 67 f3 ff 32 0f e1 48 ec-1b 77 ea 0f c6 9b c6 d7   g..2..H..w......

    Start Time: 1748882838
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
---
```

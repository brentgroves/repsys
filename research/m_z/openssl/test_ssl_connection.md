# **[Test SSL Connections Using OpenSSL](https://www.liquidweb.com/blog/how-to-test-ssl-connection-using-openssl/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Using OpenSSL to Test Server Connection
Test the Connection to Port 443
The s_client command is used to analyze client-to-server communication. For example, it helps determine whether a port is open, if it can accept a secure connection, what kind of SSL certificate is present, and when it expires.

If conda is activated and you are relying on certificates in the linux trust store then you must deactiviate conda.  `conda deactiviate` to use openssl version bound to linux standard trust store.
Here is the most basic syntax.

```bash
openssl s_client -connect <URL or IP>:<port>
```

For the URL or IP portion, use your URL or IP address. The port should be the port you wish to test. So, for the domain example.org, the command and subsequent output look like the following.

```bash
freddy@freddy-vm:~$ openssl s_client -connect example.org:443    
CONNECTED(00000003)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
verify return:1
depth=0 C = US, ST = California, L = Los Angeles, O = Internet\C2\A0Corporation\C2\A0for\C2\A0Assigned\C2\A0Names\C2\A0and\C2\A0Numbers, CN = www.example.org
verify return:1
---
Certificate chain
 0 s:C = US, ST = California, L = Los Angeles, O = Internet\C2\A0Corporation\C2\A0for\C2\A0Assigned\C2\A0Names\C2\A0and\C2\A0Numbers, CN = www.example.org
   i:C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
   a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
   v:NotBefore: Mar 14 00:00:00 2022 GMT; NotAfter: Mar 14 23:59:59 2023 GMT
 1 s:C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
   i:C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
   a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
   v:NotBefore: Apr 14 00:00:00 2021 GMT; NotAfter: Apr 13 23:59:59 2031 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIHRzCCBi+gAwIBAgIQD6pjEJMHvD1BSJJkDM1NmjANBgkqhkiG9w0BAQsFADBP
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMSkwJwYDVQQDEyBE
aWdpQ2VydCBUTFMgUlNBIFNIQTI1NiAyMDIwIENBMTAeFw0yMjAzMTQwMDAwMDBa
Fw0yMzAzMTQyMzU5NTlaMIGWMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZv
cm5pYTEUMBIGA1UEBxMLTG9zIEFuZ2VsZXMxQjBABgNVBAoMOUludGVybmV0wqBD
b3Jwb3JhdGlvbsKgZm9ywqBBc3NpZ25lZMKgTmFtZXPCoGFuZMKgTnVtYmVyczEY
MBYGA1UEAxMPd3d3LmV4YW1wbGUub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAlV2WY5rlGn1fpwvuBhj0nVBcNxCxkHUG/pJG4HvaJen7YIZ1mLc7
/P4snOJZiEfwWFTikHNbcUCcYiKG8JkFebZOYMc1U9PiEtVWGU4kuYuxiXpD8oMP
in1B0SgrF7gKfO1//I2weJdAUjgZuXBCPAlhz2EnHddzXUtwm9XuOLO/Y6LATVMs
bp8/lXnfo/bX0UgJ7C0aVqOu07A0Vr6OkPxwWmOvF3cRKhVCM7U4B51KK+IsWRLm
8cVW1IaXjwhGzW7BR6EI3sxCQ4Wnc6HVPSgmomLWWWkIGFPAwcWUB4NC12yhCO5i
W/dxNMWNLMRVtnZAyq6FpZ8wFK6j4OMwMwIDAQABo4ID1TCCA9EwHwYDVR0jBBgw
FoAUt2ui6qiqhIx56rTaD5iyxZV2ufQwHQYDVR0OBBYEFPcqCdAkWxFx7rq+9D4c
PVYSiBa7MIGBBgNVHREEejB4gg93d3cuZXhhbXBsZS5vcmeCC2V4YW1wbGUubmV0
ggtleGFtcGxlLmVkdYILZXhhbXBsZS5jb22CC2V4YW1wbGUub3Jngg93d3cuZXhh
bXBsZS5jb22CD3d3dy5leGFtcGxlLmVkdYIPd3d3LmV4YW1wbGUubmV0MA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwgY8GA1Ud
HwSBhzCBhDBAoD6gPIY6aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
VExTUlNBU0hBMjU2MjAyMENBMS00LmNybDBAoD6gPIY6aHR0cDovL2NybDQuZGln
aWNlcnQuY29tL0RpZ2lDZXJ0VExTUlNBU0hBMjU2MjAyMENBMS00LmNybDA+BgNV
HSAENzA1MDMGBmeBDAECAjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LmRpZ2lj
ZXJ0LmNvbS9DUFMwfwYIKwYBBQUHAQEEczBxMCQGCCsGAQUFBzABhhhodHRwOi8v
b2NzcC5kaWdpY2VydC5jb20wSQYIKwYBBQUHMAKGPWh0dHA6Ly9jYWNlcnRzLmRp
Z2ljZXJ0LmNvbS9EaWdpQ2VydFRMU1JTQVNIQTI1NjIwMjBDQTEtMS5jcnQwCQYD
VR0TBAIwADCCAXwGCisGAQQB1nkCBAIEggFsBIIBaAFmAHUA6D7Q2j71BjUy51co
vIlryQPTy9ERa+zraeF3fW0GvW4AAAF/ip6hdQAABAMARjBEAiAxePNT60Z/vTJT
PVryiGzXrLxCNJQqteULkguBEMbG/gIgR3QwvILJIWAUfvSfJQ/zMmqr2JDanWE8
uzbC4EWbcwAAdQA1zxkbv7FsV78PrUxtQsu7ticgJlHqP+Eq76gDwzvWTAAAAX+K
nqF8AAAEAwBGMEQCIDspTxwkUBpEoeA+IolNYwOKl9Yxmwk816yd0O2IJPZcAiAV
8TWhoOLiiqGKnY02CdcGXOzAzC7tT6m7OtLAku2+WAB2ALNzdwfhhFD4Y4bWBanc
EQlKeS2xZwwLh9zwAw55NqWaAAABf4qeoYcAAAQDAEcwRQIgKR7qwPLQb6UT2+S7
w7uQsbsDZfZVX/g8FkBtAltaTpACIQDLdtedRNGNhuzYpB6gmBBydhtSQi5YZLsp
FvaVHpeW1zANBgkqhkiG9w0BAQsFAAOCAQEAqp++XZEbreROTsyPB2RENbStOxM/
wSnYtKvzQlFJRjvWzx5Bg+ELVy+DaXllB29ZA4xRlIkYED4eXO26PY5PGhSS0yv/
1JjLp5MOvLcbk6RCQkbZ5bEaa2gqmy5IqS8dKrDj+CCUVIFQLu7X4CB6ey5n+/rY
F6Rb3MoAYu8jr3pY8Hp0DL1NQ/GMAofc464J0vf6NzzSS6sE5UOl0lURDkGHXzio
5XpeTEa4tvo/w0vNQDX/4KRxdArBIIvjVEeE1Ri9UZtAXd1CMBLROqVjmq+QCNYb
0XELBnGQ666tr7pfx9trHniitNEGI6dj87VD+laMUBd7HBtOEGsiDoRSlA==
-----END CERTIFICATE-----
subject=C = US, ST = California, L = Los Angeles, O = Internet\C2\A0Corporation\C2\A0for\C2\A0Assigned\C2\A0Names\C2\A0and\C2\A0Numbers, CN = www.example.org
issuer=C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: ECDH, prime256v1, 256 bits
---
SSL handshake has read 3772 bytes and written 739 bytes
Verification: OK
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
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: 24DCEA127E089EC6D5935D6CFB78B37E77DEFC7A653B2308D11146FBF05CDB32
    Session-ID-ctx: 
    Resumption PSK: C5A6FF368C81F70319AF99E8377B63BC4CADF3E131D61F112F8CB751BBB623DE96B4662C876C3A39351509B0DEEFACEE
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - a1 c7 6a d7 5b 6c 83 5c-f3 92 f6 0f 23 c8 c5 c3   ..j.[l.\....#...
    0010 - 29 d3 5b a4 50 6d b7 93-96 e2 68 40 93 52 22 54   ).[.Pm....h@.R"T
    0020 - 8d 4a cf bf cb 02 56 6f-1b 4b 08 05 af bf 1b dd   .J....Vo.K......
    0030 - 52 0d 3e 2a d5 4a 90 de-d9 1b f4 5d f8 06 d4 db   R.>*.J.....]....
    0040 - a4 66 7c 77 b2 73 72 02-5a ae 68 3d 61 54 c0 62   .f|w.sr.Z.h=aT.b
    0050 - 00 74 81 b1 47 38 cd fc-4a 14 d4 7c 83 43 f8 9c   .t..G8..J..|.C..
    0060 - ce 08 f2 a0 68 52 f5 66-37 c5 4f 9d 88 c4 93 c1   ....hR.f7.O.....
    0070 - 18 61 c1 b5 01 1c 3a 6e-9c 53 0f eb cd ed da a7   .a....:n.S......
    0080 - af f5 84 ed 4b fb c5 fd-98 e4 ed dd e2 44 e5 51   ....K........D.Q
    0090 - 0e d9 f5 0d 6b f5 11 75-88 c8 2c da 74 dc d1 a8   ....k..u..,.t...
    00a0 - 65 10 4b e0 df 1e c7 2e-b0 16 8e dc 06 19 1d 34   e.K............4
    00b0 - 19 04 b7 10 d6 95 6d 2b-64 b4 ea e3 99 d8 0b c1   ......m+d.......

    Start Time: 1666844343
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: D23A9980357E2CF2B9DAA63C022E57C06C588022E981A86D0997D15DFED3DFC5
    Session-ID-ctx: 
    Resumption PSK: A31A023F56B24CA274F6267C496A72E0777BCB5EC8C2590275531FB26B23E86736CE59C40ABB52556B81120FB46BA105
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - a1 c7 6a d7 5b 6c 83 5c-f3 92 f6 0f 23 c8 c5 c3   ..j.[l.\....#...
    0010 - 46 94 9b 6f 98 3f 52 72-e4 06 c4 51 24 78 5e 62   F..o.?Rr...Q$x^b
    0020 - fa 63 aa 37 ad 09 ea b9-38 16 14 85 10 85 1e 2d   .c.7....8......-
    0030 - b0 89 44 97 63 f3 08 5b-6a f8 bc 99 31 8d 1b 81   ..D.c..[j...1...
    0040 - 2a 29 36 9c 09 5c e6 35-53 8d 30 d5 5a d2 da a4   *)6..\.5S.0.Z...
    0050 - 04 c6 c7 f5 d8 f7 84 15-02 22 ce 95 72 d5 97 e2   ........."..r...
    0060 - 16 7b e2 06 db e3 2f 27-a7 83 72 67 1a e3 cb 21   .{..../'..rg...!
    0070 - e7 0a 51 d5 fa d8 8e 2f-77 6d 2a 17 49 a8 27 b4   ..Q..../wm*.I.'.
    0080 - 07 c3 f1 d5 ca 49 93 e2-1b 2d c5 d3 95 e2 ea fd   .....I...-......
    0090 - 44 a4 95 9d e0 d9 d8 af-92 b6 d0 ec bc 20 75 a0   D............ u.
    00a0 - 5e 8b 55 2f 5a 31 e5 a6-cc e6 98 7d 5b ac 30 d8   ^.U/Z1.....}[.0.
    00b0 - aa 95 cc c5 1a c2 4b 3a-ff ed d9 bf af 91 ef bd   ......K:........
    00c0 - 82 bf 31 1c d0 21 92 f9-9a 59 08 26 b2 79 4f 9c   ..1..!...Y.&.yO.

    Start Time: 1666844343
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
```

Note: I could not get the next commands to work in Azure AKS with NGINX Gateway Fabric.

You will notice that your cursor is below the output instead of a new line. This is because OpenSSL is still connected to the server and waiting for further commands. You can send a HEAD command with your HTTP request, for example. To do so, type the following.

```bash
HEAD / HTTP/1.1
```

Press Enter once, then type in your domain name again in the same manner as below, exchanging example.org with your domain.

Press Enter again to view the output.

[truncated for space reasons]

```bash
read R BLOCK
HEAD / HTTP/1.1
Host: example.org

HTTP/1.1 200 OK
Content-Encoding: gzip
Accept-Ranges: bytes
Age: 234808
Cache-Control: max-age=604800
Content-Type: text/html; charset=UTF-8
Date: Thu, 27 Oct 2022 10:54:56 GMT
Etag: "3147526947"
Expires: Thu, 03 Nov 2022 10:54:56 GMT
Last-Modified: Thu, 17 Oct 2019 07:18:26 GMT
Server: ECS (dcb/7EA3)
X-Cache: HIT
Content-Length: 648
The successful OpenSSL test connection to port 443 provides quite a bit of information such as the certificate chain, ciphers that are in use, the TLS protocol version used, and the overall SSL handshake process. If you are trying to send the HEAD request and it gives you an HTTP/1.1 400 Bad Request error, you need to append the -crlf flag. This flag will help the server understand what we are trying to do.

freddy@freddy-vm:~$ openssl s_client -connect example.org:443 -crlf
```

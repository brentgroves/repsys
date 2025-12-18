# Azure SQL db connection

```bash
openssl s_client -showcerts -connect repsys1.database.windows.net:1433
CONNECTED(00000003)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
verify return:1
depth=1 C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 07
verify return:1
depth=0 C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr15.centralus1-a.control.database.windows.net
verify return:1
---
Certificate chain
 0 s:C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr15.centralus1-a.control.database.windows.net
   i:C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 07
   a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA384
   v:NotBefore: Mar  1 19:36:42 2025 GMT; NotAfter: Aug 28 19:36:42 2025 GMT
-----BEGIN CERTIFICATE-----
MIILDzCCCPegAwIBAgITMwF1G7WaIpWE0F/NYAAAAXUbtTANBgkqhkiG9w0BAQwF
ADBdMQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
MS4wLAYDVQQDEyVNaWNyb3NvZnQgQXp1cmUgUlNBIFRMUyBJc3N1aW5nIENBIDA3
MB4XDTI1MDMwMTE5MzY0MloXDTI1MDgyODE5MzY0MlowgYUxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJXQTEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
b2Z0IENvcnBvcmF0aW9uMTcwNQYDVQQDEy5jcjE1LmNlbnRyYWx1czEtYS5jb250
cm9sLmRhdGFiYXNlLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA82JS6HU3IlOoe7GJmAquoY4M2wfq9JITYFxyE0UbFZEwrjbueRoE
Smjx+ASxquLAAa81Te1TEANlwoO5IhEnst4gGYcvzJm2GEFto70Dl0AIIUnht5Rh
HZaPqFeZaOLxMNzzeFUvInEJc1J1CY0aYgm2l7HnMHecN3LtTHsvhzk+YfQwNawU
pIXhk5rRKTRU6i9Xb/xCZUgC3SYeaYuXb1a8pTQqnz1Y51VohokY0DiN1WMVJcnf
QNdndVubuumf8lqPhM/lQKhnbvjVxGZlwft8i6QNdcGVOHiwtHctpAjv5SIGYg6u
jRr+h1Lmn8cGA6BWD0ZH/wRXojh4oJ55bQIDAQABo4IGnTCCBpkwggF+BgorBgEE
AdZ5AgQCBIIBbgSCAWoBaAB3ABLxTjS9U3JMhAYZw48/ehP457Vih4icbTAFhOvl
hiY6AAABlVM/NTkAAAQDAEgwRgIhAOpihDfi8d/YFbHDWtJPTJkQJCQseByDkKKE
ZQu2A3i7AiEAsgmS5Lh1E6GPUtwra4jMkdykTq6cGZIyaNf6/NZ1qhIAdgB9WR4S
4XgqexxhZ3xe/fjQh1wUoE6VnrkDL9kOjC55uAAAAZVTPzXdAAAEAwBHMEUCIBtZ
ZDTvv11RQyK0Nonnw3LplODNcfmw8UTMjlIFLrvBAiEA+79o5gfTDTUdgHViSNHE
u5iLNkZvyV42b5+2OY6AkvYAdQAaBP9J0FQdQK/2oMO/8djEZy9O7O4jQGiYaxdA
LtyJfQAAAZVTPzZ5AAAEAwBGMEQCIGnD1djtgZAJZ70ccK9kXmmhRKm9GfYpQ8pn
R9DeWIkcAiBvp1ZqQCVTvBh2u+NnD7RLx2bP+dtfW1RN6djhhMJLdTAnBgkrBgEE
AYI3FQoEGjAYMAoGCCsGAQUFBwMCMAoGCCsGAQUFBwMBMDwGCSsGAQQBgjcVBwQv
MC0GJSsGAQQBgjcVCIe91xuB5+tGgoGdLo7QDIfw2h1dgqvnMIft8R8CAWQCAS0w
gbQGCCsGAQUFBwEBBIGnMIGkMHMGCCsGAQUFBzAChmdodHRwOi8vd3d3Lm1pY3Jv
c29mdC5jb20vcGtpb3BzL2NlcnRzL01pY3Jvc29mdCUyMEF6dXJlJTIwUlNBJTIw
VExTJTIwSXNzdWluZyUyMENBJTIwMDclMjAtJTIweHNpZ24uY3J0MC0GCCsGAQUF
BzABhiFodHRwOi8vb25lb2NzcC5taWNyb3NvZnQuY29tL29jc3AwHQYDVR0OBBYE
FNnnZpYbw/tQ0JJOZtBmAxOQ5lXrMA4GA1UdDwEB/wQEAwIFoDCCAqQGA1UdEQSC
ApswggKXgjAqLmNyMTUuY2VudHJhbHVzMS1hLmNvbnRyb2wuZGF0YWJhc2Uud2lu
ZG93cy5uZXSCKWNlbnRyYWx1czEtYS5jb250cm9sLmRhdGFiYXNlLndpbmRvd3Mu
bmV0gisqLmNlbnRyYWx1czEtYS5jb250cm9sLmRhdGFiYXNlLndpbmRvd3MubmV0
ghYqLmRhdGFiYXNlLndpbmRvd3MubmV0gh0qLmRhdGFiYXNlLnNlY3VyZS53aW5k
b3dzLm5ldIIgKi5zZWNvbmRhcnkuZGF0YWJhc2Uud2luZG93cy5uZXSCHCoubWFy
aWFkYi5kYXRhYmFzZS5henVyZS5jb22CGioubXlzcWwuZGF0YWJhc2UuYXp1cmUu
Y29tgh0qLnBvc3RncmVzLmRhdGFiYXNlLmF6dXJlLmNvbYIYKi5zcWwucHJvamVj
dGFyY2FkaWEubmV0ghYqLnNxbC5henVyZXN5bmFwc2UubmV0gh4qLnNxbC5henVy
ZXN5bmFwc2UtZG9nZm9vZC5uZXSCHCouZGF0YWJhc2UtZmxlZXQud2luZG93cy5u
ZXSCJiouc2Vjb25kYXJ5LmRhdGFiYXNlLWZsZWV0LndpbmRvd3MubmV0giUqLmRh
aWx5LWRhdGFiYXNlLmZhYnJpYy5taWNyb3NvZnQuY29tgiMqLmR4dC1kYXRhYmFz
ZS5mYWJyaWMubWljcm9zb2Z0LmNvbYIkKi5tc2l0LWRhdGFiYXNlLmZhYnJpYy5t
aWNyb3NvZnQuY29tgh8qLmRhdGFiYXNlLmZhYnJpYy5taWNyb3NvZnQuY29tgi5j
cjE1LmNlbnRyYWx1czEtYS5jb250cm9sLmRhdGFiYXNlLndpbmRvd3MubmV0MAwG
A1UdEwEB/wQCMAAwagYDVR0fBGMwYTBfoF2gW4ZZaHR0cDovL3d3dy5taWNyb3Nv
ZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwQXp1cmUlMjBSU0ElMjBUTFMl
MjBJc3N1aW5nJTIwQ0ElMjAwNy5jcmwwZgYDVR0gBF8wXTBRBgwrBgEEAYI3TIN9
AQEwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
cy9Eb2NzL1JlcG9zaXRvcnkuaHRtMAgGBmeBDAECAjAfBgNVHSMEGDAWgBTOFRY7
6gKjpmva2Sv95YxSvnpQqDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwEw
DQYJKoZIhvcNAQEMBQADggIBAGkyDYJduaDqS9jiUc0eqVg8FFY+c/arqqyTiwJf
1P2CihkQ3ejiZO+cQuG253d6FhPADYRtNS2sveO5WLHEpnm8G5ABYeF1TLuCjxep
g/LWdk9MGrVbSw24+G4wNkXnwxzyT+c6lXwsnKbR8UWujU7XAovfddpDVmtVA8ph
3wG9e9PtpviZdFgFYpFfdx2FRVGgywYyy3OKFDBa+b/Ob7bRFzn1+viSGPlYhO/C
JBU5ueycyjgWTA+9sIebSb0O6m4A1XuvkGw7qjHGfY1QYl8FphlsydMVl79K39dI
XD5Z0Q6J213pQLc+MNErPdwfieKplaI17GPaR3mQtBbG4UVKdgjpDEhEowed6MgR
zAwyYbEtq2OGU8nOGalnHx9GYna3mR1EBzUa6USsa7mWlRrT7Qt6IwIVTKQs1Ju+
BpDsU3nGU8FUedLvXn76+RRMLlKCm1etAPeF1+zzsp0uIM16YiohJGdLID0vv/4N
yCiP+YQsNjGDUZ3I1OhS3W5jkjV0ydv7nA7V57D+DGNS3rcHazuSZmrGKluzEfkw
hMPpA7reVex7nPB+WcjgGiAnJeXTavhT+dt7mRSUHJobfdfHNUVW9R/l/+vfgpX6
i+Vvpzsns84kWlCZGW+uMooqJizkBlWmQeNYfBwgPMscZs291LxpBXmJKIxlE2Cx
AStn
-----END CERTIFICATE-----
 1 s:C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 07
   i:C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA384
   v:NotBefore: Jun  8 00:00:00 2023 GMT; NotAfter: Aug 25 23:59:59 2026 GMT
-----BEGIN CERTIFICATE-----
MIIFrDCCBJSgAwIBAgIQCkOpUJsBNS+JlXnscgi6UDANBgkqhkiG9w0BAQwFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH
MjAeFw0yMzA2MDgwMDAwMDBaFw0yNjA4MjUyMzU5NTlaMF0xCzAJBgNVBAYTAlVT
MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLjAsBgNVBAMTJU1pY3Jv
c29mdCBBenVyZSBSU0EgVExTIElzc3VpbmcgQ0EgMDcwggIiMA0GCSqGSIb3DQEB
AQUAA4ICDwAwggIKAoICAQC1ZF7KYus5OO3GWqJoR4xznLDNCjocogqeCIVdi4eE
BmF3zIYeuXXNoJAUF+mn86NBt3yMM0559JZDkiSDi9MpA2By4yqQlTHzfbOrvs7I
4LWsOYTEClVFQgzXqa2ps2g855HPQW1hZXVh/yfmbtrCNVa//G7FPDqSdrAQ+M8w
0364kyZApds/RPcqGORjZNokrNzYcGub27vqE6BGP6XeQO5YDFobi9BvvTOO+ZA9
HGIU7FbdLhRm6YP+FO8NRpvterfqZrRt3bTn8GT5LsOTzIQgJMt4/RWLF4EKNc97
CXOSCZFn7mFNx4SzTvy23B46z9dQPfWBfTFaxU5pIa0uVWv+jFjG7l1odu0WZqBd
j0xnvXggu564CXmLz8F3draOH6XS7Ys9sTVM3Ow20MJyHtuA3hBDv+tgRhrGvNRD
MbSzTO6axNWvL46HWVEChHYlxVBCTfSQmpbcAdZOQtUfs9E4sCFrqKcRPdg7ryhY
fGbj3q0SLh55559ITttdyYE+wE4RhODgILQ3MaYZoyiL1E/4jqCOoRaFhF5R++vb
YpemcpWx7unptfOpPRRnnN4U3pqZDj4yXexcyS52Rd8BthFY/cBg8XIR42BPeVRl
OckZ+ttduvKVbvmGf+rFCSUoy1tyRwQNXzqeZTLrX+REqgFDOMVe0I49Frc2/Avw
3wIDAQABo4IBYjCCAV4wEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUzhUW
O+oCo6Zr2tkr/eWMUr56UKgwHwYDVR0jBBgwFoAUTiJUIBiV5uNu5g/6+rkS7QYX
jzkwDgYDVR0PAQH/BAQDAgGGMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcD
AjB2BggrBgEFBQcBAQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2lj
ZXJ0LmNvbTBABggrBgEFBQcwAoY0aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29t
L0RpZ2lDZXJ0R2xvYmFsUm9vdEcyLmNydDBCBgNVHR8EOzA5MDegNaAzhjFodHRw
Oi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRHbG9iYWxSb290RzIuY3JsMB0G
A1UdIAQWMBQwCAYGZ4EMAQIBMAgGBmeBDAECAjANBgkqhkiG9w0BAQwFAAOCAQEA
bbV8m4/LCSvb0nBF9jb7MVLH/9JjHGbn0QjB4R4bMlGHbDXDWtW9pFqMPrRh2Q76
Bqm+yrrgX83jPZAcvOd7F7+lzDxZnYoFEWhxW9WnuM8Te5x6HBPCPRbIuzf9pSUT
/ozvbKFCDxxgC2xKmgp6NwxRuGcy5KQQh4xkq/hJrnnF3RLakrkUBYFPUneip+wS
BzAfK3jHXnkNCPNvKeLIXfLMsffEzP/j8hFkjWL3oh5yaj1HmlW8RE4Tl/GdUVzQ
D1x42VSusQuRGtuSxLhzBNBeJtyD//2u7wY2uLYpgK0o3X0iIJmwpt7Ovp6Bs4tI
E/peia+Qcdk9Qsr+1VgCGA==
-----END CERTIFICATE-----
---
Server certificate
subject=C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr15.centralus1-a.control.database.windows.net
issuer=C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 07
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: ECDH, secp384r1, 384 bits
---
SSL handshake has read 4944 bytes and written 805 bytes
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
    Session-ID: 7551E347DF0B8FDD7386F05521F65072936B924037769780824FCCF6B5C2C2D5
    Session-ID-ctx: 
    Resumption PSK: DCA280AA877AB8854EC1D079DF31F24346D8335517916E44EBF382382F76EB320A19D7599D073C5C11F42AA4AF2CFEC7
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 36000 (seconds)
    TLS session ticket:
    0000 - d5 1f 00 00 a0 12 8a 52-34 6f e2 5f c5 f6 4e fb   .......R4o._..N.
    0010 - 6f 77 60 9b 3c 9f 9b fe-3a e5 eb bb 72 22 94 3a   ow`.<...:...r".:

    Start Time: 1748886353
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
```

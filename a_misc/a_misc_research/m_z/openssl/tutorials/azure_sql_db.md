# # **[6 OpenSSL command options that every sysadmin should know](https://www.redhat.com/en/blog/6-openssl-commands)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

```bash
echo | openssl s_client -connect repsys1.database.windows.net:1433
CONNECTED(00000003)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
verify return:1
depth=1 C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 08
verify return:1
depth=0 C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr14.centralus1-a.control.database.windows.net
verify return:1
---
Certificate chain
 0 s:C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr14.centralus1-a.control.database.windows.net
   i:C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 08
   a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA384
   v:NotBefore: Mar  1 18:47:23 2025 GMT; NotAfter: Aug 28 18:47:23 2025 GMT
 1 s:C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 08
   i:C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root G2
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA384
   v:NotBefore: Jun  8 00:00:00 2023 GMT; NotAfter: Aug 25 23:59:59 2026 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
MIILDjCCCPagAwIBAgITMwFiFVh+Ank6tKPaGgAAAWIVWDANBgkqhkiG9w0BAQwF
ADBdMQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
MS4wLAYDVQQDEyVNaWNyb3NvZnQgQXp1cmUgUlNBIFRMUyBJc3N1aW5nIENBIDA4
MB4XDTI1MDMwMTE4NDcyM1oXDTI1MDgyODE4NDcyM1owgYUxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJXQTEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
b2Z0IENvcnBvcmF0aW9uMTcwNQYDVQQDEy5jcjE0LmNlbnRyYWx1czEtYS5jb250
cm9sLmRhdGFiYXNlLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAwFtHCgnbKA7LmZ9MzOVRTaazVTQWhcFqOwusqat3LlgDJkBWf8Tl
CcEaef766AQrtd5hh+9B1g6o+ggY0tranXFG+tTeZBfkxxIUVhYk0QTdxKyiuCsa
WisnAV19v7hTClNRfDB0AhTY9KQ3e928y+yT79Y9jV5Q766SXjLQTAduK/wgD8pX
cDRqxJhLGHMIGiJFMmTgHJmxjBBko3RW6o//hQPZD4s6ZmIyYk5+ZMYdMyq5D6XN
glfvIEGeaeyBMRFW1cG7dCe2anRb1I07/msYg6Gwg6D3nYa8Xg6plxOK5iWNlKMw
Anat0WwpezWAcd77wIvtPYLkqMkZiaQpJQIDAQABo4IGnDCCBpgwggF9BgorBgEE
AdZ5AgQCBIIBbQSCAWkBZwB1ABLxTjS9U3JMhAYZw48/ehP457Vih4icbTAFhOvl
hiY6AAABlVMSDKkAAAQDAEYwRAIgGaiDuZJllQmGhDmd0mAV2JQoya4fP8fqVUsN
tpxFHN0CIGEuj8nYwzLrFQ2ob2AL3RCequILfE9qsSJ+SO4iL88GAHYAfVkeEuF4
KnscYWd8Xv340IdcFKBOlZ65Ay/ZDowuebgAAAGVUxINSQAABAMARzBFAiBrrW4r
JVkLuQZ+zVOqWkVJL7+/PR3cvCVFX/qs8b3lOwIhALnCOJpabZPh71i+ta+65wVk
V6wnsFt50qo8thSZeMzwAHYAGgT/SdBUHUCv9qDDv/HYxGcvTuzuI0BomGsXQC7c
iX0AAAGVUxINcgAABAMARzBFAiAUB+zR/mpUDDylYdcMfSQFL06uaoEyTCrjIjTp
3hV7qwIhALeRAC2oRf/adA/gzwZhIG0BAtWB6R6hZjkiTM4eNY2hMCcGCSsGAQQB
gjcVCgQaMBgwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwEwPAYJKwYBBAGCNxUHBC8w
LQYlKwYBBAGCNxUIh73XG4Hn60aCgZ0ujtAMh/DaHV2Cq+cwh+3xHwIBZAIBLTCB
tAYIKwYBBQUHAQEEgacwgaQwcwYIKwYBBQUHMAKGZ2h0dHA6Ly93d3cubWljcm9z
b2Z0LmNvbS9wa2lvcHMvY2VydHMvTWljcm9zb2Z0JTIwQXp1cmUlMjBSU0ElMjBU
TFMlMjBJc3N1aW5nJTIwQ0ElMjAwOCUyMC0lMjB4c2lnbi5jcnQwLQYIKwYBBQUH
MAGGIWh0dHA6Ly9vbmVvY3NwLm1pY3Jvc29mdC5jb20vb2NzcDAdBgNVHQ4EFgQU
4dU/IwtD3+SJf8u0JpK6uVVTJfMwDgYDVR0PAQH/BAQDAgWgMIICpAYDVR0RBIIC
mzCCApeCMCouY3IxNC5jZW50cmFsdXMxLWEuY29udHJvbC5kYXRhYmFzZS53aW5k
b3dzLm5ldIIpY2VudHJhbHVzMS1hLmNvbnRyb2wuZGF0YWJhc2Uud2luZG93cy5u
ZXSCKyouY2VudHJhbHVzMS1hLmNvbnRyb2wuZGF0YWJhc2Uud2luZG93cy5uZXSC
FiouZGF0YWJhc2Uud2luZG93cy5uZXSCHSouZGF0YWJhc2Uuc2VjdXJlLndpbmRv
d3MubmV0giAqLnNlY29uZGFyeS5kYXRhYmFzZS53aW5kb3dzLm5ldIIcKi5tYXJp
YWRiLmRhdGFiYXNlLmF6dXJlLmNvbYIaKi5teXNxbC5kYXRhYmFzZS5henVyZS5j
b22CHSoucG9zdGdyZXMuZGF0YWJhc2UuYXp1cmUuY29tghgqLnNxbC5wcm9qZWN0
YXJjYWRpYS5uZXSCFiouc3FsLmF6dXJlc3luYXBzZS5uZXSCHiouc3FsLmF6dXJl
c3luYXBzZS1kb2dmb29kLm5ldIIcKi5kYXRhYmFzZS1mbGVldC53aW5kb3dzLm5l
dIImKi5zZWNvbmRhcnkuZGF0YWJhc2UtZmxlZXQud2luZG93cy5uZXSCJSouZGFp
bHktZGF0YWJhc2UuZmFicmljLm1pY3Jvc29mdC5jb22CIyouZHh0LWRhdGFiYXNl
LmZhYnJpYy5taWNyb3NvZnQuY29tgiQqLm1zaXQtZGF0YWJhc2UuZmFicmljLm1p
Y3Jvc29mdC5jb22CHyouZGF0YWJhc2UuZmFicmljLm1pY3Jvc29mdC5jb22CLmNy
MTQuY2VudHJhbHVzMS1hLmNvbnRyb2wuZGF0YWJhc2Uud2luZG93cy5uZXQwDAYD
VR0TAQH/BAIwADBqBgNVHR8EYzBhMF+gXaBbhllodHRwOi8vd3d3Lm1pY3Jvc29m
dC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBBenVyZSUyMFJTQSUyMFRMUyUy
MElzc3VpbmclMjBDQSUyMDA4LmNybDBmBgNVHSAEXzBdMFEGDCsGAQQBgjdMg30B
ATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3Bz
L0RvY3MvUmVwb3NpdG9yeS5odG0wCAYGZ4EMAQICMB8GA1UdIwQYMBaAFPZ+L72A
o0qycFvr35of2O3KYYAHMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDATAN
BgkqhkiG9w0BAQwFAAOCAgEAsMoCYQBeIhUKEKcnIFUDY0yuGFgII7e8U5ELQodZ
aWT1IHBuVdwRdq3EeFly+uIFhiPIjpxvxaXCU7SSLg0zgGmMvnkvK3Zxnn3vTpYa
RlL722moDp585S2L9pCB+BetSSeMCo81QD6Bqt7BAfWQItbAKvGdmp15DYq8fkGM
CibEJB4S58p800bu2U3/+fZGR1mPvgZoohbWrEu5ae8akESBbkY6mRwaC3HkGkA1
qpT0gde9ISaOGHv3b+UvzIgev1jwgHuk4oiFLX90e/vizS9q3/sNUqDx66zIhNgU
O+Xk59uA3DMAdUzSKnlUlyyKk6r2/MPVEYy89cPWIl/zLU1/SfMzmkW/T+P2Afpk
Ekqk1sacO0Guq6R8AOoWCVSJcZrEvaJYRw/yahhMYLWB57xsjzMdN5WP9fcIHOuG
uMkHneVm6p8B/rp6KwJdVx4dqdrEE0qFKxtqXmZDOo6xWrNn9EN7e0zhwz3nCmfs
D23cuEZlXpimIPDugdcJhlrAV7PxamdM40B239On28EI3551byXJK5akKXzwUU8P
X63VzPTeiGO6aJRBeWkH275ls30Da0ygSslhZ142ZPsIthtuYa2zxUKnYbqOXdZu
tVVoVKra2511eIz1fXIadq6SCbuN9cM/W5E8SG+mmQiiRAKRWhwGclUGI/wzzVyg
Z0o=
-----END CERTIFICATE-----
subject=C = US, ST = WA, L = Redmond, O = Microsoft Corporation, CN = cr14.centralus1-a.control.database.windows.net
issuer=C = US, O = Microsoft Corporation, CN = Microsoft Azure RSA TLS Issuing CA 08
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: ECDH, secp384r1, 384 bits
---
SSL handshake has read 4943 bytes and written 805 bytes
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
DONE
```

## check extensions

```bash
# echo | openssl s_client -connect redhat.com:443 2>/dev/null | openssl x509 -noout -ext subjectAltName
echo | openssl s_client -connect repsys1.database.windows.net:1433 2>/dev/null | openssl x509 -noout -ext subjectAltName

X509v3 Subject Alternative Name: 
DNS:*.cr14.centralus1-a.control.database.windows.net, DNS:centralus1-a.control.database.windows.net, DNS:*.centralus1-a.control.database.windows.net, DNS:*.database.windows.net, DNS:*.database.secure.windows.net, DNS:*.secondary.database.windows.net, DNS:*.mariadb.database.azure.com, DNS:*.mysql.database.azure.com, DNS:*.postgres.database.azure.com, DNS:*.sql.projectarcadia.net, DNS:*.sql.azuresynapse.net, DNS:*.sql.azuresynapse-dogfood.net, DNS:*.database-fleet.windows.net, DNS:*.secondary.database-fleet.windows.net, DNS:*.daily-database.fabric.microsoft.com, DNS:*.dxt-database.fabric.microsoft.com, DNS:*.msit-database.fabric.microsoft.com, DNS:*.database.fabric.microsoft.com, DNS:cr14.centralus1-a.control.database.windows.net
```

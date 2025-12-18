# # **[6 OpenSSL command options that every sysadmin should know](https://www.redhat.com/en/blog/6-openssl-commands)**

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

Plex sends no certificates so can not determine if it is the real plex.

```bash
echo | openssl s_client -cipher 'ADH-AES128-SHA:@SECLEVEL=0' -tls1_2 -connect odbc.plex.com:19995

# no certs show
echo | openssl s_client -cipher 'ADH-AES128-SHA:@SECLEVEL=0'  -connect odbc.plex.com:19995

# no certs show
echo | openssl s_client -showcerts -cipher 'ADH-AES128-SHA:@SECLEVEL=0' -connect odbc.plex.com:19995


```

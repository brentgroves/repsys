# conda reports test

```bash
pushd .
cd /src/odbc/openssl/troubleshooting
# openssl req -new -x509 -nodes -days 30 -out myserver.pem -keyout myserver.key
openssl s_server -cert myserver.pem -key myserver.key
```

## scan client machine

```bash
sslscan localhost:4433
```

compare conda env openssl to plex.

## plex ciphers

```bash
  Supported Server Cipher(s):
Preferred TLSv1.2  128 bits  ADH-AES128-SHA                DHE 1024 bits
    Unable to parse certificate
    Unable to parse certificate
    Unable to parse certificate
    Unable to parse certificate
```

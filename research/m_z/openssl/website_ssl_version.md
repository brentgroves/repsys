# use openssl find what version of ssl website uses

## AI Overview

To determine the SSL/TLS version a website uses with OpenSSL, you can use the command openssl s_client -connect <hostname>:<port>. This command establishes a connection to the specified host and port, and the output will show details about the TLS version, ciphers, and other connection parameters used.

```bash
openssl s_client -connect odbc.plex.com:19995
CONNECTED(00000003)
80ABF9AC267A0000:error:0A000410:SSL routines:ssl3_read_bytes:sslv3 alert handshake failure:../ssl/record/rec_layer_s3.c:1599:SSL alert number 40
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
-

openssl s_client -showcerts -connect odbc.plex.com:19995

# nmap -v --script=ssl-cert -p 1433 server.example.com

nmap -v --script=ssl-cert -p 19995 odbc.plex.com
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-28 14:58 EDT
NSE: Loaded 1 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 14:58
Completed NSE at 14:58, 0.00s elapsed
Initiating Ping Scan at 14:58
Scanning odbc.plex.com (38.97.236.75) [2 ports]
Completed Ping Scan at 14:58, 3.00s elapsed (1 total hosts)
Nmap scan report for odbc.plex.com (38.97.236.75) [host down]
NSE: Script Post-scanning.
Initiating NSE at 14:58
Completed NSE at 14:58, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
Nmap done: 1 IP address (0 hosts up) scanned in 3.15 seconds

nmap -v --script=ssl-cert -Pn 19995 odbc.plex.com


```

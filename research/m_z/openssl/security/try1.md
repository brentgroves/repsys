# try 1

```bash
pushd .
cd ~/src/repsys/research/m_z/openssl/security
# does not pick up ADH-AES128-SHA
openssl ciphers -s -v DEFAULT:@SECLEVEL=0 | grep ADH-AES128-SHA
# works
openssl ciphers -s -v COMPLEMENTOFDEFAULT:@SECLEVEL=0 | grep ADH-AES128-SHA
# WORKS
openssl ciphers -s -v ALL:@SECLEVEL=0 | grep ADH-AES128-SHA

# works
openssl ciphers -s -v ADH:@SECLEVEL=0 | grep ADH-AES128-SHA
# DOES NOT WORK
openssl ciphers -s -v DEFAULT:ADH:@SECLEVEL=0 | grep ADH-AES128-SHA

# try with modified config 
export OPENSSL_CONF=/home/brent/src/repsys/research/m_z/openssl/security/try1.cfg
# works
openssl ciphers -s -v COMPLEMENTOFDEFAULT:@SECLEVEL=0 | grep ADH-AES128-SHA
# works
openssl ciphers -s -v  | grep ADH-AES128-SHA
# still works
openssl s_client -cipher 'ALL:@SECLEVEL=0' -connect odbc.plex.com:19995
# this works now
openssl s_client -connect odbc.plex.com:19995

```

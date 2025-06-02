# try 1

```bash
pushd .
cd ~/src/repsys/research/m_z/openssl/security
export OPENSSL_CONF=/home/brent/src/repsys/research/m_z/openssl/security/try1.cnf
openssl ciphers -s -v DEFAULT:@SECLEVEL=0 | grep ADH-AES128-SHA

```

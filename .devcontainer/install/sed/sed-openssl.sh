#!/bin/bash
# This is a RUN command in the dockerfile so it is not needed.
sed -i "s/CipherString = DEFAULT:@SECLEVEL=2/CipherString = DEFAULT:@SECLEVEL=0/g" /etc/ssl/openssl.cnf

#!/usr/bin/expect -f
spawn ssh-keygen -t ed25519 -C brent.groves@gmail.com
expect "id_ed25519):"
send "\n"
expect "passphrase):"
send "\n"
expect "again:"
send "\n"
expect eof

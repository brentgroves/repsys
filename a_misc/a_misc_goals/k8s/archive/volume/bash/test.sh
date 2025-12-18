#!/usr/bin/expect -f
spawn ssh-copy-id $argv
expect "(yes/no/\[fingerprint\])?"
send "yes\n"
expect "password:"
send "JesusLives1!\n"
expect eof

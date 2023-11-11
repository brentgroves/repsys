#!/usr/bin/expect -f
spawn cat ~/.ssh/id_ed25519.pub \
| parallel-ssh -O StrictHostKeyChecking=no -h .pssh_hosts_files -l remoteuser -A -I -i  \
'                                         \
  umask 077;                              \
  mkdir -p ~/.ssh;                        \
  afile=~/.ssh/authorized_keys;           \
  cat - >> $afile;                        \
  sort -u $afile -o $afile                \
'  
expect "password" \
send "JesusLives1!\n" 

# cat ~/.ssh/id_ed25519.pub | parallel-ssh -O StrictHostKeyChecking=no -h .pssh_hosts_files -l remoteuser -A -I -i 'umask 077; mkdir -p ~/.ssh; afile=~/.ssh/authorized_keys; cat - >> $afile; sort -u $afile -o $afile'    

Install and use sshpass
Use interactive mode to force the password which is just an empty string
Used command cat local | sshpass -ppassword parallel-ssh -I -h new_hosts -l root -A 'cat >> remote'
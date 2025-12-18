#!/bin/bash
cat ~/.ssh/id_ed25519.pub                    \
    | parallel-ssh -O StrictHostKeyChecking=no -h .pssh_hosts_files -l remoteuser -A -I -i  \
    '                                         \
      umask 077;                              \
      mkdir -p ~/.ssh;                        \
      afile=~/.ssh/authorized_keys;           \
      cat - >> $afile;                        \
      sort -u $afile -o $afile                \
    '  

# cat ~/.ssh/id_ed25519.pub | parallel-ssh -O StrictHostKeyChecking=no -h .pssh_hosts_files -l remoteuser -A -I -i 'umask 077; mkdir -p ~/.ssh; afile=~/.ssh/authorized_keys; cat - >> $afile; sort -u $afile -o $afile'    
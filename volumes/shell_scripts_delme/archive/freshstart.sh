#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
rm -rf ~/dotfiles
cd ~
git clone https://github.com/brentgroves/dotfiles.git
cd ~/src
rm -rf ~/src/repsys
git clone --recursive git@github.com:brentgroves/repsys.git
## git switch main if detached head
cd ~/src/repsys/volumes/ansible/rsapb
git switch main
cd ~/src/repsys/volumes/bash/rsbsh
git switch main
cd ~/src/repsys/volumes/go/replib
git switch main
cd ~/src/repsys/volumes/go/runner
git switch main
cd ~/src/repsys/volumes/java/etlj
git switch main
cd ~/src/repsys/volumes/pki
git switch main
cd ~/src/repsys/volumes/python/tbetl
git switch main
cd ~/src/repsys/volumes/python/tutorials/flask_cert
git switch main
cd ~/src/repsys/volumes/pki
git switch main
cd ~/src/repsys/volumes/sql/tbsql
git switch main
cd ~/src/repsys/linux
git switch main

popd

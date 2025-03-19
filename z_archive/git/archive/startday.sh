#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .

# --recurse-submodules don't seem to always pull all the commits

echo "pulling git"
cd ~/src/repsys/git
git pull

echo "pulling projects"
cd ~/src/repsys/projects
git pull

echo "pulling status"
cd ~/src/repsys/status
git pull

echo "pulling rsapb"
cd ~/src/repsys/volumes/ansible/rsapb
git pull

echo "pulling rsbsh"
cd ~/src/repsys/volumes/bash/rsbsh
git pull

echo "pulling replib"
cd ~/src/repsys/volumes/go/replib
git pull

echo "pulling runner"
cd ~/src/repsys/volumes/go/runner
git pull

echo "pulling etlj"
cd ~/src/repsys/volumes/java/etlj
git pull

echo "pulling tbetl"
cd ~/src/repsys/volumes/python/tbetl
git pull

echo "pulling flask_cert"
cd ~/src/repsys/volumes/python/tutorials/flask_cert
git pull

echo "pulling pki"
cd ~/src/repsys/volumes/pki
git pull

echo "pulling tbsql"
cd ~/src/repsys/volumes/sql/tbsql
git pull

echo "pulling linux"
cd ~/src/repsys/linux
git pull

cd ~/src/repsys
git pull --recurse-submodules

popd
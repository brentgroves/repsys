#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
rm -rf ~/src/volumes
cp -r /media/brent/KINGSTON/volumes ~/src
rm -rf ~/src/odbc
cp -r /media/brent/KINGSTON/odbc ~/src
rm -rf ~/src/azure
cp -r /media/brent/KINGSTON/azure ~/src
rm -rf ~/src/secrets
cp -r /media/brent/KINGSTON/secrets ~/src
rm -rf ~/src/k8s
cp -r /media/brent/KINGSTON/k8s ~/src
rm -rf ~/src/backups
cp -r /media/brent/KINGSTON/backups ~/src
rm -rf ~/src/pki
cp -r /media/brent/KINGSTON/pki ~/src

popd

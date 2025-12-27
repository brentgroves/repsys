#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
rm -rf ~/src/volumes
cp -r "/media/brent/Seagate Expansion Drive/volumes" ~/src
rm -rf ~/src/odbc
cp -r "/media/brent/Seagate Expansion Drive/odbc" ~/src
rm -rf ~/src/azure
cp -r "/media/brent/Seagate Expansion Drive/azure" ~/src
rm -rf ~/src/secrets
cp -r "/media/brent/Seagate Expansion Drive/secrets" ~/src
rm -rf ~/src/k8s
cp -r "/media/brent/Seagate Expansion Drive/k8s" ~/src
rm -rf ~/src/backups
cp -r "/media/brent/Seagate Expansion Drive/backups" ~/src
rm -rf ~/src/pki
cp -r "/media/brent/Seagate Expansion Drive/pki" ~/src

popd

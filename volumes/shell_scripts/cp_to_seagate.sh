#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .

rm -rf "/media/brent/Seagate Expansion Drive/volumes" 
cp -r  ~/src/volumes "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/odbc" 
cp -r  ~/src/odbc "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/azure" 
cp -r  ~/src/azure "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/secrets" 
cp -r  ~/src/secrets "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/k8s" 
cp -r  ~/src/k8s "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/backups" 
cp -r ~/src/backups "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/shell_scripts"
cp -r ~/src/repsys/volumes/shell_scripts "/media/brent/Seagate Expansion Drive/"

rm -rf "/media/brent/Seagate Expansion Drive/pki"
cp -r ~/src/pki "/media/brent/Seagate Expansion Drive/"


popd

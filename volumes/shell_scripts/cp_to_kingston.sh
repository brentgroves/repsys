#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
rm -rf /media/brent/KINGSTON/azure 
cp -r  ~/src/azure /media/brent/KINGSTON/

rm -rf /media/brent/KINGSTON/secrets 
cp -r  ~/src/secrets /media/brent/KINGSTON/
rm -rf /media/brent/KINGSTON/k8s 
cp -r  ~/src/k8s /media/brent/KINGSTON/

rm -rf /media/brent/KINGSTON/backups 
cp -r ~/src/backups /media/brent/KINGSTON/

rm -rf /media/brent/KINGSTON/shell_scripts
cp -r ~/src/repsys/volumes/shell_scripts /media/brent/KINGSTON/

rm -rf /media/brent/KINGSTON/pki
cp -r ~/src/pki /media/brent/KINGSTON/


popd

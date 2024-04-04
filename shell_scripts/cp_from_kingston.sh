#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
rm -rf ~/src/secrets
cp -r /media/brent/KINGSTON/secrets ~/src
rm -rf ~/src/k8s
cp -r /media/brent/KINGSTON/k8s ~/src
rm -rf ~/src/backups
cp -r /media/brent/KINGSTON/backups ~/src


popd

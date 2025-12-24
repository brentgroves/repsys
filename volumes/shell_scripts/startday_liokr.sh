#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .

# --recurse-submodules don't seem to always pull all the commits

echo "pulling linux"
cd ~/src/liokr/linux
git pull

cd ~/src/liokr
git pull --recurse-submodules

# when repsys makes changes we need to switch to main after liokr pull
cd ~/src/liokr/linux
git pull
git switch main

popd
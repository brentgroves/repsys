#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .

# --recurse-submodules don't seem to always pull all the commits

echo "pulling linux"
cd ~/src/biokr/linux
git pull

cd ~/src/biokr
git pull --recurse-submodules

# when repsys makes changes we need to switch to main after biokr pull
cd ~/src/biokr/linux
git switch main

popd
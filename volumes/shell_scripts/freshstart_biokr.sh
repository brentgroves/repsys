#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
# rm -rf ~/dotfiles
# cd ~
# git clone https://github.com/brentgroves/dotfiles.git
cd ~/src
rm -rf ~/src/biokr
git clone --recursive git@bitbucket.org-brent_groves:biokr/biokr.git

## git switch main if detached head
cd ~/src/biokr/linux
git switch main

popd

#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .
# rm -rf ~/dotfiles
# cd ~
# git clone https://github.com/brentgroves/dotfiles.git
cd ~/src
rm -rf ~/src/liokr
git clone --recursive git@bitbucket.org-brent_admin:liokr/liokr.git

## git switch main if detached head
cd ~/src/liokr/linux
git switch main

popd

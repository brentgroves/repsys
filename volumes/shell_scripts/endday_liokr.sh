#!/bin/bash
pushd .
# https://gist.github.com/gitaarik/8735255
# Make changes inside a submodule
# cd inside the submodule directory.
# Make the desired changes.
# git commit the new changes.
# git push the new commit.
# cd back to the main repository.
# In git status you'll see that the submodule directory is modified.
# In git diff you'll see the old and new commit pointers.
# When you git commit in the main repository, it will update the pointer.

cd ~/src/liokr/linux
echo "commit linux"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/liokr
echo "commit liokr"
git add -A 
git commit -m "updated source code"
git push -u origin main

popd
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

cd ~/src/repsys/volumes/ansible/rsapb
echo "commit rsapb"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/bash/rsbsh
echo "commit rsbsh"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/go/replib
echo "commit replib"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/go/runner
echo "commit runner"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/java/etlj
echo "commit etlj"
git add -A 
git commit -m "updated source code"
git push -u origin main


cd ~/src/repsys/volumes/python/tbetl
echo "commit tbetl"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/python/tutorials/flask_cert
echo "commit flask_cert"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/pki
echo "commit pki"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/volumes/sql/tbsql
echo "commit tbsql"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys/linux
echo "commit linux"
git add -A 
git commit -m "updated source code"
git push -u origin main

cd ~/src/repsys
echo "commit repsys"
git add -A 
git commit -m "updated source code"
git push -u origin main

popd
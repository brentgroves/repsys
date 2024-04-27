# Create repo with submodules

## References

<https://github.blog/2016-02-01-working-with-submodules/>
https://git-scm.com/book/en/v2/Git-Tools-Submodules

```bash
pushd ~/src/
git clone git@github.com:brentgroves/repsys.git
pushd ~/src/repsys
git submodule add git@github.com:brentgroves/git 
git submodule add git@github.com:brentgroves/projects.git
git submodule add git@github.com:brentgroves/status.git
mkdir -p ~/src/repsys/volumes/ansible
git submodule add git@github.com:brentgroves/rsapb.git volumes/ansible/rsapb
git submodule add git@github.com:brentgroves/rsbsh.git volumes/bash/rsbsh
mkdir ~/src/repsys/volumes/go
git submodule add git@github.com:brentgroves/replib volumes/go/replib
git submodule add git@github.com:brentgroves/runner volumes/go/runner
mkdir ~/src/repsys/volumes/java
git submodule add git@github.com:brentgroves/etlj volumes/java/etlj
git submodule add git@github.com:brentgroves/pki.git volumes/pki

mkdir -p ~/src/repsys/volumes/python/tutorials
git submodule add git@github.com:brentgroves/flask_cert.git volumes/python/tutorials/flask_cert

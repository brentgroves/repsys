# Install Shell scripts

Go to a development system with the repo of the shell scripts to be installed.

## copy shell scripts to server

```bash
# From dev system 
cd ~/src/repsys/shell_scripts
ssh brent@repsys12
mkdir -p ~/bin/shell_scripts/
chmod 755 ~/bin/shell_scripts/
exit

# upload shell scripts to server
lftp brent@rephub12
:~> cd ~/bin/shell_scripts #this is in dotfiles path
:~> mput *.sh
exit
ssh brent@repsys12
chmod 755 ~/bin/shell_scripts/*
# clone repos
~/bin/shell_scripts/freshstart.sh
~/bin/shell_scripts/freshstart-old.sh
exit
```

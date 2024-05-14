# Install Shell scripts

**[Ubuntu 22.04 Desktop](../../linux/ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../../linux/ubuntu22-04/server-install.md)**\
**[Back to Main](../../README.md)**

Go to a development system with the repo of the shell scripts to be installed.

## copy shell scripts to server

```bash
# From dev system 
cd ~/src/repsys/volumes/shell_scripts
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

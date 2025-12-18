# **[lftp client](https://linuxopsys.com/topics/lftp-commands)**

**[Ubuntu 22.04 Desktop](../../ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../../ubuntu22-04/server-install.md)**\
**[Back to Main](../../../README.md)**

## copy shell scripts to server

```bash
# From dev system 
cd ~/src/repsys/volumes/shell_scripts
ssh brent@repsys12
mkdir -p ~/bin/shell_scripts/
chmod 755 ~/bin/shell_scripts/
exit

# upload shell scripts to server
lftp brent@repsys12
:~> cd ~/bin/shell_scripts #this is in dotfiles path
:~> mput *.sh
exit

# copy kube config files to server
ssh brent@repsys12
mkdir ~/.kube
chmod 766 ~/.kube
exit

cd ~/src/k8s/all-config-files
# upload kube config files to server .config dir
lftp brent@repsys12
:~> cd .kube
:~> mput *.yaml
exit
```

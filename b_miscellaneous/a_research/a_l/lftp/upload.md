# Upload files to server

```bash
# From dev system 
cd ~/src/repsys/shell_scripts

# upload files to server
lftp brent@rephub12
:~> mput *.sh
exit
# The shell scripts are now in the servers /home/$USER directory

cd ~/src/repsys/k8s/kubectl/all-config-files
# upload kube config files to server .config dir
lftp brent@rephub12
:~> cd .kube
:~> mput *.sh
```
#!/usr/bin/env bash
set -e
# https://unix.stackexchange.com/questions/30470/what-does-mean-in-a-shell-script
# man bash
${parameter:-word}
# Use Default Values. If parameter is unset or null, the expansion of word is substituted. Otherwise, the value of parameter is substituted.
# USERNAME="${USERNAME:-"${_REMOTE_USER}"}"

# Script copies localhost's ~/.kube/config file into the container and swaps out 
# localhost for host.docker.internal on bash/zsh start to keep them in sync.
cp copy-kube-config.sh /usr/local/share/

chown ${USERNAME}:root /usr/local/share/copy-kube-config.sh
# The source command reads and executes commands from the file 
# specified as its argument in the current shell environment. 
# It is useful to load functions, variables, and configuration 
# files into shell scripts
echo "source /usr/local/share/copy-kube-config.sh" | tee -a /root/.bashrc >> /root/.zshrc
if [ ! -z "${USERNAME}" ] && [ "${USERNAME}" != "root" ]; then
    echo "source /usr/local/share/copy-kube-config.sh" | tee -a /home/${USERNAME}/.bashrc >> /home/${USERNAME}/.zshrc
fi
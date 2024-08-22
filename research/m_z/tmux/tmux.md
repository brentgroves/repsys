# Install TMUX

**[Ubuntu 22.04 Desktop](../../ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../../ubuntu22-04/server-install.md)**\
**[Back to Main](../../../README.md)**

Build and install it. Don’t use apt install tmux
<https://github.com/tmux/tmux/wiki/Installing>
On ubuntu 22.04
<https://programmerah.com/prompt-libevent-not-found-when-installing-tmux-6772/>
<https://www.cyberciti.biz/faq/linux-install-ncurses-library-headers-on-debian-ubuntu-centos-fedora/>

```bash

sudo apt-get install libncurses5-dev libncursesw5-dev libevent-dev ncurses-dev 

cd ~/Downloads
-L means follow the redirects
curl -LO https://sourceforge.net/projects/tmux.mirror/files/3.3/tmux-3.3.tar.gz

# https://sourceforge.net/projects/tmux.mirror/

#  -z, --gzip, --gunzip, --ungzip   filter the archive through gzip
#  -x, --extract, --get       extract files from an archive
#  -f, --file=ARCHIVE         use archive file or device ARCHIVE
# tar --help | grep -- "-f"

sudo apt install ncurses-dev 
sudo apt install libevent-dev
tar -zxf tmux-*.tar.gz
cd tmux-*/
./configure
make 
sudo make install  
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux

Ctrl-a or Ctrl-b is the prefix
:kill-server // to end session
Prefix I // to install tmux plugins

ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane. ctrl + a + " to make a Horizontal split.

```

## Install language server

```bash
# THIS IS OBSOLETE USE COC LANGUAGE SERVERS. SEE VIM DOC.
# <https://github.com/sourcegraph/javascript-typescript-langserver>
# Npm not installed?
# Do this again: nvm install --lts
Cd ~
git clone <https://github.com/sourcegraph/javascript-typescript-langserver.git>
cd javascript-typescript-langserver
npm install

# compile

npm run build

# run over STDIO

node lib/language-server-stdio

# start nvim
```

# **[How to Remove APT Repositories on Debian or Ubuntu](https://unix.stackexchange.com/questions/60595/how-to-undo-sudo-add-apt-repository)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

From Ubuntu's manual pages (man add-apt-repository):

-r, --remove Remove the specified repository

So...

```bash
sudo add-apt-repository -r ppa:noobslab/indicators
This removes it from the repo list in /etc/apt/sources.list.d/.
```

Depending on what you are doing, BEFORE you run the above command - If an installed package from that repo is newer than the same package in a standard repo, then manually downgrade with **[ppa-purge](https://launchpad.net/~xorg-edgers/+archive/ppa)**:

```bash
sudo ppa-purge ppa:noobslab/indicators
```

For Debian, just delete the .list file in /etc/apt/sources.list.d/
# **[Check if a package is required or whether it can be safely deleted](https://askubuntu.com/questions/1271073/check-if-a-package-is-required-or-whether-it-can-be-safely-deleted)**

**[Research List](../../research_list.md)**\
**[Detailed Status](../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

I can get the list of packages using command:

`dpkg-query --show --showformat='${Package;-50}\t${Installed-Size}\n' | sort -k 2 -n | grep -v deinstall | awk '{printf "%.3f MB \t %s\n", $2/(1024), $1}'`

and now I would like to know whether the particular package is critical for the system or not. If the package is no longer required then I will delete them. I want free up root space.

## Answer

Deleting packages is rarely an effective way to free up space in the root filesystem. Packages are small and numerous.

Look for large (runaway) logfiles in /var/log. Those can free up a lot of space quickly! Remember that a runaway log is merely a symptom of a problem that still needs to be investigated and fixed.

Look for large personal files in your /home. A movie or two takes up a lot of storage. Occasionally, folks who have a separate /home discover that it failed to mount and all their data is in the root filesystem instead.

Run baobab (also known as Disk Usage Analyzer) to search for large files on your root filesystem. It's included with every stock install of Ubuntu Desktop -- use your Desktop Search to find it. If you are on a Server instead of a desktop, here are some good techniques to find big files using **[du](https://askubuntu.com/questions/2045/how-to-determine-where-biggest-files-directories-on-my-system-are-stored)**

Here's one easy, safe way to determine is a package is system-critical:

```bash
apt remove --simulate <package_name>
```

The --simulate option means that the removal WON'T actually take place. An additional protection is omitting sudo.

Read the output: If only the package is removed (and perhaps a few dependencies), then it is likely safe to remove.

However, if the list of proposed removals includes one of these red flags, then DON'T do it for real:

The list is lengthy
The list includes applications that you use
The list includes one of the desktop meta-packages (ubuntu-desktop, kubuntu-desktop, etc.)
The list includes the apt, dpkg, python3, or python3-minimal packages (removing those would destroy your package manager)

```bash
sudo apt-get update && sudo apt-get install make build-essential libssl-dev \
    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

apt remove --simulate libncursesw5-dev

The following upgrades have been deferred due to phasing:
  libsnmp-base libsnmp40t64 pci.ids python3-software-properties software-properties-common software-properties-gtk ubuntu-drivers-common
The following packages have been kept back:
  libclang-cpp18 libllvm18

sudo apt update -y && sudo apt upgrade -y
sudo apt list --upgradable
Listing... Done
libclang-cpp18/focal-security 1:18.1.8-11~20.04.2 amd64 [upgradable from: 1:18.1.3-1ubuntu1]
libllvm18/focal-security 1:18.1.8-11~20.04.2 amd64 [upgradable from: 1:18.1.3-1ubuntu1]
libsnmp-base/noble-updates,noble-updates 5.9.4+dfsg-1.1ubuntu3.1 all [upgradable from: 5.9.4+dfsg-1.1ubuntu3]
libsnmp40t64/noble-updates 5.9.4+dfsg-1.1ubuntu3.1 amd64 [upgradable from: 5.9.4+dfsg-1.1ubuntu3]
pci.ids/noble-updates,noble-updates 0.0~2024.03.31-1ubuntu0.1 all [upgradable from: 0.0~2024.03.31-1]
python3-software-properties/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
software-properties-common/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
software-properties-gtk/noble-updates,noble-updates 0.99.49.2 all [upgradable from: 0.99.49.1]
ubuntu-drivers-common/noble-updates 1:0.9.7.6ubuntu3.2 amd64 [upgradable from: 1:0.9.7.6ubuntu3.1]
```

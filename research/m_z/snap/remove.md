# **[How to uninstall snap package](https://superuser.com/questions/1871847/how-to-uninstall-snap-package)**

- **[remove snap](https://itsfoss.com/remove-snap/)**

how to completely remove snap app

1

It is possible that darktable has packages under another name. **[List all Snap packages](https://itsfoss.com/remove-snap/)**, and then remove the correct ones by specific names. In terminal, do the following:

Check and **[fix any broken nap packages](https://phoenixnap.com/kb/ubuntu-fix-broken-packages)** by performing,` in sequence:

```bash
sudo apt update --fix-missing
sudo apt install -f
sudo dpkg --configure -a
sudo apt clean
```

Perform snap list to list all installed Snap apps.

```bash
snap list
```

For each item related to darktable, perorm sudo snap remove purge <package_name>.

```bash
sudo snap remove purge 
```

Perform sudo apt autoremove to clean up.

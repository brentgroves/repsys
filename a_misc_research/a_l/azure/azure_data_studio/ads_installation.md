# **[Install Azure Data Studio](https://snapcraft.io/install/azuredatastudio/ubuntu)**

## retires on 2026

Azure Data Studio officially retires on February 28, 2026. You should migrate to Visual Studio Code. This change aims to consolidate SQL development tools and provide a more robust and feature-rich environment for the developer community.

Snaps are applications packaged with all their dependencies to run on all popular Linux distributions from a single build. They update automatically and roll back gracefully.

Snaps are discoverable and installable from the Snap Store, an app store with an audience of millions.

## Install Azure Data Studio

To install Azure Data Studio, simply use the following command:

```bash
sudo snap install azuredatastudio
```

## launch with basic plain text authentication

**[Keychain issues](https://code.visualstudio.com/docs/configure/settings-sync#_troubleshooting-keychain-issues)**

```bash
azuredatastudio --verbose --vmodule="*/components/os_crypt/*=1"
# azuredatastudio --password-store="gnome-keyring"
# azuredatastudio --password-store="gnome-libsecret"
# You're running in a GNOME environment but the OS keyring is not available for encryption. Ensure you have gnome-keyring or another libsecret compatible implementation installed and running.

# The only one that works is basic
# And then I had to launch passwords and keys before launching ads.
azuredatastudio --password-store="basic"
```

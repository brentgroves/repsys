# **[50-cloud-init](https://ubuntuforums.org/showthread.php?t=2492108)**

## Brent's summary

I updated /etc/netplan/50-cloud-init.yaml at it's changes persisted on reboot but if I start having network problems this is the first place I will check

## post

RE: My earlier post was found while setting a static IP address in Noble Server Edition.
That openned some other doors I wasn't expecting... In both Server and Desktop.

Let me go back a bit... In Mantic, I started noticing some permissions changes of the log files in Mantic to rw------- root:root (600). That broke a few things in apport-collect that I reported in launchpad: <https://bugs.launchpad.net/ubuntu/+s...h/+bug/2041737>

In Noble, I noticed I could no longer grep (read) the yaml files in /etc/netplan/, and that yaml file was curiously named "50-cloud-init.yaml"... I didn't think much of that at the time. The permission's of this file has also changed to 600. And look at the new header in that file:

```code
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
```

So the netplan file in /etc/netplan/ (50-cloud-init) is no longer persistent, and is generated by the datasource file /etc/cloud/cloud.cfg.d/90-installer-network.cfg, and where we now need to edit to make netplan changes. On boot, when cloud-init kicks off, cloud-init uses that cfg file to dynamically generate the netplan file.

Also in that folder are:

```code
mafoelffen@noble00:~$ ls /etc/cloud/cloud.cfg.d/
05_logging.cfg  90-installer-network.cfg  curtin-preserve-sources.cfg
90_dpkg.cfg     99-installer.cfg          README
```

All these files are also set to 600. Where these are now other things are configured at boot by cloud-init. I haven't checked, just what else these other files are changing 'yet'. I will when I have time later.

At first I thought maybe this was just for Server, but I checked my Desktop VM's and they are the same way...

Which brings up something, I noticed that the new netplan files omit the renderer line... I added in my server config's but noticed something squirrely on my desktop VM's.

When upgraded from Mantic to Noble, the old /etc/netplan/01-network-manager-all.yaml file remains, with 50-cloud-init.yaml added mirroring it, omitting the renderer line. Since it has a later sort order, it overrides the old one, but without a renderer specified. I don't know if this really matters yet, but I'm keeping my eyes open to possible issues with that.

For networking, this changes where the files are that people need to update, and breaks scripts that skim by reading files without elevated permissions, because they can only be read by root. I know I have to go back through some of my scripts to adapt to these permission changes.

This will also affect some users that have been disabling and/or uninstalling cloud-init. (LOL) Just something to adjust to.

EDIT: I have a bug filed on ubuntu-desktop-installer Mantic, that should fix the autoinstall.yaml... They say they will have that ready for testing in the beta branch soon.

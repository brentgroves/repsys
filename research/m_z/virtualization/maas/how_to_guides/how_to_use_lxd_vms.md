# **[How to use LXD virtual machines](https://maas.io/docs/how-to-use-lxd-vms)**

This guide provides step-by-step instructions for setting up, managing, and overseeing LXD VM hosts and virtual machines in MAAS.

Setting up LXD for VM hosts
Remove older LXD versions

```bash
sudo apt-get purge -y *lxd* *lxc*
sudo apt-get autoremove -y
```

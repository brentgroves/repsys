# try 1

try to fix unshare: write failed /proc/self/uid_map: Operation not permitted error.

```bash
sudo snap install lxd --channel=5.21/stable --cohort="+"
# sudo snap install microceph --channel=squid/stable --cohort="+"
# sudo snap install microovn --channel=24.03/stable --cohort="+"
# sudo snap install microcloud --channel=2/stable --cohort="+"

If this is your first time running LXD on this machine, you should also run: lxd init
To start your first container, try: lxc launch ubuntu:24.04
Or for a virtual machine: lxc launch ubuntu:24.04 --vm

Generating a client certificate. This may take a minute...

# To indefinitely hold all updates to the snaps needed for MicroCloud, run:

sudo snap refresh --hold lxd

lxc remote add <remote_name> <token>
lxc remote add micro11 token
```

lxc console v1 --type vga
unshare: write failed /proc/self/uid_map: Operation not permitted
<https://tbhaxor.com/exploiting-linux-capabilities-part-1/>
<https://blog.quarkslab.com/digging-into-linux-namespaces-part-2.html>

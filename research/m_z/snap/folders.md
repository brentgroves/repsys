# AI Overview

Snap packages are primarily stored in /var/lib/snapd/snaps/ on your system. When you install a snap, it's downloaded and stored as a compressed SquashFS archive in this location. The contents of the snap are then mounted to /snap/<snap_name>/<revision> and /snap/bin.
Here's a breakdown:

`/var/lib/snapd/snaps/:`
This is where the actual .snap files (SquashFS archives) are stored.

```bash
ls /var/lib/snapd/snaps/
core22_2010.snap  core24_1006.snap  lxd_33110.snap  microceph_1393.snap  microcloud_1144.snap  microovn_667.snap  partial  snapd_24718.snap  snapd_24792.snap
```

`/snap/<snap_name>/<revision>/:`
This is a mount point where the contents of the snap are made available to the system. Each snap revision gets its own directory here.

```bash
ls /snap
bin  core22  core24  lxd  microceph  microcloud  microovn  README  snapd
brent@micro13:~$ ls /snap/microcloud
1144  current
brent@micro13:~$ ls /snap/microcloud/1144/
bin  commands  lib  meta  snap
```

`/snap/bin:`

This directory contains symlinks to the executable files within the snap packages, making them accessible from the command line.

```bash
ls /snap/bin
ceph         lxd.check-kernel  microceph.rados          microovn             microovn.ovn-trace     microovn.ovs-dpctl  ovn-nbctl   ovsdb-client  ovs-vsctl
lxc          lxd.lxc           microceph.radosgw-admin  microovn.ovn-appctl  microovn.ovs-appctl    microovn.ovs-ofctl  ovn-sbctl   ovsdb-tool    rados
lxd          microceph         microceph.rbd            microovn.ovn-nbctl   microovn.ovsdb-client  microovn.ovs-vsctl  ovn-trace   ovs-dpctl     radosgw-admin
lxd.buginfo  microceph.ceph    microcloud               microovn.ovn-sbctl   microovn.ovsdb-tool    ovn-appctl          ovs-appctl  ovs-ofctl     rbd
```

`/home/<user>/snap:`
.
This directory is used to store user-specific configuration and data for snaps.

```bash
ls -alh /home/brent
total 32K
drwxr-x--- 4 brent brent 4.0K Jun 27 18:50 .
drwxr-xr-x 3 root  root  4.0K Jun 25 21:17 ..
-rw------- 1 brent brent 2.1K Jul 10 23:28 .bash_history
-rw-r--r-- 1 brent brent  220 Mar 31  2024 .bash_logout
-rw-r--r-- 1 brent brent 3.7K Mar 31  2024 .bashrc
drwx------ 2 brent brent 4.0K Jun 25 21:19 .cache
-rw-r--r-- 1 brent brent  807 Mar 31  2024 .profile
drwx------ 2 brent brent 4.0K Jun 25 21:17 .ssh
-rw-r--r-- 1 brent brent    0 Jun 27 18:50 .sudo_as_admin_successful
```

/snap/<snap_name>/current:

This is a symbolic link that points to the currently active revision of the snap.

```bash
ls /snap
bin  core22  core24  lxd  microceph  microcloud  microovn  README  snapd
brent@micro13:~$ ls /snap/microcloud/
1144  current
brent@micro13:~$ ls /snap/microcloud/current
bin  commands  lib  meta  snap
```

# **[tmpfs](https://docs.kernel.org/filesystems/tmpfs.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[tmpfs](https://wiki.archlinux.org/title/Tmpfs)**

## Tmpfs

Tmpfs is a file system which keeps all of its files in virtual memory.

Everything in tmpfs is temporary in the sense that no files will be created on your hard drive. If you unmount a tmpfs instance, everything stored therein is lost.

tmpfs puts everything into the kernel internal caches and grows and shrinks to accommodate the files it contains and is able to swap unneeded pages out to swap space, if swap was enabled for the tmpfs mount. tmpfs also supports THP.

Tmpfs extends ramfs with a few userspace configurable options listed and explained further below, some of which can be reconfigured dynamically on the fly using a remount (‘mount -o remount ...’) of the filesystem. A tmpfs filesystem can be resized but it cannot be resized to a size below its current usage. tmpfs also supports POSIX ACLs, and extended attributes for the trusted.*, security.* and user.* namespaces. ramfs does not use swap and you cannot modify any parameter for a ramfs filesystem. The size limit of a ramfs filesystem is how much memory you have available, and so care must be taken if used so to not run out of memory.

An alternative to tmpfs and ramfs is to use brd to create RAM disks (/dev/ram*), which allows you to simulate a block device disk in physical RAM. To write data you would just then need to create an regular filesystem on top this ramdisk. As with ramfs, brd ramdisks cannot swap. brd ramdisks are also configured in size at initialization and you cannot dynamically resize them. Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely on the block layer at all.

**[Usage](https://wiki.archlinux.org/title/Tmpfs)**

Some directories where tmpfs(5) is commonly used are /tmp, /var/lock and /var/run. Do not use it on /var/tmp, because that directory is meant for temporary files that are preserved across reboots.

Arch uses a tmpfs /run directory, with /var/run and /var/lock simply existing as symlinks for compatibility. It is also used for /tmp by the default systemd setup and does not require an entry in fstab unless a specific configuration is needed.

glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for POSIX shared memory. Mounting tmpfs at /dev/shm is handled automatically by systemd and manual configuration in fstab is not necessary.

Generally, tasks and programs that run frequent read/write operations can benefit from using a tmpfs directory. Some applications can even receive a substantial gain by offloading some (or all) of their data onto the shared memory. For example, relocating the Firefox profile into RAM shows a significant improvement in performance.

## Examples

Note: The actual memory/swap consumption depends on how much is used, as tmpfs partitions do not consume any memory until it is actually needed.
By default, a tmpfs partition has its maximum size set to half of the available RAM, however it is possible to overrule this value. To explicitly set a maximum size, in this example to override the default /tmp mount, use the size mount option:

```bash
/etc/fstab
tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=2G          0  0
```

To specify a more secure mounting, specify the following mount option:

```bash
/etc/fstab
tmpfs   /www/cache    tmpfs  rw,size=1G,nr_inodes=5k,noexec,nodev,nosuid,uid=user,gid=group,mode=1700 0 0
```

See the tmpfs(5) man page and Security#File systems for more information.

Reboot for the changes to take effect. Note that although it may be tempting to simply run mount -a to make the changes effective immediately, this will make any files currently residing in these directories inaccessible (this is especially problematic for running programs with lockfiles, for example). However, if all of them are empty, it should be safe to run mount -a instead of rebooting (or mount them individually).

After applying changes, verify that they took effect by looking at /proc/mounts and using findmnt:

```bash
cat /etc/fstab   
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda3 during installation
UUID=c4f246c3-6c58-4602-ab50-c9e9d37f9a58 /               ext4    errors=remount-ro 0       1
# /boot/efi was on /dev/sda2 during installation
UUID=06DA-A0E5  /boot/efi       vfat    umask=0077      0       1
/swapfile                                 none            swap    sw              0       0

findmnt /        
TARGET SOURCE    FSTYPE OPTIONS
/      /dev/sda3 ext4   rw,relatime,errors=remount-ro

findmnt /boot/efi
TARGET    SOURCE    FSTYPE OPTIONS
/boot/efi /dev/sda2 vfat   rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro


sudo ls /proc/mounts         
/proc/mounts

$ findmnt /tmp
TARGET SOURCE FSTYPE OPTIONS
/tmp   tmpfs  tmpfs  rw,nosuid,nodev,relatime
```

The tmpfs can also be temporarily resized without the need to reboot, for example when a large compile job needs to run soon. In this case, run:

```bash
# mount -o remount,size=4G /tmp
Or resize based on RAM:

# mount -o remount,size=80% /tmp
```

## Disable automatic mount

Under systemd, /tmp is automatically mounted as a tmpfs, if it is not already a dedicated mountpoint (either tmpfs or on-disk) in /etc/fstab. To disable the automatic mount, mask the tmp.mount systemd unit.

Files will no longer be stored in a tmpfs, but on the block device instead. The /tmp contents will now be preserved between reboots (they are still cleaned up after 10 days though), which might not be the desired behavior. To regain the previous behavior and clean the /tmp directory automatically when restarting, consider using tmpfiles.d(5):

```bash
ls /etc/tmpfiles.d
screen-cleanup.conf

cat /etc/tmpfiles.d/screen-cleanup.conf
# This file is generated by /var/lib/dpkg/info/screen.postinst upon package configuration
d /run/screen 1777 root utmp

/etc/tmpfiles.d/tmp.conf
# see tmpfiles.d(5)
# always enable /tmp directory cleaning
D! /tmp 1777 root root 0

# remove files in /var/tmp older than 10 days
D /var/tmp 1777 root root 10d

# namespace mountpoints (PrivateTmp=yes) are excluded from removal
x /tmp/systemd-private-*
x /var/tmp/systemd-private-*
X /tmp/systemd-private-*/tmp
X /var/tmp/systemd-private-*/tmp
```

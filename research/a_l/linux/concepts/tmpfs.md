# **[tmpfs](https://docs.kernel.org/filesystems/tmpfs.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Tmpfs

Tmpfs is a file system which keeps all of its files in virtual memory.

Everything in tmpfs is temporary in the sense that no files will be created on your hard drive. If you unmount a tmpfs instance, everything stored therein is lost.

tmpfs puts everything into the kernel internal caches and grows and shrinks to accommodate the files it contains and is able to swap unneeded pages out to swap space, if swap was enabled for the tmpfs mount. tmpfs also supports THP.

Tmpfs extends ramfs with a few userspace configurable options listed and explained further below, some of which can be reconfigured dynamically on the fly using a remount (‘mount -o remount ...’) of the filesystem. A tmpfs filesystem can be resized but it cannot be resized to a size below its current usage. tmpfs also supports POSIX ACLs, and extended attributes for the trusted.*, security.* and user.* namespaces. ramfs does not use swap and you cannot modify any parameter for a ramfs filesystem. The size limit of a ramfs filesystem is how much memory you have available, and so care must be taken if used so to not run out of memory.

An alternative to tmpfs and ramfs is to use brd to create RAM disks (/dev/ram*), which allows you to simulate a block device disk in physical RAM. To write data you would just then need to create an regular filesystem on top this ramdisk. As with ramfs, brd ramdisks cannot swap. brd ramdisks are also configured in size at initialization and you cannot dynamically resize them. Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely on the block layer at all.

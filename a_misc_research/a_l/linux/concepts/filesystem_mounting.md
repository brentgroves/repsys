# **[What exactly does it mean to mount a filesystem?](https://www.reddit.com/r/linux4noobs/comments/pceamf/what_exactly_does_it_mean_to_mount_a_filesystem/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What exactly does it mean to mount a filesystem?

I often create a directory for various purposes that I intend to keep on a separate disk. For example, I'll create a directory under / called /srv/data

Then I'll create a filesystem using ```sudo mkfs.ext4 /dev/nvme1```

Finally, I mount the filesystem: ```sudo mount /dev/nvme1 /srv/data```

What exactly is happening here? Would I somehow still be able to access this data if I removed that drive? Will the directory disappear?

## answers

The kernel offers a filesystem-agnostic view of the directory hierarchy. It's an abstraction layer over multiple actual filesystems, meaning multiple separate data buffers, on disks, in files, what have you. Your root partition is a contiguous data buffer with a filesystem on it, and the kernel puts that filesystem at the top of its hierarchy, at /. It can only have one /, but it can map other data buffers (and some kernel features masquerading as filesystems, we call these "pseudo"-filesystems) at other points in the hierarchy.

The mapping is only at the hierarchy level; it only affects that abstraction layer, that view of your filesystems that's presented, that kernel feature that makes your running system think the directories are nested inside each other. Directories are not actually nested inside each other in the contiguous data representation of your typical filesystem, and nor are filesystems actually nested inside each other when you mount them. The drive you mount does not get copied into whatever drive is mounted above it; it's only presented as being there; the mountpoint is the mounted drive's access point in the hierarchy, not a copy destination.

Say you have /dev/sda1 mounted at / on boot, and you mount /dev/sdb1 at /mnt. All this means is that you've instructed the kernel, that when you access the directory /mnt, it should show you the filesystem on /dev/sdb1. Indeed this does not mean the files will remain there if you unplug /dev/sdb. The unplug would be detected, and the filesystem on the drive, being now inaccessible, would be automatically unmapped from the /mnt directory, leaving it empty.

```bash
ls /sys/fs/cgroup
cgroup.controllers      cgroup.procs            cpu.pressure           cpu.stat             init.scope     io.prio.class     memory.reclaim          misc.current                   sys-kernel-debug.mount
cgroup.max.depth        cgroup.stat             cpuset.cpus.effective  cpu.stat.local       io.cost.model  io.stat           memory.stat             proc-sys-fs-binfmt_misc.mount  sys-kernel-tracing.mount
cgroup.max.descendants  cgroup.subtree_control  cpuset.cpus.isolated   dev-hugepages.mount  io.cost.qos    memory.numa_stat  memory.zswap.writeback  sys-fs-fuse-connections.mount  system.slice
cgroup.pressure         cgroup.threads          cpuset.mems.effective  dev-mqueue.mount     io.pressure    memory.pressure   misc.capacity           sys-kernel-config.mount        user.slice
```

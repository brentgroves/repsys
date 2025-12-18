# **[backup](https://mailtrap.io/smtp-service/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## references

- **[backup](https://unix.stackexchange.com/questions/315960/linux-alternative-to-file-history-shadow-copies-for-internal-backup)**

The Windows 'Shadow Copy' aka 'Volume Shadow Copy Servce' does filesystem snapshotting. The Linux equivalent requires changing your filesystem/partitions, or possibly using 3rd party tools.

Options

LVM -
you must leave free space on your volume group, and has a pretty high performance cost. All though not super fast it is available, stable, and pretty usable out of the box on most Linux releases.
btfrs - not entirely stable
be careful to read the note about setups that should not be used. Apparently it has some major ways it can be broken and result in full data loss.
zfs - not natively available on most distributions yet.
Very popular option, but is very difficult to use as a root fs on Linux. Great for data filesystems
R1Soft Hot Copy - https://www.r1soft.com/free-tool-linux-hot-copy
I haven't used this, but I don't believe it is designed for long term snapshots, instead it is just used for getting a clean backup.
So, if you need to snapshot your root FS, I suspect you probably need to setup the system with LVM, and leave lots of free space in your volume group.

If you need snapshots for a data-only filesystem, I strongly suggest you look at zfs or maybe btrfs.

Honestly I haven't actually used HotCopy, but I was just including it for completeness. Of the other three I mentioned zfs, lvm, and btfrs all support snapshots. LVM snapshots unfortunately are pretty slow. btfrs is not really stable and can lose your data if setup wrong. ZFS is a PITA to use as the root filesystem right now. So of them are idea. ZFS is probably is the best as far as data safety, and performance. LVM is probably the easiest to use out of the box.
# **[linux NBD: Introduction to Linux Network Block Devices](https://medium.com/@aysadx/linux-nbd-introduction-to-linux-network-block-devices-143365f1901b)**

Network block devices (NBD) are used to access remote storage device that does not physically reside in the local machine. Using Network Block Device, we can access and use the remote storage devices in following three ways on the local machine:

SWAP
File System
RAW

NBD presents a remote resource as local resource to the client. Also, NBD driver makes a remote resource look like a local device in Linux, allowing a cheap and safe real-time mirror to be constructed.

you dont need to compare NFS with NBD because both are totally different ways of solutions of network storage system

Press enter or click to view image in full size

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*0WqhqSXX_IBTyhVtbsZtYg.png)

Why NBD ? usecase scenario

For example, maybe you want to format the device. Or you want to modify or copy entire partitions. These tasks would be impossible to accomplish with a network file system, because they would require you to have the file system unmounted in order to perform them — and if you unmount your network file system, it’s no longer connected.

But if your remote storage device is mounted as a block device (NBD), you can do anything to it that you’d be able to do to a local block device.

In other words, with NBD, you can take a device like /dev/sda on one machine and make it available to another machine as if it were a local device there connected via a SCSI or SATA cable, even though in actuality it is connected over the network.

Sometimes you may want to complete operations on a storage device at a lower level than a network file system(NFS) would support.

You can also boot complete OS from NBD over network.(e.g. scaleway.com users boots everytime from nbd)

## Getting started with NBD

I used debian OS for my example below (would works also with all derivates like ubuntu)

NBD works according to a client/server architecture. You use the server to make a volume available as a network block device from a host, then run the client to connect to it from another host.

ServerSide
serverIP: 192.168.1.100

```bash
apt-get install nbd-server
modprobe nbd
```

modprobe is a Linux utility for intelligently loading and removing kernel modules, which are code pieces that extend the operating system's functionality.

after installation you can begin to export a device or file now

## Export device

Example: export ServerSide Disk Device like /dev/sda on port 9999

nbd-server 9999 /dev/sda

Export img file
Example: export ServceSide .img file like vmdisk.img on port 9998

nbd-server 9998 vmdisk.img

img over NDB can be useful if you’re working with virtual disk images, for example.

## ClientSide

clientIP: 192.168.1.200

On the client machine that we want to use to connect to the NBD export we just created, we first need to install the NBD client package with:

```bash
apt-get install nbd-client
modprobe nbd-client
```

map/mount remote NBD exported device as local device/dev/nbd0

```bash
nbd-client 192.168.1.100 9999 /dev/nbd0
nbd-client 192.168.1.100 9998 /dev/nbd1
```

What you can do now on ClientSide with mounted NBD?
you can start doing cool things with the NBD export from the client machine by using /dev/nbd0 as the target.

now you are able to use /dev/nbd0 like local disk on clientSide

example: you can format it
`mkfs.ext4 /dev/dbd0 )`

other usage examples szenarios clientSide

+ You could resize partitions
+ You could create a filesystem (like local filesystem)
+ You could create btrfs /zfs/glusterfs storage pools

As long as the export that the client is using at /dev/nbd0 is mapped to a device like /dev/sda on the server, operations from the client on /dev/nbd0 will take effect on the server just as they would if you were running them locally on the server with /dev/sda as the target.

## Important

use this case szenario only in protected Local Networks !

Never use NBD in Public networks (e.g over internet) without configure your security. (the same rules aplies NFS too ! )

All of the above said, NBD is a cool tool. It lets you do things that would otherwise not be possible. It doesn’t get much press these days (which is not surprising because NBD dates all the way back to the early 2000s, and hasn’t ever been important commercially), but it may be just the tool you need to solve some of the strange challenges that can arise in the life of a sysadmin.

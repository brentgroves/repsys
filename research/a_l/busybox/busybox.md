# **[busybox](https://en.wikipedia.org/wiki/BusyBox#Examples)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## What is BusyBox?

The Swiss Army Knife of Embedded Linux

Coming in somewhere between 1 and 5 Mb in on-disk size (depending on the variant), BusyBox⁠ is a very good ingredient to craft space-efficient distributions.

BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. The utilities in BusyBox generally have fewer options than their full-featured GNU cousins; however, the options that are included provide the expected functionality and behave very much like their GNU counterparts. BusyBox provides a fairly complete environment for any small or embedded system.

## Appliances and reception

BusyBox is used by several operating systems running on embedded systems and is an essential component of distributions such as OpenWrt, OpenEmbedded (including the Yocto Project) and Buildroot. The Sharp Zaurus utilizes BusyBox extensively for ordinary Unix-like tasks performed on the system's shell.[43]

BusyBox is also an essential component of VMware ESXi, Tiny Core Linux, SliTaz 5(Rolling), and Alpine Linux, all of which are not embedded distributions.

It is necessary for several root applications on Android and is also preinstalled with some "1 Tap Root" solutions such as Kingo Root.

BusyBox is a software suite that provides several **[Unix utilities](https://en.wikipedia.org/wiki/List_of_Unix_commands)** in a single executable file. It runs in a variety of POSIX environments such as Linux, Android, and FreeBSD, although many of the tools it provides are designed to work with interfaces provided by the Linux kernel.

It was specifically created for embedded operating systems with very limited resources. The authors dubbed it "The Swiss Army knife of Embedded Linux",[10] as **the single executable replaces basic functions of more than 300 common commands**. It is released as free software under the terms of the GNU General Public License v2,[6] after controversially deciding not to move to version 3.

## Features

BusyBox can be customized to provide a subset of over two hundred utilities. It can provide most of the utilities specified in the **[Single Unix Specification (SUS)](https://en.wikipedia.org/wiki/Single_Unix_Specification)** plus many others that a user would expect to see on a Linux system. BusyBox uses the **[Almquist shell](https://en.wikipedia.org/wiki/Almquist_shell)**, also known as A Shell, ash and sh.[36] An alternative for customization is the smaller 'hush' shell. "Msh" and "lash" used to be available.[37]

As it is a complete bootstrap system, it will further replace the init daemon and udev (or the latter-day systemd) using itself to be called as init on startup and mdev at hotplug time.

The BusyBox website provides a full list of the utilities implemented.[38]

## side SUS

The Single UNIX Specification (SUS) is a standard for computer operating systems,[1][2] compliance with which is required to qualify for using the "UNIX" trademark. The standard specifies programming interfaces for the C language, a command-line shell, and user commands. The core specifications of the SUS known as Base Specifications are developed and maintained by the Austin Group, which is a joint working group of IEEE, ISO/IEC JTC 1/SC 22/WG 15 and The Open Group. If an operating system is submitted to The Open Group for certification, and passes conformance tests, then it is deemed to be compliant with a UNIX standard such as UNIX 98 or UNIX 03.

Very few BSD and Linux-based operating systems are submitted for compliance with the Single UNIX Specification, although system developers generally aim for compliance with POSIX standards, which form the core of the Single UNIX Specification.

The latest SUS consists of two parts: the base specifications technically identical to POSIX, and X/Open Curses specification.[3]

Some parts of the SUS are optional.

## Single binary

Typical computer programs have a separate binary (executable) file for each application. BusyBox is a single binary, which is a conglomerate of many applications, each of which can be accessed by calling the single BusyBox binary with various names [supported by having a symbolic link or hard link for each different name](39) in a specific manner with appropriate arguments.

BusyBox benefits from the single binary approach, as it reduces the overhead introduced by the executable file format (typically ELF), and it allows code to be shared between multiple applications without requiring a library. This technique is similar to what is provided by the crunchgen[40] command in FreeBSD, the difference being that BusyBox provides simplified versions of the utilities (for example, an ls command without file sorting ability), while a crunchgen generated sum of all the utilities would offer the fully functional versions.

Sharing of the common code, along with routines written with size-optimization in mind, can make a BusyBox system use much less storage space than a system built with the corresponding full versions of the utilities replaced by BusyBox. Research[41] that compared GNU, BusyBox, asmutils and Perl implementations of the standard Unix commands showed that in some situations BusyBox may perform faster than other implementations, but not always.

## Examples

Programs included in BusyBox can be run simply by adding their name as an argument to the BusyBox executable:

/bin/busybox ls
More commonly, the desired command names are linked (using hard or symbolic links) to the BusyBox executable; BusyBox reads argv[0] to find the name by which it is called, and runs the appropriate command, for example just

/bin/ls
after /bin/ls is linked to /bin/busybox. This works because the first argument passed to a program is the name used for the program call, in this case the argument would be "/bin/ls". BusyBox would see that its "name" is "ls" and act like the "ls" program.

## Hard links

The concept of a hard link is the most basic we will discuss today. Every file on the Linux filesystem starts with a single hard link. The link is between the filename and the actual data stored on the filesystem. Creating an additional hard link to a file means a few different things. Let's discuss these.

First, you create a new filename pointing to the exact same data as the old filename. This means that the two filenames, though different, point to identical data. For example, if I create file /home/tcarrigan/demo/link_test and write hello world in the file, I have a single hard link between the file name link_test and the file content hello world.

```bash
[tcarrigan@server demo]$ ls -l
total 4
-rw-rw-r--. 1 tcarrigan tcarrigan 12 Aug 29 14:27 link_test
```

## Take note of the link count here (1)

Next, I create a new hard link in /tmp to the exact same file using the following command:

```bash
[tcarrigan@server demo]$ ln link_test /tmp/link_new
```

The syntax is ln (original file path) (new file path).

Now when I look at my filesystem, I see both hard links.

```bash
[tcarrigan@server demo]$ ls -l link_test /tmp/link_new 
-rw-rw-r--. 2 tcarrigan tcarrigan 12 Aug 29 14:27 link_test
-rw-rw-r--. 2 tcarrigan tcarrigan 12 Aug 29 14:27 /tmp/link_new
```

The primary difference here is the filename. The link count has also been changed (2). Most notably, if I cat the new file's contents, it displays the original data.

```bash
[tcarrigan@server demo]$ cat /tmp/link_new 
hello world
```

When changes are made to one filename, the other reflects those changes. The permissions, link count, ownership, timestamps, and file content are the exact same. **If the original file is deleted, the data still exists under the secondary hard link. The data is only removed from your drive when all links to the data have been removed.** If you find two files with identical properties but are unsure if they are hard-linked, use the **ls -i** command to view the inode number. Files that are hard-linked together share the same inode number.

```bash
[tcarrigan@server demo]$ ls -li link_test /tmp/link_new 
2730074 -rw-rw-r--. 2 tcarrigan tcarrigan 12 Aug 29 14:27 link_test
2730074 -rw-rw-r--. 2 tcarrigan tcarrigan 12 Aug 29 14:27 /tmp/link_new
```

The shared inode number is 2730074, meaning these files are identical data.
If you want more information on inodes, read my **[full article here](https://www.redhat.com/sysadmin/inodes-linux-filesystem)**.

## What is an inode?

By definition, an inode is an index node. It serves as a unique identifier for a specific piece of metadata on a given filesystem. Each piece of metadata describes what we think of as a file. That's right, inodes operate on each filesystem, independent of the others. Where this gets confusing is when you realize that each inode is stored in a common table. In short, each filesystem mounted to your computer has its own inodes. An inode number may be used more than once but never by the same filesystem. The filesystem id combines with the inode number to create a unique identification label.

## How many inodes are there?

If you don't care for math, you may want to skip this section. There are many inodes on every system, and there are a couple of numbers to be aware of. First up, and less important, the theoretical maximum number of inodes is equal to 2^32 (approximately 4.3 billion inodes). Second, and far more important, is the number of inodes on your system. Generally, the ratio of inodes is 1:16KB of system capacity. Obviously, every system is different, so you need to do that math for yourself.

## Advanced usage

There is good news for those of you who are math averse: "There's a command for that." To check the number of inodes on your system, you can use the -i option with the df command, as seen here:

```bash
[tcarrigan@rhel ~]$ df -i /dev/sda1
Filesystem     Inodes IUsed  IFree IUse% Mounted on
/dev/sda1      524288   312 523976    1% /boot
```

You can see from the command syntax and the output above that we ran df -i on filesystem /dev/sda1. There are a total of 524,288 inodes on this filesystem, with only 312 of them being used (about 1%).

## File-level inode

We can also look at the inode number of a specific file. To do this, we use the ls -i command on the desired file. For example:

```bash
[tcarrigan@rhel my_articles]$ ls -i Creating_volume_groups 
1459027 Creating_volume_groups
The inode number for this file is 1459027.
```

## Directory-level inode

Just like with files, we can also see the inode of a directory. To do this, we use the ls -i command again with a few additional options. For example:

```bash
[tcarrigan@rhel article_submissions]$ ls -idl my_articles/
352757 drwxrwxr-x. 2 tcarrigan tcarrigan 69 Apr  7 11:31 my_articles/
```

You can see that we used -i (inodes) as well as -l (long format) and -d(directory). These flags present us with a plethora of information about the my_articles directory, including inode number, permissions, ownership, etc.

## Appliances and reception 2

BusyBox is used by several operating systems running on embedded systems and is an essential component of distributions such as OpenWrt, OpenEmbedded (including the Yocto Project) and Buildroot. The Sharp Zaurus utilizes BusyBox extensively for ordinary Unix-like tasks performed on the system's shell.[43]

BusyBox is also an essential component of VMware ESXi, Tiny Core Linux, SliTaz 5(Rolling), and Alpine Linux, all of which are not embedded distributions.

It is necessary for several root applications on Android and is also preinstalled with some "1 Tap Root" solutions such as Kingo Root.

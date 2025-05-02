# **[Linux Logging with Systemd](https://www.loggly.com/ultimate-guide/linux-logging-with-systemd/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Linux Logging with Systemd

Systemd is a system and service manager for Linux. It’s become the de facto system management daemon in various Linux distributions in recent years. Systemd was first introduced in Fedora. Other distributions like Arch Linux, openSUSE, or CoreOS have already made it part of their operating systems. Red Hat Enterprise Linux (RHEL) and its downstream distros like CentOS started to use systemd natively from version 7. Another major distribution, Ubuntu—which had introduced another service management daemon called Upstart—started shipping with systemd from version 15.04.

The reason for this wide-scale adoption is the versatility of systemd. It manages not only daemons and processes in a Linux system, but also various resources like devices, sockets, and mount points. When the system boots, it does not load services sequentially like System V, which saves significant time at startup. Services are loaded in parallel, and a service waits until other required resources for it are also activated.

Systemd is backward compatible with predecessors like System V init and Upstart. That means any service still using older System V init scripts for starting will work under systemd, and you can use systemd commands like systemctl to start, stop, and check the service’s status. Another advantage of systemd is its ease of configuration. Systemd is controlled by unit files that are declarative in nature and easy to understand. This contrasts with System V where the application’s developer had to create complicated shell scripts for starting, stopping, or reloading the service.

As we’ll see later, systemd has a sophisticated logging service that can be used instead of the traditional syslog service. It can also be used to complement syslog.

## Units and Targets

At the heart of systemd are unit files. A unit file is a plain text file that lives under the /lib/systemd/system directory and has a type associated with it. A unit file basically describes a resource and tells systemd how to activate that resource. The naming standard for a unit file is <resource_name>.<unit_type>. The different types of units include service, path, mount point, automount, swap, target, timer, device, and socket. So, we have unit files like cron.service, tmp.mount, syslog.socket, or graphical.target. For each service unit that’s enabled, a symbolic link to the unit file is placed under the `/etc/systemd/system/<target>.wants/` directory.

A target unit is a special kind of unit file because it doesn’t represent a single resource; rather, it groups other units to bring the system to a particular state. Target units in systemd loosely resemble run levels in System V in the sense that each target unit represents a particular system state. For example, the graphical.target unit represents a system that has booted in multi-user, graphical mode, similar to System V’s runlevel 5. Multi-user.target, on the other hand, is similar to runlevel 3 (multi-user, text mode with networking enabled). However, targets are also different from runlevels because in System V, a Linux box can exist in only one runlevel at any time. In systemd, target units are inclusive. A target unit can group other target units when it’s coming up—so it’s possible for a system to remain in more than one target. Going back to the graphical.target example, when the target comes up, it also activates multi-user.target.

For a good introduction on systemd, you can refer to this **[article](https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal)** from DigitalOcean, or the **[systemd for Administrators](https://0pointer.de/blog/projects/systemd-pdf.html)** ebook from systemd creator Lennart Poettering.

## Systemd Journal Basics

The journal is a component of systemd. It’s a centralized location for all messages logged by different components in a systemd-enabled Linux system. This includes kernel and boot messages, messages coming from syslog, or different services.

In traditional Linux, during the boot-up phase, different subsystems of the OS, or application daemons, would log all their message in different text files throughout the system. Each subsystem would log its messages with varying level of details. When troubleshooting, an administrator would often have to go through messages from multiple files within different time frames and correlate the entries. Journaling takes away this difficulty by recording both OS and application level messages in one place.

The journal is controlled by the systemd-journald daemon. It collects information from different sources and loads the messages into the journal.

The systemd journal is not a large text file. It’s a binary file maintained by the daemon. So, it can’t be opened with a text editor. As we’ll see later, the location and size of this binary file is controlled by the daemon’s configuration file. It doesn’t have to be persistent either; using configuration parameters, an administrator can turn off journaling altogether or keep it in memory so it’s volatile in nature. With in-memory journaling, systemd creates its journal files under the `/run/log/journal` directory. The directory is created if it doesn’t exist. With persistent storage, the journal is created under `/var/log/journal` directory; again, the directory is created by systemd if needed. If this directory is deleted for some reason, systemd-journald will not re-create it automatically; rather, it will write the logs under /run/log/journal in a non-persistent way. It will re-create the directory when the daemon is restarted.

Here is an example of the systemd journal:

```bash
$ ls -l /var/log/journal

drwxr-sr-x 2 root systemd-journal 4096 Jun 25 00:06 fd8cf26e06e411e4a9d004010897bd01

$ ls -l /var/log/journal/fd8cf26e06e411e4a9d004010897bd01/

-rw-r-----+ 1 root systemd-journal 109051904 Jun 27 23:00 system.journal

-rw-r-----+ 1 root systemd-journal 25165824 Jun 27 23:00 user-1000.journal
```

With systemd journal, there is no option or reason for a traditional syslog utility like logrotate. Systemd-journald can be configured to grow its files up to a percentage of the size of the volume it’s hosted in. The daemon would then automatically delete old journal entries to keep the size below that threshold. Again, as we will see later, there are multiple options for controlling journal size.

## Journald Configuration

The main configuration file for systemd-journald is /etc/systemd/journald.conf. However, other packages can create their configuration files which can be under any of these directories with a .conf extension:

- /etc/systemd/journald.conf.d/*.conf
- /run/systemd/journald.conf.d/*.conf
- /usr/lib/systemd/journald.conf.d/*.conf

The main configuration file is read before any of the custom *.conf files. If there are custom configs present, they override the main configuration parameters.

A look into the default configuration file shows the following entries. As you can see, all the parameters are commented out, meaning the values are already known to systemd as default values. If any of the values need to be changed, they have to be uncommented and the systemd-journald.service restarted.

```bash
#  This file is part of systemd.##  systemd is free software; you can redistribute

#  it and/or modify it under the terms of the GNU Lesser General Public License as

#  published by the Free Software Foundation; either version 2.1 of the License, or

#  (at your option) any later version.

#

# Entries in this file show the compile time defaults.

# You can change settings by editing this file.

# Defaults can be restored by simply deleting this file.

#

# See journald.conf(5) for details.

[Journal]

#Storage=auto

#Compress=yes

#Seal=yes

#SplitMode=uid

#SyncIntervalSec=5m

#RateLimitInterval=30s

#RateLimitBurst=1000

...
```

A brief description of some of the configuration parameters are shown below. The parameters relate to:

1. Event message persistence
2. Disk space management
3. Writing to files, syslog servers, or other destinations

For a full list of parameters, see the **[official journald.conf](https://www.freedesktop.org/software/systemd/man/journald.conf.html)** documentation. Here are six parameters you might find useful:

| Parameter       | Purpose and Possible Values                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Storage         | There are four possible values for it:  ●      “none”: This effectively turns off journaling. Any log message received will be dropped. However, any redirection to console, syslog, or kernel log buffer would still be in effect. ●      “volatile”: Journal data is saved in memory and temporarily available under the /run/log/journal directory. The directory will be created if it does not exist. ●      “persistent”: Journal data is saved persistently on disk under the /var/log/journal directory. The directory will be created if it does not exist. If the disk volume is not accessible or writable, the files will be created under /run/log/journal. ●      “auto”: The storage mode is like persistent—data will be written to disk; however, if the /var/log/journal directory does not exist, it will be created under /run/log/journal. |
| Compress        | If this parameter is enabled, data stored in the journal that is larger than a threshold will be compressed before being written to disk. The option is turned on by default and has a default threshold of 512 bytes. You can specify the threshold here, or set it to “true” to use the default.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| SystemKeepFree  | This is one of several parameters that control how large the journal can grow up to. This parameter applies if systemd is saving journals under the /var/log/journal directory. It specifies how much disk space the systemd-journald daemon will leave for other applications in the file system where the journal is hosted. The default is 15%.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| RuntimeKeepFree | This is the same as SystemKeepFree, except this applies when the journaling storage option is set to “volatile”, meaning journal files are created under /run/log/journal.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ForwardToSyslog | This parameter specifies if log messages that are received by the systemd-journald daemon will also be forwarded to a syslog daemon. The default is yes, but if no process is reading off from the socket, nothing happens.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| MaxLevelStore   | This parameter sets the maximum level of logs that are stored to disk, forwarded to syslog, the kernel log buffer, the console, or wall (if they are enabled). This parameter can take any of the following values:  ●      0 or “emerg” ●      1 or “alert” ●      2 or “crit” ●      3 or “err” ●      4 or “warning” ●      5 or “notice” ●      6 or “info” ●      7 or “debug” All messages equal or below the level specified will be stored on disk. The default value is “debug” which includes all log messages from “emerg” to “debug”.                                                                                                                                                                                                                                                                                                               |

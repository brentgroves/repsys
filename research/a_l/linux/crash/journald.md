# **[](https://sematext.com/blog/journald-logging-tutorial/)**

I’m sure you bumped into journald: it’s what most distros use by default for system logging in Linux. Most applications running as a service will also log to the journal. So how do you make use of these logs to:

find the error or debug message that you’re looking for?
make sure logs don’t fill your disk?
centralize journals so you don’t have to ssh to each box?
In this post, we’ll answer all the above and more. We will dive into the following topics:

- what is journald, how it came to be and what are its benefits
main configuration options, like when to remove old logs so you don’t run out of disk
- journald and containers: can/should containers log to the journal?
- journald vs syslog: advantages and disadvantages of both, how they integrate
- ways to centralize journals. Advantages and disadvantages of each method, and which is the best. Spoiler alert: you can - configure journald to send logs directly to Sematext Cloud; or you can use the open-source Logagent as a journald aggregator. Or – and this is the easiest approach of all – use Journald Discovery. Either way, you’ll have one place to search and analyze your journal events:

There are lots of other options to centralize journal entries, and lots of tools to help. We’ll explore them in detail, but before that, let’s zoom in to journald itself.

## What is journald?

journald is the part of systemd that deals with logging. systemd, at its core, is in charge of managing services: it starts them up and keeps them alive.

All services and systemd itself need to log: “ssh started” or “user root logged in”, they might say. That’s where journald comes in: to capture these logs, record them, make them easy to find, and remove them when they pass a certain age.

## Why use journald?

In short, because syslog sucks 🙂 Jokes aside, the paper announcing journald explained that systemd needed functionality that was hard to get through existing syslog implementations. Examples include structured logging, indexing logs for fast search, access control and signed messages.

As you might expect, not everyone agrees with these statements or the general approach systemd took with journald. But by now, systemd is adopted by most Linux distributions, and it includes journald as well. journald happily coexists with syslog daemons, as:

some syslog daemons can both read from and write to the journal
journald exposes the syslog API

## journald benefits

Think of journald as your mini-command-line-ELK that lives on virtually every Linux box. It provides lots of features, most importantly:

Indexing. journald uses a binary storage for logs, where data is indexed. Lookups are much faster than with plain text files
Structured logging. Though it’s possible with syslog, too, it’s enforced here. Combined with indexing, it means you can easily filter specific logs (e.g. with a set priority, in a set timeframe)
Access control. By default, storage files are split by user, with different permissions to each. As a regular user, you won’t see everything root sees, but you’ll see your own logs
Automatic log rotation. You can configure journald (see below) to keep logs only up to a space limit, or based on free space

## Configuring journald

To tweak how journald behaves, you’ll edit /etc/systemd/journald.conf and then reload the journal service like:

`systemctl reload systemd-journald.service`

Though earlier versions of journald need to be restarted:

systemctl restart systemd-journald.service
Most important settings will be around storage: whether the journal should be kept in memory or on disk, when to remove old logs and how much to rate limit. We’ll focus on some of those next, but you can see all the configuration options in journald.conf’s man page.

## journald storage

The Storage option controls whether the journal is stored in memory (under /run/log/journal) or on disk (under /var/log/journal). Setting Storage=volatile will store the journal in memory, while Storage=persistent will store it on disk. Most distributions have it set to auto, which means it will store the journal on disk if /var/log/journal exists, otherwise it will be stored in memory.

Once you’ve decided where to store the journal, you may want to set some limits. For example, SystemMaxUse=4G will limit /var/log/journal to about 4GB. Similarly, SystemKeepFree=10G will try to keep 10GB of disk space free. If you choose to keep the journal in memory, the equivalent options are RuntimeMaxUse and RuntimeKeepFree.

You can check the current disk usage of the journal with journalctl via journalctl --disk-usage. If you need to, you can clean it up on demand via journalctl --vacuum-size=4GB (i.e. to reduce it to 4GB).

Compression is enabled by default on log entries larger than 512 bytes. If you want to change this threshold to, say 1KB, you’d add Compress=1K.

Also by default, journald will drop all log messages from a service if it passes certain limits. These limits can be configured via RateLimitBurst and RateLimitIntervalSec, which default to 10000 and 30s respectively. Actual values will depend on the available free space. For example, if you have more than 64GB of free disk space, the multiplier will be 6. Meaning it will drop logs from a service after 60K messages sent in 30 seconds.

The rate limit defaults are sensible, unless you have a specific service that’s generating lots of logs (e.g. a web server). In that case, it might be better to LogRateLimitBurst and LogRateLimitIntervalSec in that application’s service definition.

## journald commands via journalctl

journalctl is your main tool for interacting with the journal. If you just run it, you’ll see:

all entries, from oldest to newest
paged by less
lines go past the edge of your screen if they have to (use left and right arrow keys to navigate)
format is similar to the syslog output, as it is configured in most Linux distributions: syslog timestamp + hostname + program and its PID + message

Here’s an example snippet:

Apr 09 10:22:49 localhost.localdomain su[866]: pam_unix(su-l:session): session opened for user solr by (uid=0)<
Apr 09 10:22:49 localhost.localdomain systemd[1]: Started Session c1 of user solr.<
Apr 09 10:22:49 localhost.localdomain systemd[1]: Created slice User Slice of solr.<
Apr 09 10:22:49 localhost.localdomain su[866]: (to solr) root on none

This is rarely what you want. More common scenarios are:

last N lines (equivalent of tail -n 20 – if N=20): journalctl -n 20
follow (tail -f equivalent): journalctl -f
page from newest to oldest: journalctl --reverse
skip paging and just grep for something (e.g. “solr”): journalctl --no-pager | grep solr
If you often find yourself using --no-pager, you can change the default pager through the SYSTEMD_PAGER variable. export SYSTEMD_PAGER=cat will disable paging. That said, you might want to look into journalctl’s own options for displaying and filtering – described below – before using text processing tools.

journalctl display settings
The main option here is --output, which can take many values. As an ELK consultant, I want my timestamps ISO 8601, and --output=short-iso will do just that. Now this is more like it:

2020-04-09T10:23:01+0000 localhost.localdomain solr[860]: Started Solr server on port 8983 (pid=999). Happy searching!
2020-04-09T10:23:01+0000 localhost.localdomain su[866]: pam_unix(su-l:session): session closed for user solr
journald keeps more information than what the short/short-iso output shows. Adding --output=json-pretty (or just json if you want it compact) can look like this for a single event:

{
 "__CURSOR" : "s=83694dffb084461ea30a168e6cef1e6c;i=103f;b=f0bbba1703cb43229559a8fcb4cb08b9;m=c2c9508c;t=5a2d9c22f07ed;x=c5fe854a514cef39",
 "__REALTIME_TIMESTAMP" : "1586431033018349",
 "__MONOTONIC_TIMESTAMP" : "3267973260",
 "_BOOT_ID" : "f0bbba1703cb43229559a8fcb4cb08b9",
 "PRIORITY" : "6",
 "_UID" : "0",
 "_GID" : "0",
 "_MACHINE_ID" : "13e3a06d01d54447a683822d7e0b4dc9",
 "_HOSTNAME" : "localhost.localdomain",
 "SYSLOG_FACILITY" : "3",
 "SYSLOG_IDENTIFIER" : "systemd",
 "_TRANSPORT" : "journal",
 "_PID" : "1",
 "_COMM" : "systemd",
 "_EXE" : "/usr/lib/systemd/systemd",
 "_CAP_EFFECTIVE" : "1fffffffff",
 "_SYSTEMD_CGROUP" : "/",
 "CODE_FILE" : "src/core/job.c",
 "CODE_FUNCTION" : "job_log_status_message",
 "RESULT" : "done",
 "MESSAGE_ID" : "9d1aaa27d60140bd96365438aad20286",
 "_SELINUX_CONTEXT" : "system_u:system_r:init_t:s0",
 "UNIT" : "user-0.slice",
 "MESSAGE" : "Removed slice User Slice of root.",
 "CODE_LINE" : "781",
 "_CMDLINE" : "/usr/lib/systemd/systemd --switched-root --system --deserialize 22",
 "_SOURCE_REALTIME_TIMESTAMP" : "1586431033018103"
}
This is where you can use structured logging to filter events. Next up, we’ll look closer at the most important options for filtering.

journald log filtering
You can filter by any field (see the JSON output above) by specifying key=value arguments, like:

journalctl _SYSTEMD_UNIT=sshd.service
There are shortcuts, for example the _SYSTEMD_UNIT above can be expressed as -u. The above command is the equivalent of of:

journalctl -u sshd.service
Other useful shortcuts:

severity (here called priority). journalctl -p warning will show logs with at least a severity of warning
show only kernel messages: journalctl --dmesg

You can also filter by time, of course. Here, you have multiple options:

--since/--until as a full timestamp. For example: journalctl --since="2020-04-09 11:30:00"
date only (00:00:00 is assumed as the time): journalctl --since=2020-04-09
abbreviations: journalctl --since=yesterday --until=now
In general, you have to specify the exact value you’re looking for. With the exception of _SYSTEMD_UNIT. Here, patterns also work:

journalctl -u sshd*
Newer versions of systemd also allow a --grep flag, which allows you to filter the MESSAGE field by regex. But you can always pipe the journalctl output through grep itself.

journald and boots
Besides messages logged by applications, journald remembers significant events, such as system reboots. Here’s an example:

# journalctl MESSAGE="Server listening on 0.0.0.0 port 22."

-- Logs begin at Wed 2020-04-08 11:53:18 UTC, end at Thu 2020-04-09 12:01:01 UTC. --
Apr 08 11:53:23 localhost.localdomain sshd[822]: Server listening on 0.0.0.0 port 22.
Apr 08 13:23:42 localhost.localdomain sshd[7425]: Server listening on 0.0.0.0 port 22.
-- Reboot --
Apr 09 10:22:49 localhost.localdomain sshd[857]: Server listening on 0.0.0.0 port 22.
You can suppress these special messages via -q. Use -b to show only messages after a certain boot. For example, to show messages since the last boot:

# journalctl MESSAGE="Server listening on 0.0.0.0 port 22." -b

-- Logs begin at Wed 2020-04-08 11:53:18 UTC, end at Thu 2020-04-09 12:01:01 UTC. --
Apr 09 10:22:49 localhost.localdomain sshd[857]: Server listening on 0.0.0.0 port 22.
You can specify a boot as an offset to the current one (e.g. -b -1 is the boot before the last). You can also specify a boot ID, but to do this you need to know what are the available boot IDs:

# journalctl --list-boots

-1 d26652f008ef4020b15a3d510bbcb381 Wed 2020-04-08 11:53:18 UTC—Wed 2020-04-08 14:31:16 UTC
 0 f0bbba1703cb43229559a8fcb4cb08b9 Thu 2020-04-09 10:22:43 UTC—Thu 2020-04-09 12:01:01 UTC

## journald centralized logging

As you probably noticed, journald is quite host-centric. In practice, you’ll want to access these logs in a central location, without having to SSH into each machine.

There are multiple ways of centralizing journald logs, and we’ll detail each below:

systemd-journal-upload uploads journal entries. Either directly to Sematext Cloud or to a log shipper that can read its output, such as the open-source Logagent
systemd-journal-remote as a “centralizer”. The idea is to have all journals on one host, so you can use journalctl to search (see above). This can work in “pull” or “push” mode
a syslog daemon or another log shipper reads from the local journal. Then, it forwards logs to a central store like ELK or Sematext Cloud
journald forwards entries to a local syslog socket. Then, a log shipper (typically a syslog daemon) picks messages up and forwards them to the central store
While all these tools will work, the approach that is the easiest by far is via journald auto-discovery in Sematext Cloud. Journald Discovery brings all your systemd service logs under one roof where you can granularly define log shipping rules by including/excluding specific services. This is what it looks like:

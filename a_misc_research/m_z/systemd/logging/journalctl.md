# **[Using journalctl](https://www.loggly.com/ultimate-guide/using-journalctl/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Using journalctl

Journalctl is a utility for querying and displaying logs from journald, systemd’s logging service. Since journald stores log data in a binary format instead of a plaintext format, journalctl is the standard way of reading log messages processed by journald.

In the following paragraphs, we’ll show you several ways of using journalctl to retrieve, format, and analyze your logs. These methods can be used on their own or in combination with other commands to refine your search. To get a full listing of journalctl options, visit the journalctl man page.

## All Messages

When run without any parameters, the following command will show all journal entries, which can be fairly long:

`$ journalctl`

The entries will start with a banner similar to this which shows the time span covered by the log.

```bash
-- Logs begin at Tue 2019-06-11 08:11:07 EDT, end at Mon 2019-06-24 15:18:11 EDT. --
```

Journalctl splits the results into pages, similar to the less command in Linux. You can navigate using the arrow keys, the Page Up/Page Down keys, and the space bar. To quit navigation, press the Q key.

Long entries are printed to the width of the screen and truncated off at the end if they don’t fit. The cut-off portion can be viewed using the left and right arrow keys.

## Boot Messages

Journald tracks each log to a specific system boot. To limit the logs shown to the current boot, use the -b switch.

`$ journalctl -b`

You can view messages from an earlier boot by passing in its offset from the current boot. For example, the previous boot has an offset of -1, the boot before that is -2, and so on. Here, we are retrieving messages from the last boot:

`$ journalctl -b -1`

To list the boots of the system, use the following command.

`$ journalctl --list-boots`

It will show a tabular result like this.

```bash
-3 5a035370cc264015a5afcad6e310769f Sun 2019-06-23 09:27:30 EDT—Sun 2019-06-23 11:26:45 EDT

-2 ff65fc7baac14b429a4f41828db669d4 Sun 2019-06-23 11:59:55 EDT—Sun 2019-06-23 12:29:46 EDT

-1 2d54fbdb9fc04087930fd7543f57e922 Sun 2019-06-23 20:29:15 EDT—Sun 2019-06-23 23:01:43 EDT

0 aa2a1cf3cc2143b2a0245403739a336e Mon 2019-06-24 09:23:50 EDT—Mon 2019-06-24 15:18:11 EDT
```

The first field is the offset (0 being the latest boot, -1 being the boot before that, and so on), followed by a Boot ID (a long hexadecimal number), followed by the time stamps of the first and the last messages related to that boot.

## Time Ranges

To see messages logged within a specific time window, we can use the --since and --until options. The following command shows journal messages logged within the last hour.

`$ journalctl --since "1 hour ago"`

To see messages logged in the last two days, the following command can be used.

`$ journalctl --since "2 days ago"`
The command below will show messages between two dates and times. All messages logged on or after the since parameter and logged on or before the until parameter will be shown.

`$ journalctl --since "2015-06-26 23:15:00" --until "2015-06-26 23:20:00"`

For greater accuracy, format the date and time as “YYYY-MM-DD HH:MM:SS”. You can also use any format that follows the systemd.time specification.

## By Unit

To see messages logged by any systemd unit, use the -u switch. The command below will show all messages logged by the Nginx web server. You can use the --since and --until switches here to pinpoint web server errors occurring within a time window.

`$ journalctl -u nginx.service`

The -u switch can be used multiple times to specify more than one unit source. For example, if you want to see log entries for both nginx and mysql, the following command can be used.

`$ journalctl -u nginx.service -u mysql.service`

## Follow or Tail

Journalctl can print log messages to the console as they are added, much like the Linux tail command. To do this, add the -f switch,

`$ journalctl -f`
For example, this command “follows” the mysql service log.

`$ journalctl -u mysql.service -f`
To stop following and return to the prompt, press Ctrl+C.

Like the tail command, the -n switch will print the specified number of most recent journal entries. In the command below, we are printing the last 50 messages logged within the last hour.

`$ journalctl -n 50 --since "1 hour ago"`

The -r parameter shows journal entries in reverse chronological order, so the latest messages are printed first. The command below shows the last 10 messages from the sshd daemon, listed in reverse order.

`$ journalctl -u sshd.service -r -n 1`

## Output Formats

The -o parameter enables us to format the output of journalctl query. -o (or --output if we are using the long form parameter name) can take a few values.

- jsonwill show each journal entry in json format in one long line. This is useful when sending logs to a log centralization or analysis service, since it makes them easier to parse.
- json-pretty will show each log entry in easy-to-read json format.
- verbose will show very detailed information for each journal record with all fields listed.
- cat shows messages in very short form, without any date/time or source server names.
- shortis the default output format. It shows messages in syslog style.
- short-monotonic is similar to short, but the time stamp second value is shown with precision. This can be useful when you are looking at error messages generated from more than one source, which apparently are throwing error messages at the same time and you want to go to the granular level.
For example, the following command prints logs from the Apache web server in json-pretty format.

`$ journalctl -u apache2.service -r -o json-pretty`

Here’s a sample of the output. You can see a number of important fields including the user, group, syslog facility, and even the code location that generated the message (if available).

```json
{

"__CURSOR" : "s=c4ee459c883148549d114c566bc0b979;i=12b782;b=6c92864cbcc64a5fabebe04147953894;m=42d22604a2;t=58bc87981a1f5;x=8daf632187

"__REALTIME_TIMESTAMP" : "1561068031812085",

"__MONOTONIC_TIMESTAMP" : "286993548450",

"_BOOT_ID" : "6c92864cbcc64a5fabebe04147953894",

"SYSLOG_FACILITY" : "3",

"_UID" : "0",

"_GID" : "0",

...

"UNIT" : "apache2.service",

"CODE_LINE" : "2039",

"CODE_FUNCTION" : "unit_notify",

"MESSAGE" : "apache2.service: Unit entered failed state.",

"_SOURCE_REALTIME_TIMESTAMP" : "1561068031809136"

}
```

## By User

To find all messages related to a particular user, use the UID for that user. In the following example, we are finding the UID of the user mysql.

`$ id mysql`
This returns a line like this.

```bash
uid=108(mysql) gid=116(mysql) groups=116(mysql)
And then we are querying the journal for all messages logged by that user.

# journalctl _UID=108
```

This shows logs generated by processes running under the mysql user.

-- Logs begin at Thu 2015-06-25 00:34:38 EDT, end at Sun 2015-06-28 23:16:08 EDT. --

Jun 25 00:53:21 test-ubuntu15 mysqld_safe[11177]: 150625 00:53:21 mysqld_safe Can't log to error log and syslog at the same time.  Remove all --log-error configuration options for --syslog to take effect.

Jun 25 00:53:21 test-ubuntu15 mysqld_safe[11177]: 150625 00:53:21 mysqld_safe Logging to '/var/log/mysql/error.log'.

Jun 25 00:53:21 test-ubuntu15 mysqld_safe[11177]: 150625 00:53:21 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql

Jun 27 21:41:26 test-ubuntu15 mysqld_safe[11177]: Could not open required defaults file: /etc/mysql/debian.cnf

Jun 27 21:41:26 test-ubuntu15 mysqld_safe[11177]: Fatal error in defaults handling. Program aborted

Jun 27 21:41:26 test-ubuntu15 mysqld_safe[11177]: 150627 21:41:26 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended

<b>-- Reboot --</b>

Jun 27 21:41:33 test-ubuntu15 mysqld_safe[561]: 150627 21:41:33 mysqld_safe Can't log to error log and syslog at the same time.  Remove all --log-error configuration options for --syslog to take effect.

Jun 27 21:41:33 test-ubuntu15 mysqld_safe[561]: 150627 21:41:33 mysqld_safe Logging to '/var/log/mysql/error.log'.

Jun 27 21:41:33 test-ubuntu15 mysqld_safe[561]: 150627 21:41:33 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql

# **[How can I send a message to the systemd journal from the command line?](https://serverfault.com/questions/573946/how-can-i-send-a-message-to-the-systemd-journal-from-the-command-line)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

**[logging tutorial](https://sematext.com/blog/journald-logging-tutorial/)**

## unit-file

Since the question mentions Arch Linux (systemd-controlled from day one) and logging, I'll hazard a guess it is related to logging from a systemd service. Here's another **[logging technique for shell scripts](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Logging%20and%20Standard%20Input/Output)** invoked from systemd service units. systemd can be (and by default is) set up to listen to the service's processes stderr and/or stdout, and forward messages to the journal. When a message starts with a 3-character prefix '<' N '>', where N is a digit from 0 to 7, systemd interprets it as the log level, omits it, and logs the rest of the string at the specified level.

It is convenient, since any stderr message from any command will be automatically logged at the error level. Another fd is reserved for logging at an arbitrary different severity.

This is of course available to all programs, not only shell scripts.

## Example

A shell script (Bash in this case, relying on process substitution and trap ... EXIT behavior), taken from a real service's ExecStartPre script:

```bash
# !/bin/bash

# Redirect stderr such that any message is reported as an error to journald by

# prepending '<3>' to it. Use fd 4 (the saved stderr) to directly report other

# severity levels

exec 4>&2 2> >(while read -r REPLY; do printf >&4 '<3>%s\n' "$REPLY"; done)

# Systemd can kill the logging subshell swiftly when we exit, and lose messages

# Close the subshell before exiting the main program explicitly. This will block

# until the read builtin reads the EOF

trap 'exec >&2-' EXIT

### From this point on, all stderr messages will be logged to syslog as errors

### via the subshell running the while loop. Fd 4 is the old stderr, and may

### be used to specify non-error level

echo >&2 "This message is logged as an error, red and bold."

echo >&4 "<5>This is logged as a notice-level message, dim and boring."

echo >&4 "This is logged at the default severity level, 'info' unless changed."


## systemd-cat

`systemd-cat` is the equivalent to logger:

`echo 'hello' | systemd-cat`

In another terminal, running `journalctl -f`:

Feb 07 13:38:33 localhost.localdomain cat[15162]: hello
Priorities are specified just by part of the string:

```bash
echo 'hello' | systemd-cat -p info
echo 'hello' | systemd-cat -p warning
echo 'hello' | systemd-cat -p emerg
```

Warnings are bold, emergencies are bold and red. Scary stuff.

You can also use an 'identifier' which is arbitrary, to specify the app name. These are like syslog's old facilities, but you're not stuck with ancient things like lpr uucp nntp or the ever-descriptive local0 through local7.

```bash
echo 'hello' | systemd-cat -t someapp -p emerg
echo 'hello' | systemd-cat -t myiptables -p emerg

echo 'hello' | systemd-cat -u myiptables -p emerg

journalctl -t someapp

```

Is logged as:

Feb 07 13:48:56 localhost.localdomain someapp[15278]: hello

Very useful. You can filter to the log messages created with -t using the following command: journalctl -t someapp –
Att Righ
 CommentedOct 1, 2017 at 13:05

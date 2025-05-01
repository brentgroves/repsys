# **[How can I send a message to the systemd journal from the command line?](https://serverfault.com/questions/573946/how-can-i-send-a-message-to-the-systemd-journal-from-the-command-line)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

**[logging tutorial](https://sematext.com/blog/journald-logging-tutorial/)**

## 138

systemd-cat is the equivalent to logger:

echo 'hello' | systemd-cat
In another terminal, running journalctl -f:

Feb 07 13:38:33 localhost.localdomain cat[15162]: hello
Priorities are specified just by part of the string:

echo 'hello' | systemd-cat -p info
echo 'hello' | systemd-cat -p warning
echo 'hello' | systemd-cat -p emerg
Warnings are bold, emergencies are bold and red. Scary stuff.

You can also use an 'identifier' which is arbitrary, to specify the app name. These are like syslog's old facilities, but you're not stuck with ancient things like lpr uucp nntp or the ever-descriptive local0 through local7.

echo 'hello' | systemd-cat -t someapp -p emerg
Is logged as:

Feb 07 13:48:56 localhost.localdomain someapp[15278]: hello

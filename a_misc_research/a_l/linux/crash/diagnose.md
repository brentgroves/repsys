# Linux crash logs

I'm running a straightforward Ubuntu 11.04 linux box. Lately it has started to shutdown inexplicably. I'm not doing any heavy stuff at all, just the odd usenet / torrent download (sabnzbd / transmission).

So, how do I diagnose the problem? Where can I find logs etc to find what's going wrong, and what should I look for?

EDIT: It's a server box sitting unattended so I have never seen it shutting down. All I know sometimes when I try to ssh to the box I realize it has shut down, i.e., I have no clue why, how, or when it has turned itself off. No clues when I restart, and it restarts just fine too...

EDIT: I am fairly certain a psu cable caused a short. Perhaps it is time to buy a proper case. Thanks much for all the replies! Once again I was reminded of all the awesomeness of the linux community!

Upvote
25

Downvote

39
Go to comments

## answer

All linux logs are stored in /var/log, dmesg or messages are the ones your probably want. These are general system logs (but many other programs make logs).

There is a cronjob that rotates them (logrotate), so syslog gets moved to syslog.1, syslog.1 becomes syslog.2, syslog.2 is usually deleted and an empty syslog is created, same for just about every other log. On my system at least (slackware) dmesg is the only one overwritten at boot.

If the kernel itself crashes there won't be any logs in /var/log/*, if it's a hardware issue he should be running mcelog and smartmon-tools

Ubuntu should have memtest already installed to verify there's nothing wrong with your physical memory, but if it's instantly powering down randomly it sounds like a power supply issue. I don't know how you can verify that easily unless you have a spare power supply laying around.

If the server is running X have you looked at the Xorg log yet? If it's a graphics card issue you might get a hint in there. I'm on arch and mine is located at /var/log/Xorg.0.log. Should be the same or very similar on Ubuntu. Just look for any lines beginning with (EE) which specifies an error.

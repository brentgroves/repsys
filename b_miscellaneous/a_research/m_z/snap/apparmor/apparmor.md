# **[](https://apparmor.net/)**

AppArmor
Linux kernel security module
Quick introduction
AppArmor is an effective and easy-to-use Linux application security system. AppArmor proactively protects the operating system and applications from external or internal threats, even zero-day attacks, by enforcing good behavior and preventing both known and unknown application flaws from being exploited.

AppArmor supplements the traditional Unix discretionary access control (DAC) model by providing mandatory access control (MAC). It has been included in the mainline Linux kernel since version 2.6.36 and its development has been supported by Canonical since 2009.

## Installation

Many Linux distributions (e.g. Debian, Ubuntu, OpenSUSE) ship with AppArmor.

Simply run aa-status to see if your Linux distribution already has AppArmor integrated:

$ aa-status
apparmor module is loaded.

Since it is a kernel module it is usually not something users install themselves. Individual users and system administrators might however want to manage the application profiles which define what each application is allowed to do by editing the files in /etc/apparmor.d/.

The list of currently active profiles can be easily checked with aa-status.

sudo cat /etc/apparmor.d/lxc-unshare

# This profile allows everything and only exists to give the

# application a name instead of having the label "unconfined"

abi <abi/4.0>,
include <tunables/global>

profile lxc-unshare /usr/bin/lxc-unshare flags=(unconfined) {
  userns,

# Site-specific additions and overrides. See local/README for details

  include if exists <local/lxc-unshare>
}

## Checking AppArmor log messages

Each time AppArmor denies applications from doing potentially harmful operations the event is logged. Depending on your system the AppArmor events can be seen in the syslog, auditd, kernel log or in journald logs.

Example:

```bash
$ sudo journalctl -fx
audit[13172]: AVC apparmor="ALLOWED" operation="open"
profile="libreoffice-soffice"
name="/home/otto/.mozilla/firefox/ov37570l.default/cert8.db"
pid=13172 comm="soffice.bin" requested_mask="w"
denied_mask="w" fsuid=1001 ouid=1001
```

Desktop systems that have the tool aa-notify installed can show events as graphical notifications.

## Debugging application problems

When debugging issues, the first step should always be to disable the AppArmor profile for the application and check if it had an effect. If not, the problem in the application was not related to AppArmor.

Read more
More details about AppArmor can be found in the **[wiki](https://gitlab.com/apparmor/apparmor/-/wikis/home)**.

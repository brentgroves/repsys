# **[Linux Logging with Systemd](https://www.loggly.com/ultimate-guide/linux-logging-with-systemd/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Units and Targets

At the heart of systemd are unit files. A unit file is a plain text file that lives under the /lib/systemd/system directory and has a type associated with it. A unit file basically describes a resource and tells systemd how to activate that resource. The naming standard for a unit file is <resource_name>.<unit_type>. The different types of units include service, path, mount point, automount, swap, target, timer, device, and socket. So, we have unit files like cron.service, tmp.mount, syslog.socket, or graphical.target. For each service unit that’s enabled, a symbolic link to the unit file is placed under the `/etc/systemd/system/<target>.wants/` directory.

A target unit is a special kind of unit file because it doesn’t represent a single resource; rather, it groups other units to bring the system to a particular state. Target units in systemd loosely resemble run levels in System V in the sense that each target unit represents a particular system state. For example, the graphical.target unit represents a system that has booted in multi-user, graphical mode, similar to System V’s runlevel 5. Multi-user.target, on the other hand, is similar to runlevel 3 (multi-user, text mode with networking enabled). However, targets are also different from runlevels because in System V, a Linux box can exist in only one runlevel at any time. In systemd, target units are inclusive. A target unit can group other target units when it’s coming up—so it’s possible for a system to remain in more than one target. Going back to the graphical.target example, when the target comes up, it also activates multi-user.target.

For a good introduction on systemd, you can refer to this **[article](https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal)** from DigitalOcean, or the **[systemd for Administrators](https://0pointer.de/blog/projects/systemd-pdf.html)** ebook from systemd creator Lennart Poettering.

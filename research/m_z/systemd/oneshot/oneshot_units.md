# **[What sysadmins need to know about systemd's oneshot service type](https://www.redhat.com/en/blog/systemd-oneshot-service)**

**[Current Tasks](../../../../a_status/current_tasks.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

systemd is a robust tool for handling Linux services. If you've interacted with a systemd service file, it's probably been a simple or forking type. There are many other service types in systemd, including exec, dbus, notify, idle, and oneshot, each with different functions.

The oneshot service type is useful if you want to trigger a workflow but need to do some setup first or have a series of sequential standalone tasks. If you were to use a simple service type, you would end up with a dead service status after the script runs and exits, which is misleading for anyone who doesn't have knowledge of that particular service. It's also a great service to run as a shutdown hook.

The **[systemd.service man page](https://www.man7.org/linux/man-pages/man5/systemd.service.5.html)** goes into more detail about each service type. According to the systemd man page:

[The] behavior of oneshot is similar to simple; however, the service manager will consider the unit up after the main process exits. It will then start follow-up units. RemainAfterExit= is particularly useful for this type of service. Type=oneshot is the implied default if neither Type= nor ExecStart= are specified. Note that if this option is used without RemainAfterExit= the service will never enter "active" unit state, but directly transition from "activating" to "deactivating" or "dead" since no process is configured that shall run continuously. In particular this means that after a service of this type ran (and which has RemainAfterExit= not set) it will not show up as started afterwards, but as dead.

A great example of using a oneshot service is to build it into a golden image and hook it into the startup process to perform a specific action. Perhaps you want to make a one-time call to a service and set its value in an environment variable. Or maybe you want to run a very specific system health check to ensure a complex system on the server started up correctly. The oneshot service can be useful in many different situations.

What's in a service file?
Before I get into using oneshot, I'll show what a service file looks like.

[ Want to know more about systemd? Download the free **[Linux systemd cheat sheet](https://opensource.com/downloads/linux-systemd-cheat-sheet?intcmp=701f20000012ngPAAQ&_gl=1*1nmwhk4*_gcl_au*MTY0NDkyMDEwNS4xNzQ2MjA0MTMy)**. ]

Here is a service file for Nginx located at /usr/lib/systemd/system/nginx.service:

Here is a service file for Nginx located at /usr/lib/systemd/system/nginx.service:

```bash
[Unit]
Description=The nginx HTTP and reverse proxy server
After=network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/run/nginx.pid

# Nginx will fail to start if /run/nginx.pid already exists but has the wrong

# SELinux context. This might happen when running `nginx -t` from the cmdline

# <https://bugzilla.redhat.com/show_bug.cgi?id=1268621>

ExecStartPre=/usr/bin/rm -f /run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
KillSignal=SIGQUIT
TimeoutStopSec=5
KillMode=mixed
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

Every service must have a [Service] block, and the [Unit] and [Install] sections are common.

The [Unit] block defines information that isn't dependent on the type of story. Description is pretty self-explanatory. After and Wants are used for ordering.

The [Service] block contains all of the service-specific configurations. Parameters such as the start and reload commands and whether PrivateTmp is used are specified here. This section hosts the Type parameter, which is where a oneshot service type would be specified.

The [Install] block usually includes the WantedBy parameter and occasionally a RequiredBy parameter. That section is only used when you enable a service with systemctl enable. When a service is enabled, it adds a symbolic link to a directory. The link is read during startup and started in the appropriate order.

For more details on the available parameters, I encourage you to dig into the systemd.service man page.

## What a oneshot service looks like

The simplest oneshot service might look something like this:

```bash
[Unit]
Description=A simple oneshot service

[Service]
Type=oneshot
ExecStart=/bin/bash -c "echo Hello world"
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

The service is called on system boot. But what does RemainAfterExit do? The man page isn't exactly useful:

Takes a boolean value that specifies whether the service shall be considered active even when all its processes exited. Defaults to no.

Essentially, if RemainAfterExit=no is left unspecified when the service runs, the state becomes inactive (dead). This can have downstream effects on dependent services since the service never actually transitions to an active state.

## Chaining commands in a oneshot service

One of the most powerful benefits of a oneshot service is chaining multiple ExecStart and ExecStop parameters. For example, a oneshot service could chain several commands like this:

```bash
[Unit]
Description=A oneshot service with many start and stop execs

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c "echo First"
ExecStart=/bin/bash -c "echo Second"
ExecStart=/bin/bash -c "echo Third"
ExecStop=/bin/bash -c "echo Fourth"
ExecStop=/bin/bash -c "echo Fifth"
ExecStop=/bin/bash -c "echo Sixth"

[Install]
WantedBy=multi-user.target
```

On a system start, the service above will echo First, Second, Third, and on a shutdown event, it will echo Fourth, Fifth, Sixth. The simplicity of the example aside, there's significant potential for this capability.

![os](https://www.redhat.com/rhdc/managed-files/styles/wysiwyg_full_width/private/sysadmin/2022-04/oneshot.png.webp?itok=_KD_GeeJ)

## Creating a oneshot service

You create a oneshot service like any other service. A user-created service file should reside in /etc/systemd/system/ while system services exist in /usr/lib/systemd/system.

There's no explicit guidance on the man page for file permissions, but looking at the services in /usr/lib/systemd/system, normal files are essentially all -rw-r--r-- or 644.

After you generate a service file, you need to reload systemd's configuration with `systemctl daemon-reload`.

After that, it functions like any other service. You can enable it to start on boot with systemctl enable foo.service and manipulate the service state with systemctl start foo.service, systemctl stop foo.service, and so on.

## A oneshot service example

The example above is simple, but here is a more realistic scenario:

You are using AWS and have the IMDSv2 Metadata service enabled and reachable on your instance. You have a number of resource tags on your instance and have a script that queries the metadata service for the tag values. You also run an agent binary that sends metrics to a third-party monitoring service on the server. You want to attach those resource tags to your monitoring service and send readiness alerts to the event stream in that service.

With the above scenario, you can accomplish that with a straightforward oneshot service:

```bash
[Unit]
Description=Query metadata and attach to monitoring service

[Service]
Type=oneshot
RemainAfterExit=yes
#This script querys the IMDSv2 endpoint for resource tags and saves them into a configuration file
ExecStart=/usr/local/bin/metadata.sh

#This script sends an event to the monitoring service, the parameter start declares the system is starting up
ExecStart=/usr/local/bin/eventNotifier.sh start

#Same script as above, but sends a system stop message to the monitoring service.
ExecStop=/usr/local/bin/eventNotifier.sh stop 

[Install]
WantedBy=multi-user.target
```

## Wrap up

When you consider the flexibility of systemd and using concepts such as service chaining, the appeal of oneshot services becomes more apparent. While the examples presented above are functional, they are very simple to showcase how to construct a oneshot service.

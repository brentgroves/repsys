# **[How to set environment variable in systemd service?](https://serverfault.com/questions/413397/how-to-set-environment-variable-in-systemd-service)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

423

I have an Arch Linux system with systemd and I've created my own service. The configuration service at /etc/systemd/system/myservice.service looks like this:

[Unit]
Description=My Daemon

[Service]
ExecStart=/bin/myforegroundcmd

[Install]
WantedBy=multi-user.target
Now I want to have an environment variable set for the /bin/myforegroundcmd. How do I do that?

## answer

Times change and so do best practices.

The current best way to do this is to run systemctl edit myservice, which will create an override file for you or let you edit an existing one.

In normal installations this will create a directory /etc/systemd/system/myservice.service.d, and inside that directory create a file whose name ends in .conf (typically, override.conf), and in this file you can add to or override any part of the unit shipped by the distribution.

For instance, in a file /etc/systemd/system/myservice.service.d/myenv.conf:

```bash
[Service]
Environment="SECRET=pGNqduRFkB4K9C2vijOmUDa2kPtUhArN"
Environment="ANOTHER_SECRET=JP8YLOc2bsNlrGuD6LVTq7L36obpjzxd"
```

Also note that if the directory exists and is empty, your service will be disabled! If you don't intend to put something in the directory, ensure that it does not exist.

For reference, the old way was:

The recommended way to do this is to create a file /etc/sysconfig/myservice which contains your variables, and then load them with EnvironmentFile.

For complete details, see Fedora's documentation on how to write a systemd script.

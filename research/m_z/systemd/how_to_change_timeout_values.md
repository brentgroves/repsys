# **[How to change systemd service timeout value?](https://unix.stackexchange.com/questions/227017/how-to-change-systemd-service-timeout-value)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

<https://stackoverflow.com/questions/77991982/monitoring-for-failure-and-quickly-restarting-systemd-service>

In the company I am working now there is a legacy service and its init script is using old SysvInit, but is running over systemd (CentOS 7).

Because there's a lot of computation, this service takes around 70 seconds to finish. I didn't configure any timeout for systemd, and didn't change the default configs at /etc/systemd/system.conf, but still when I execute service SERVICE stop my service is timing out after 60 seconds.

Checking with journalctl -b -u SERVICE.service I find this log:

Sep 02 11:27:46 service.hostname systemd[1]: Stopping LSB: Start/Stop
Sep 02 11:28:46 service.hostname SERVICE[24151]: Stopping service: Error code: 255
Sep 02 11:28:46 service.hostname SERVICE[24151]: [FAILED]
I already tried changing the DefaultTimeoutStopSec property at /etc/systemd/system.conf to 90s, but the timeout still happens.

Does anyone have any idea why is it timeouting at 60s? Is there somewhere else that this timeout value is configured? Is there a way I can check it?

This service runs with java 7 and to daemonize it, it uses JSVC. I configured the -wait parameter with the value 120.

## answer

My systemd service kept timing out because of how long it would take to boot up also, so this fixed it for me:

Edit your systemd file:

For modern versions of systemd: Run `systemctl edit --full node.service` (replace "node" with your service name).
This will create a system file at /etc/systemd/system/node.service.d/ that will override the system file at /usr/lib/systemd/system/node.service. This is the proper way to configure your system files. More information about how to use systemctl edit is here.
Directly editing system file: The system file for me is at /usr/lib/systemd/system/node.service. Replace "node" with your application name. However, it is not safe to directly edit files in /usr/lib/systemd/ (See comments)
Use TimeoutStartSec, TimeoutStopSec or TimeoutSec (more info **[here](https://www.freedesktop.org/software/systemd/man/systemd.service.html)**) to specify how long the timeout should be for starting & stopping the process. Afterwards, this is how my systemd file looked:

```bash
[Unit]
Description=MyProject
Documentation=man:node(1)
After=rc-local.service

[Service]
WorkingDirectory=/home/myproject/GUIServer/Server/
Environment="NODE_PATH=/usr/lib/node_modules"
ExecStart=-/usr/bin/node Index.js
Type=simple
Restart=always
KillMode=process
TimeoutSec=900

[Install]
WantedBy=multi-user.target
```

You can also view the current Timeout status by running any of these (but you'll need to edit your service to make changes! See step 1). Confusingly, the associated properties have a "U" in their name for microseconds. See this Github issue for more information:

```bash
systemctl show node.service -p TimeoutStartUSec
systemctl show node.service -p TimeoutStopUSec
systemctl show node.service -p TimeoutUSec
```

- Next you'll need to reload the systemd with systemctl reload node.service
- Now try to start your service with systemctl start node.service
- If that didn't work, try to reboot systemctl with systemctl reboot

If that didn't work, try using the `--no-block` option for systemctl like so: systemctl --no-block start node.service. This option is described here: "Do not synchronously wait for the requested operation to finish. If this is not specified, the job will be verified, enqueued and systemctl will wait until the unit's start-up is completed. By passing this argument, it is only verified and enqueued."

There is also the option to use systemctl mask instead of systemctl start. For more info see here.

## Updates from Comments

- TimeoutSec=infinity: Instead of using "infinity" here, put a large amount of time instead, like TimeoutSec=900 (15 min). If the application takes "forever" to exit, then it's possible that it will block a reboot indefinitely. Credit @Alexis Wilke and @JCCyC
- Instead of editing /usr/lib/systemd/system, try `systemctl edit` instead or edit `/etc/systemd/system` to override them instead. You should never edit service files in /usr/lib/. Credit @ryeager and @0xC0000022L

**Update from systemd source docs** When specified "infinity" as a value to any of these timeout params, the timeout logic is disabled.

`JobTimeoutSec=, JobRunningTimeoutSec=,TimeoutStartSec=,  TimeoutAbortSec=`

The default is "infinity" (job timeouts disabled), except for device units where JobRunningTimeoutSec= defaults to DefaultTimeoutStartSec=.

Reference: enter **[link description here](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#)**

Similarly this logic applies to service level and laid out clearly in URL below. Reference: enter link description **[here](https://www.freedesktop.org/software/systemd/man/systemd.service.html#)**

# **[Centralizing with Syslog](https://www.loggly.com/ultimate-guide/centralizing-with-syslog/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Centralizing with Syslog

Systemd can collect and store logs, but it doesn’t have a built-in method of logging to remote locations such as log management systems. Instead, it relies on the device’s syslog service to relay messages between journald and a remote syslog server. However, syslog is text-based and the journald uses a binary format, so your logs need to be converted before they can be transferred. You can do this by using either systemd’s ForwardToSyslog configuration setting, or by using rsyslog’s imjournal module.

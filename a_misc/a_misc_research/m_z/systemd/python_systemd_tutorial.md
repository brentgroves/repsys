# **[Writing a systemd Service in Python](https://github.com/torfsen/python-systemd-tutorial)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

If you restart your system now then our service will be started automatically once you log in. After your last session is closed, your user's systemd instance (and with it, our service) will shutdown. You can make your user's systemd instance independent from your user's sessions (so that our service starts at boot time even if you don't log in and also keeps running until a shutdown/reboot) via

$ sudo loginctl enable-linger $USER

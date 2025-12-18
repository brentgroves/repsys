# **[How do I add ~/bin to PATH for a systemd service?](https://askubuntu.com/questions/1014480/how-do-i-add-bin-to-path-for-a-systemd-service)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

You could hardcode the PATH in the systemd service:

```bash
[Service]
Environment=PATH=/home/brent/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

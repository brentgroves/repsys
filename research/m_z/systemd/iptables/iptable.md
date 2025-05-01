# **[invoke-iptables-from-systemd-unit-file](https://unix.stackexchange.com/questions/694357/how-to-invoke-iptables-from-systemd-unit-file)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## note

Many apps update iptables so I will try to avoid using iptables-save and instead recreate my rules only. Example is recreate_rules.sh

## reference

- **[invoke-iptables-from-systemd-unit-file](https://unix.stackexchange.com/questions/694357/how-to-invoke-iptables-from-systemd-unit-file)**
- **[Configuration and usage](https://wiki.archlinux.org/title/Iptables)**
- **[github docker](https://github.com/ntk148v/systemd-iptables)**
- **[github iptables docker](https://github.com/boTux-fr/systemd-service-iptables)**

## **[What capabilites does the unit file need to invoke iptables](https://unix.stackexchange.com/questions/694357/how-to-invoke-iptables-from-systemd-unit-file)**

The bare minimum Capabilties required to execute iptables are CAP_NET_RAW and CAP_NET_ADMIN (At least tested on my RHEL instance, but this should be a general thing). I wasn't able to dig up anything relevant in a quick search as to why CAP_NET_RAW was also required; But an educated best guess would be that iptables uses raw sockets to handle MAC filtering/any filtering that would occur at Layer 2.

This means your override file should look something like this; Provided there aren't any additional Capabilities the script you are executing in it requires.

```bash
[Service]
Type=forking
ExecStart=
ExecStart=/etc/memcache/memcache-repl-start.sh start
ExecStop=/etc/memcache/memcache-repl-start.sh stop
CapabilityBoundingSet=CAP_SETGID CAP_SETUID CAP_SYS_RESOURCE CAP_NET_ADMIN CAP_NET_RAW
```

It's possible that particular rules could require additional Capabilities; But with the information provided I can't dig very much further.

Doing strace on iptables tells why: socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER) = 3. So it's a RAW socket, but for the netlink API (for iptables-nft). iptables-legacy using the legacy API does: socket(AF_INET, SOCK_RAW, IPPROTO_RAW) = 3

## Where does the display-manager unit file store it's files

In `/usr/share/gdm/generate-config`
So we could create a `/usr/share/iptables` dir to store the `recreate_rules.sh` script.

```bash
cat /etc/systemd/system/display-manager.service 
...
[Service]
ExecStartPre=/usr/share/gdm/generate-config
ExecStart=/usr/sbin/gdm3
KillMode=mixed
Restart=always
RestartSec=1s
IgnoreSIGPIPE=no
BusName=org.gnome.DisplayManager
EnvironmentFile=-/etc/default/locale
ExecReload=/usr/share/gdm/generate-config
ExecReload=/bin/kill -SIGHUP $MAINPID
KeyringMode=shared
```

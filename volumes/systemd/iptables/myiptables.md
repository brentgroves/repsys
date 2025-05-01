# **[iptable unit file example](https://serverfault.com/questions/69510/i-have-a-file-with-all-the-iptable-settings-how-do-i-load-this-into-my-server)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## reference

- **[invoke-iptables-from-systemd-unit-file](https://unix.stackexchange.com/questions/694357/how-to-invoke-iptables-from-systemd-unit-file)**

## AI Overview

An example iptables unit file would define the rules for a firewall, specifying which network traffic to accept, drop, or forward. A unit file would typically include sections for setting the default policy (like ACCEPT or DROP), defining specific rules, and optionally saving or restoring the rules at system startup.
Here's a basic example:

```bash
[Unit]
Description=Iptables firewall rules
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
Type=oneshot
ExecStart=/sbin/iptables-restore < /etc/iptables/rules.v4
ExecStop=/sbin/iptables-save > /etc/iptables/rules.v4
```

## Explanation

```bash
[Unit]
section:
Description: A short description of the service.
After: Specifies that this service should start after the network.target service, ensuring the network is up before applying firewall rules.

[Install]
section:
WantedBy: Indicates that this service should be started when multi-user.target is reached (typically after the system has fully booted).

[Service]
section:
Type: Sets the service type to oneshot, meaning it runs once and then exits.
ExecStart: The command executed when the service starts. Here, it uses iptables-restore to load the firewall rules from /etc/iptables/rules.v4.
ExecStop: The command executed when the service stops. This uses iptables-save to save the current iptables rules to /etc/iptables/rules.v4. 

```

## Test unit file

```bash
pushd .
cd ~/src/repsys/volumes/systemd/iptables
sudo mkdir /etc/myiptables
sudo chmod 777 /etc/myiptables
# copy contents
cp ./*.sh /etc/myiptables/
# verify
ls -alh /etc/myiptables
total 24K
drwxrwxrwx   2 root  root  4.0K May  1 15:47 .
drwxr-xr-x 148 root  root   12K May  1 15:34 ..
-rwxrwxr-x   1 brent brent 2.0K May  1 15:47 delete_myrules.sh
-rwxrwxr-x   1 brent brent 2.3K May  1 15:47 recreate_myrules.sh

```

## manually test scripts without systemd

```bash
iptables -S
iptables -t nat -S
/etc/myiptables/recreate_rules.sh
/etc/myiptables/delete_rules.sh
```

## verify rule changes

```bash
iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A PREROUTING -d 10.187.40.123/32 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
-A POSTROUTING -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j SNAT --to-source 10.187.40.123

iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A FORWARD -s 10.188.50.202/32 -p tcp -m tcp --sport 8080 -j ACCEPT
-A FORWARD -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j ACCEPT
```

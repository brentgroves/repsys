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
cd 
sudo mkdir /etc/myiptables
sudo chmod 777 /etc/myiptables
copy contents
cp ./*.sh /etc/myiptables/
```

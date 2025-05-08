# SystemD iptables test3

```bash
[Unit]
Description=Iptables firewall rules
After=network.target

[Service]
Type=oneshot
WorkingDirectory=/path/to/your/project
ExecStart=/etc/myiptables/recreate_rules.sh
User=your_user
Group=your_group

[Install]
WantedBy=multi-user.target
```

In this example:

- Description: Provides a description for the service.
- After: Specifies that the service should start after the network is up.
- WorkingDirectory: Sets the working directory for the script.
- ExecStart: Defines the shell script to execute.
- User and Group: Define the user and group to run the script as.
- Restart: Configures the service to restart on failure.
- WantedBy: Specifies that the service should be enabled for multi-user targets.

## iptest3

```bash
# from 1st terminal
journalctl -u iptest3.service -f 
# or if there were issues starting service
journalctl -f 

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/iptables
mkdir -p /etc/mytests/iptest3/
cp iptest3*.sh /etc/mytests/iptest3/
sudo cp iptest3.service /etc/systemd/system/
sudo systemctl start iptest3

# from 1st terminal
journalctl -u iptest2.service -f 

May 07 17:25:53 research21 systemd[1]: iptest2.service: Deactivated successfully.
May 07 17:25:53 research21 systemd[1]: Finished iptest2.service - Iptables firewall rules test1.
May 07 17:54:41 research21 systemd[1]: Starting iptest2.service - Iptables firewall rules test1...
May 07 17:54:41 research21 iptest2start.sh[620266]: Starting the script...
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 1
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 2
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 3
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 4
May 07 17:54:41 research21 iptest2start.sh[620266]: Ending the script...
May 07 17:54:41 research21 systemd[1]: Finished iptest2.service - Iptables firewall rules test1.

# check log
cat /etc/mytests/iptest2/log       

Hello, world!

## check it out
systemctl status iptest2.service
● iptest2.service - Iptables firewall rules test1
     Loaded: loaded (/etc/systemd/system/iptest2.service; disabled; preset: enabled)
     Active: active (exited) since Wed 2025-05-07 17:54:41 EDT; 7s ago
    Process: 620266 ExecStart=/etc/mytests/iptest2/iptest2start.sh (code=exited, status=0/SUCCESS)
   Main PID: 620266 (code=exited, status=0/SUCCESS)
        CPU: 5ms

May 07 17:54:41 research21 systemd[1]: Starting iptest2.service - Iptables firewall rules test1...
May 07 17:54:41 research21 iptest2start.sh[620266]: Starting the script...
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 1
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 2
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 3
May 07 17:54:41 research21 iptest2start.sh[620266]: log level 4
May 07 17:54:41 research21 iptest2start.sh[620266]: Ending the script...
May 07 17:54:41 research21 systemd[1]: Finished iptest2.service - Iptables firewall rules test1.

# stop service
sudo systemctl stop iptest2

# check status
systemctl status iptest2.service

○ iptest2.service - Iptables firewall rules test1
     Loaded: loaded (/etc/systemd/system/iptest2.service; disabled; preset: enabled)
     Active: inactive (dead)

May 07 17:54:41 research21 systemd[1]: Finished iptest2.service - Iptables firewall rules test1.
May 07 17:57:03 research21 systemd[1]: Stopping iptest2.service - Iptables firewall rules test1...
May 07 17:57:03 research21 iptest2stop.sh[620881]: Starting the stop script...
May 07 17:57:03 research21 iptest2stop.sh[620881]: stop - log level 1
May 07 17:57:03 research21 iptest2stop.sh[620881]: stop - log level 2
May 07 17:57:03 research21 iptest2stop.sh[620881]: stop - log level 3
May 07 17:57:03 research21 iptest2stop.sh[620881]: stop - log level 4
May 07 17:57:03 research21 iptest2stop.sh[620881]: Ending the stop script...
May 07 17:57:03 research21 systemd[1]: iptest2.service: Deactivated successfully.
May 07 17:57:03 research21 systemd[1]: Stopped iptest2.service - Iptables firewall rules test1.
```

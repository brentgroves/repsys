# SystemD iptables test1

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

## iptest1

```bash
# from 1st terminal
journalctl -u iptest1.service -f 
# or if there were issues starting service
journalctl -f 

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/iptables
mkdir -p /etc/mytests/iptest1/
cp iptest1.sh /etc/mytests/iptest1/
sudo cp iptest1.service /etc/systemd/system/
sudo systemctl start iptest1

# from 1st terminal
journalctl -u iptest1.service -f 
May 07 16:48:51 research21 systemd[1]: Starting iptest1.service - Iptables firewall rules test1...
May 07 16:48:51 research21 iptest1.sh[602027]: Starting the script...
May 07 16:48:51 research21 iptest1.sh[602027]: log level 2
May 07 16:48:51 research21 iptest1.sh[602027]: log level 3
May 07 16:48:51 research21 iptest1.sh[602027]: log level 4
May 07 16:48:51 research21 iptest1.sh[602027]: Ending the script...
May 07 16:48:51 research21 systemd[1]: iptest1.service: Deactivated successfully.
May 07 16:48:51 research21 systemd[1]: Finished iptest1.service - Iptables firewall rules test1.

# check log
cat /etc/mytests/iptest1/log       
Hello, world!

## check it out
systemctl status iptest1.service
○ iptest1.service - Iptables firewall rules test1
     Loaded: loaded (/etc/systemd/system/iptest1.service; disabled; preset: enabled)
     Active: inactive (dead)

May 07 16:44:30 research21 systemd[1]: iptest1.service: Failed with result 'exit-code'.
May 07 16:44:30 research21 systemd[1]: Failed to start iptest1.service - Iptables firewall rules test1.
May 07 16:48:51 research21 systemd[1]: Starting iptest1.service - Iptables firewall rules test1...
May 07 16:48:51 research21 iptest1.sh[602027]: Starting the script...
May 07 16:48:51 research21 iptest1.sh[602027]: log level 2
May 07 16:48:51 research21 iptest1.sh[602027]: log level 3
May 07 16:48:51 research21 iptest1.sh[602027]: log level 4
May 07 16:48:51 research21 iptest1.sh[602027]: Ending the script...
May 07 16:48:51 research21 systemd[1]: iptest1.service: Deactivated successfully.
May 07 16:48:51 research21 systemd[1]: Finished iptest1.service - Iptables firewall rules test1.

# stop service
# sudo systemctl stop iptest1
```

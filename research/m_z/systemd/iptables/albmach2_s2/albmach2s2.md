# SystemD iptables Albion Mach2 Port Forwarding

`PD-ALB-MACH2-S2.linamar.com (10.187.220.52)`

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

## Albion Mach2 port forwarding

## accessible from firewall machine test

```bash
# openssl s_client -showcerts -connect 10.188.220.50:443 -servername reports11 -CApath /etc/ssl/certs -
openssl s_client -showcerts -connect 10.187.220.52:443

```

## deploy service

```bash
# from 1st terminal
journalctl -u albmach2.service -f 
# or if there were issues starting service
journalctl -f 

# from 2nd terminal
pushd .
cd ~/src/repsys/research/m_z/systemd/iptables/albmach2
mkdir -p /etc/myscripts/albmach2/
cp albmach2*.sh /etc/myscripts/albmach2/
ls /etc/myscripts/albmach2/
sudo cp albmach2.service /etc/systemd/system/
# sudo systemctl daemon-reload
sudo systemctl start albmach2


# from 1st terminal
journalctl -u albmach2.service -f 
May 08 15:36:56 research21 systemd[1]: Starting iptest3.service - Iptables firewall rules test3...
May 08 15:36:56 research21 iptest3start.sh[660672]: Starting the start script...
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 1
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 2
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 3
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 4
May 08 15:36:56 research21 iptest3start.sh[660672]: Ending the start script...
May 08 15:36:56 research21 iptest3start.sh[660674]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660676]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660679]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660682]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 systemd[1]: Finished iptest3.service - Iptables firewall rules test3.

# check log
cat /etc/mytests/iptest3/log       

Starting iptest3 service using iptest3start.sh at Thu May  8 03:36:56 PM EDT 2025
Successfully started iptest3 service using iptest3start.sh at Thu May  8 03:36:56 PM EDT 2025

## check it out
systemctl status iptest3.service
iptest3.service - Iptables firewall rules test3
     Loaded: loaded (/etc/systemd/system/iptest3.service; disabled; preset: enabled)
     Active: active (exited) since Thu 2025-05-08 15:36:56 EDT; 1min 12s ago
    Process: 660672 ExecStart=/etc/mytests/iptest3/iptest3start.sh (code=exited, status=0/SUCCESS)
   Main PID: 660672 (code=exited, status=0/SUCCESS)
        CPU: 34ms

May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 1
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 2
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 3
May 08 15:36:56 research21 iptest3start.sh[660672]: start log level 4
May 08 15:36:56 research21 iptest3start.sh[660672]: Ending the start script...
May 08 15:36:56 research21 iptest3start.sh[660674]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660676]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660679]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 iptest3start.sh[660682]: iptables: Bad rule (does a matching rule exist in that chain?).
May 08 15:36:56 research21 systemd[1]: Finished iptest3.service - Iptables firewall rules test3.

# verify rules were added
sudo iptables -S                
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A FORWARD -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j ACCEPT
-A FORWARD -s 10.188.50.202/32 -p tcp -m tcp --sport 8080 -j ACCEPT

sudo iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A PREROUTING -d 10.187.40.123/32 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
-A POSTROUTING -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j SNAT --to-source 10.187.40.123

# stop service
sudo systemctl stop iptest3

# check status
systemctl status iptest3.service

May 08 15:36:56 research21 systemd[1]: Finished iptest3.service - Iptables firewall rules test3.
May 08 15:39:00 research21 systemd[1]: Stopping iptest3.service - Iptables firewall rules test3...
May 08 15:39:00 research21 iptest3stop.sh[661615]: Starting the stop script...
May 08 15:39:00 research21 iptest3stop.sh[661615]: stop log level 1
May 08 15:39:00 research21 iptest3stop.sh[661615]: stop log level 2
May 08 15:39:00 research21 iptest3stop.sh[661615]: stop log level 3
May 08 15:39:00 research21 iptest3stop.sh[661615]: stop log level 4
May 08 15:39:00 research21 iptest3stop.sh[661615]: Ending the stop script...
May 08 15:39:00 research21 systemd[1]: iptest3.service: Deactivated successfully.
May 08 15:39:00 research21 systemd[1]: Stopped iptest3.service - Iptables firewall rules test3.

## look at log file
cat /etc/mytests/iptest3/log       

Starting iptest3 service using iptest3start.sh at Thu May  8 03:36:56 PM EDT 2025
Successfully started iptest3 service using iptest3start.sh at Thu May  8 03:36:56 PM EDT 2025
Stopping iptest3 service using iptest3stop.sh at Thu May  8 03:39:00 PM EDT 2025
Successfully Stopped iptest3 service using iptest3stop.sh at Thu May  8 03:39:00 PM EDT 2025

# verify rules were deleted
sudo iptables -S                
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

sudo iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
```

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

## verify flask app is working

```bash
ssh brent@10.188.50.202
cd ~/src/python/veth_and_namespaces
uv run server.py
uv run server.py
 * Serving Flask app 'server'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8080
 * Running on http://10.188.50.202:8080
Press CTRL+C to quit
10.187.40.123 - - [01/May/2025 19:53:25] "GET / HTTP/1.1" 200 -
10.187.40.123 - - [01/May/2025 20:45:33] "GET / HTTP/1.1" 200 -
```

## request and response flow

1. client requests 10.187.40.123:8080
2. gateway changes destination to 10.188.50.202:8080
It's ok to forward packets to 10.188.50.202:8080
`iptables -A FORWARD -p tcp -d 10.188.50.202 --dport 8080 -j ACCEPT`
Netfilter hook changes the destination of packet.
iptables -t nat -A PREROUTING -p tcp -d 10.187.40.123 --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
3. gateway changes source from client to gateway's ip 10.187.40.123.
`iptables -t nat -A POSTROUTING -p tcp -d 10.188.50.202 --dport 8080 -j SNAT --to-source 10.187.40.123`
Netfilter keeps track of network request's original source IP for reversal of response.
4. Netsocket service host completes request and responds to the natted gateway IP.
5. Netfilter recognizes the response as being from the client machine's request and changes the destination from the gateway's IP to the client's IP.
`iptables -A FORWARD -p tcp -s 10.188.50.202 --sport 8080 -j ACCEPT`
I'm unsure of if netfilter also changes the source IP from the Netsocket service host to the gateway's IP.

From another terminal on the gateway machine start tcpdump

```bash
sudo tcpdump -i enp0s25 'src 10.187.40.18 and dst 10.187.40.123 and dst port 8080'
```

From another machine with access to the gateway machine.

```bash
curl https://10.188.40.123:8080

Hello from Flask!
```

## create service file

Create a new service file in the /etc/systemd/system directory. You can use a text editor such as nano or vi to create the file. The file name should be in the format of "yourscriptname.service"

```bash
pushd .
cd /home/brent/src/repsys/volumes/systemd/iptables
cp myiptables.service /etc/systemd/system/
ls -alh /etc/systemd/system/myiptables.service

# this one is a symbolic link
ls -alh /etc/systemd/system/display-manager.service
lrwxrwxrwx 1 root root 32 Feb 15 03:14 /etc/systemd/system/display-manager.service -> /lib/systemd/system/gdm3.service
```

Reload the systemd manager configuration by running the following command `sudo systemctl daemon-reload`

Enable the service by running the following command `sudo systemctl enable myiptables.service`

Start the service by running the following command

```bash
iptables -S
iptables -t nat -S

/etc/myiptables/delete_rules.sh
iptables -S
iptables -t nat -S
sudo systemctl start myiptables.service

iptables -S
iptables -t nat -S

```

Restart your system to test that the script is being run on startup

## **[run startup script](https://www.tutorialspoint.com/run-a-script-on-startup-in-linux#:~:text=Make%20the%20script%20file%20executable,scriptname%20defaults%22%20in%20the%20terminal.)**

```bash

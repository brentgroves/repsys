#!/usr/bin/env bash
# cd ~/src/repsys/research/m_z/systemd/iptables/
# -S, --split-string=S process and split S into separate arguments; used to pass multiple arguments on shebang lines

# The bash variable $EUID shows the effective UID the script is running at, if you want to make sure the script runs as root, check wether $EUID contains the value 0 or not:
# $EUID not available from systemd unit script.
# if [[ $EUID -ne 0 ]]; then
#     echo "$0 is not running as root. Try using sudo."
#     exit 2
# fi


# https://unix.stackexchange.com/questions/13724/file-descriptors-shell-scripting
# exec 5>/tmp/foo       # open /tmp/foo for writing, on fd 5
# exec 6</tmp/bar       # open /tmp/bar for reading, on fd 6
# cat <&6 |             # call cat, with its standard input connected to
#                       # what is currently fd 6, i.e., /tmp/bar
# https://copyconstruct.medium.com/bash-redirection-fun-with-descriptors-e799ec5a3c16
exec 2>&1 4>stoplog 

printf "Goodbye, world!\n" >&4
# The logging levels are defined in sd-daemon(3):

#define SD_EMERG   "<0>"  /* system is unusable */
#define SD_ALERT   "<1>"  /* action must be taken immediately */
#define SD_CRIT    "<2>"  /* critical conditions */
#define SD_ERR     "<3>"  /* error conditions */
#define SD_WARNING "<4>"  /* warning conditions */
#define SD_NOTICE  "<5>"  /* normal but significant condition */
#define SD_INFO    "<6>"  /* informational */
#define SD_DEBUG   "<7>"  /* debug-level messages */

printf "<5>Starting the stop script...\n"
printf "<1>stop log level 1\n"
printf "<2>stop log level 2\n"
printf "<3>stop log level 3\n"
printf "<4>stop log level 4\n"
printf "<5>Ending the stop script...\n"

# nat: This table is consulted when a packet that creates a new connection is encountered. 
# It consists of three built-ins: PREROUTING (for altering packets as soon as they come in), 
# OUTPUT (for altering locally-generated packets before routing), and POSTROUTING (for altering 
# packets as they are about to go out).

# Parameter Description
# -p, --protocol The protocol, such as TCP, UDP, etc.
# -s, --source Can be an address, network name, hostname, etc.
# -d, --destination An address, hostname, network name, etc.
# -j, --jump Specifies the target of the rule; i.e. what to do if the packet matches.
# -m is for matching module name and not string. By using a particular module you get 
# certain options to match. See the cpu module example above. With the -m tcp the module tcp is loaded. The tcp module allows certain options: --dport, --sport, --tcp-flags, --syn, --tcp-option to use in iptables rules

# iptables -t nat -S
# allow inbound and outbound forwarding
iptables -D FORWARD -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j ACCEPT
# iptables -A FORWARD -p tcp -d 10.188.50.202 --dport 8080 -j ACCEPT

iptables -D FORWARD -s 10.188.50.202/32 -p tcp -m tcp --sport 8080 -j ACCEPT
# iptables -A FORWARD -p tcp -s 10.188.50.202 --sport 8080 -j ACCEPT

# iptables -t nat -S
# route packets arriving at external IP/port to LAN machine
iptables -t nat -D PREROUTING -d 10.187.40.123/32 -p tcp -m tcp --dport 8080 -j DNAT --to-destination 10.188.50.202:8080
# iptables -t nat -A PREROUTING  -p tcp -d 10.187.40.123 --dport 8080 -j DNAT --to-destination 10.188.50.202:8080

# rewrite packets going to LAN machine (identified by address/port)
# to originate from gateway's internal address
iptables -t nat -D POSTROUTING -d 10.188.50.202/32 -p tcp -m tcp --dport 8080 -j SNAT --to-source 10.187.40.123
# iptables -t nat -A POSTROUTING -p tcp -d 10.188.50.202 --dport 8080 -j SNAT --to-source 10.187.40.123

# # Close FD
exec 4>&- 

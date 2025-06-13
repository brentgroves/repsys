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
exec 2>&1 4>>log

# In shell-scripting, backticks are deprecated. They have been for a while. They're not deprecated in the sense that they're going to be removed any time soon. They're deprecated in the sense that the newer syntax has advantages over the old back-tick syntax and that the newer syntax should be preferred. Back-ticks are only really kept in bash for backwards compatibility with older, pre-existing scripts. But the current POSIX standard strongly recommends using the newer $() substitution syntax.
# https://www.linux.org/threads/backtick-usage.47910/
# The main advantage of using the newer syntax is that it's much easier to create nested substitutions.
# e.g.
# Bash:
# someVar=$(/path/to/script -infile "$(ls -1tr 202312[0-9][0-9]*.txt | tail -n 1)" -print0)

now=$(date)
printf "Starting moto service using motostart.sh at %s\n" "$now" >&4

# The logging levels are defined in sd-daemon(3):

#define SD_EMERG   "<0>"  /* system is unusable */
#define SD_ALERT   "<1>"  /* action must be taken immediately */
#define SD_CRIT    "<2>"  /* critical conditions */
#define SD_ERR     "<3>"  /* error conditions */
#define SD_WARNING "<4>"  /* warning conditions */
#define SD_NOTICE  "<5>"  /* normal but significant condition */
#define SD_INFO    "<6>"  /* informational */
#define SD_DEBUG   "<7>"  /* debug-level messages */

# ... more commands ...

printf "<5>Starting the start script...\n"
printf "<1>start log level 1\n"
printf "<2>start log level 2\n"
printf "<3>start log level 3\n"
printf "<4>start log level 4\n"
printf "<5>Ending the start script...\n"

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

# accept everything
iptables -D FORWARD -j ACCEPT
iptables -A FORWARD -j ACCEPT
# iptables -S
# -P INPUT ACCEPT
# -P FORWARD ACCEPT
# -P OUTPUT ACCEPT

# allow NAT over all traffic
iptables -t nat -D POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE
# iptables -t nat -S
# -P PREROUTING ACCEPT
# -P INPUT ACCEPT
# -P OUTPUT ACCEPT
# -P POSTROUTING ACCEPT
# -A POSTROUTING -j MASQUERADE

now=$(date)
printf "Successfully started moto service using motostart.sh at %s\n" "$now" >&4

# # Close FD
exec 4>&-

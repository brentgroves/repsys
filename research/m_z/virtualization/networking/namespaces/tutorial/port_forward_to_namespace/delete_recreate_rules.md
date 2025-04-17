# Delete and recreate rules

## all forwarding rules

```bash
# https://askubuntu.com/questions/966066/port-forwarding-in-network-namespace

# iptables -A FORWARD -p tcp -d 10.1.8.1 --dport 1008 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT 
# iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 1008 -j DNAT --to-destination 10.1.8.1:1008

iptables -A FORWARD -p tcp -d 192.168.0.2 --dport 8080 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT 
iptables -L FORWARD --line-numbers

iptables -t nat -A PREROUTING -p tcp -i wlp114s0f0 --dport 8080 -j DNAT --to-destination 192.168.0.2:8080
iptables -t nat -L PREROUTING --line-numbers

I was able to do it with iptables.

# iptables -t nat -A PREROUTING -i wlp114s0f0 -p tcp --dport 6000 -j DNAT --to 192.168.0.2:8080

# iptables -t nat -A PREROUTING -i wlp114s0f0 -p tcp --dport 6000 -j DNAT --to 192.168.0.2:8080
# http://172.25.188.34:6000/
```

```bash
iptables -A FORWARD -i wlp114s0f0 -o veth0 -j ACCEPT
iptables -A FORWARD -o wlp114s0f0 -i veth0 -j ACCEPT
iptables -A FORWARD -p tcp -d 192.168.0.2 --dport 8080 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -L FORWARD --line-numbers
iptables -D FORWARD 6
iptables -D FORWARD 6
iptables -D FORWARD 6

# Adding Forwarding Rules to the Basic Firewall
iptables -A FORWARD -i wlp114s0f0 -o veth0 -p tcp --syn --dport 6000 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -i wlp114s0f0 -o veth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sudo iptables -A FORWARD -i veth0 -o wlp114s0f0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


```

## all nat rules

```bash
iptables -t nat -L PREROUTING --line-numbers
iptables -t nat -D PREROUTING 1
```

## Add the DNAT Rule

Use the DNAT option in iptables to modify the destination IP and port.

Example: iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 8080 -j DNAT --to-destination 10.0.0.1:80
-t nat: Specifies the NAT (Network Address Translation) table.
-A PREROUTING: Adds the rule to the PREROUTING chain, which is evaluated before the packet is routed.
-i eth0: Specifies the incoming network interface (e.g., eth0).
-p tcp: Specifies the protocol as TCP.
--dport 8080: Specifies the destination port to forward (e.g., 8080).
-j DNAT: Specifies the action as Destination NAT.
--to-destination 10.0.0.1:80: Specifies the new destination IP address and port (e.g., 10.0.0.1:80).

```bash
iptables -t nat -L PREROUTING --line-numbers

# iptables -t nat -A PREROUTING -i wlp114s0f0 -p tcp --dport 6000 -j DNAT --to-destination 192.168.0.2:8080
# or
iptables -t nat -A PREROUTING -i wlp114s0f0 -p tcp --dport 6000 -j DNAT --to 192.168.0.2:8080

```

## To configure proper routing, you also need to modify the packet’s source address as it leaves the firewall en route to the web server

<https://unix.stackexchange.com/questions/76300/iptables-port-to-another-ip-port-from-the-inside>

```bash

iptables -t nat -L POSTROUTING --line-numbers
iptables -t nat -D POSTROUTING 1

# iptables -t nat -A POSTROUTING -o veth0 -p tcp --dport 8080 -d 172.25.188.34 -j SNAT --to-source 192.168.0.2
# or
iptables -t nat -A POSTROUTING -p tcp -d 192.168.0.2 --dport 8080 -j MASQUERADE
iptables -t nat -L POSTROUTING --line-numbers
```

```bash
sudo su

# for wireless
iptables -t nat -A POSTROUTING -s 192.168.0.0/255.255.255.0 -o wlp114s0f0 -j MASQUERADE
iptables -t nat -L POSTROUTING --line-numbers
# Warning: iptables-legacy tables present, use iptables-legacy to see them
Chain POSTROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    LIBVIRT_PRT  all  --  anywhere             anywhere            
2    MASQUERADE  all  --  192.168.0.0/24       anywhere            
3    MASQUERADE  all  --  192.168.0.0/24       anywhere    

sudo iptables -D POSTROUTING 2
sudo iptables -t nat -S

# for wireless
iptables -A FORWARD -i wlp114s0f0 -o veth0 -j ACCEPT
iptables -L FORWARD --line-numbers
# Warning: iptables-legacy tables present, use iptables-legacy to see them
Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination         
1    LIBVIRT_FWX  all  --  anywhere             anywhere            
2    LIBVIRT_FWI  all  --  anywhere             anywhere            
3    LIBVIRT_FWO  all  --  anywhere             anywhere            
4    ACCEPT     all  --  10.1.0.0/16          anywhere             /* generated for MicroK8s pods */
5    ACCEPT     all  --  anywhere             10.1.0.0/16          /* generated for MicroK8s pods */
6    ACCEPT     all  --  anywhere             anywhere            
7    ACCEPT     all  --  anywhere             anywhere            
8    ACCEPT     tcp  --  anywhere             192.168.0.2          tcp dpt:http-alt state NEW,RELATED,ESTABLISHED
9    ACCEPT     tcp  --  anywhere             192.168.0.2          tcp dpt:http-alt state NEW,RELATED,ESTABLISHED

sudo iptables -D FORWARD 8
sudo iptables -S

sudo iptables -t nat -S
# for wireless
iptables -t nat -A PREROUTING -p tcp -i wlp114s0f0 --dport 6000 -j DNAT --to-destination 192.168.0.2:8080
iptables -t nat -L PREROUTING --line-numbers
# Warning: iptables-legacy tables present, use iptables-legacy to see them
Chain PREROUTING (policy ACCEPT)
num  target     prot opt source               destination         
1    DNAT       tcp  --  anywhere             anywhere             tcp dpt:x11 to:192.168.0.2:8080

sudo iptables -D PREROUTING 8

iptables -t nat -S

iptables -A FORWARD -p tcp -d 192.168.0.2 --dport 8080 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -L FORWARD --line-numbers

iptables -S

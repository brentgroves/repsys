# **[Nmap tutorial](https://nmap.org/docs.html)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Tasks](../../../a_status/current_tasks.md)**\
**[Back to Main](../../../README.md)**

## install

```bash
sudo snap install nmap
```

## quick scan

If we want to run a quick scan of machines in our network without trying to see if any port is open, we run:

```bash
sudo nmap -sn 10.187.220.0/24
Starting Nmap 7.95 ( https://nmap.org ) at 2025-05-08 17:48 EDT
Couldn't open a raw socket. Error: Permission denied (13)

nmap -sn 10.187.220.0/24
Starting Nmap 7.95 ( https://nmap.org ) at 2025-05-08 17:49 EDT
Nmap scan report for PD-ALB-MACH2-S1.linamar.com (10.187.220.51)
Host is up (0.0045s latency).
Nmap scan report for PD-ALB-MACH2-S2.linamar.com (10.187.220.52)
Host is up (0.0042s latency).
Nmap done: 256 IP addresses (2 hosts up) scanned in 44.86 seconds
```

## full scan

Let's assume your local network is 192.168.0.0/24, and you want to run a scan on this network. Running a scan without any argument except the network address yields the following:

```bash
nmap 192.168.0.0/24
Starting Nmap 7.80 ( https://nmap.org ) at 2020-03-06 21:00 CET
Nmap scan report for Archer.lan (192.168.0.1)
Host is up (0.0046s latency).
Not shown: 995 closed ports
PORT      STATE SERVICE
22/tcp    open  ssh
53/tcp    open  domain
80/tcp    open  http
1900/tcp  open  upnp
20005/tcp open  btx
MAC Address: 50:ff:BF:ff:ff:AC (Tp-link Technologies)

Nmap scan report for Lyric-1111C2.lan (192.168.0.101)
Host is up (0.013s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE0
80/tcp open  http
MAC Address: B8:dd:A0:dd:dd:C2 (Resideo)
Multiple networks can be scanned at once. For example
nmap 192.168.0.0/24 10.80.0.0/24
```

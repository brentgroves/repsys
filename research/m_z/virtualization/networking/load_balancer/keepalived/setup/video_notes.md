# **[Meet keepalived - High Availability and Load Balancing in One](https://technotim.live/posts/keepalived-ha-loadbalancer/)**

In my quest to make my services highly available I decided to use keepalived.keepalived is a framework for both load balancing and high availability that implements VRRP.This is a protocol that you see on some routers and has been implemented in keepalived. It creates a Virtual IP (or VIP, or floating IP) that acts as a gateway to route traffic to all participating hosts.This VIP that can provide a high availability setup and fail over to another host in the event that one is down. In this video, we’ll set up and configure keepalived, we’ll test our configuration to make sure it’s working, and we’ll also talk about some advanced use cases like load balancing.

## Installation

```bash
sudo apt update
sudo apt install keepalived
sudo apt install libipset13
```

ipset
Build Status

The ipset library provides C data types for storing sets of IP addresses, and maps of IP addresses to integers. It supports both IPv4 and IPv6 addresses. It's implemented using Binary Decision Diagrams (BDDs), which (we hypothesize) makes it space efficient for large sets.

## Configuration

Find your IP

`ip a`

edit your config

```bash
sudo vi /etc/keepalived/keepalived.conf
vrrp_instance VI_1 {
  state MASTER
  interface ens18
  virtual_router_id 55
  priority 150
  advert_int 1
  unicast_src_ip 192.168.30.31
  unicast_peer {
    192.168.30.32
  }

  authentication {
    auth_type PASS
    auth_pass C3P9K9gc
  }

  virtual_ipaddress {
    192.168.30.100/24
  }
}
```

## Start and enable the service

```bash
sudo systemctl enable --now keepalived.service
Synchronizing state of keepalived.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable keepalived
```

## stopping the service

```bash
sudo systemctl stop keepalived.service
```

## get the status

```bash
ssh brent@micro11
sudo systemctl status keepalived.service
● keepalived.service - Keepalive Daemon (LVS and VRRP)
     Loaded: loaded (/usr/lib/systemd/system/keepalived.service; enabled; preset: enabled)
     Active: active (running) since Thu 2025-08-14 21:05:37 UTC; 1min 37s ago
       Docs: man:keepalived(8)
             man:keepalived.conf(5)
             man:genhash(1)
             https://keepalived.org
   Main PID: 306382 (keepalived)
      Tasks: 2 (limit: 154503)
     Memory: 1.8M (peak: 2.1M)
        CPU: 23ms
     CGroup: /system.slice/keepalived.service
             ├─306382 /usr/sbin/keepalived --dont-fork
ssh brent@micro12
sudo systemctl status keepalived.service
● keepalived.service - Keepalive Daemon (LVS and VRRP)
     Loaded: loaded (/usr/lib/systemd/system/keepalived.service; enabled; preset: enabled)
     Active: active (running) since Thu 2025-08-14 21:07:48 UTC; 16s ago
       Docs: man:keepalived(8)
             man:keepalived.conf(5)
             man:genhash(1)
             https://keepalived.org
   Main PID: 266444 (keepalived)
      Tasks: 2 (limit: 154503)
     Memory: 1.8M (peak: 2.0M)
        CPU: 19ms
     CGroup: /system.slice/keepalived.service
             ├─266444 /usr/sbin/keepalived --dont-fork
             └─266447 /usr/sbin/keepalived --dont-fork

Aug 14 21:07:48 micro12 systemd[1]: Starting keepalived.service - Keepalive Daemon (LVS and VRRP)...
Aug 14 21:07:48 micro12 Keepalived[266444]: Starting Keepalived v2.2.8 (04/04,2023), git commit v2.2.7-154-g292b299e+
Aug 14 21:07:48 micro12 Keepalived[266444]: Running on Linux 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 (built for Linux 6.8.0)
Aug 14 21:07:48 micro12 Keepalived[266444]: Command line: '/usr/sbin/keepalived' '--dont-fork'
Aug 14 21:07:48 micro12 Keepalived[266444]: Configuration file /etc/keepalived/keepalived.conf
Aug 14 21:07:48 micro12 Keepalived[266444]: NOTICE: setting config option max_auto_priority should result in better keepalived performance
Aug 14 21:07:48 micro12 Keepalived[266444]: Starting VRRP child process, pid=266447
Aug 14 21:07:48 micro12 Keepalived[266444]: Startup complete
Aug 14 21:07:48 micro12 Keepalived_vrrp[266447]: (VI_1) Entering BACKUP STATE (init)
Aug 14 21:07:48 micro12 systemd[1]: Started keepalived.service - Keepalive Daemon (LVS and VRRP).

```

## check logs

```bash
ssh brent@micro11
journalctl -xeu keepalived.service
Aug 14 21:05:37 micro11 Keepalived[306382]: NOTICE: setting config option max_auto_priority should result in better keepalived performance
Aug 14 21:05:37 micro11 Keepalived[306382]: Starting VRRP child process, pid=306383
Aug 14 21:05:37 micro11 Keepalived[306382]: Startup complete
Aug 14 21:05:37 micro11 Keepalived_vrrp[306383]: (VI_1) Entering BACKUP STATE (init)
Aug 14 21:05:37 micro11 systemd[1]: Started keepalived.service - Keepalive Daemon (LVS and VRRP).
░░ Subject: A start job for unit keepalived.service has finished successfully
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░ 
░░ A start job for unit keepalived.service has finished successfully.
░░ 
░░ The job identifier is 677390.
Aug 14 21:05:40 micro11 Keepalived_vrrp[306383]: (VI_1) Entering MASTER STATE

ssh brent@micro12
journalctl -xeu keepalived.service
Aug 14 21:07:48 micro12 systemd[1]: Starting keepalived.service - Keepalive Daemon (LVS and VRRP)...
░░ Subject: A start job for unit keepalived.service has begun execution
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░ 
░░ A start job for unit keepalived.service has begun execution.
░░ 
░░ The job identifier is 670299.
Aug 14 21:07:48 micro12 Keepalived[266444]: Starting Keepalived v2.2.8 (04/04,2023), git commit v2.2.7-154-g292b299e+
Aug 14 21:07:48 micro12 Keepalived[266444]: Running on Linux 6.8.0-63-generic #66-Ubuntu SMP PREEMPT_DYNAMIC Fri Jun 13 20:25:30 UTC 2025 (built for Linux 6.8.0)
Aug 14 21:07:48 micro12 Keepalived[266444]: Command line: '/usr/sbin/keepalived' '--dont-fork'
Aug 14 21:07:48 micro12 Keepalived[266444]: Configuration file /etc/keepalived/keepalived.conf
Aug 14 21:07:48 micro12 Keepalived[266444]: NOTICE: setting config option max_auto_priority should result in better keepalived performance
Aug 14 21:07:48 micro12 Keepalived[266444]: Starting VRRP child process, pid=266447
Aug 14 21:07:48 micro12 Keepalived[266444]: Startup complete
Aug 14 21:07:48 micro12 Keepalived_vrrp[266447]: (VI_1) Entering BACKUP STATE (init)
Aug 14 21:07:48 micro12 systemd[1]: Started keepalived.service - Keepalive Daemon (LVS and VRRP).
░░ Subject: A start job for unit keepalived.service has finished successfully
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░ 
░░ A start job for unit keepalived.service has finished successfully.
░░ 
░░ The job identifier is 670299.

```

## test

```bash
ping 10.188.50.200
root@node01:~# ip address show eno150
14: eno150@eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b8:ca:3a:6a:35:98 brd ff:ff:ff:ff:ff:ff
    inet 10.188.50.201/24 brd 10.188.50.255 scope global eno150
       valid_lft forever preferred_lft forever
    inet 10.188.50.200/24 scope global secondary eno150
       valid_lft forever preferred_lft forever
    inet6 fe80::baca:3aff:fe6a:3598/64 scope link 
       valid_lft forever preferred_lft forever

# set link down on primary node
root@node01:~# ip link set down eno150

# on backup node
root@node02:~# ip address show eno150
13: eno150@eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b8:ca:3a:6a:38:7c brd ff:ff:ff:ff:ff:ff
    inet 10.188.50.202/24 brd 10.188.50.255 scope global eno150
       valid_lft forever preferred_lft forever
    inet6 fe80::baca:3aff:fe6a:387c/64 scope link 
       valid_lft forever preferred_lft forever

# virtual IP address is assigned

# set link up on primary node

ip link set down eno150
root@node01:~# ip link set up eno150
root@node01:~# ip address show eno150
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:35:69:7c brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.51/24 brd 10.0.0.255 scope global enp1s0
       valid_lft forever preferred_lft forever
    inet 10.0.0.30/24 scope global secondary enp1s0
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fe35:697c/64 scope link
       valid_lft forever preferred_lft forever

# failback automatically
```

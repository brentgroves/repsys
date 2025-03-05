# **[Setup Multipass VM](https://canonical.com/multipass/docs/configure-static-ips)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[Create an instance with multiple network interfaces](https://multipass.run/docs/create-an-instance#heading--create-an-instance-with-multiple-network-interfaces)**
- **[create bridges with netplan](./create_bridges_with_netplan.md)**

## Note

This process assumes you are using Ubuntu 24.04 server or OS that is using networkd or an OS which is setup with NetworkMangager but is completely integrated with Netplan 1.0 such as I think Ubuntu 24.04 desktop.

## Step 1: **[Goto create bridges with netplan](./create_bridges_with_netplan.md)**

## Step 2: **[Install Multipass](./multipass_install.md)**

You can also run multipass networks to confirm the bridge is available for Multipass to connect to.

```bash
multipass networks
Name        Type       Description
br0         bridge     Network bridge with eno1
eno1        ethernet   Ethernet device
eno2        ethernet   Ethernet device
eno3        ethernet   Ethernet device
eno4        ethernet   Ethernet device
enp66s0f0   ethernet   Ethernet device
enp66s0f1   ethernet   Ethernet device
enp66s0f2   ethernet   Ethernet device
enp66s0f3   ethernet   Ethernet device
mpqemubr0   bridge     Network bridge

```

## Create an instance with a specific image

To find out what images are available, run:

```bash
multipass find
Image                       Aliases           Version          Description
core                        core16            20200818         Ubuntu Core 16
core18                                        20211124         Ubuntu Core 18
core20                                        20230119         Ubuntu Core 20
core22                                        20230717         Ubuntu Core 22
20.04                       focal             20240612         Ubuntu 20.04 LTS
22.04                       jammy             20240626         Ubuntu 22.04 LTS
23.10                       mantic            20240619         Ubuntu 23.10
24.04                       noble,lts         20240622         Ubuntu 24.04 LTS
```

## Decide how much ram and vcpu to use

```bash
lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          46 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   32
  On-line CPU(s) list:    0-31
Vendor ID:                GenuineIntel
  Model name:             Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
    CPU family:           6
    Model:                45
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            2
    Stepping:             7
    CPU(s) scaling MHz:   45%
    CPU max MHz:          2800.0000
    CPU min MHz:          1200.0000
    BogoMIPS:             4000.10
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon peb
                          s bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadl
                          ine_timer aes xsave avx lahf_lm pti ssbd ibrs ibpb stibp tpr_shadow flexpriority ept vpid xsaveopt dtherm ida arat pln pts vnmi md_clear flush_l1d
Virtualization features:  
  Virtualization:         VT-x
Caches (sum of all):      
  L1d:                    512 KiB (16 instances)
  L1i:                    512 KiB (16 instances)
  L2:                     4 MiB (16 instances)
  L3:                     40 MiB (2 instances)
NUMA:                     
  NUMA node(s):           2
  NUMA node0 CPU(s):      0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30
  NUMA node1 CPU(s):      1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31
Vulnerabilities:          
  Gather data sampling:   Not affected
  Itlb multihit:          KVM: Mitigation: Split huge pages
  L1tf:                   Mitigation; PTE Inversion; VMX conditional cache flushes, SMT vulnerable
  Mds:                    Mitigation; Clear CPU buffers; SMT vulnerable
  Meltdown:               Mitigation; PTI
  Mmio stale data:        Unknown: No mitigations
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:             Mitigation; Retpolines; IBPB conditional; IBRS_FW; STIBP conditional; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected
```

## **[remove an instance](./remove_instance.md)**

## Launch VM with extra network interface

The full multipass help launch output explains the available options:

```bash
$  multipass help launch
Usage: multipass launch [options] [[<remote:>]<image> | <url>]
```

## **[Notes launch command](https://multipass.run/docs/launch-command)**

```bash
--network <spec>                      Add a network interface to the
                                        instance, where <spec> is in the
                                        "key=value,key=value" format, with the
                                        following keys available:
                                         name: the network to connect to
                                        (required), use the networks command for
                                        a list of possible values, or use
                                        'bridged' to use the interface
                                        configured via `multipass set
                                        local.bridged-network`.
                                         mode: auto|manual (default: auto)
                                         mac: hardware address (default:
                                        random).
                                        You can also use a shortcut of "<name>"
                                        to mean "name=<name>".
```

### Step 2: Launch an instance

<!-- You can also leave the MAC address unspecified (just --network name=localbr,mode=manual). If you do so, Multipass will generate a random MAC for you, but you will need to retrieve it in the next step. -->

```bash

multipass launch --network br0 --name k8sn2 --cpus 2 --memory 32G --disk 250G 

# errors need to add another config request

[2025-03-05T20:29:05.138] [error] [url downloader] Failed to get https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main: Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main
[2025-03-05T20:29:05.139] [error] [blueprint provider] Error fetching Blueprints: failed to download from 'https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main': Error opening https://codeload.github.com/canonical/multipass-blueprints/zip/refs/heads/main

multipass info k8sn1
Name:           k8sn1
State:          Running
Snapshots:      0
IPv4:           10.130.245.199
Release:        Ubuntu 24.04.2 LTS
Image hash:     a3aea891c930 (Ubuntu 24.04 LTS)
CPU(s):         2
Load:           0.03 0.16 0.09
Disk usage:     1.8GiB out of 242.1GiB
Memory usage:   586.7MiB out of 31.3GiB
Mounts:         --
```

Use the ip utility to display the link status of devices in br0:

```bash
ip link show master br0
5: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether b8:ca:3a:6a:38:7c brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
14: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master br0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether fe:21:f6:5e:ec:63 brd ff:ff:ff:ff:ff:ff
```

Verify access to host routes

```bash
ssh brent@10.188.50.202
multipass shell k8sn2
ip route
default via 10.97.219.1 dev ens3 proto dhcp src 10.97.219.230 metric 100 
10.97.219.0/24 dev ens3 proto kernel scope link src 10.97.219.230 metric 100 
10.97.219.1 dev ens3 proto dhcp scope link src 10.97.219.230 metric 100 

# verify access to every network the host has access to
ping 10.188.50.79
# works

ping 10.188.220.50
# works

ping 10.188.73.11
# works

ping 10.188.40.230
# works

ping 172.20.88.64
# works

# FW rules
curl https://api.snapcraft.io
snapcraft.io store API service - Copyright 2018-2022 Canonical.

exit
```

## Step 3: Configure the extra interface

## retrieve the hardware address

See how multipass configured the network. Until I can figure out how to pass the hardware address manaully during launch we will have to grab the one multipass or lxd creates.

```bash

multipass exec -n k8sn2 -- sudo cat /etc/netplan/50-cloud-init.yaml
network:
  version: 2
  ethernets:
    default:
      match:
        macaddress: "52:54:00:3c:6d:95"
      dhcp-identifier: "mac"
      dhcp4: true
    extra0:
      match:
        macaddress: "52:54:00:27:91:55"
      optional: true
      dhcp-identifier: "mac"
      dhcp4: true
      dhcp4-overrides:
        route-metric: 200
```

### update netplan with hardware address

```bash

# Make sure the mac address remains the same

multipass exec -n k8sn2 -- sudo bash -c 'cat << EOF > /etc/netplan/50-cloud-init.yaml
network:
  version: 2
  ethernets:
    default:
      match:
        macaddress: "52:54:00:3c:6d:95"
      dhcp-identifier: "mac"
      dhcp4: true
    extra0:
      addresses:
      - 10.188.50.213/24
      nameservers:
         addresses:
         - 10.225.50.203
         - 10.224.50.203
      routes:
      - to: default
        via: 10.188.50.254
      match:
        macaddress: "52:54:00:27:91:55"
      optional: true
EOF'

# verify yaml

multipass exec -n k8sn2 -- sudo cat /etc/netplan/50-cloud-init.yaml

network:
  version: 2
  ethernets:
    default:
      match:
        macaddress: "52:54:00:3c:6d:95"
      dhcp-identifier: "mac"
      dhcp4: true
    extra0:
      addresses:
      - 10.188.50.213/24
      nameservers:
         addresses:
         - 10.225.50.203
         - 10.224.50.203
      routes:
      - to: default
        via: 10.188.50.254
      match:
        macaddress: "52:54:00:27:91:55"
      optional: true
```

if all looks good apply network changes

```bash
multipass exec -n k8sn2 -- sudo netplan apply
```

## Step 5: Confirm that it works

You can confirm that the new IP is present in the instance with Multipass:

```bash

multipass info k8sn2
Name:           k8sn2
State:          Running
Snapshots:      0
IPv4:           10.97.219.230
                10.188.50.213
Release:        Ubuntu 24.04.2 LTS
Image hash:     a3aea891c930 (Ubuntu 24.04 LTS)
CPU(s):         2
Load:           0.00 0.00 0.00
Disk usage:     1.9GiB out of 242.1GiB
Memory usage:   583.0MiB out of 31.3GiB
Mounts:         --
```

The command above should show two IPs, the second of which is the one we just configured (10.188.50.213). You can use ping to confirm that it can be reached from the host:

```bash
# from netwwork machine
ping 10.188.50.213
# works

```

Confirm VM can ping lan and wan

```bash
multipass exec -n microk8s-vm -- ping -c 1 -n 10.1.0.113
PING 10.1.0.113 (10.1.0.113) 56(84) bytes of data.
64 bytes from 10.1.0.113: icmp_seq=1 ttl=64 time=0.560 ms

--- 10.1.0.113 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.560/0.560/0.560/0.000 ms

multipass exec -n microk8s-vm -- ping -c 1 -n google.com
PING google.com (142.250.191.238) 56(84) bytes of data.
64 bytes from 142.250.191.238: icmp_seq=1 ttl=57 time=9.04 ms

--- google.com ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 9.039/9.039/9.039/0.000 ms

```

## Verify routing tables

**[references iproute2 intro for ip commands](../networking/iproute2/introduction_to_iproute.md)**

```bash
ip route list table local
local 10.1.0.125 dev eno1 proto kernel scope host src 10.1.0.125 
local 10.1.0.126 dev br0 proto kernel scope host src 10.1.0.126 
broadcast 10.1.3.255 dev br0 proto kernel scope link src 10.1.0.126 
broadcast 10.1.3.255 dev eno1 proto kernel scope link src 10.1.0.125 
local 10.13.31.1 dev br1 proto kernel scope host src 10.13.31.1 
broadcast 10.13.31.255 dev br1 proto kernel scope link src 10.13.31.1 
local 10.127.233.1 dev mpbr0 proto kernel scope host src 10.127.233.1 
broadcast 10.127.233.255 dev mpbr0 proto kernel scope link src 10.127.233.1 
local 127.0.0.0/8 dev lo proto kernel scope host src 127.0.0.1 
local 127.0.0.1 dev lo proto kernel scope host src 127.0.0.1 
broadcast 127.255.255.255 dev lo proto kernel scope link src 127.0.0.1 

# there should be only 1 default route
ip route list table main
default via 10.1.1.205 dev eno1 proto static 
10.1.0.0/22 dev br0 proto kernel scope link src 10.1.0.126 
10.1.0.0/22 dev eno1 proto kernel scope link src 10.1.0.125 
10.13.31.0/24 dev br1 proto kernel scope link src 10.13.31.1 
10.127.233.0/24 dev mpbr0 proto kernel scope link src 10.127.233.1

# ip shows us our routes
ip route show
default via 10.1.1.205 dev eno1 proto static 
10.1.0.0/22 dev br0 proto kernel scope link src 10.1.0.126 
10.1.0.0/22 dev eno1 proto kernel scope link src 10.1.0.125 
10.13.31.0/24 dev br1 proto kernel scope link src 10.13.31.1 
10.127.233.0/24 dev mpbr0 proto kernel scope link src 10.127.233.1 

# You can view your machines current arp/neighbor cache/table like so:
ip neigh show
10.1.0.162 dev eno2 lladdr 4c:91:7a:64:0f:7d STALE
10.1.0.166 dev eno1 lladdr 4c:91:7a:63:c0:3a STALE
10.1.1.205 dev eno1 lladdr 34:56:fe:77:58:bc STALE

# view devices linked to bridge
ip link show master br0
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether b8:ca:3a:6a:37:19 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
14: tap34dcb760: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether 5a:8a:38:e5:66:f1 brd ff:ff:ff:ff:ff:ff
18: tap38ceeb39: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether ce:80:f5:53:04:fb brd ff:ff:ff:ff:ff:ff

ip link show master mpbr0
13: tape518c5a7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master mpbr0 state UP mode DEFAULT group default qlen 1000
    link/ether e6:53:77:50:74:f1 brd ff:ff:ff:ff:ff:ff

# show vm routing table
multipass exec -n microk8s-vm -- ip route list table local
local 10.1.0.129 dev enp6s0 proto kernel scope host src 10.1.0.129 
broadcast 10.1.3.255 dev enp6s0 proto kernel scope link src 10.1.0.129 
local 10.127.233.194 dev enp5s0 proto kernel scope host src 10.127.233.194 
broadcast 10.127.233.255 dev enp5s0 proto kernel scope link src 10.127.233.194 
local 127.0.0.0/8 dev lo proto kernel scope host src 127.0.0.1 
local 127.0.0.1 dev lo proto kernel scope host src 127.0.0.1 
broadcast 127.255.255.255 dev lo proto kernel scope link src 127.0.0.1 

multipass exec -n microk8s-vm -- ip route list table main
default via 10.127.233.1 dev enp5s0 proto dhcp src 10.127.233.194 metric 100 
10.1.0.0/22 dev enp6s0 proto kernel scope link src 10.1.0.129 
10.127.233.0/24 dev enp5s0 proto kernel scope link src 10.127.233.194 metric 100 
10.127.233.1 dev enp5s0 proto dhcp scope link src 10.127.233.194 metric 100
```

## **[multipass ubuntu password set](https://askubuntu.com/questions/1230753/login-and-password-for-multipass-instance)**

In multipass instance, set a password to ubuntu user. Needed to ftp from dev system. Multipass has transfer command but only works from the host.

```bash
sudo passwd ubuntu
```

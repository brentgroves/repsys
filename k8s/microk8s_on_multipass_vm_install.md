# **[Installing MicroK8s with multipass](https://microk8s.io/docs/install-multipass)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[How to Bridge Two Network Interfaces in Linux Using Netplan](https://www.tecmint.com/netplan-bridge-network-interfaces/)**
- **[bridge commands](https://developers.redhat.com/articles/2022/04/06/introduction-linux-bridging-commands-and-features#spanning_tree_protocol)**
- **[Create an instance with multiple network interfaces](https://multipass.run/docs/create-an-instance#heading--create-an-instance-with-multiple-network-interfaces)**

## Note

This process assumes you are using Ubuntu 24.04 server or OS that is using networkd or an OS which is setup with NetworkMangager but is completely integrated with Netplan 1.0 such as I think Ubuntu 24.04 desktop. It also assumes microk8s is installed on a Ubuntu 22.04 vm.

## **[Install multipass](../research/m_z/virtualization/multipass/multipass_install.md)**

Multipass is the fastest way to create a complete Ubuntu virtual machine on Linux, Windows or macOS, and it’s a great base for using MicroK8s.

## **[Create a Bridge](./create_bridges_with_netplan.md)**

```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        eno1:
            addresses:
            - 10.1.0.125/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            routes:
            -   to: default
                via: 10.1.1.205
        eno2:
            dhcp4: no
        eno3:
            dhcp4: true
        eno4:
            dhcp4: true
        enp66s0f0:
            dhcp4: true
        enp66s0f1:
            dhcp4: true
        enp66s0f2:
            dhcp4: true
        enp66s0f3:
            dhcp4: true
    bridges:
        br0:
            dhcp4: no
            addresses:
            - 10.1.0.126/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno2]
        br1:
            dhcp4: no
            addresses:
            - 10.13.31.1/24
        br2:
            dhcp4: no
            addresses:
            - 10.1.0.127/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            interfaces: [eno3]
    version: 2
```

Show bridge details in a pretty JSON format (which is a good way to get bridge key-value pairs):

```bash
# ip -j -p -d link show br0
ip -j -p -d link show br0

# show tap devices and master bridges
bridge link show
# bridge link show master br0
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 5 
13: tap434bfb4d: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master mpbr0 state forwarding priority 32 cost 2 
14: tap34dcb760: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 2 
15: tap7a27ad4e: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master mpbr0 state forwarding priority 32 cost 2 
16: tapf48799c9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br1 state forwarding priority 32 cost 2
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

With multipass installed, you can now create a VM to run MicroK8s. At least 4 Gigabytes of RAM and 40G of storage is recommended – we can pass these
requirements when we launch the VM:

```bash
# can't get manual mode in which you pass the hardware address to work
# multipass launch --name test3 --network name=mybr,mode=manual,mac="7f:71:f0:b2:55:dd"

multipass launch --network br0 --name repsys21-c1-n1 --cpus 2 --memory 16G --disk 100G 22.04

# Add memory if going to run only sql server
multipass launch --network br0 --name microk8s-vm --memory 8G --disk 80G 22.04

multipass launch --network br2 --name repsys11-c2-n1 --memory 16G --disk 80G 22.04

multipass launch --network br2 --name repsys11-c2-n2 --cpus 2 --memory 16G --disk 80G 22.04

multipass launch --network br2 --name repsys11-c2-n3 --cpus 2 --memory 16G --disk 80G 22.04

multipass list
Name                    State             IPv4             Image
microk8s-vm             Running           10.127.233.194   Ubuntu 24.04 LTS
                                          10.1.2.143
test1                   Running           10.127.233.173   Ubuntu 24.04 LTS
                                          10.1.0.128
test2                   Running           10.127.233.24    Ubuntu 24.04 LTS
                                          10.13.31.201

```

Use the ip utility to display the link status of Ethernet devices that are ports of a specific bridge:

```bash
ip link show master br2
8: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br2 state UP mode DEFAULT group default qlen 1000
    link/ether b8:ca:3a:6a:37:1a brd ff:ff:ff:ff:ff:ff
    altname enp1s0f2
21: tap50844081: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br2 state UP mode DEFAULT group default qlen 1000
    link/ether 7e:c8:dd:1b:2b:24 brd ff:ff:ff:ff:ff:ff

ip link show master br0
7: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether b8:ca:3a:6a:37:19 brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
14: tap34dcb760: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether 5a:8a:38:e5:66:f1 brd ff:ff:ff:ff:ff:ff
18: tap38ceeb39: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br0 state UP mode DEFAULT group default qlen 1000
    link/ether ce:80:f5:53:04:fb brd ff:ff:ff:ff:ff:ff

```

## retrieve the hardware address

See how multipass configured the network. Until I can figure out how to pass the hardware address manaully during launch we will have to grab the one multipass or lxd creates.

```bash
multipass exec -n repsys21-c1-n1 -- sudo networkctl -a status
● 3: enp6s0                                                                    
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: /run/systemd/network/10-netplan-extra0.network
                          Type: ether
                         State: routable (configured)
                  Online state: unknown
                          Path: pci-0000:06:00.0
                        Driver: virtio_net
                        Vendor: Red Hat, Inc.
                         Model: Virtio network device
                    HW Address: 52:54:00:96:35:56
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.1.2.234 (DHCP4 via 10.1.2.69)
                                fe80::5054:ff:fe96:3556
                       Gateway: 10.1.1.205
                           DNS: 10.1.2.69
                                10.1.2.70
                                172.20.0.39
                Search Domains: BUSCHE-CNC.COM
             Activation Policy: up
           Required For Online: no
               DHCP4 Client ID: IAID:0x24721ac8/DUID
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab11a866203a4ad4a3490000

Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Link UP
Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Gained carrier
Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: DHCPv4 address 10.1.2.234/22 via 10.1.1.205
Jul 17 20:28:42 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Gained IPv6LL
```

## Step 3: Configure the extra interface

We now need to configure the manual network interface inside the instance. We can achieve that using Netplan. The following command plants the required Netplan configuration file in the instance:

```bash
multipass exec -n repsys21-c1-n1 -- sudo bash -c 'cat /etc/netplan/50-cloud-init.yaml'
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        default:
            dhcp4: true
            match:
                macaddress: 52:54:00:b2:f2:b4
        extra0:
            dhcp4: true
            dhcp4-overrides:
                route-metric: 200
            match:
                macaddress: 52:54:00:96:35:56
            optional: true
    version: 2

multipass exec -n repsys21-c1-n1 -- sudo bash -c 'cat << EOF > /etc/netplan/50-cloud-init.yaml
network:
    ethernets:
        default:
            dhcp4: true
            match:
                macaddress: 52:54:00:b2:f2:b4
        extra0:
            addresses:
              - 10.1.0.133/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            match:
                macaddress: 52:54:00:96:35:56
            optional: true
    version: 2
EOF'

# verify yaml

multipass exec -n repsys21-c1-n1 -- sudo bash -c 'cat /etc/netplan/50-cloud-init.yaml'
network:
    ethernets:
        default:
            dhcp4: true
            match:
                macaddress: 52:54:00:b2:f2:b4
        extra0:
            addresses:
              - 10.1.0.133/22
            nameservers:
                addresses:
                - 10.1.2.69
                - 10.1.2.70
                - 172.20.0.39
                search: [BUSCHE-CNC.COM]
            match:
                macaddress: 52:54:00:96:35:56
            optional: true
    version: 2

# if all looks good apply network changes
multipass exec -n repsys21-c1-n1 -- sudo netplan apply
WARNING:root:Cannot call Open vSwitch: ovsdb-server.service is not running.
# check network interfaces with networkd cli
multipass exec -n repsys21-c1-n1 -- sudo networkctl -a status
# skip multipass default network interfaces
...
● 3: enp6s0                                                                    
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: /run/systemd/network/10-netplan-extra0.network
                          Type: ether
                         State: routable (configured)
                  Online state: unknown
                          Path: pci-0000:06:00.0
                        Driver: virtio_net
                        Vendor: Red Hat, Inc.
                         Model: Virtio network device
                    HW Address: 52:54:00:96:35:56
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.1.0.133
                                fe80::5054:ff:fe96:3556
                           DNS: 10.1.2.69
                                10.1.2.70
                                172.20.0.39
                Search Domains: BUSCHE-CNC.COM
             Activation Policy: up
           Required For Online: no
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab11a866203a4ad4a3490000

Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Link UP
Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Gained carrier
Jul 17 20:28:41 repsys21-c1-n1 systemd-networkd[647]: enp6s0: DHCPv4 address 10.1.2.234/22 via 10.1.1.205
Jul 17 20:28:42 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Gained IPv6LL
Jul 17 20:34:49 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 17 20:34:49 repsys21-c1-n1 systemd-networkd[647]: enp6s0: DHCP lease lost
Jul 17 20:34:49 repsys21-c1-n1 systemd-networkd[647]: enp6s0: DHCPv6 lease lost
Jul 17 20:34:49 repsys21-c1-n1 systemd-networkd[647]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 17 20:34:49 repsys21-c1-n1 systemd-networkd[647]: enp6s0: DHCPv6 lease lost

# https://stackoverflow.com/questions/77352932/ovsdb-server-service-from-no-where
# If the package isn't installed, there's no reason to warn that a non-existent service can't be restarted.
# You can also install the Open vSwitch package, even if you're not planning to use it:

#      apt-get install openvswitch-switch

# The spurious warning message problem goes away. Not elegant, but it works.



```

## Step 5: Confirm that it works

You can confirm that the new IP is present in the instance with Multipass:

```bash
multipass info repsys21-c1-n1

```

You can use ping to confirm that it can be reached from another host on lan:

```bash
ping -c 1 -n 10.1.0.123

ping -c 1 -n 10.1.0.129
PING 10.1.0.129 (10.1.0.129) 56(84) bytes of data.
64 bytes from 10.1.0.129: icmp_seq=1 ttl=64 time=1.31 ms

--- 10.1.0.129 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.309/1.309/1.309/0.000 ms
```

Confirm VM can ping lan and wan

```bash
multipass exec -n repsys21-c1-n1 -- ping -c 1 -n 10.1.0.113
PING 10.1.0.113 (10.1.0.113) 56(84) bytes of data.
64 bytes from 10.1.0.113: icmp_seq=1 ttl=64 time=0.560 ms

--- 10.1.0.113 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.560/0.560/0.560/0.000 ms

multipass exec -n repsys21-c1-n1 -- ping -c 1 -n google.com
PING google.com (142.250.191.238) 56(84) bytes of data.
64 bytes from 142.250.191.238: icmp_seq=1 ttl=57 time=9.04 ms

--- google.com ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 9.039/9.039/9.039/0.000 ms

```

## **[install microk8s](https://microk8s.io/docs/install-multipass)**

We can now find the static IP address which has been allocated. Running:

```bash
multipass list
Name                    State             IPv4             Image
microk8s-vm             Running           10.127.233.194   Ubuntu 24.04 LTS
                                          10.1.0.129
test1                   Running           10.127.233.173   Ubuntu 24.04 LTS
                                          10.1.0.128
test2                   Running           10.127.233.24    Ubuntu 24.04 LTS
                                          10.13.31.201
```

Take a note of this IP as services will become available there when accessed
from the host machine.

To work within the VM environment more easily, you can run a shell:

```bash
multipass shell repsys11-c2-n1
multipass shell microk8s-vm
```

Then install the MicroK8s snap and configure the network:
<https://microk8s.io/docs/getting-started>

```bash
sudo snap install microk8s --classic --channel=1.30/stable
sudo iptables -P FORWARD ACCEPT
The iptables command is necessary to permit traffic between the VM and host.
sudo iptables -S
# Warning: iptables-legacy tables present, use iptables-legacy to see them
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A FORWARD -s 10.1.0.0/16 -m comment --comment "generated for MicroK8s pods" -j ACCEPT
-A FORWARD -d 10.1.0.0/16 -m comment --comment "generated for MicroK8s pods" -j ACCEPT

```

## Join the microk8s group

MicroK8s creates a group to enable seamless usage of commands which require admin privilege. To add your current user to the group and gain access to the .kube caching directory, run the following two commands:

```bash
sudo usermod -a -G microk8s $USER
mkdir ~/.kube
sudo chown -f -R $USER ~/.kube
# You will also need to re-enter the session for the group update to take place:
su - $USER
-or-
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  
```

## Check each node for necessary changes

```bash
microk8s inspect
Inspecting system
Inspecting Certificates
Inspecting services
  Service snap.microk8s.daemon-cluster-agent is running
  Service snap.microk8s.daemon-containerd is running
  Service snap.microk8s.daemon-kubelite is running
  Service snap.microk8s.daemon-k8s-dqlite is running
  Service snap.microk8s.daemon-apiserver-kicker is running
  Copy service arguments to the final report tarball
Inspecting AppArmor configuration
Gathering system information
  Copy processes list to the final report tarball
  Copy disk usage information to the final report tarball
  Copy memory usage information to the final report tarball
  Copy server uptime to the final report tarball
  Copy openSSL information to the final report tarball
  Copy snap list to the final report tarball
  Copy VM name (or none) to the final report tarball
  Copy current linux distribution to the final report tarball
  Copy asnycio usage and limits to the final report tarball
  Copy inotify max_user_instances and max_user_watches to the final report tarball
  Copy network configuration to the final report tarball
Inspecting kubernetes cluster
  Inspect kubernetes cluster
Inspecting dqlite
  Inspect dqlite
cp: cannot stat '/var/snap/microk8s/6876/var/kubernetes/backend/localnode.yaml': No such file or directory

Building the report tarball
  Report tarball is at /var/snap/microk8s/6876/inspection-report-20240626_220925.tar.gz


# Do what inspect tells you to do.

```

## perform status check

```bash
microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
  disabled:
    cert-manager         # (core) Cloud native certificate management
    cis-hardening        # (core) Apply CIS K8s hardening
    community            # (core) The community addons repository
    dashboard            # (core) The Kubernetes dashboard
    gpu                  # (core) Alias to nvidia add-on
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    minio                # (core) MinIO object storage
    nvidia               # (core) NVIDIA hardware (GPU and network) support
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    rook-ceph            # (core) Distributed Ceph storage using Rook
    storage              # (core) Alias to hostpath-storage add-on, deprecated
```

## Enable RBAC

```bash
microk8s enable rbac
Infer repository core for addon rbac
Enabling RBAC
Reconfiguring apiserver
Restarting apiserver
RBAC is enabledm

```

## install kubectl

```bash
sudo snap install kubectl  --classic
cd ~/.kube
microk8s config > repsys11c2n1.yaml
cat repsys11c2n1.yaml
cp repsys11c2n1.yaml ~/.kube/config

microk8s config > repsys11_sql_server.yaml
cat repsys11_sql_server.yaml
cp repsys11_sql_server.yaml ~/.kube/config

```

## add to config files

```bash
multipass shell microk8s-vm
cat repsys11_sql_server.yaml
# copy and paste
cd ~/src/k8s/all-config-files
touch repsys11_sql_server.yaml
# copy and paste config file and replace the server ip with the static one from the bridged network interface.
nvim repsys11_sql_server.yaml

cp repsys11_sql_server.yaml ~/.kube/
# scc.sh repsys11_sql_server.yaml microk8s
# scc.sh repsys11c2n1.yaml microk8s

```

## **[create a debug pod](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ # exit
pod "debug" deleted
```

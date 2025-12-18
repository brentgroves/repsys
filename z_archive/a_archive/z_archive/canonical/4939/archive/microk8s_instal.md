# Microk8s install on vlan

Issue: MicroK8s will not run on Ubuntu 24.04 server with the below network configurations on either a bare metal server or a multipass Ubuntu 24.04 server VM.

We tried to install MicroK8s from both 1.28 and 1.32 stable channels. After install `microk8s status` reports not running. The `microk8s inspect` command shows no obvious issues except `cp: cannot stat '/var/snap/microk8s/7399/var/kubernetes/backend/localnode.yaml': No such file or directory`

The bare metal server and multipass VM both work as expected in our network environment in which the bare metal server is attached to a port configured to allow traffic from both default vlan 50 and vlan 220 of an extreme network switch.

Bare Metal Server Netplan Config:

```yaml
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: false
      dhcp6: false
  vlans:
    vlan220:
      id: 220
      link: eno1
  bridges:
    br0:
      dhcp4: false
      dhcp6: false  
      addresses:
      - 10.188.50.202/24    
      routes:
      - to: default
        via: 10.188.50.254
      nameservers:
        addresses:
        - 10.225.50.203
        - 10.224.50.203
      interfaces: [eno1] 
    br1:
      interfaces: ["vlan220"]
      dhcp4: false
      dhcp6: false  
      addresses:
      - 10.188.220.202/24
      nameservers:
        addresses:
        - 10.225.50.203
        - 10.224.50.203
      routes:
        - to: 10.188.73.0/24
          via: 10.188.220.254      
```

Multipass VM network configuration:

```yaml
network:
  version: 2
  ethernets:
    default:
      match:
        macaddress: "52:54:00:4a:f4:2e"
      dhcp-identifier: "mac"
      dhcp4: true
    extra0:
      match:
        macaddress: "52:54:00:34:6f:ca"
      optional: true
      dhcp4: false
      dhcp6: false
      addresses:
      - 10.188.50.214/24
      nameservers:
         addresses:
         - 10.225.50.203
         - 10.224.50.203
      routes:
      - to: 10.188.40.0/24
        via: 10.188.50.254
      - to: 10.188.42.0/24
        via: 10.188.50.254
      - to: 10.184.40.0/24
        via: 10.188.50.0/24  
      - to: 10.184.42.0/24
        via: 10.188.50.0/24  
      - to: 10.181.40.0/24
        via: 10.188.50.0/24  
      - to: 10.181.42.0/24
        via: 10.188.50.0/24  
      - to: 10.185.40.0/24
        via: 10.188.50.0/24  
      - to: 10.185.42.0/24
        via: 10.188.50.0/24  
      - to: 10.187.40.0/24
        via: 10.188.50.0/24  
      - to: 10.187.42.0/24
        via: 10.188.50.0/24  
      - to: 10.189.40.0/24
        via: 10.188.50.0/24  
      - to: 10.189.42.0/24
        via: 10.188.50.0/24  
      - to: 172.20.88.0/24
        via: 10.188.50.254
    extra1:
      match:
        macaddress: "52:54:00:46:3b:fd"
      optional: true
      dhcp4: false
      dhcp6: false
      addresses:
      - 10.188.220.214/24
      nameservers:
         addresses:
         - 10.225.50.203
         - 10.224.50.203
      routes:
      - to: 10.188.73.0/24
        via: 10.188.220.254
```

## status and inspection details after successful installs

```bash
# After install status reports not running.
microk8s status
microk8s is not running. Use microk8s inspect for a deeper inspection.

# inspections shows no obvious issues except cp: cannot stat '/var/snap/microk8s/7399/var/kubernetes/backend/localnode.yaml': No such file or directory

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
cp: cannot stat '/var/snap/microk8s/7399/var/kubernetes/backend/localnode.yaml': No such file or directory

Building the report tarball
  Report tarball is at /var/snap/microk8s/7399/inspection-report-20250311_192426.tar.gz
```

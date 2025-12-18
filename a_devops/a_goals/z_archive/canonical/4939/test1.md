# Test 1

Configure a basic network with no bridges or VLAN.

## Details

```yaml
server: r620_201
```

## Netplan config

```yaml
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: false
      addresses:
      - 10.188.50.201/24    
      routes:
      - to: default
        via: 10.188.50.254
      nameservers:
        addresses:
        - 10.225.50.203
        - 10.224.50.203
```

## steps

```bash
bridge link
# none
sudo ip link set dev vlan220 down
sudo ip link delete vlan220
ip -d link show vlan220

sudo snap install microk8s --classic --channel=1.32/stable
microk8s (1.32/stable) v1.32.2 from Canonical✓ installed

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
cp: cannot stat '/var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml': No such file or directory

Building the report tarball
  Report tarball is at /var/snap/microk8s/7731/inspection-report-20250312_222941.tar.gz

sudo usermod -a -G microk8s brent
sudo chown -R brent ~/.kube
newgrp microk8s
microk8s status

microk8s is not running. Use microk8s inspect for a deeper inspection.
```

# Microk8s install

Issue: MicroK8s will not run on Ubuntu 24.04 server with vlan.

Netplan Config:

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

## Install Microk8s snap

```bash
sudo snap install microk8s --classic --channel=1.32/stable
sudo snap install microk8s --classic --channel=1.32
```

## Join the microk8s group

MicroK8s creates a group to enable seamless usage of commands which require admin privilege. To add your current user to the group and gain access to the .kube caching directory, run the following two commands:

```bash
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
chmod 0700 ~/.kube
# or
sudo chown -f -R $USER ~/.kube
# You will also need to re-enter the session for the group update to take place:
su - $USER
-or-
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  
```

<https://microk8s.io/docs/getting-started>

## **[issue](https://github.com/canonical/microk8s/issues/4361)**

After installing MicroK8s

## Install Microk8s snap

```bash
sudo snap install microk8s --classic --channel=1.28/stable
sudo snap install microk8s --classic --channel=1.32/stable

```

```bash
cp: cannot stat '/var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml': No such file or directory
touch /var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml
```

Check the status

MicroK8s has a built-in command to display its status. During installation you can use the --wait-ready flag to wait for the Kubernetes services to initialise:

```bash
microk8s status --wait-ready

microk8s kubectl get nodes
NAME      STATUS     ROLES    AGE   VERSION
k8sn211   NotReady   <none>   20m   v1.32.2

microk8s kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   21m
```

## Check each node for necessary changes

```bash
microk8s inspect
Inspecting dqlite
  Inspect dqlite
cp: cannot stat '/var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml': No such file or directory
touch /var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml
 WARNING:  IPtables FORWARD policy is DROP. Consider enabling traffic forwarding with: sudo iptables -P FORWARD ACCEPT
# Do what inspect tells you to do.

```

- Ensure communications between nodes by pinging all the ip addresses in cluster

## Add all nodes to cluster

```bash
sudo microk8s add-node
# go to the node you want to add and run the command shown to add it as either a control plane or worker node.

# This is the message you get when you join as a worker node.
# Contacting cluster at 10.1.0.110

# The node has joined the cluster and will appear in the nodes list in a few seconds.

# This worker node gets automatically configured with the API server endpoints.
# If the API servers are behind a loadbalancer please set the '--refresh-interval' to '0s' in:
#     /var/snap/microk8s/current/args/apiserver-proxy
# and replace the API server endpoints with the one provided by the loadbalancer in:
#     /var/snap/microk8s/current/args/traefik/provider.yaml
```

## Verify all nodes have been added to the cluster

```bash
microk8s kubectl get node -o wide
```

## Enable RBAC

```bash
microk8s enable rbac
```

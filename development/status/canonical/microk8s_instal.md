# Microk8s install

**[Report System Install](./report-system-install.md)**\
**[Ubuntu 22.04 Desktop](../linux/ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../linux/ubuntu22-04/server-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## References

<https://microk8s.io/#install-microk8s>
<https://microk8s.io/docs/getting-started>
<https://microk8s.io/docs/setting-snap-channel>
<https://microk8s.io/docs/clustering>
<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/>
<https://microk8s.io/docs/high-availability>
<https://kubernetes.io/docs/concepts/overview/components/>

## Requirements

MicroK8s runs in as little as 540MB of memory, but to accommodate workloads, we recommend a system with at least 20G of disk space and 4G of memory.

## Remove Microk8s

```bash
snap info microk8s
microk8s stop
sudo snap remove microk8s --purge
sudo reboot
```

## Install Microk8s snap

```bash
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

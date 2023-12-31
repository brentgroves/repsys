# week50

## Report System and IT Admin, Hardware, or Software Topics

R
![dashboard](../linux/grafana/dashboard.png)

Summary,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about Microsoft server admin or anything you want :-)
- Brent G. Web Hooks **[example](../volumes/go/tutorials/webhook/webhook.md)** to be used in the report system. In setting up the report systems observability software I came across the need to understand webhooks. Prometheus rules can be created to monitor data points from our applications.  When a rule condition is satisfied for example the number of http requests exceeds a certain rate then a webhook is called.  The webhook listener can then increase the number of web app instances running in our k8s, send an email, or whatever other action is required.

- Can Open Source compete in server arena? Dell needs to make money so Microsoft Server hardware drivers will work first, then VMWare ESXi, Red Hat, SuSu Novell, and finally debian Canonical.
- What is the main Open Source project competing in the server/cloud arena?
OpenStack 3rd most popular Open Source project. With the great help of Carl and Jared I'm attempting to install Canonical's implementation on Dell PowerEdge R620s.
- Data analysis used in reporting can drive business decisions.  What should I learn?  Study statistics, Microsoft PowerBI, IBM SPSS, R, and Python.
- New data analysis and machine learning ideas are available first in R and is used more in acedemics but Python is also greatly used and has the advantage of being a general purpose language which is easier to make software with.  

Notes from this meeting will be located at: ~/src/repsys/meeting/week50.md
To get a fresh copy please run ~/freshstart.sh at a command prompt.
It can be viewed by logging into devcon2 as bcieslik,bcook,sjackson,cstangland,jdavis,or kyoung with password k8sAdmin1! and opening week50.md from visual studio code and pressing shift-ctrl-v

- Share anything related to IT Admin, hardware, or software with group
- Install **[Prometheus and Grafana](../k8s/kube-prometheus-stack-install.md)**
- Export, Scrape, and visualize **[metrics](../volumes/go/tutorials/prometheus/tutorials.md)** example
- Metric Alerts

- **[Backup and Restore  Prometheus](https://devopstales.github.io/kubernetes/backup-and-retore-prometheus/)**
- **[Time Series Analysis](../linux/time-series-analysis/time-series-analysis.md)**
- **[Grafana vs Power BI](https://www.metricfire.com/blog/grafana-vs-power-bi/)**
- **[OpenStack](../linux/openstack/openstack-on-kubernetes.md)** on Kubernetes
- **[JuJu](https://juju.is/docs/juju)**

## Multipass

<https://multipass.run/docs#:~:text=Multipass%20is%20a%20tool%20to,your%20own%20local%20mini%2Dcloud>.

Multipass is a tool to generate cloud-style Ubuntu VMs quickly on Linux, macOS, and Windows. It gives you a simple but powerful CLI that allows you to quickly access an Ubuntu command line or create your own local mini-cloud.

Cloud-style VMs at your fingertips
Spin up cloud instances with a single command

Launch instances of Ubuntu and initialise them with cloud-init metadata in the same way you would on AWS, Azure, Google, IBM and Oracle. Simulate your own cloud deployment on your workstation.

## JuJu

JuJu manages the life-cycle of software deployed to public clouds using charms.

### Juju supports all of the following clouds

Amazon EC2
Amazon EKS
Equinix Metal
Google GCE
Google GKE
LXD
MAAS
Manual
MicroK8s
Microsoft Azure
Microsoft AKS
OpenStack (see also the OpenStack website; or MicroStack)
Oracle OCI
VMware vSphere

<https://juju.is/docs/juju/tutorial>

- Use Multipass to launch an Ubuntu VM with the charm-dev blueprint

```bash
multipass launch --cpus 4 --memory 8G --disk 30G --name tutorial-vm charm-dev
```

Use multipass shell tutorial-vm to open a shell into the VM. Sample session:

```bash
multipass shell tutorial-vm
```

Your VM comes with MicroK8s preinstalled.
Your VM comes with the Juju CLI client preinstalled.

Add your cloud definition to Juju
Juju has automatically used your MicroK8s’s .kube/config file to define a cloud called microk8s.

Run juju clouds to verify. Sample session:

```bash
ubuntu@tutorial-vm:~$ juju clouds
Only clouds with registered credentials are shown.
There are more clouds, use --all to see them.

Clouds available on the controller:
Cloud     Regions  Default    Type
microk8s  1        localhost  k8s  

Clouds available on the client:
Cloud      Regions  Default    Type  Credentials  Source    Description
localhost  1        localhost  lxd   1            built-in  LXD Container Hypervisor
microk8s   1        localhost  k8s   1            built-in  A Kubernetes Cluster

```

LXD is a system container and virtual machine manager

## Grafana vs Power BI

- Use Grafana for time series databases - PromQL time-series language
- Use Power BI for SQL databases - TSQL for SQL databases

## Reference

- Use grafana with a **[mysql](https://www.techrepublic.com/article/how-to-connect-grafana-to-a-remote-mysql-database/)** data source

<https://www.youtube.com/watch?v=BatCdEsJgEo>
<https://jonathangazeley.com/2020/09/10/building-a-hyperconverged-kubernetes-cluster-with-microk8s-and-ceph/>
<https://mswis.com/load-balancing-with-microk8s-kubernetes/>
<https://microk8s.io/docs/how-to-ceph>
Note: Before enabling the rook-ceph addon on a strictly confined MicroK8s, make sure the rbd kernel module is loaded with sudo modprobe rbd.
<https://mswis.com/building-a-micro-kubernetes-cluster-with-raspberry-pi-4-and-solid-state-drives/>
<https://metallb.universe.tf/>
<https://benbrougher.tech/posts/microk8s-ingress/>

- Install Load Balancer and try on IP range outside of Cluster
The microk8s stack has a concept of addons that can be enabled to easily give your cluster common functionality. The first step is to identify a range of IP addresses that will be allocatable by MetalLB. For this example, I’ll use 192.168.1.200-192.168.1.220. These IP adresses must be on the same subnet where the cluster is located.

## K8s Observable Report System on our Private Cloud

This markdown file is located at: ~/src/linux-utils/status/report_system/week45.md
It can be viewed by logging into devcon2 as bcieslik,bcook,sjackson,cstangland,jdavis,or kyoung with password k8sAdmin1! and opening week45.md from visual studio code and pressing shift-ctrl-v

## Topics

- Ansible
- Network namespaces
- High Availibility
- Node maintenance
- Deploy Prometheus and Grafana for observability
- Install Load Balancer using network namespaces
- Install Ingress Controller.
- Use PKI to gernate SAN certificate.
- Deploy test app with Ingress using new cert.
- Verify secure connection to test app.
- Virtual disks
- Ceph storage
- S3 compatible storage

## **[HA](../architecture/ha.md)**

## **[Node maintenance](../k8s/maintenance.md)**

## Find static IPs for load balancer

microk8s enable metallb:172.20.88.59-172.20.88.60
microk8s enable metallb:10.1.0.8-10.1.0.9

nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22

## Using visual studio code to view our repos

Update docs and source code from our repos.

```bash
# git@github.com:brentgroves/linux-utils.git
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# If you want to change anything in them please create a new branch
# At the start of the day you run this command to get repo updates
~/startday.sh
# If you get error messages from ~/startday.sh that means there were changes made in our repo directories.  In that case you can either stash your changes or undo them.
# To undo any changes inadvertantly made in the repo directories run this command which removes the directies and recreates them.
~/freshstart.sh

```

## **[Ubuntu 22.04 Server install](../../ubuntu22-04/server-install.md)**

If you want to install Ubuntu 22.04 Server here is the process used on all our K8s reports nodes.

Now that the load balancer and ingress controller are working try getting the ingress controller to collect metrics using prometheus and graph data in graphina.

- Install MicroK8s observability stack
- monitor the ingress controller with prometheus
- configure MicroK8s to ship logs and metric data to an external
 Observability stack for logging, monitoring and alerting.

The Observability stack used in this example consists of:
Prometheus
Elasticsearch
Alertmanager

- Install S3 Compatible Object Storage.
- K8s Training Cluster and devcon2 access to all report system meeting members.
- SSH access to K8s nodes.
- Regular package updates with Ansible or tmux.
- What snap channel should be used when installing MicroK8s?
- Install kubectl and cluster contexts.
- How to reboot Kubernetes.

## Install Microk8s

**[Microk8s Installation](../../../reports/k8s/microk8s_1.28_install.md)**

## What is Mayastor

A dynamic storage provider managed entirely with k8s which uses the hugepages and nvme instruction set found in AMD/I64 cpu.

Postgres does work with on a k8s node with hugepages enabled so **[disable hubepages](../../../reports/k8s/mayastor-install-2.0.0.md)** for now.

## What is a virtual disk

It is a file that is treated as a disk.  Ceph Storage uses virtual disks to provide dynamic storage.

## What is Ceph Storage

**[What is Ceph Storage](https://en.wikipedia.org/wiki/Ceph_(software))**

Ceph is a free and open-source software-defined storage platform that provides object storage, block storage, and file storage built on a common distributed cluster foundation.

Why do we need it? To install Minio S3 compatible Cloud Object Storage which will be used to store report excel files.

**[Ceph Storage](../../ceph-storage/microk8s-ceph-storage.md)**

## What is MicroCeph

MicroCeph is a lightweight way of deploying a Ceph cluster with a focus on reduced ops. It is distributed as a snap and thus it gets deployed with:

## S3 Compatible Coud Object Storage

**[S3](https://aws.amazon.com/s3/)**

Amazon S3 or Amazon Simple Storage Service is a service offered by Amazon Web Services that provides object storage through a web service interface.

What ca we use it for? Backing up postgres databases.
Can we have in-house S3 storage? Yes.
What is Minio?
**[Minio](https://en.wikipedia.org/wiki/MinIO)**
"
MinIO is a High-Performance Object Storage released under GNU Affero General Public License v3.0. It is API compatible with the Amazon S3 cloud storage service. It can handle unstructured data such as photos, videos, log files, backups, and container images with a current maximum supported object size of 50TB.
"
How to setup Minio?
**[Minio Setup](https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/)**
"
"
How to backup Postgres database to S3 bucket?
**[Postgres S3 clone](https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/)**

## Our Minio server

Spun up a server for testing purposes

<http://reports-alb:9001>
admin/supersecret

<https://min.io/docs/minio/linux/reference/minio-mc.html?ref=docs-redirect>

```bash
cd ~/Downloads
mc ls minio minio/test-bucket/
mc cp minio/test-bucket/TB-202209_to_202309_on_10-24_DM_GP.xlsx ~/data/
```

## K8s Training Cluster

### Access devcon2 and K8s Training Cluster

If you wish to use devcon2 to access the K8s Training cluster you can log in using rdp or ssh.  The **[meeting notes](~/src/linux-utils/status/report_system/week43.md)** can be viewed by logging into devcon2 and running vscode which has a markdown viewer.  Typing ~/startday.sh ensures you get a fresh copy of all our git repositories.  If you change any of the files please make your changes to a different branch.

user: bcieslik
user: bcook
user: sjackson
user: jdavis
user: kyoung
Initial password for all: k8sAdmin1!

FYI: Thanks to Brendan these IP addresses are in our DNS.

```hosts
10.1.0.110      reports11
10.1.0.111      reports12
10.1.0.112      reports13
10.1.0.120      devcon2
```

- devcon2 already has these entries in /etc/hosts file.
- On Windows to change hosts file you must open a command prompt as administrator and type notepad c:\Windows\System32\Drivers\etc\hosts then add the above host entries but Brendan has added the A records to our DNS so you should not have to add them to test go to the command prompt and type:

```bash
ping reports11
ping devcon2
```

## Create a new user with sudo priviliges

**[Setup admin user account](https://jumpcloud.com/blog/how-to-create-a-new-sudo-user-manage-sudo-access-on-ubuntu-20-04)**

### Create user

```bash
sudo adduser bcook 
Adding user newuser' ... Adding new group newuser' (1001) ...
Adding new user newuser' (1001) with group newuser' ...
Creating home directory /home/newuser' ... Copying files from /etc/skel' ...

At the prompt, enter the password for the new user twice to set and verify it.

New password: ******
Retype new password: ******
passwd: password updated successfully

# verify user with id
id bcook
uid=1002(bcook) gid=1002(bcook) groups=1002(bcook)
```

### Grant root permissions for a new or existing user

Add admin users to sudo group.

```bash

bcieslik@devcon2:~# sudo usermod -aG sudo bcook # add user to sudo group
bcieslik@devcon2:~# id bcook # verify user was added to sudo group
uid=1002(bcook) gid=1002(bcook) groups=1002(bcook),27(sudo)
bcieslik@devcon2:~#
```

## K8s node SSH server setup

**[SSH Setup](https://linuxhint.com/enable-use-ssh-ubuntu/)**

```bash
sudo apt install openssh-server -y
sudo systemctl status ssh
ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-10-26 17:22:44 EDT; 2h 57min left
       Docs: man:sshd(8)
             man:sshd_config(5)
    Process: 549 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 591 (sshd)
      Tasks: 1 (limit: 37467)
     Memory: 5.9M
        CPU: 121ms
     CGroup: /system.slice/ssh.service
             └─591 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups"

Oct 26 17:22:43 devcon2.busche-cnc.com systemd[1]: Starting OpenBSD Secure Shell server...
Oct 26 17:22:44 devcon2.busche-cnc.com sshd[591]: Server listening on 0.0.0.0 port 22.
Oct 26 17:22:44 devcon2.busche-cnc.com sshd[591]: Server listening on :: port 22.
Oct 26 17:22:44 devcon2.busche-cnc.com systemd[1]: Started OpenBSD Secure Shell server.
Oct 26 14:24:49 devcon2.busche-cnc.com sshd[1440]: Accepted password for bcieslik from 10.1.0.113 port 58486 ssh2
Oct 26 14:24:49 devcon2.busche-cnc.com sshd[1440]: pam_unix(sshd:session): session opened for user bcieslik(uid=1001) by (uid=0)
(
```

### Development System SSH client setup

To enable passwordless login to K8s nodes use an encryption key pair.

note: I did this already for report system team on devcon2 @ 10.1.0.120.

```bash
# rdp or ssh into the development system as the user.
ssh bcook@devcon2
# Generate the ssh key with the ed25519 algorithm and accept the defaults 
bcook@devcon2:~$ ssh-keygen -t ed25519 -C bcook@mobexglobal.com 

# start the ssh-agent if not already started
# We don't normally need to stop and start the ssh-agent on Ubuntu 22.04 desktop but on Ubuntu 22.04 server you may need to
bcook@devcon2:~$ eval "$(ssh-agent -s)"
Agent pid 2443

# Add the SSH private key to the SSH-agent 
bcook@devcon2:~$ ssh-add ~/.ssh/id_ed25519 
Identity added: /home/bcook/.ssh/id_ed25519 (bcook@mobexglobal.com)

# To list ssh-keys that have been added: 
bcook@devcon2:~$ ssh-add -L
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrLD//7Ui7/MZHHyg+3EGl2wc1HwXZiLprsXqUh5ubF bcook@mobexglobal.com

# Add the SSH public key to each remote K8s node user's authorized_keys file using ssh-copy-id command.
ssh-copy-id bcook@reports11
ssh-copy-id bcook@reports12
ssh-copy-id bcook@reports13
```

## Package update options

We need a way to update the K8s nodes with the latest package updates at least weekly.

1. Ansible automation.
2. tmux.

**[Ansible Setup](https://www.linode.com/docs/guides/getting-started-with-ansible/)**

Ansible is a one way to automate the Linux package update process.  You first create a file of ip addresses or host names that is grouped if you like. Then you put some commands to update OS packages in a file and run ansible.

## Ansible play-book notes

```bash
ssh jdavis@devcon2
pushd ~/src/reports/volume/ansible/playbooks
# copy a file
cd ~/src/reports/volume/ansible/playbooks

ansible reports11 -m ansible.builtin.copy -a "src=./test.yml dest=/tmp/test.yaml"
ansible-playbook upgrade.yml -i inventory.yaml -b --ask-become-pass
ansible-playbook reboot-reports11-jdavis.yml -i inventory.yaml -b --ask-become-pass
```

TMUX splits your screen up into sections then each section there is a command prompt for you to ssh into one node.  So you will be looking at all nodes at once.  You then press the key combo to output to all sections of the TMUX screen.  Finally type the commands that you want to run on all 4 nodes.

```bash
# tmux commands
# start
tmux
# end
Ctrl-a is the prefix
type the prefix before any command
:kill-server // to end session
# split screen
ctrl + a + % to make a vertical split. ctrl + a + " to make a Horizontal split. ctrl + a + left arrow to move to the left pane.
```

```bash
# send command to all panes
ctrl + e
## stop sending commands to all panes
ctrl + E
```

## What snap channel should be used when installing MicroK8s?

IMO it is best to use channel 1.28 because it has better storage drivers and the observability add-on.

### Check snap channel

snap info microk8s

## Kubernetes Reboot Daemon

After package updates a reboot is sometimes required. So how do you reboot K8s nodes safely?

**[Install and test Kured](https://www.youtube.com/watch?v=t2vwuSHmInk)**

```bash
scc.sh reports1.yaml microk8s
kubectl get pods -n kube-system -owide | grep kured
kubectl edit daemonset kured -n kube-system
- command
  - /usr/bin/kured
  - --period=0h0m30s

# check if pods came up after change
kubectl get pods -n kube-system -owide | grep kured

# watch the nodes
kubectl get nodes -w

# Or look at the logs to see the reboot
kubectl logs -f kured-gpf2w -n kube-system

# Check MySQL InnoDB Cluster
kubectl get pods -n default -owide 
```

## Install kubectl and cluster contexts

```bash
sudo snap install kubectl  --classic
```

## generate microk8s config from k8s node

```bash
ssh brent@reports11
cd ~
mkdir .kube
cd .kube
microk8s config > config
```

## How to reboot kubernetes

**[Kubernetes Reboot Daemon](https://kured.dev/docs/)**
"
Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.
"

## Install Kured

**[Install Kured](https://kured.dev/docs/installation/)**

"
Installation
To obtain a default installation without Prometheus alerting interlock or Slack notifications:

```bash
scc.sh reports1.yaml microk8s
sudo apt  install jq
latest=$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')
kubectl apply -f "https://github.com/kubereboot/kured/releases/download/$latest/kured-$latest-dockerhub.yaml"
clusterrole.rbac.authorization.k8s.io/kured created
clusterrolebinding.rbac.authorization.k8s.io/kured created
role.rbac.authorization.k8s.io/kured created
rolebinding.rbac.authorization.k8s.io/kured created
serviceaccount/kured created
daemonset.apps/kured created
```

**[Install and test Kured](https://www.youtube.com/watch?v=t2vwuSHmInk)**

```bash
# Verify installation
kubectl get pods -n kube-system -owide | grep kured

# Change this for test purposes to 30
kubectl edit daemonset kured -n kube-system
- command
  - /usr/bin/kured
  - --period=0h0m30s

# check if pods came up after change
kubectl get pods -n kube-system -owide | grep kured

# You can test your configuration by provoking a reboot on a node:
ssh brent@reports11
sudo touch /var/run/reboot-required

# watch the nodes to detect reboot
kubectl get nodes -w

# Or look at the logs to see the reboot
kubectl logs -f kured-gpf2w -n kube-system

```

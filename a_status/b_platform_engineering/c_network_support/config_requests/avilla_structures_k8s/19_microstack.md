# MicroStack Request

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Issue: In order for **[MicroStack](https://canonical.com/microstack/docs)** to work as intended it must have access to the following **[domains](https://discourse.ubuntu.com/t/proxy-acl-access/43948)**.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the domains needed for MicroStack to work correctly.

Reason: MicroStack is used to install Kubernetes but it is also **[managed by Kubernetes](https://ubuntu.com/blog/kubernetes-vs-openstack)**.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the **[ACL list](https://discourse.ubuntu.com/t/proxy-acl-access/43948)** MicroStack needs in order to run.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - streams.canonical.com
  - *canonical.com
  - archive.ubuntu.com
  - security.ubuntu.com
  - cloud-images.ubuntu.com
  - *ubuntu.com
  - api.charmhub.io
  - *charmhub.io
  - docker.io
  - *docker.io
  - production.cloudflare.docker.com
  - *docker.com
  - quay.io
  - *quay.io
  - ghcr.io
  - *ghcr.io
  - pkg-containers.githubusercontent.com
  - *githubusercontent.com
  - registry.k8s.io
  - *k8s.io
  - pkg.dev
  - *pkg.dev
  - amazonaws.com
  - *amazonaws.com
  - registry.jujucharms.com
  - *jujucharms.com
  - api.snapcraft.io
  - *snapcraft.io
  - snapcraftcontent.com
  - *snapcraftcontent.com
  - builds.coreos.fedoraproject.org
  - *fedoraproject.org
  - download.cirros-cloud.net
  - *cirros-cloud.net
  - maas.io
  - *maas.io
  - contracts.canonical.com
  - images.lxd.canonical.com

## Verify

```bash
# on a separate terminal watch for any blocked get requests.
sudo tcpdump -i eno1
# https://packaging.python.org/en/latest/tutorials/installing-packages/
```

```bash
sudo snap install openstack
```

Sunbeam can generate a script to ensure that the machine has all of the required dependencies installed and is configured correctly for use in OpenStack - you can review this script using:

```bash
sunbeam prepare-node-script --bootstrap

+ echo 'Sunbeam requires the LXD bridge to be called anything except lxdbr0'
Sunbeam requires the LXD bridge to be called anything except lxdbr0
+ exit 1

# uninstalled the lxd snap and the following script reinstalled it

sunbeam prepare-node-script --bootstrap | bash -x && newgrp snap_daemon
 sunbeam prepare-node-script --bootstrap | bash -x && newgrp snap_daemon
++ lsb_release -sc
+ '[' noble '!=' noble ']'
++ whoami
+ USER=brent
++ id -u
+ '[' 1000 -eq 0 -o brent = root ']'
+ SUDO_ASKPASS=/bin/false
+ sudo -A whoami
+ sudo grep -r brent /etc/sudoers /etc/sudoers.d
+ grep NOPASSWD:ALL
+ for pkg in openssh-server curl sed
+ dpkg -s openssh-server
+ for pkg in openssh-server curl sed
+ dpkg -s curl
+ for pkg in openssh-server curl sed
+ dpkg -s sed
+ sudo usermod --append --groups snap_daemon brent
+ '[' -f /home/brent/.ssh/id_ed25519 ']'
+ cat /home/brent/.ssh/id_ed25519.pub
++ hostname --all-ip-addresses
+ ssh-keyscan -H 172.24.188.57
# 172.24.188.57:22 SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.11
# 172.24.188.57:22 SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.11
# 172.24.188.57:22 SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.11
# 172.24.188.57:22 SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.11
# 172.24.188.57:22 SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.11
+ grep -E 'HTTPS?_PROXY' /etc/environment
+ curl -s -m 10 -x '' api.charmhub.io
+ grep -E -q 'HTTPS?_PROXY=' /etc/environment
+ grep -E -q NO_PROXY= /etc/environment
+ sudo snap connect openstack:ssh-keys
+ sudo snap install --channel 3.6/stable juju
snap "juju" is already installed, see 'snap help refresh'
+ mkdir -p /home/brent/.local/share
+ mkdir -p /home/brent/.config/openstack
++ snap list openstack --unicode=never --color=never
++ grep openstack
+ snap_output='openstack  2024.1   727  2024.1/stable  canonical**  -'
++ awk -v col=4 '{print $col}'
+ track=2024.1/stable
+ [[ 2024.1/stable =~ edge ]]
+ [[ 2024.1/stable == \- ]]
+ [[ 2024.1/stable =~ beta ]]
+ [[ 2024.1/stable =~ candidate ]]
+ risk=stable
+ [[ stable != \s\t\a\b\l\e ]]
+ sudo snap install lxd --channel 5.21/stable
lxd (5.21/stable) 5.21.3-c5ae129 from Canonical✓ installed
++ whoami
+ USER=brent
+ sudo usermod --append --groups lxd brent
++ sudo --user brent lxc network list --format csv
++ grep lxdbr0
If this is your first time running LXD on this machine, you should also run: lxd init
To start your first container, try: lxc launch ubuntu:24.04
Or for a virtual machine: lxc launch ubuntu:24.04 --vm

+ '[' -n '' ']'
++ sudo --user brent lxc storage list --format csv
+ '[' -z '' ']'
+ echo 'Bootstrapping LXD'
Bootstrapping LXD
+ cat
+ sudo --user brent lxd init --preseed
+ grep -E -q 'HTTPS?_PROXY=' /etc/environment
+ echo 'Bootstrapping Juju onto LXD'
Bootstrapping Juju onto LXD
+ sudo --user brent juju show-controller
{}
+ '[' 1 -ne 0 ']'
+ set -e
+ printenv
+ grep -q '^HTTP_PROXY'
+ sudo --user brent juju bootstrap localhost
Creating Juju controller "localhost-localhost" on localhost/localhost
Looking for packaged Juju agent version 3.6.5 for amd64
Located Juju agent version 3.6.5-ubuntu-amd64 at https://streams.canonical.com/juju/tools/agent/3.6.5/juju-3.6.5-linux-amd64.tgz
To configure your system to better support LXD containers, please see: https://documentation.ubuntu.com/lxd/en/latest/explanation/performance_tuning/
Launching controller instance(s) on localhost/localhost...
 - juju-abebe7-0 (arch=amd64)                   
Installing Juju agent on bootstrap instance
Waiting for address
Attempting to connect to 10.159.97.95:22
Connected to 10.159.97.95
Running machine configuration script...
Bootstrap agent now started
Contacting Juju controller at 10.159.97.95 to verify accessibility...

Bootstrap complete, controller "localhost-localhost" is now available
Controller machines are in the "controller" model

Now you can run
        juju add-model <model-name>
to create a new model to deploy workloads.
+ echo 'Juju bootstrap complete, you can now bootstrap sunbeam!'
Juju bootstrap complete, you can now bootstrap sunbeam!
```

## Bootstrap the cloud

Deploy the OpenStack cloud using the cluster bootstrap command:

```bash
sunbeam cluster bootstrap
```

You will first be prompted whether or not to enable network proxy usage. If ‘Yes’, several sub-questions will be asked.

Use proxy to access external network resources? [y/n] (y):
http_proxy ():
https_proxy ():
no_proxy ():
Note that proxy settings can also be supplied by using a manifest (see Deployment manifest).

When prompted, enter the CIDR and the address range for the control plane networking. Here we use the values given earlier:

Management network (172.16.1.0/24):
OpenStack APIs IP ranges (172.16.1.201-172.16.1.240): 172.16.1.201-172.16.1.220

## Configure the cloud

Now configure the deployed cloud using the configure command:

```bash
sunbeam configure --openrc demo-openrc
172.24.188.57/23
gw:172.24.189.254
8.8.8.8 8.8.4.4
```

The --openrc option specifies a regular user (non-admin) cloud init file (demo-openrc here).

A series of questions will now be asked. Below is a sample output of an entire interactive session. The values in square brackets, when present, provide acceptable values. A value in parentheses is the default value. Here we use the values given earlier:

Local or remote access to VMs [local/remote] (local): remote
External network (172.16.2.0/24):
External network’s gateway (172.16.2.1):
Populate OpenStack cloud with demo user, default images, flavors etc [y/n] (y):
Username to use for access to OpenStack (demo):
Password to use for access to OpenStack (mt********):
Project network (192.168.0.0/24):
Enable ping and SSH access to instances? [y/n] (y):
External network’s allocation range (172.16.2.2-172.16.2.254):
External network’s type [flat/vlan] (flat):
Writing openrc to demo-openrc ... done
External network’s interface [eno1/eno2] (eno1): eno2

Any remote hosts intending to connect to VMs on this node (remote access in first question) must have connectivity with the interface selected for external traffic (last question above).

## Launch a VM

Verify the cloud by launching a VM called ‘test’ based on the ‘ubuntu’ image (Ubuntu 22.04 LTS). The launch command is used:

```bash
sunbeam launch ubuntu --name test
```

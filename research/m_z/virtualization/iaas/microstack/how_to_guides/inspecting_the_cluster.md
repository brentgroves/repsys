# **[Inspecting the cluster](https://canonical.com/microstack/docs/inspect)**

## Overview

MicroStack aims to remove the need for an operator to know all of the technical detail about how to deploy an OpenStack cloud; however when something does go wrong it’s important to be able to inspect the various components in order to discover the nature of the problem.

## Juju

MicroStack makes extensive use of Juju to manage the components of the OpenStack cloud across both the underlying nodes and on Kubernetes (see Canonical Kubernetes).

MicroStack uses two Juju models for managing the various components deployed to create the OpenStack cloud.

## Juju controller authentication

MicroStack uses a set of credentials for each node in the cluster for access to the Juju controller. The authenticated session for each node expires after 24 hours so to use the juju command directly it may be necessary to re-authenticate.

Juju commands will prompt for a password once the session has expired - the password for the node’s user can be found in `${HOME}/snap/openstack/current/account.yaml`.

Alternatively the juju-login helper can be used to re-authenticate with the Juju controller:

`sunbeam utils juju-login`

## Controller model

The controller model contains the MicroStack components that are placed directly on the nodes that make up the deployment. The status of this model can be queried using the following command:

```bash
pushd .
cd ~/src/repsys/research/m_z/virtualization/iaas/microstack
cat ${HOME}/snap/openstack/current/account.yaml
juju status -m admin/controller
y21G7frmewOU
Model       Controller          Cloud/Region                Version  SLA          Timestamp
controller  sunbeam-controller  moral-bobcat-k8s/localhost  3.6.5    unsupported  16:49:21-04:00

App         Version  Status  Scale  Charm            Channel     Rev  Address  Exposed  Message
controller           active      1  juju-controller  3.6/stable  116           no       

Unit           Workload  Agent  Address    Ports      Message
controller/0*  active    idle   10.1.0.75  37017/TCP 
```

This should work from any node in the deployment

This model contains the application deployments for the K8S (control role), MicroCeph (storage role) and OpenStack Hypervisor (compute role) components of MicroStack.

Depending on the roles assigned to individual machines, a unit of each of the applications should be present in the model.

The controller application is a special application that represents the Juju controller.

## OpenStack model

The openstack model contains all of the components of the OpenStack Cloud that are deployed on top of Kubernetes (provided by K8S from the controller model).

The status of this model can be queried using the following command:

```bash
cat ${HOME}/snap/openstack/current/account.yaml

juju status -m openstack
Model      Controller          Cloud/Region                Version  SLA          Timestamp
openstack  sunbeam-controller  moral-bobcat-k8s/localhost  3.6.5    unsupported  16:53:09-04:00

App                     Version                  Status   Scale  Charm                     Channel        Rev  Address         Exposed  Message
certificate-authority                            active       1  self-signed-certificates  1/stable       263  10.152.183.100  no       
cinder                                           blocked      1  cinder-k8s                2024.1/stable  118  10.152.183.210  no       (storage-backend) integration missing
cinder-mysql-router     8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.58   no       
glance                                           active       1  glance-k8s                2024.1/stable  139  10.152.183.229  no       
glance-mysql-router     8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.233  no       
horizon                                          active       1  horizon-k8s               2024.1/stable  129  10.152.183.142  no       http://172.16.1.204/openstack-horizon
horizon-mysql-router    8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.143  no       
keystone                                         active       1  keystone-k8s              2024.1/stable  235  10.152.183.132  no       
keystone-mysql-router   8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.74   no       
mysql                   8.0.41-0ubuntu0.22.04.1  active       1  mysql-k8s                 8.0/stable     240  10.152.183.152  no       
neutron                                          active       1  neutron-k8s               2024.1/stable  137  10.152.183.148  no       
neutron-mysql-router    8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.49   no       
nova                                             active       1  nova-k8s                  2024.1/stable  128  10.152.183.234  no       
nova-api-mysql-router   8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.145  no       
nova-cell-mysql-router  8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.151  no       
nova-mysql-router       8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.197  no       
ovn-central                                      active       1  ovn-central-k8s           24.03/stable   128  10.152.183.243  no       
ovn-relay                                        active       1  ovn-relay-k8s             24.03/stable   115  10.152.183.71   no       
placement                                        active       1  placement-k8s             2024.1/stable  111  10.152.183.137  no       
placement-mysql-router  8.0.41-0ubuntu0.22.04.1  active       1  mysql-router-k8s          8.0/stable     599  10.152.183.173  no       
rabbitmq                3.12.1                   active       1  rabbitmq-k8s              3.12/stable     50  10.152.183.232  no       
traefik                 2.11.0                   active       1  traefik-k8s               latest/stable  236  10.152.183.44   no       Serving at 172.16.1.205
traefik-public          2.11.0                   active       1  traefik-k8s               latest/stable  236  10.152.183.20   no       Serving at 172.16.1.204

Unit                       Workload  Agent      Address     Ports  Message
certificate-authority/0*   active    idle       10.1.0.199         
cinder-mysql-router/0*     active    idle       10.1.0.74          
cinder/0*                  blocked   idle       10.1.0.204         (storage-backend) integration missing
glance-mysql-router/0*     active    idle       10.1.0.87          
glance/0*                  active    idle       10.1.0.10          
horizon-mysql-router/0*    active    idle       10.1.0.195         
horizon/0*                 active    idle       10.1.0.168         
keystone-mysql-router/0*   active    idle       10.1.0.24          
keystone/0*                active    idle       10.1.0.83          
mysql/0*                   active    executing  10.1.0.250         Primary
neutron-mysql-router/0*    active    idle       10.1.0.23          
neutron/0*                 active    idle       10.1.0.15          
nova-api-mysql-router/0*   active    idle       10.1.0.2           
nova-cell-mysql-router/0*  active    idle       10.1.0.190         
nova-mysql-router/0*       active    idle       10.1.0.72          
nova/0*                    active    idle       10.1.0.173         
ovn-central/0*             active    idle       10.1.0.203         
ovn-relay/0*               active    idle       10.1.0.229         
placement-mysql-router/0*  active    idle       10.1.0.11          
placement/0*               active    idle       10.1.0.130         
rabbitmq/0*                active    idle       10.1.0.22          
traefik-public/0*          active    idle       10.1.0.249         Serving at 172.16.1.204
traefik/0*                 active    idle       10.1.0.188         Serving at 172.16.1.205

Offer                  Application            Charm                     Rev  Connected  Endpoint              Interface             Role
cert-distributor       keystone               keystone-k8s              235  1/1        send-ca-cert          certificate_transfer  provider
certificate-authority  certificate-authority  self-signed-certificates  263  1/1        certificates          tls-certificates      provider
keystone-credentials   keystone               keystone-k8s              235  1/1        identity-credentials  keystone-credentials  provider
keystone-endpoints     keystone               keystone-k8s              235  0/0        identity-service      keystone              provider
nova                   nova                   nova-k8s                  128  1/1        nova-service          nova                  provider
ovn-relay              ovn-relay              ovn-relay-k8s             115  1/1        ovsdb-cms-relay       ovsdb-cms             provider
rabbitmq               rabbitmq               rabbitmq-k8s              50   1/1        amqp                  rabbitmq              provider
```

This should work from any node in the deployment.

If the storage role is not specified for any nodes in the deployment the cinder-ceph application will remain in a blocked state. This is expected and means that the deployed OpenStack cloud does not support the block storage service.

## OpenStack Hypervisor

The OpenStack Hypervisor is a snap based component that provides all of the core functionality needed to operate a hypervisor as part of an OpenStack Cloud. This include Nova Compute, Libvirt+QEMU for hardware based virtualisation, OVN and OVS for software defined networking and supporting services to provide metadata to instances.

The status of the snap’s services can be checked using:

```bash
sudo systemctl status snap.openstack-hypervisor.*
zsh: no matches found: snap.openstack-hypervisor.*
```

All log output for the services can be captured by consulting the journal:

```bash
sudo journalctl -xe -u snap.openstack-hypervisor.*
```

This component is deployed and integrated into the cloud using the openstack-hypervisor charm that is deployed in the controller model.

## Canonical Kubernetes

Canonical Kubernetes (K8s) provides Kubernetes as part of MicroStack.

The current status of the K8S cluster can be checked by running:

```bash
sudo k8s status
cluster status:           ready
control plane nodes:      172.24.188.57:6400 (voter)
high availability:        no
datastore:                k8s-dqlite
network:                  enabled
dns:                      enabled at 10.152.183.178
ingress:                  disabled
load-balancer:            enabled, L2 mode
local-storage:            enabled at /var/snap/k8s/common/rawfile-storage
gateway                   disabled
```

A more in-depth inspection and generation of a archive suitable for use as part of a bug submission can also be completed by running:

```bash
sudo k8s inspect
Collecting service information
Running inspection on a control-plane node
 INFO:  Service k8s.containerd is running
 INFO:  Service k8s.kube-proxy is running
 INFO:  Service k8s.k8s-dqlite is running
 INFO:  Service k8s.k8sd is running
 INFO:  Service k8s.kube-apiserver is running
 INFO:  Service k8s.kube-controller-manager is running
 INFO:  Service k8s.kube-scheduler is running
 INFO:  Service k8s.kubelet is running
Collecting registry mirror logs
Collecting service arguments
 INFO:  Copy service args to the final report tarball
Collecting k8s cluster-info
 INFO:  Copy k8s cluster-info dump to the final report tarball
Collecting SBOM
 INFO:  Copy SBOM to the final report tarball
Collecting system information
 INFO:  Copy processes list to the final report tarball
 INFO:  Copy disk usage information to the final report tarball
 INFO:  Copy /proc/mounts to the final report tarball
 INFO:  Copy memory usage information to the final report tarball
 INFO:  Copy swap information to the final report tarball
 INFO:  Copy node uptime to the final report tarball
 INFO:  Copy /etc/os-release to the final report tarball
 INFO:  Copy loaded kernel modules to the final report tarball
 INFO:  Copy dmesg entries
 INFO:  Core dump directory empty or missing, skipping...
Collecting snap and related information
 INFO:  Copy uname to the final report tarball
 INFO:  Copy snap diagnostics to the final report tarball
 INFO:  Copy k8s diagnostics to the final report tarball
Collecting networking information
 INFO:  Copy network diagnostics to the final report tarball
Building the report tarball
 SUCCESS:  Report tarball is at /home/brent/src/repsys/research/m_z/virtualization/iaas/microstack/inspection-report-20250520_170215.tar.gz
```

## Services hosted on Canonical Kubernetes

Components of OpenStack Control Plane are hosted on Canonical Kubernetes (K8s).

You can get the different units by running:

```bash
sudo k8s kubectl get pods --namespace openstack
NAME                             READY   STATUS    RESTARTS   AGE
certificate-authority-0          1/1     Running   0          3d21h
cinder-0                         3/3     Running   0          3d21h
cinder-mysql-router-0            2/2     Running   0          3d21h
glance-0                         2/2     Running   0          3d21h
glance-mysql-router-0            2/2     Running   0          3d21h
horizon-0                        2/2     Running   0          3d21h
horizon-mysql-router-0           2/2     Running   0          3d21h
keystone-0                       2/2     Running   0          3d21h
keystone-mysql-router-0          2/2     Running   0          3d21h
modeloperator-6cbd5bbd86-qqxwg   1/1     Running   0          3d21h
mysql-0                          2/2     Running   0          3d21h
neutron-0                        2/2     Running   0          3d21h
neutron-mysql-router-0           2/2     Running   0          3d21h
nova-0                           5/5     Running   0          3d21h
nova-api-mysql-router-0          2/2     Running   0          3d21h
nova-cell-mysql-router-0         2/2     Running   0          3d21h
nova-mysql-router-0              2/2     Running   0          3d21h
ovn-central-0                    4/4     Running   0          3d21h
ovn-relay-0                      2/2     Running   0          3d21h
placement-0                      2/2     Running   0          3d21h
placement-mysql-router-0         2/2     Running   0          3d21h
rabbitmq-0                       2/2     Running   0          3d21h
traefik-0                        2/2     Running   0          3d21h
traefik-public-0                 2/2     Running   0          3d21h
```

To fetch the logs of a specific unit on K8S, it is necessary to know the name of the containers running inside a given pod. To get the names of the containers:

```bash
sudo k8s kubectl get pod --namespace openstack -o jsonpath="{.spec.containers[*].name}" <pod_name>
```

A Juju unit will always have a charm container running the Juju agent responsible for running the charm. To fetch logs associated with the charm of a particular unit:

```bash
sudo k8s kubectl logs --namespace openstack --container charm <pod_name>
```

# Get started with Juju

**[Back to Research List](../../research_list.md)**\
**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Imagine your business needs a chat service such as Mattermost backed up by a database such as PostgreSQL. In a traditional setup, this can be quite a challenge, but with Juju you’ll find yourself deploying, configuring, scaling, integrating, etc., applications in no time. Let’s get started!

## references

- <https://juju.is/docs/juju/tutorial>
- <https://charmhub.io/mattermost-k8s>
- <https://charmhub.io/postgresql-k8s>
- <https://charmhub.io/self-signed-certificates>

![](https://discourse-charmhub-io.s3.eu-west-2.amazonaws.com/original/2X/7/7a96fdecba28aa84691a7eccf337615a2296d3d5.png)

## Setup: Create your test environment

When you’re trying things out, it’s good to be in an isolated environment, so you don’t have to worry too much about cleanup. It’s also nice if you don’t need to bother too much with setup. In the Juju world you can get both by spinning up an Ubuntu virtual machine (VM) with Multipass, specifically, using their Juju-ready charm-dev blueprint.

This tutorial assumes you will use the Multipass blueprint. Still, if you'd prefer not to:
At the “Add your cloud definition to Juju” step, when you install MicroK8s, if you’re installing it on Linux from snap, make sure to install the strictly-confined snap: ```snap install microk8s --channel 1.28-strict```.

Strict Used by the majority of snaps. **[Strictly confined snaps](../../m_z/snap/confinement.md)** run in complete isolation, up to a minimal access level that's deemed always safe.

For this and more, see steps 5 (“Set up your cloud”) and 6 (“Set up Juju”) of the Charm SDK | Set up your development environment manually guide.

Install Multipass: Linux | macOS | Windows. On Linux (assumes your have snapd):

```bash
ssh brent@repsys11
sudo snap install multipass
```

## What you’ll need

A working station, e.g., a laptop, that has sufficient resources to launch a virtual machine with 4 CPUs, 8 GB RAM, and 50 GB disk space.
What you’ll do:

Plan, deploy, and maintain a chat service based on Mattermost and backed by PostgreSQL on a local Kubernetes cloud with Juju.

## Set up an isolated test environment

Tempted to skip this step? We strongly recommend that you do not! As you will see in a minute, the VM you set up in this step does not just provide you with an isolated test environment but also with almost everything else you’ll need in the rest of this tutorial (and the non-VM alternative may not yield exactly the same results).

On your machine, install Multipass and use it to set up an Ubuntu virtual machine (VM) called my-juju-vm from the charm-dev blueprint.

See more: **[Set up your test environment automatically > steps 1-2](https://juju.is/docs/juju/set-up--tear-down-your-test-environment#heading--set-up-automatically)**

Note: This document also contains a manual path, using which you can set things up without the Multipass VM or the charm-dev blueprint. However, please note that the manual path may yield slightly different results that may impact your experience of this tutorial. For best results we strongly recommend the automatic path, or else suggest that you follow the manual path in a way that stays very close to the definition of the charm-dev blueprint.

Use Multipass with the **[charm-dev blueprint](https://github.com/canonical/multipass-blueprints/blob/main/v1/charm-dev.yaml)** to launch a Juju-ready Ubuntu VM (below my-juju-vm):

charm-dev readme.md

```markdown
# This blueprint creates a juju testing environment ready to go.
# A microk8s controller and an empty model are created as part of the cloud-init script
# so you can `juju deploy` right away.
# For development convenience, charmcraft and tox are installed as well.
# If you are a zsh user, the ohmyzsh juju plugin is already enabled when you switch to zsh.
#
# To create a VM similar to a GitHub-hosted runner:
# multipass launch --memory 7G --cpus 2 --name charm-dev-2cpu-7g charm-dev
# https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners
#
# To only test the cloud init portion of this blueprint:
#
#   yq '.instances."charm-dev"."cloud-init"."vendor-data"' v1/charm-dev.yaml > charm-dev-cloud-init.yaml
#   multipass launch --cloud-init ./charm-dev-cloud-init.yaml --name test --memory 7G --cpus 2 --disk 30G
```

```bash
ssh brent@repsys11
multipass launch --cpus 4 --memory 8G --disk 50G --name my-juju-vm charm-dev
```

This step may take a few minutes to complete (e.g., 10 mins).

This is because the command downloads, installs, (updates,) and configures a number of packages, and the speed will be affected by network bandwidth (not just your own, but also that of the package sources).

However, once it’s done, you’ll have everything you’ll need – all in a nice isolated environment that you can clean up easily.

See more: **[GitHub > multipass-blueprints > charm-dev.yaml](https://github.com/canonical/multipass-blueprints/blob/ae90147b811a79eaf4508f4776390141e0195fe7/v1/charm-dev.yaml#L134)**

## Open a shell into the VM

```bash
ssh brent@repsys11
multipass shell my-juju-vm
```

## Verify that the VM has indeed come pre-equipped with you’ll need

Verify that you have Juju, MicroK8s (for machine charms) / LXD (for machine charms), a MicroK8s / LXD cloud (microk8s / localhost), a controller on that cloud (microk8s / lxd), and a workload model on that controller (welcome-k8s / welcome-lxd) by switching to the workload model:

```bash
juju switch microk8s:welcome-k8s
juju switch
microk8s:admin/welcome-k8s
juju switch lxd:welcome-lxd
microk8s:admin/welcome-k8s -> lxd:admin/welcome-lxd
```

When used without an argument, the command shows the current controller and its active model. When a single argument without a colon is provided juju first looks for a controller by that name and switches to it, and if it’s not found it tries to switch to a model within current controller. mycontroller: switches to default model in mycontroller, :mymodel switches to mymodel in current controller and mycontroller:mymodel switches to mymodel on mycontroller. The juju models command can be used to determine the active model (of any controller). An asterisk denotes it.

```bash
juju models
Controller: microk8s

Model         Cloud/Region        Type        Status     Units  Access  Last connection
controller    microk8s/localhost  kubernetes  available  1       admin  just now
welcome-k8s*  microk8s/localhost  kubernetes  available  -       admin  never connected
juju switch lxd:welcome-lxd
```

Done!

Going forward:

Use the Multipass VM shell to run all commands.
At any point:

To exit the shell, press mod key + C or type exit.
To stop the VM after exiting the VM shell, run multipass stop charm-dev-vm.
To restart the VM and re-open a shell into it, type multipass shell charm-dev-vm.

```bash
# To stop and exit the VM
multipass stop my-juju-vm
```

Tear down automatically
Delete the Multipass VM (below, my-juju-vm):

```bash
multipass delete --purge my-juju-vm
```

## Plan

In this tutorial your goal is to set up a chat service on a cloud.

First, decide which cloud (i.e., anything that provides storage, compute, and networking) you want to use. Juju supports a long list of clouds, including a low-ops, minimal production Kubernetes called ‘MicroK8s’. In a terminal, open a shell into your VM and verify that you already have MicroK8s installed (microk8s version).

Next, decide which charms (i.e., software operators) you want to use. Charmhub provides a large collection. For this tutorial plan to use mattermost-k8s for the chat service, postgresql-k8s for its backing database, and self-signed-certificates to TLS-encrypt traffic from PostgreSQL.

See more: Charm, Charmhub, Charmhub | mattermost-k8s, **[postgresql-k8s](https://charmhub.io/postgresql-k8s)**, **[self-signed-certificates](https://charmhub.io/self-signed-certificates)**

Look around

1. Learn more about your MicroK8s cloud.
1a. Find out more about its snap: snap info microk8s.
1b. Find out the installed version: microk8s version.
1c. Check its enabled addons: microk8s status.
1d. Inspect its .kube/config file: cat ~/.kube/config.
1e. Try microk8s kubectl; you won’t need it once you have Juju, but it’s there anyway.

**[Deploy](https://juju.is/docs/juju/tutorial)**

juju
You will need to install a Juju client; on the client, add your cloud and cloud credentials; on the cloud, bootstrap a controller (i.e., control plan); on the controller, add a model (i.e., canvas to deploy things on; namespace); on the model, deploy, configure, and integrate the charms that make up your chat service.

The blueprint used to launch your VM has ensured that most of these things are already in place for you – verify that you have a Juju client, that it knows about your MicroK8s cloud and cloud credentials, that the MicroK8s cloud already has a controller bootstrapped on it, and that the Microk8s controller already has a model on it.

Just for practice, bootstrap a new controller and model with more informative names – a controller called 31microk8s (reflecting the version of Juju that came with your VM and the cloud that the controller lives on) and a model called chat (reflecting the fact that we intend to use it for applications related to a chat service).

Finally, go ahead and deploy, configure, and integrate your charms.

Sample session (yours should look very similar):

Pro tip:
Split your terminal window into three. In all, access your Multipass VM shell (multipass shell my-juju-vm) and then:

Shell 1: Keep using it as you’ve already been doing so far, namely to type the commands in this tutorial.

Shell 2: Run juju status --relations --watch 1s to watch your deployment status evolve. (Things are all right if your App Status and your Unit - Workload reach active and your Unit - Agent reaches idle. See more: **[Status](https://juju.is/docs/juju/status)**.)

Shell 3: Run juju debug-log to watch all the details behind your deployment status. (Especially useful when things don’t evolve as expected. In that case, please get in touch.)

```bash
# Verify that you have the juju client installed:
ubuntu@my-juju-vm:~$ juju version
3.1.8-genericlinux-amd64

# Verify that the client already knows about your microk8s cloud:
ubuntu@my-juju-vm:~$ juju clouds
# (Ignore the client-controller distinction for now --it'll make sense in a bit.)
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

## Verify that the client already knows about your microk8s credentials

```bash
ubuntu@my-juju-vm:~$ juju credentials
# (Ignore the client-controller distinction for now --it'll make sense in a bit.)
Controller Credentials:
Cloud     Credentials
microk8s  microk8s

Client Credentials:
Cloud      Credentials
localhost  localhost*
microk8s   microk8s*

ubuntu@my-juju-vm:~$ juju controllers
Use --refresh option with this command to see the latest information.

Controller  Model        User   Access     Cloud/Region         Models  Nodes    HA  Version
lxd         welcome-lxd  admin  superuser  localhost/localhost       2      1  none  3.1.8  
microk8s*   welcome-k8s  admin  superuser  microk8s/localhost        2      1     -  3.1.8  

# Bootstrap a new controller:
# In Juju, bootstrapping refers to the process whereby a Juju client creates a controller on a specific cloud. 
ubuntu@my-juju-vm:~$ juju bootstrap microk8s 31microk8s
Creating Juju controller "31microk8s" on microk8s/localhost
Bootstrap to Kubernetes cluster identified as microk8s/localhost
Creating k8s resources for controller "controller-31microk8s"
Starting controller pod
Bootstrap agent now started
Contacting Juju controller at 10.152.183.189 to verify accessibility...

Bootstrap complete, controller "31microk8s" is now available in namespace "controller-31microk8s"

Now you can run
# In Juju, a model is an abstraction that holds applications and application supporting components – machines, storage, network spaces, relations (integrations), etc.
juju add-model <model-name>
to create a new model to deploy k8s workloads.

juju controllers
Use --refresh option with this command to see the latest information.

Controller   Model        User   Access     Cloud/Region         Models  Nodes    HA  Version
31microk8s*  -            admin  superuser  microk8s/localhost        1      1     -  3.1.8  
lxd          welcome-lxd  admin  superuser  localhost/localhost       2      1  none  3.1.8  
microk8s     welcome-k8s  admin  superuser  microk8s/localhost        2      1     -  3.1.8 
```

## Create a new model

```bash
# In Juju, a model is an abstraction that holds applications and application supporting components – machines, storage, network spaces, relations (integrations), etc.
ubuntu@my-juju-vm:~$ juju add-model chat
Added 'chat' model on microk8s/localhost with credential 'microk8s' for user 'admin'

# Deploy mattermost-k8s
# juju deploy [options] <charm or bundle> [<application name>]
# Deploys a new application or bundle to a machine / container.
ubuntu@tutorial-vm:~$ juju deploy mattermost-k8s
Located charm "mattermost-k8s" in charm-hub, revision 27
Deploying "mattermost-k8s" from charm-hub charm "mattermost-k8s", revision 27 in channel stable on ubuntu@20.04/stable

# Deploy and configure postgresql-k8s:
# juju deploy [options] <charm or bundle> [<application name>]
# Deploys a new application or bundle to a machine / container.
ubuntu@tutorial-vm:~$ juju deploy postgresql-k8s --channel 14/stable --trust --config profile=testing
Located charm "postgresql-k8s" in charm-hub, revision 193
Deploying "postgresql-k8s" from charm-hub charm "postgresql-k8s", revision 193 in channel 14/stable on ubuntu@22.04/stable

# Deploy self-signed-certificates:
# juju deploy [options] <charm or bundle> [<application name>]
# https://github.com/canonical/self-signed-certificates-operator
# An operator to provide self-signed X.509 certificates to your charms.
ubuntu@my-juju-vm:~$ juju deploy self-signed-certificates
Located charm "self-signed-certificates" in charm-hub, revision 72
Deploying "self-signed-certificates" from charm-hub charm "self-signed-certificates", revision 72 in channel stable on ubuntu@22.04/stable
Located: command not found
Deploying: command not found

microk8s kubectl get all --namespace chat
NAME                                  READY   STATUS    RESTARTS   AGE
pod/modeloperator-545b744f7d-vb66p    1/1     Running   0          4d22h
pod/mattermost-k8s-operator-0         1/1     Running   0          4d22h
pod/self-signed-certificates-0        1/1     Running   0          4d22h
pod/mattermost-k8s-8497bd9757-gcqmz   1/1     Running   0          4d22h
pod/postgresql-k8s-0                  2/2     Running   0          4d22h

NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/modeloperator                        ClusterIP   10.152.183.184   <none>        17071/TCP           4d22h
service/mattermost-k8s-operator              ClusterIP   10.152.183.200   <none>        30666/TCP           4d22h
service/postgresql-k8s-endpoints             ClusterIP   None             <none>        <none>              4d22h
service/postgresql-k8s                       ClusterIP   10.152.183.124   <none>        5432/TCP,8008/TCP   4d22h
service/postgresql-k8s-primary               ClusterIP   10.152.183.74    <none>        8008/TCP,5432/TCP   4d22h
service/postgresql-k8s-replicas              ClusterIP   10.152.183.231   <none>        8008/TCP,5432/TCP   4d22h
service/patroni-postgresql-k8s-config        ClusterIP   None             <none>        <none>              4d22h
service/self-signed-certificates             ClusterIP   10.152.183.75    <none>        65535/TCP           4d22h
service/self-signed-certificates-endpoints   ClusterIP   None             <none>        <none>              4d22h
service/mattermost-k8s                       ClusterIP   10.152.183.104   <none>        8065/TCP            4d22h

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/modeloperator    1/1     1            1           4d22h
deployment.apps/mattermost-k8s   1/1     1            1           4d22h

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/modeloperator-545b744f7d    1         1         1       4d22h
replicaset.apps/mattermost-k8s-8497bd9757   1         1         1       4d22h

NAME                                        READY   AGE
statefulset.apps/mattermost-k8s-operator    1/1     4d22h
statefulset.apps/postgresql-k8s             1/1     4d22h
statefulset.apps/self-signed-certificates   1/1     4d22h


# Integrate self-signed-certificates with postgresql-k8s:

ubuntu@tutorial-vm:~$ juju integrate self-signed-certificates postgresql-k8s 
# Integrate two applications. Integrated applications communicate over a common interface provided by the Juju controller that enables units to share information. This topology allows units to share data, without needing direct connectivity between units is restricted by firewall rules. Charms define the logic for transferring and interpreting integration data.

# The most common use of ‘juju integrate’ specifies two applications that co-exist within the same model:
# juju integrate <application> <application>

# Integrate postgresql-k8s with mattermost-k8s:
ubuntu@tutorial-vm:~$ juju integrate postgresql-k8s:db mattermost-k8s 

# Check your model's status:
ubuntu@my-juju-vm:~$ juju status --relations


Model  Controller  Cloud/Region        Version  SLA          Timestamp
chat   31microk8s  microk8s/localhost  3.1.8    unsupported  16:33:33-04:00

App                       Version                         Status  Scale  Charm                     Channel    Rev  Address         Exposed  Message
mattermost-k8s            .../mattermost:v8.1.3-20.04...  active      1  mattermost-k8s            stable      27  10.152.183.104  no       
postgresql-k8s            14.10                           active      1  postgresql-k8s            14/stable  193  10.152.183.124  no       
self-signed-certificates                                  active      1  self-signed-certificates  stable      72  10.152.183.75   no       

Unit                         Workload  Agent  Address      Ports     Message
mattermost-k8s/0*            active    idle   10.1.32.149  8065/TCP  
postgresql-k8s/0*            active    idle   10.1.32.147            Primary
self-signed-certificates/0*  active    idle   10.1.32.148            

Integration provider                   Requirer                       Interface         Type     Message
postgresql-k8s:database-peers          postgresql-k8s:database-peers  postgresql_peers  peer     
postgresql-k8s:db                      mattermost-k8s:db              pgsql             regular  
postgresql-k8s:restart                 postgresql-k8s:restart         rolling_op        peer     
postgresql-k8s:upgrade                 postgresql-k8s:upgrade         upgrade           peer     
self-signed-certificates:certificates  postgresql-k8s:certificates    tls-certificates  regular  
```

From the output of juju status> Unit > mattermost-k8s/0, retrieve the IP address and the port and feed them to curl on the template below:

```bash
# 10.1.32.149  8065
curl 10.1.32.149:8065/api/v4/system/ping
Sample session:

ubuntu@my-juju-vm:~$ curl 10.1.32.149:8065/api/v4/system/ping
{"ActiveSearchBackend":"database","AndroidLatestVersion":"","AndroidMinVersion":"","IosLatestVersion":"","IosMinVersion":"","status":"OK"}
```

Congratulations, your chat service is up and running!

![](https://discourse-charmhub-io.s3.eu-west-2.amazonaws.com/original/2X/7/7f7d16728c8305907398427d1c041fcecefe0177.jpeg)

Your computer with your Multipass VM, your MicroK8s cloud, and a live Juju controller (the ‘charm’ in the Controller Unit is the juju-controller charm) + a sample deployed application on it (the ‘charm’ in the Regular Unit stands for any charm that you might deploy). If in the Regular Application you replace the charm with mattermost-k8s and image a few more Regular Applications where you replace the charm with postgresql-k8s and, respectively, self-signed-certificates, and if you trace the path from postgresql-k8s’s Unit Agent through the Controller Agent to self-signed-certificates’s and, respectively, mattermost-k8s Unit Agent, you get a full representation of your deployment. (Note: After integration, the workloads may also know how to contact each other directly; still, all communication between their respective charms goes through the Juju controller and the result of that communication is stored in the database in the form of maps known as ‘relation data bags’.)

## Scale

A database failure can be very costly. Let’s scale it!

Sample session:

```bash
ubuntu@my-juju-vm:~$ juju scale-application postgresql-k8s 3
postgresql-k8s scaled to 3 units
```

## **[START HERE](https://juju.is/docs/juju/tutorial)**

Look around

## **[Continue Study of MicroStack](../../m_z/microstack/NEXT_microstack.md)**

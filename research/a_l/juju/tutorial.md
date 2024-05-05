# Get started with Juju

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Imagine your business needs a chat service such as Mattermost backed up by a database such as PostgreSQL. In a traditional setup, this can be quite a challenge, but with Juju you’ll find yourself deploying, configuring, scaling, integrating, etc., applications in no time. Let’s get started!

## references

<https://juju.is/docs/juju/tutorial>

<https://charmhub.io/mattermost-k8s>
<https://charmhub.io/postgresql-k8s>
<https://charmhub.io/self-signed-certificates>
![](https://discourse-charmhub-io.s3.eu-west-2.amazonaws.com/original/2X/7/7a96fdecba28aa84691a7eccf337615a2296d3d5.png)

## Setup: Create your test environment

When you’re trying things out, it’s good to be in an isolated environment, so you don’t have to worry too much about cleanup. It’s also nice if you don’t need to bother too much with setup. In the Juju world you can get both by spinning up an Ubuntu virtual machine (VM) with Multipass, specifically, using their Juju-ready charm-dev blueprint.

This tutorial assumes you will use the Multipass blueprint. Still, if you'd prefer not to:
At the “Add your cloud definition to Juju” step, when you install MicroK8s, if you’re installing it on Linux from snap, make sure to install the strictly-confined snap: ```snap install microk8s --channel 1.28-strict```.

Strict Used by the majority of snaps. Strictly confined snaps run in complete isolation, up to a minimal access level that's deemed always safe.

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

Use Multipass with the charm-dev blueprint to launch a Juju-ready Ubuntu VM (below my-juju-vm):

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

## START HERE

**[Deploy](https://juju.is/docs/juju/tutorial)**

juju
You will need to install a Juju client; on the client, add your cloud and cloud credentials; on the cloud, bootstrap a controller (i.e., control plan); on the controller, add a model (i.e., canvas to deploy things on; namespace); on the model, deploy, configure, and integrate the charms that make up your chat service.

<https://juju.is/docs/juju/set-up--tear-down-your-test-environment#heading--set-up-automatically>
<https://multipass.run/docs/blueprint>
<https://multipass.run/docs/instance>

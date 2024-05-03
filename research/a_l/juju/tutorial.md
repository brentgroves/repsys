# Get started with Juju

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Imagine your business needs a chat service such as Mattermost backed up by a database such as PostgreSQL. In a traditional setup, this can be quite a challenge, but with Juju you’ll find yourself deploying, configuring, scaling, integrating, etc., applications in no time. Let’s get started!

## references

<https://juju.is/docs/juju/tutorial>

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

## START HERE

<https://juju.is/docs/juju/set-up--tear-down-your-test-environment#heading--set-up-automatically>
<https://multipass.run/docs/blueprint>
<https://multipass.run/docs/instance>

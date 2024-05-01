# Get started with Juju

I love you my son. Do not fear I'm always with you!

Imagine your business needs a chat service such as Mattermost backed up by a database such as PostgreSQL. In a traditional setup, this can be quite a challenge, but with Juju you’ll find yourself deploying, configuring, scaling, integrating, etc., applications in no time. Let’s get started!

## references

<https://juju.is/docs/juju/tutorial>

## Setup: Create your test environment

When you’re trying things out, it’s good to be in an isolated environment, so you don’t have to worry too much about cleanup. It’s also nice if you don’t need to bother too much with setup. In the Juju world you can get both by spinning up an Ubuntu virtual machine (VM) with Multipass, specifically, using their Juju-ready charm-dev blueprint.

This tutorial assumes you will use the Multipass blueprint. Still, if you'd prefer not to:
At the “Add your cloud definition to Juju” step, when you install MicroK8s, if you’re installing it on Linux from snap, make sure to install the strictly-confined snap: snap install microk8s --channel 1.28-strict.

For this and more, see steps 5 (“Set up your cloud”) and 6 (“Set up Juju”) of the Charm SDK | Set up your development environment manually guide.

Install Multipass: Linux | macOS | Windows. On Linux (assumes your have snapd):

```bash
sudo snap install multipass
```
